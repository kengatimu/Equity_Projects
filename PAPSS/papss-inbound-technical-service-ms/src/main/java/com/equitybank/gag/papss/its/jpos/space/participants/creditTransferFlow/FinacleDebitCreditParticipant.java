package com.equitybank.gag.papss.its.jpos.space.participants.creditTransferFlow;

import com.equitybank.gag.papss.its.entity.FinacleTransaction;
import com.equitybank.gag.papss.its.entity.TransactionMaster;
import com.equitybank.gag.papss.its.entity.TransactionPayload;
import com.equitybank.gag.papss.its.enums.TransactionStatus;
import com.equitybank.gag.papss.its.enums.TransactionType;
import com.equitybank.gag.papss.its.exception.CustomException;
import com.equitybank.gag.papss.its.jpos.jposService.ISOMsgSerializerAndDeserializerService;
import com.equitybank.gag.papss.its.jpos.jposService.SendToFinacleService;
import com.equitybank.gag.papss.its.jpos.space.configs.JposConstants;
import com.equitybank.gag.papss.its.jpos.space.configs.SpringBeanLoader;
import com.equitybank.gag.papss.its.service.DatabaseService;
import org.jpos.iso.ISOMsg;
import org.jpos.transaction.Context;
import org.jpos.transaction.TransactionParticipant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;

import java.io.Serializable;
import java.time.OffsetDateTime;
import java.util.Map;

import static com.equitybank.gag.papss.its.config.StatusCodeMessages.*;
import static com.equitybank.gag.papss.its.enums.PapssStatusCodes.RJCT;
import static com.equitybank.gag.papss.its.enums.TransactionStatus.*;

/**
 * jPOS participant for inbound credit transfer Finacle processing.
 * - Sends ISO 8583 debit/credit request to Finacle
 * - Processes field 39 in the response
 * - Updates DB entities and payload
 * - Decides whether reversal is needed
 */
public final class FinacleDebitCreditParticipant implements TransactionParticipant {
    private static final Logger log = LoggerFactory.getLogger(FinacleDebitCreditParticipant.class);

    private Map<String, String> finacleErrorMapping;
    private SendToFinacleService sendToFinacleService;
    private DatabaseService databaseService;
    private ISOMsgSerializerAndDeserializerService isoMsgSerializerAndDeserializerService;

    public FinacleDebitCreditParticipant() {
        // Load Spring-managed beans from the ApplicationContext
        ApplicationContext context = SpringBeanLoader.getApplicationContext();
        if (context != null) {
            try {
                this.finacleErrorMapping = (Map<String, String>) context.getBean("finacleErrorMapping");
                sendToFinacleService = context.getBean(SendToFinacleService.class);
                databaseService = context.getBean(DatabaseService.class);
                isoMsgSerializerAndDeserializerService = context.getBean(ISOMsgSerializerAndDeserializerService.class);
                log.info("Spring beans initialized.");
            } catch (Exception e) {
                log.error("Failed to initialize Spring beans: {}", e.getMessage(), e);
            }
        } else {
            log.error("ApplicationContext is null.");
        }
    }

