package com.equitybank.gag.papss.ots.jpos.space.participants;

import com.equitybank.gag.papss.ots.jpos.space.configs.JposConstants;
import com.equitybank.gag.papss.ots.jpos.space.configs.SpringBeanLoader;
import com.equitybank.gag.papss.ots.dto.channelRequest.transaction.ChannelCreditTransferDetailsReq;
import com.equitybank.gag.papss.ots.entity.TransactionMaster;
import com.equitybank.gag.papss.ots.enums.TransactionStatus;
import com.equitybank.gag.papss.ots.enums.TransactionType;
import com.equitybank.gag.papss.ots.service.DatabaseService;
import com.equitybank.gag.papss.ots.service.ISOPayloadXmlComposerService;
import org.jpos.transaction.Context;
import org.jpos.transaction.TransactionParticipant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;

import java.io.Serializable;

import static com.equitybank.gag.papss.ots.enums.TransactionStatus.FINACLE_DEBITED;

public class ISO20022MessageBuilderParticipant implements TransactionParticipant {

    private static final Logger log = LoggerFactory.getLogger(ISO20022MessageBuilderParticipant.class);

    private ISOPayloadXmlComposerService isoPayloadXmlComposerService;
    private DatabaseService databaseService;

    public ISO20022MessageBuilderParticipant() {
        // Load Spring-managed beans via static context from SpringBeanLoader
        ApplicationContext context = SpringBeanLoader.getApplicationContext();
        if (context != null) {
            try {
                this.isoPayloadXmlComposerService = context.getBean(ISOPayloadXmlComposerService.class);
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
        log.info("{}: Starting prepare phase.", rrn);

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

        // Ensure critical services are available
        if (isoPayloadXmlComposerService == null || databaseService == null) {
            updateJposContextAndReversal(ctx, rrn, TransactionStatus.FAILURE, "Missing required Spring services.", transactionEntity);
            return ABORTED;
        }

        // Proceed only if Finacle successfully debited the funds
        if (transactionEntity == null || transactionEntity.getFinacleStatus() != FINACLE_DEBITED) {
            updateJposContextAndReversal(ctx, rrn, TransactionStatus.FAILURE, "Finacle status is not FINACLE_DEBITED. Aborting.", transactionEntity);
            return ABORTED;
        }

        // Retrieve original channel request
        ChannelCreditTransferDetailsReq channelRequest = (ChannelCreditTransferDetailsReq) ctx.get(JposConstants.TRANSACTION_CONTEXT);
        if (channelRequest == null) {
            updateJposContextAndReversal(ctx, rrn, TransactionStatus.FAILURE, "Channel request is missing in context.", transactionEntity);
            return ABORTED;
        }

        try {
            // Compose the ISO20022 PACS.008 XML request
            String pacs008Xml = isoPayloadXmlComposerService.composePacs008TransactionRequest(ctx, channelRequest);
            log.info("{}: PACS.008 message composed. Length: {}", rrn, pacs008Xml.length());

            // Store XML in context for next participant
            ctx.put(JposConstants.ISO20022_PACS008_REQUEST_XML, pacs008Xml);

            // Explicitly mark reversal flag
            ctx.put(JposConstants.NEEDS_FINACLE_TRANSACTION_LEG_REVERSAL, false);
            ctx.put(JposConstants.NEEDS_FINACLE_CHARGES_LEG_REVERSAL, false);
            updateJposContext(ctx, rrn, TransactionStatus.PENDING, "PACS.008 composed successfully.");
            return PREPARED;

        } catch (Exception e) {
            log.error("{}: Failed to build PACS.008: {}", rrn, e.getMessage(), e);
            updateJposContextAndReversal(ctx, rrn, TransactionStatus.FAILURE, "Failed to build ISO20022 message: " + e.getMessage(), transactionEntity);
            return ABORTED;
        }
    }

    @Override
    public void commit(long id, Serializable ctx) {
        String rrn = (String) ((Context) ctx).get(JposConstants.RRN);
        log.info("{}: Commit phase — no action needed.", rrn);
    }

    @Override
    public void abort(long id, Serializable ctx) {
        String rrn = (String) ((Context) ctx).get(JposConstants.RRN);
        log.info("{}: Abort phase — no action needed.", rrn);
    }

    // Update jPOS context with status and message only — does not affect reversal logic
    private void updateJposContext(Context ctx, String rrn, TransactionStatus status, String message) {
        if (status == TransactionStatus.FAILURE || status == TransactionStatus.TIMEOUT) {
            log.error("{}: {}", rrn, message);
        } else {
            log.info("{}: {}", rrn, message);
        }
        ctx.put(JposConstants.TXN_STATUS, status);
        ctx.put(JposConstants.STATUS_CODE, status.getCode());
        ctx.put(JposConstants.STATUS_MESSAGE, message);

        // Disable PAPSS processing on failure
        ctx.put(JposConstants.NEEDS_PAPSS_PROCESSING, (status != TransactionStatus.FAILURE && status != TransactionStatus.TIMEOUT));
    }

    // Update jPOS context and also evaluate if reversal is needed
    private void updateJposContextAndReversal(Context ctx, String rrn, TransactionStatus status, String message, TransactionMaster entity) {
        updateJposContext(ctx, rrn, status, message);

        boolean needsReversal = entity != null
                && entity.getFinacleStatus() == FINACLE_DEBITED
                && status == TransactionStatus.FAILURE;

        // Only mark reversal as needed if Finacle was debited and current status is FAILURE (not TIMEOUT)
        ctx.put(JposConstants.NEEDS_FINACLE_TRANSACTION_LEG_REVERSAL, needsReversal);
        ctx.put(JposConstants.NEEDS_FINACLE_CHARGES_LEG_REVERSAL, needsReversal);

        if (needsReversal) {
            log.warn("{}: Finacle debited and failure detected. Reversal required. Flag NEEDS_FINACLE_REVERSAL = true.", rrn);
        } else {
            log.info("{}: No reversal required. Finacle not debited or failure not applicable.", rrn);
        }
    }
}
