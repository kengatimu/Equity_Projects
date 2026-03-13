package com.equitybank.gag.papss.ots.jpos.space.participants;

import com.equitybank.gag.papss.ots.jpos.space.configs.JposConstants;
import com.equitybank.gag.papss.ots.jpos.space.configs.SpringBeanLoader;
import com.equitybank.gag.papss.ots.entity.TransactionMaster;
import com.equitybank.gag.papss.ots.enums.TransactionStatus;
import com.equitybank.gag.papss.ots.enums.TransactionType;
import com.equitybank.gag.papss.ots.exception.CustomException;
import com.equitybank.gag.papss.ots.service.DatabaseService;
import com.equitybank.gag.papss.ots.service.HttpAdapterService;
import org.jpos.transaction.Context;
import org.jpos.transaction.TransactionParticipant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;

import java.io.Serializable;

import static com.equitybank.gag.papss.ots.enums.TransactionStatus.FINACLE_DEBITED;
import static com.equitybank.gag.papss.ots.enums.TransactionStatus.TIMEOUT;

public class SendHttpMessagesParticipant implements TransactionParticipant {

    private static final Logger log = LoggerFactory.getLogger(SendHttpMessagesParticipant.class);

    private HttpAdapterService httpAdapterService;
    private DatabaseService databaseService;

    public SendHttpMessagesParticipant() {
        ApplicationContext context = SpringBeanLoader.getApplicationContext();
        if (context != null) {
            try {
                this.httpAdapterService = context.getBean(HttpAdapterService.class);
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

        // Ensure HTTP adapter service is available
        if (httpAdapterService == null) {
            updateJposContextAndReversal(ctx, rrn, TransactionStatus.FAILURE, "HTTP Adapter service not initialized.", transactionEntity);
            return ABORTED;
        }

        // Retrieve the signed PACS.008 XML from context
        String signedPacs008Xml = (String) ctx.get(JposConstants.ISO20022_SIGNED_PACS008_XML);
        if (signedPacs008Xml == null || signedPacs008Xml.isEmpty()) {
            updateJposContextAndReversal(ctx, rrn, TransactionStatus.FAILURE, "Signed PACS.008 XML not found in context.", transactionEntity);
            return ABORTED;
        }

        try {
            // Send the signed ISO 20022 message using the HttpAdapterService
            String httpResponseString = httpAdapterService.sendHttpTransactionRequest(ctx,rrn, signedPacs008Xml, TransactionType.CREDIT_TRANSFER.name());
            log.info("{}: HTTP message sent successfully. CloseableHttpResponse received.", rrn);

            // Store the CloseableHttpResponse object in context for the next participant (ProcessHttpResponseParticipant)
            ctx.put(JposConstants.HTTP_RESPONSE, httpResponseString);

            // Explicitly mark reversal unnecessary for this step
            ctx.put(JposConstants.NEEDS_FINACLE_TRANSACTION_LEG_REVERSAL, false);
            ctx.put(JposConstants.NEEDS_FINACLE_CHARGES_LEG_REVERSAL, false);
            updateJposContext(ctx, rrn, TransactionStatus.PENDING, "HTTP message sent successfully. CloseableHttpResponse stored.");

            // Remove signed message from context
            ctx.put(JposConstants.ISO20022_SIGNED_PACS008_XML, "[Signed PACS008 context excluded]");
            return PREPARED;
        } catch (Exception e) {
            log.error("{}: Unexpected exception occurred when sending HTTP message: {}", rrn, e.getMessage());
            updateJposContextAndReversal(ctx, rrn, TransactionStatus.FAILURE, "Failed to send HTTP message: " + e.getMessage(), transactionEntity);

            // Remove signed message from context
            ctx.put(JposConstants.ISO20022_SIGNED_PACS008_XML, "[Signed PACS008 context excluded]");
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

    // Update jPOS context with transaction status, code, and message. Also disables further PAPSS processing in case of failure.
    private void updateJposContext(Context ctx, String rrn, TransactionStatus status, String message) {
        if (status == TransactionStatus.FAILURE || status == TransactionStatus.TIMEOUT) {
            log.error("{}: {}", rrn, message);
        } else {
            log.info("{}: {}", rrn, message);
        }

        // Handle timeout status
        if (message != null) {
            // Normalize to lowercase for consistent matching
            String lowerMessage = message.toLowerCase();
            if (lowerMessage.contains("timeout")
                    || lowerMessage.contains("time out")
                    || lowerMessage.contains("timed out")) {
                status = TIMEOUT;
            }
        }

        ctx.put(JposConstants.TXN_STATUS, status);
        ctx.put(JposConstants.STATUS_CODE, status.getCode());
        ctx.put(JposConstants.STATUS_MESSAGE, message);

        // Disable PAPSS flow if this participant fails or times out
        ctx.put(JposConstants.NEEDS_PAPSS_PROCESSING, (status != TransactionStatus.FAILURE && status != TransactionStatus.TIMEOUT));
    }


    // Update jPOS context and also evaluate if reversal is needed.
    private void updateJposContextAndReversal(Context ctx, String rrn, TransactionStatus status, String message, TransactionMaster entity) {
        // Handle timeout status
        if (message != null && (message.toLowerCase().contains("timeout")
                || message.toLowerCase().contains("time out")
                || message.toLowerCase().contains("timed out"))) {
            status = TransactionStatus.TIMEOUT;
        }

        // Update context
        updateJposContext(ctx, rrn, status, message);

        // Check if reversal is needed
        boolean needsReversal = entity != null
                && entity.getFinacleStatus() == FINACLE_DEBITED
                && status == TransactionStatus.FAILURE;

        ctx.put(JposConstants.NEEDS_FINACLE_TRANSACTION_LEG_REVERSAL, needsReversal);
        ctx.put(JposConstants.NEEDS_FINACLE_CHARGES_LEG_REVERSAL, needsReversal);

        if (needsReversal) {
            log.warn("{}: Transaction failed after Finacle debit. Flagging for reversal.", rrn);
        } else {
            log.info("{}: Reversal not required. Status: {} ", rrn, status);
        }
        log.info("{}: Transaction Reversal flag: {}", rrn, ctx.get(JposConstants.NEEDS_FINACLE_TRANSACTION_LEG_REVERSAL));
        log.info("{}: Charges Reversal flag: {}", rrn, ctx.get(JposConstants.NEEDS_FINACLE_CHARGES_LEG_REVERSAL));
    }
}