    @Override
    public int prepare(long id, Serializable serializedContext) {
        // Operation is fixed for inbound credit transfer
        String operation = "creditTransfer";

        Context ctx = (Context) serializedContext;
        String rrn = (String) ctx.get(JposConstants.RRN);

        log.info("{}: Starting FinacleDebitCredit Participant.", rrn);

        // Abort if required services are not available
        if (sendToFinacleService == null || databaseService == null || isoMsgSerializerAndDeserializerService == null) {
            updateJposContext(ctx, rrn, "Required Spring services not available from context.");
            return ABORTED;
        }

        // Retrieve inbound PACS.008 details map
        @SuppressWarnings("unchecked")
        Map<String, String> detailsMap = (Map<String, String>) ctx.get(JposConstants.PACS008_REQUEST_MAP);
        if (detailsMap == null || detailsMap.isEmpty()) {
            updateJposContext(ctx, rrn, "Details map missing from context.");
            return ABORTED;
        }

        // Retrieve prepared ISO message from context
        ISOMsg requestIsoMessage = (ISOMsg) ctx.get(JposConstants.ISO_MESSAGE_FINACLE_REQUEST);
        if (requestIsoMessage == null) {
            updateJposContext(ctx, rrn, "ISO message request missing from context.");
            return ABORTED;
        }

        // Load the latest transaction record from DB
        TransactionMaster entity;
        try {
            entity = databaseService.getSavedRecord(rrn, TransactionType.CREDIT_TRANSFER);
            ctx.put(JposConstants.TRANSACTION_ENTITY_CONTEXT, entity);
            log.info("{}: Loaded latest TransactionMaster from DB.", rrn);
        } catch (Exception e) {
            updateJposContext(ctx, rrn, "Failed to load latest transaction from DB: " + e.getMessage());
            return ABORTED;
        }

        // Ensure transaction payload exists
        TransactionPayload transactionPayload = entity.getTransactionPayload();
        if (transactionPayload == null) {
            updateJposContext(ctx, rrn, "Payload missing from TransactionMaster entity object.");
            return ABORTED;
        }

        try {
            // Send ISO request to Finacle and get the response
            log.info("{}: Sending Transaction Request ISO Message to Finacle", rrn);
            ISOMsg responseIsoMessage = sendToFinacleService.sendTransaction(rrn, requestIsoMessage, DEFAULT_BANK_ID_KE, TransactionType.CREDIT_TRANSFER);

            // Serialize ISO response into bytes for storage
            byte[] responseBytes = isoMsgSerializerAndDeserializerService.serializeISOMsg(responseIsoMessage);

            // Put ISO response in context (excluding full content in logs)
            ctx.put(JposConstants.ISO_MESSAGE_FINACLE_RESPONSE, responseIsoMessage);
            ctx.put(JposConstants.ISO_MESSAGE_FINACLE_RESPONSE + "_BYTES", "[ISOMsg content excluded]");

            // Update payload record
            transactionPayload.setFinTxnIsoResponse(responseBytes);
            transactionPayload.setUpdatedAt(OffsetDateTime.now());

            // Process Finacle response code and update DB if service is available
            processFinacleResponse(rrn, ctx, entity, responseIsoMessage);

            // Save record in the DB
            updateDatabase(rrn, entity, "Updating DB after a successful Finacle debit credit");

            log.info("{}: Finacle response received successfully.", rrn);
            ctx.put(JposConstants.TRANSACTION_PREPARED, true);
            return PREPARED;

        } catch (CustomException e) {
            // Handle expected Finacle errors (e.g., timeout)
            handleFinacleException(ctx, rrn, entity, transactionPayload, e);
            return ABORTED;
        } catch (Exception e) {
            // Handle any other unexpected exceptions
            handleUnexpectedException(ctx, rrn, entity, transactionPayload, e);
            return ABORTED;
        }
    }

    @Override
    public void commit(long id, Serializable serialisedContext) {
        // No commit-phase actions required for this participant
        Context ctx = (Context) serialisedContext;
        String rrn = (String) ctx.get(JposConstants.RRN);
        log.info("{}: Commit phase (no action).", rrn);
    }

    @Override
    public void abort(long id, Serializable serialisedContext) {
        // No abort-phase actions required for this participant
        Context ctx = (Context) serialisedContext;
        String rrn = (String) ctx.get(JposConstants.RRN);
        log.info("{}: Abort phase (no action).", rrn);
    }

    // Process Finacle responses
    private void processFinacleResponse(String rrn, Context ctx, TransactionMaster entity, ISOMsg responseIsoMessage) {
        String responseCode = responseIsoMessage.hasField(39) ? responseIsoMessage.getString(39) : null;

        if (responseCode == null) {
            log.warn("{}: Field 39 is null - keeping transaction status as PENDING.", rrn);
            setPendingStatus(entity);
            return;
        }

        if ("000".equals(responseCode)) {
            log.info("{}: Finacle debit/ credit successful", rrn);
            setFinacleDebitedStatus(entity, responseCode);
            ctx.put(JposConstants.NEEDS_FINACLE_REVERSAL, false);
        } else {
            // Get finacle error desc
            String desc = finacleErrorMapping.getOrDefault(responseCode, "Unknown Finacle error: " + responseCode);

            log.info("{}: Finacle debit/ credit failed. Finacle code: {}. Desc: {}", rrn, responseCode, desc);
            setFinacleFailedStatus(entity, responseCode);
            ctx.put(JposConstants.NEEDS_FINACLE_REVERSAL, false);
        }
    }

    // Set status for successful debit
    private void setFinacleDebitedStatus(TransactionMaster entity, String responseCode) {
        entity.setStatus(FINACLE_DEBITED);
        entity.setResponseCode(FINACLE_DEBITED.getCode());
        entity.setResponseMessage(FINACLE_DEBITED.getDescription());
        entity.setFinacleStatus(FINACLE_DEBITED);
        entity.setFinacleResponseCode(responseCode);
        entity.setFinacleResponseMessage(FINACLE_DEBITED.getDescription());
        entity.setUpdatedAt(OffsetDateTime.now());
    }

