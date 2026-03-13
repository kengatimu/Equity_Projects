package com.equitybank.gag.papss.ots.jpos.space.participants;

import com.equitybank.gag.papss.ots.jpos.space.configs.JposConstants;
import com.equitybank.gag.papss.ots.jpos.space.configs.SpringBeanLoader;
import com.equitybank.gag.papss.ots.entity.TransactionMaster;
import com.equitybank.gag.papss.ots.enums.TransactionStatus;
import com.equitybank.gag.papss.ots.enums.TransactionType;
import com.equitybank.gag.papss.ots.exception.CustomException;
import com.equitybank.gag.papss.ots.service.DatabaseService;
import com.equitybank.gag.papss.ots.service.ISOSignatureGenerationService;
import org.jpos.transaction.Context;
import org.jpos.transaction.TransactionParticipant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;

import java.io.Serializable;

import static com.equitybank.gag.papss.ots.enums.TransactionStatus.FINACLE_DEBITED;

public class ISO20022MessageSigningParticipant implements TransactionParticipant {

    private static final Logger log = LoggerFactory.getLogger(ISO20022MessageSigningParticipant.class);

    private ISOSignatureGenerationService isoSignatureGenerationService;
    private DatabaseService databaseService;

    public ISO20022MessageSigningParticipant() {
        // Initialize required Spring-managed beans using static ApplicationContext
        ApplicationContext context = SpringBeanLoader.getApplicationContext();
        if (context != null) {
            try {
                this.isoSignatureGenerationService = context.getBean(ISOSignatureGenerationService.class);
                this.databaseService = context.getBean(DatabaseService.class);
                log.info("Spring beans loaded successfully.");
            } catch (Exception e) {
                log.error("Failed to load Spring beans: {}", e.getMessage(), e);
            }
        } else {
            log.error("ApplicationContext is null.");
        }
    }

    @Override
    public int prepare(long id, Serializable serializedContext) {
        Context ctx = (Context) serializedContext;
        String rrn = (String) ctx.get(JposConstants.RRN);

        log.info("{}: Begin prepare phase.", rrn);

        // Get the latest entity version from DB inorder to preventing optimistic locking errors
        TransactionMaster transactionEntity;
        try {
            transactionEntity = databaseService.getSavedRecord(rrn, TransactionType.CREDIT_TRANSFER);
            ctx.put(JposConstants.TRANSACTION_ENTITY_CONTEXT, transactionEntity);
            log.info("{}: Loaded latest TransactionMaster from DB.", rrn);
        } catch (Exception e) {
            updateJposContextAndReversal(ctx, rrn, TransactionStatus.FAILURE, "Error fetching transaction from DB: " + e.getMessage(), null);
            return ABORTED;
        }

        // Abort if this transaction does not require PAPSS processing
        Boolean needsPapssProcessing = (Boolean) ctx.get(JposConstants.NEEDS_PAPSS_PROCESSING);
        if (needsPapssProcessing == null || !needsPapssProcessing) {
            updateJposContextAndReversal(ctx, rrn, TransactionStatus.FAILURE, "PAPSS processing not required. Reversing transaction.", transactionEntity);
            return ABORTED;
        }

        // Ensure signature service is available
        if (isoSignatureGenerationService == null) {
            updateJposContextAndReversal(ctx, rrn, TransactionStatus.FAILURE, "Signature service not initialized.", transactionEntity);
            return ABORTED;
        }

        // Retrieve unsigned PACS.008 message from context
        String unsignedPacs008Xml = (String) ctx.get(JposConstants.ISO20022_PACS008_REQUEST_XML);
        if (unsignedPacs008Xml == null || unsignedPacs008Xml.isEmpty()) {
            updateJposContextAndReversal(ctx, rrn, TransactionStatus.FAILURE, "Unsigned PACS.008 XML not found in context.", transactionEntity);
            return ABORTED;
        }

        try {
            // Perform digital signing of the ISO 20022 PACS.008 message
            TransactionType txnType = (TransactionType) ctx.get(JposConstants.TXN_TYPE);
            String signedPacs008Xml = isoSignatureGenerationService.generateXMLDigitalSignature(rrn, unsignedPacs008Xml, String.valueOf(txnType));
            log.info("{}: PACS.008 XML signed successfully.", rrn);

            // Store the signed XML in context for next participant (e.g., HTTP sender)
            ctx.put(JposConstants.ISO20022_SIGNED_PACS008_XML, signedPacs008Xml);

            // Mark transaction as successful so far, no reversal needed
            ctx.put(JposConstants.NEEDS_FINACLE_TRANSACTION_LEG_REVERSAL, false);
            ctx.put(JposConstants.NEEDS_FINACLE_CHARGES_LEG_REVERSAL, false);
            updateJposContext(ctx, rrn, TransactionStatus.PENDING, "Signing successful. Message stored in context.");

            // Remove pacs.008 from context
            ctx.put(JposConstants.ISO20022_PACS008_REQUEST_XML, "[PACS008 content excluded]");
            return PREPARED;

        } catch (CustomException e) {
            log.error("{}: Signing failed due to CustomException: {}", rrn, e.getMessage());
            updateJposContextAndReversal(ctx, rrn, TransactionStatus.FAILURE, "Failed to sign ISO20022 message: " + e.getMessage(), transactionEntity);

            // Remove pacs.008 from context
            ctx.put(JposConstants.ISO20022_PACS008_REQUEST_XML, "[PACS008 content excluded]");
            return ABORTED;

        } catch (Exception e) {
            log.error("{}: Unexpected error during signing: {}", rrn, e.getMessage(), e);
            updateJposContextAndReversal(ctx, rrn, TransactionStatus.FAILURE, "Failed to sign ISO20022 message: " + e.getMessage(), transactionEntity);

            // Remove pacs.008 from context
            ctx.put(JposConstants.ISO20022_PACS008_REQUEST_XML, "[PACS008 content excluded]");
            return ABORTED;
        }
    }