    // Set status for failed debit
    private void setFinacleFailedStatus(TransactionMaster entity, String responseCode) {
        entity.setStatus(FAILURE);
        entity.setResponseCode(FAILURE.getCode());
        entity.setResponseMessage("Finacle debit failed with code: " + responseCode);
        entity.setFinacleStatus(FINACLE_FAILED);
        entity.setFinacleResponseCode(responseCode);
        entity.setFinacleResponseMessage(FINACLE_FAILED.getDescription());
        entity.setUpdatedAt(OffsetDateTime.now());
    }

    // Set status to pending if no field 39
    private void setPendingStatus(TransactionMaster entity) {
        entity.setStatus(PENDING);
        entity.setResponseCode(PENDING.getCode());
        entity.setResponseMessage(PENDING.getDescription());
        entity.setFinacleStatus(PENDING);
        entity.setUpdatedAt(OffsetDateTime.now());
    }

    // Handle known Finacle exceptions (timeouts, etc.)
    private void handleFinacleException(Context ctx, String rrn, TransactionMaster entity, TransactionPayload payload, CustomException e) {
        String errorMsg = e.getMessage();
        boolean isTimeout = e.getMessage() != null && e.getMessage().contains("timeout");
        TransactionStatus status = isTimeout ? FINACLE_TIMEOUT : FAILURE;

        log.error("{}: {}", rrn, errorMsg);

        // Set error statuses for DB update
        setErrorStatuses(entity, payload, status, errorMsg);

        // Attempt DB save
        updateDatabase(rrn, entity, "Updating DB after CustomException. CustomException: " + e.getMessage());

        // Update jPOS context for downstream participants
        updateJposContext(ctx, rrn, errorMsg);
    }

    // Handles any unexpected errors during Finacle send.
    private void handleUnexpectedException(Context ctx, String rrn, TransactionMaster entity, TransactionPayload payload, Exception e) {
        String errorMsg = "Unexpected Finacle error. Exception occurred: " + e.getMessage();
        log.error("{}: {}", rrn, errorMsg, e);

        // Set error statuses for DB update
        setErrorStatuses(entity, payload, FAILURE, errorMsg);

        // Attempt DB save
        updateDatabase(rrn, entity, "Updating DB after Exception. Exception: " + e.getMessage());

        // Update jPOS context for downstream participants
        updateJposContext(ctx, rrn, errorMsg);
    }

    // Common method for setting error statuses in entity + payload
    private void setErrorStatuses(TransactionMaster entity, TransactionPayload payload, TransactionStatus status, String message) {
        entity.setStatus(status);
        entity.setResponseCode(status.getCode());
        entity.setResponseMessage(message);
        entity.setFinacleStatus(status);
        entity.setFinacleResponseCode(status.getCode());
        entity.setFinacleResponseMessage(message);
        entity.setCompletedAt(OffsetDateTime.now());
        entity.setUpdatedAt(OffsetDateTime.now());

        if (payload != null) {
            payload.setFinTxnIsoResponse(null);
            payload.setUpdatedAt(OffsetDateTime.now());
        }

        FinacleTransaction finacleTransaction = entity.getFinacleTransaction();
        if (finacleTransaction != null) {
            finacleTransaction.setFinacleStatus(status);
            finacleTransaction.setFinacleResponseCode(status.getCode());
            finacleTransaction.setFinacleResponseDesc(message);
            finacleTransaction.setUpdatedAt(OffsetDateTime.now());
        }
    }

    // Attempt DB save and log any failure
    private void updateDatabase(String rrn, TransactionMaster entity, String logContext) {
        log.info("{}: {}", rrn, logContext);
        try {
            databaseService.updateDbRecord(entity);
        } catch (Exception ex) {
            log.error("{}: Failed to update DB. Exception occurred: {}", rrn, ex.getMessage());
        }
    }

    // Updates the jPOS context with failure information and prevents PAPSS posting.
    private void updateJposContext(Context ctx, String rrn, String statusMessage) {
        log.error("{}: {}", rrn, statusMessage);
        ctx.put(JposConstants.TXN_STATUS, FAILURE);
        ctx.put(JposConstants.STATUS_MESSAGE, statusMessage);
        ctx.put(JposConstants.STATUS_CODE, FAILURE.getCode());

        // PAPSS error code and message
        ctx.put(JposConstants.SENT_PAPSS_STATUS_CODE, RJCT);
        ctx.put(JposConstants.PAPSS_ERROR_CODE, DEFAULT_PAPSS_ERROR_CODE);
        ctx.put(JposConstants.PAPSS_ERROR_MESSAGE, DEFAULT_PAPSS_ERROR_MESSAGE);

        // Send a RJCT status to PAPSS after abort for this participant
        ctx.put(JposConstants.HTTP_POSTING_REQUIRED_ON_ABORT, true);

        // Set reversal flags
        ctx.put(JposConstants.NEEDS_FINACLE_REVERSAL, false);
    }
}