    @Override
    public void commit(long id, Serializable ctx) {
        String rrn = (String) ((Context) ctx).get(JposConstants.RRN);
        log.info("{}: Commit phase — no action required.", rrn);
    }

    @Override
    public void abort(long id, Serializable ctx) {
        String rrn = (String) ((Context) ctx).get(JposConstants.RRN);
        log.info("{}: Abort phase — no rollback actions.", rrn);
    }


    // Update jPOS context with transaction status, code, and message. Also disables further PAPSS processing in case of failure.
    private void updateJposContext(Context ctx, String rrn, TransactionStatus status, String message) {
        if (status == TransactionStatus.FAILURE || status == TransactionStatus.TIMEOUT) {
            log.error("{}: {}", rrn, message);
        } else {
            log.info("{}: {}", rrn, message);
        }

        ctx.put(JposConstants.TXN_STATUS, status);
        ctx.put(JposConstants.STATUS_CODE, status.getCode());
        ctx.put(JposConstants.STATUS_MESSAGE, message);

        // Disable PAPSS flow if this participant fails or times out
        ctx.put(JposConstants.NEEDS_PAPSS_PROCESSING, (status != TransactionStatus.FAILURE && status != TransactionStatus.TIMEOUT));
    }

    // Update jPOS context with status and determine if reversal is needed.
    private void updateJposContextAndReversal(Context ctx, String rrn, TransactionStatus status, String message, TransactionMaster entity) {
        updateJposContext(ctx, rrn, status, message);

        boolean needsReversal = entity != null
                && entity.getFinacleStatus() == FINACLE_DEBITED
                && status == TransactionStatus.FAILURE;

        ctx.put(JposConstants.NEEDS_FINACLE_TRANSACTION_LEG_REVERSAL, needsReversal);
        ctx.put(JposConstants.NEEDS_FINACLE_CHARGES_LEG_REVERSAL, needsReversal);

        if (needsReversal) {
            log.warn("{}: Transaction failed after Finacle debit. Flagging for reversal.", rrn);
        } else {
            log.info("{}: Reversal not required (Finacle not debited or failure not applicable).", rrn);
        }
    }
}
