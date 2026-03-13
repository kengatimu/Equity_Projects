package com.equitybank.gag.papss.ots.jpos.space.participants;

import com.equitybank.gag.papss.ots.jpos.space.configs.JposConstants;
import com.equitybank.gag.papss.ots.jpos.space.configs.SpringBeanLoader;
import com.equitybank.gag.papss.ots.jpos.jposService.ISOMsgSerializerAndDeserializerService;
import com.equitybank.gag.papss.ots.entity.FinacleTransaction;
import com.equitybank.gag.papss.ots.entity.TransactionPayload;
import com.equitybank.gag.papss.ots.entity.TransactionMaster;
import com.equitybank.gag.papss.ots.enums.TransactionStatus;
import com.equitybank.gag.papss.ots.enums.TransactionType;
import com.equitybank.gag.papss.ots.service.DatabaseService;
import org.jpos.iso.ISOMsg;
import org.jpos.transaction.Context;
import org.jpos.transaction.TransactionParticipant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;

import java.io.Serializable;
import java.time.OffsetDateTime;
import java.util.Map;

/**
 * jPOS Participant that processes Finacle ISO responses.
 * - Reads principal + charges ISO responses
 * - Determines success per F39
 * - Updates DB state accordingly
 * - Sets reversal flags when needed
 * - Sets PAPSS routing flag only when BOTH legs succeed
 */
public class ProcessFinacleResponseParticipant implements TransactionParticipant {
    private static final Logger log = LoggerFactory.getLogger(ProcessFinacleResponseParticipant.class);

    private final DatabaseService databaseService;
    private final Map<String, String> finacleErrorMapping;
    private final ISOMsgSerializerAndDeserializerService isoMsgSerializerAndDeserializerService;

    public ProcessFinacleResponseParticipant() {
        ApplicationContext context = SpringBeanLoader.getApplicationContext();
        ISOMsgSerializerAndDeserializerService isoMsgSerializer = null;
        DatabaseService dbSvc = null;
        Map<String, String> errMap = null;

        if (context != null) {
            try {
                dbSvc = context.getBean(DatabaseService.class);
                errMap = (Map<String, String>) context.getBean("finacleErrorMapping");
                isoMsgSerializer = context.getBean(ISOMsgSerializerAndDeserializerService.class);
                log.info("Spring beans loaded successfully.");
            } catch (Exception e) {
                log.error("Failed to load Spring beans: {}", e.getMessage(), e);
            }
        } else {
            log.error("ApplicationContext is null.");
        }

        this.databaseService = dbSvc;
        this.finacleErrorMapping = errMap;
        this.isoMsgSerializerAndDeserializerService = isoMsgSerializer;
    }

    @Override
    public int prepare(long id, Serializable ctxObj) {
        Context ctx = (Context) ctxObj;
        String rrn = (String) ctx.get(JposConstants.RRN);

        log.info("{}: Preparing Finacle response.", rrn);

        // Validate required beans
        if (databaseService == null || finacleErrorMapping == null || isoMsgSerializerAndDeserializerService == null) {
            updateJposContext(ctx, rrn, TransactionStatus.FAILURE, "Missing required beans.");
            ctx.put(JposConstants.NEEDS_PAPSS_PROCESSING, false);
            ctx.put(JposConstants.NEEDS_FINACLE_TRANSACTION_LEG_REVERSAL, false);
            ctx.put(JposConstants.NEEDS_FINACLE_CHARGES_LEG_REVERSAL, false);
            return ABORTED;
        }

        // Load latest DB state for accuracy
        TransactionMaster entity;
        try {
            entity = databaseService.getSavedRecord(rrn, TransactionType.CREDIT_TRANSFER);
            ctx.put(JposConstants.TRANSACTION_ENTITY_CONTEXT, entity);
            log.info("{}: Loaded latest TransactionMaster from DB.", rrn);
        } catch (Exception e) {
            updateJposContext(ctx, rrn, TransactionStatus.FAILURE, "Failed to load transaction from DB: " + e.getMessage());
            ctx.put(JposConstants.NEEDS_PAPSS_PROCESSING, false);
            ctx.put(JposConstants.NEEDS_FINACLE_TRANSACTION_LEG_REVERSAL, false);
            ctx.put(JposConstants.NEEDS_FINACLE_CHARGES_LEG_REVERSAL, false);
            return ABORTED;
        }

        // Retrieve ISO responses from context
        ISOMsg principalIsoResponse = (ISOMsg) ctx.get(JposConstants.ISO_MESSAGE_FINACLE_TRANSACTION_RESPONSE);
        ISOMsg chargesIsoResponse = (ISOMsg) ctx.get(JposConstants.ISO_MESSAGE_FINACLE_CHARGES_RESPONSE);

        TransactionPayload transactionPayload = entity.getTransactionPayload();

        // If principal ISO missing, try to restore from DB
        if (principalIsoResponse == null) {
            if (transactionPayload == null || transactionPayload.getFinTxnIsoResponse() == null) {
                updateJposContext(ctx, rrn, TransactionStatus.FAILURE, "Principal ISO response missing.");
                ctx.put(JposConstants.NEEDS_PAPSS_PROCESSING, false);
                ctx.put(JposConstants.NEEDS_FINACLE_TRANSACTION_LEG_REVERSAL, false);
                ctx.put(JposConstants.NEEDS_FINACLE_CHARGES_LEG_REVERSAL, false);
                return ABORTED;
            }

            try {
                principalIsoResponse = isoMsgSerializerAndDeserializerService.deserializeISOMsg(transactionPayload.getFinTxnIsoResponse());
                ctx.put(JposConstants.ISO_MESSAGE_FINACLE_TRANSACTION_RESPONSE, principalIsoResponse);
                log.info("{}: Principal ISO response restored from transactionPayload.", rrn);
            } catch (Exception e) {
                updateJposContext(ctx, rrn, TransactionStatus.FAILURE, "Failed to deserialize principal ISO response: " + e.getMessage());
                ctx.put(JposConstants.NEEDS_PAPSS_PROCESSING, false);
                ctx.put(JposConstants.NEEDS_FINACLE_TRANSACTION_LEG_REVERSAL, false);
                ctx.put(JposConstants.NEEDS_FINACLE_CHARGES_LEG_REVERSAL, false);
                return ABORTED;
            }
        }

        // If charges ISO missing, try to restore from DB
        if (chargesIsoResponse == null) {
            if (transactionPayload == null || transactionPayload.getFinChargesIsoResponse() == null) {
                // At this point principal succeeded but charges missing → reversal needed
                updateJposContext(ctx, rrn, TransactionStatus.FAILURE, "Charges ISO response missing.");
                ctx.put(JposConstants.NEEDS_FINACLE_TRANSACTION_LEG_REVERSAL, true);
                ctx.put(JposConstants.NEEDS_FINACLE_CHARGES_LEG_REVERSAL, false);
                ctx.put(JposConstants.NEEDS_PAPSS_PROCESSING, false);
                return ABORTED;
            }

            try {
                chargesIsoResponse = isoMsgSerializerAndDeserializerService.deserializeISOMsg(transactionPayload.getFinChargesIsoResponse());
                ctx.put(JposConstants.ISO_MESSAGE_FINACLE_CHARGES_RESPONSE, chargesIsoResponse);
                log.info("{}: Charges ISO response restored from transactionPayload.", rrn);
            } catch (Exception e) {
                updateJposContext(ctx, rrn, TransactionStatus.FAILURE, "Failed to deserialize charges ISO response: " + e.getMessage());
                ctx.put(JposConstants.NEEDS_FINACLE_TRANSACTION_LEG_REVERSAL, true);
                ctx.put(JposConstants.NEEDS_FINACLE_CHARGES_LEG_REVERSAL, false);
                ctx.put(JposConstants.NEEDS_PAPSS_PROCESSING, false);
                return ABORTED;
            }
        }

        // Ensure sub-entities exist
        FinacleTransaction finacleTransaction = entity.getFinacleTransaction();
        try {
            // Extract F39 for both legs
            String f39Principal = principalIsoResponse.getString(39);
            String f39Charges = chargesIsoResponse.getString(39);

            // Guard: principal F39 must exist
            if (f39Principal == null || f39Principal.isBlank()) {
                handleFinacleFailure(ctx, rrn, entity, finacleTransaction, "999", "Principal F39 missing.");
                ctx.put(JposConstants.NEEDS_PAPSS_PROCESSING, false);
                return ABORTED;
            }

            // Guard: charges F39 must exist
            if (f39Charges == null || f39Charges.isBlank()) {
                handleFinacleFailure(ctx, rrn, entity, finacleTransaction, "999", "Charges F39 missing.");
                ctx.put(JposConstants.NEEDS_FINACLE_TRANSACTION_LEG_REVERSAL, true);
                ctx.put(JposConstants.NEEDS_PAPSS_PROCESSING, false);
                return ABORTED;
            }

            // Both legs must return "000" for full success
            if ("000".equals(f39Principal) && "000".equals(f39Charges)) {
                String authId = principalIsoResponse.getString(38);
                handleFinacleSuccess(ctx, rrn, entity, finacleTransaction, "000", authId);

                ctx.put(JposConstants.NEEDS_PAPSS_PROCESSING, true);
                ctx.put(JposConstants.NEEDS_FINACLE_TRANSACTION_LEG_REVERSAL, false);
                ctx.put(JposConstants.NEEDS_FINACLE_CHARGES_LEG_REVERSAL, false);

                removeIsoMsgsFromContext(ctx);
                return PREPARED;
            }

            // Principal failed? stop, fail transaction, no reversals
            if (!"000".equals(f39Principal)) {
                String desc = finacleErrorMapping.getOrDefault(f39Principal, "Finacle principal error: " + f39Principal);
                handleFinacleFailure(ctx, rrn, entity, finacleTransaction, f39Principal, desc);

                ctx.put(JposConstants.NEEDS_PAPSS_PROCESSING, false);
                ctx.put(JposConstants.NEEDS_FINACLE_TRANSACTION_LEG_REVERSAL, false);
                ctx.put(JposConstants.NEEDS_FINACLE_CHARGES_LEG_REVERSAL, false);

                removeIsoMsgsFromContext(ctx);
                return ABORTED;
            }

            // Charges failed, reverse principal only. At this point, f39Charges is not 000
            String desc = finacleErrorMapping.getOrDefault(f39Charges, "Finacle charges error: " + f39Charges);
            handleFinacleFailure(ctx, rrn, entity, finacleTransaction, f39Charges, desc);

            ctx.put(JposConstants.NEEDS_PAPSS_PROCESSING, false);
            ctx.put(JposConstants.NEEDS_FINACLE_TRANSACTION_LEG_REVERSAL, true);
            ctx.put(JposConstants.NEEDS_FINACLE_CHARGES_LEG_REVERSAL, false);

            removeIsoMsgsFromContext(ctx);
            return ABORTED;

        } catch (Exception e) {
            // Generic processing error
            String err = "Exception while processing Finacle response: " + e.getMessage();
            log.error("{}: {}", rrn, err, e);

            handleFinacleFailure(ctx, rrn, entity, finacleTransaction, "999", err);

            // For safety, these flags should be false
            ctx.put(JposConstants.NEEDS_PAPSS_PROCESSING, false);
            ctx.put(JposConstants.NEEDS_FINACLE_TRANSACTION_LEG_REVERSAL, false);
            ctx.put(JposConstants.NEEDS_FINACLE_CHARGES_LEG_REVERSAL, false);

            removeIsoMsgsFromContext(ctx);
            return ABORTED;
        }
    }

    @Override
    public void commit(long id, Serializable ctx) {
        String rrn = (String) ((Context) ctx).get(JposConstants.RRN);
        log.info("{}: Commit phase (no action).", rrn);
    }

    @Override
    public void abort(long id, Serializable ctx) {
        String rrn = (String) ((Context) ctx).get(JposConstants.RRN);
        log.info("{}: Abort phase (no action).", rrn);
    }

    private void removeIsoMsgsFromContext(Context ctx) {
        // Clear ISO messages to reduce memory and avoid misuse by next participants
        ctx.put(JposConstants.ISO_MESSAGE_FINACLE_TRANSACTION_REQUEST, "[excluded]");
        ctx.put(JposConstants.ISO_MESSAGE_FINACLE_TRANSACTION_RESPONSE, "[excluded]");
        ctx.put(JposConstants.ISO_MESSAGE_FINACLE_CHARGES_REQUEST, "[excluded]");
        ctx.put(JposConstants.ISO_MESSAGE_FINACLE_CHARGES_RESPONSE, "[excluded]");
    }

    private void handleFinacleSuccess(Context ctx, String rrn, TransactionMaster entity, FinacleTransaction finacleTransaction, String responseCode, String authId) {
        // Mark Finacle debit as successful
        finacleTransaction.setFinacleStatus(TransactionStatus.FINACLE_DEBITED);
        finacleTransaction.setFinacleResponseCode(TransactionStatus.FINACLE_DEBITED.getCode());
        finacleTransaction.setFinacleResponseDesc(TransactionStatus.FINACLE_DEBITED.getDescription());
        finacleTransaction.setFinacleTranId(authId);
        finacleTransaction.setUpdatedAt(OffsetDateTime.now());

        // Move TransactionMaster to a Pending state (awaiting PAPSS)
        entity.setStatus(TransactionStatus.PENDING);
        entity.setResponseCode(TransactionStatus.PENDING.getCode());
        entity.setResponseMessage(TransactionStatus.PENDING.getDescription());
        entity.setFinacleStatus(TransactionStatus.FINACLE_DEBITED);
        entity.setFinacleResponseCode(TransactionStatus.FINACLE_DEBITED.getCode());
        entity.setFinacleResponseMessage(TransactionStatus.FINACLE_DEBITED.getDescription());
        entity.setUpdatedAt(OffsetDateTime.now());
        entity.setCompletedAt(OffsetDateTime.now());

        try {
            databaseService.updateDbRecord(entity);
            updateJposContext(ctx, rrn, TransactionStatus.PENDING, "Finacle debit OK. Routing to PAPSS.");
        } catch (Exception e) {
            log.error("{}: DB update failed after Finacle success: {}", rrn, e.getMessage(), e);
            entity.setStatus(TransactionStatus.FAILURE);
            entity.setResponseMessage("Finacle OK but DB update failed: " + e.getMessage());
            updateJposContext(ctx, rrn, TransactionStatus.FAILURE, entity.getResponseMessage());
        }
    }

    private void handleFinacleFailure(Context ctx, String rrn, TransactionMaster entity, FinacleTransaction finacleTransaction, String responseCode, String responseDesc) {
        TransactionStatus status = TransactionStatus.FAILURE;
        String statusCode = status.getCode();

        if (responseDesc.toLowerCase().contains("timeout")) {
            status = TransactionStatus.FINACLE_TIMEOUT;
            statusCode = TransactionStatus.TIMEOUT.getCode();
        }

        // Update TransactionMaster with failure
        entity.setStatus(status);
        entity.setResponseCode(statusCode);
        entity.setResponseMessage(responseDesc);
        entity.setFinacleStatus(status);
        entity.setFinacleResponseCode(responseCode);
        entity.setFinacleResponseMessage(responseDesc);
        entity.setCompletedAt(OffsetDateTime.now());
        entity.setUpdatedAt(OffsetDateTime.now());

        // Update FinacleTransaction child record
        finacleTransaction.setFinacleStatus(status);
        finacleTransaction.setFinacleResponseCode(responseCode);
        finacleTransaction.setFinacleResponseDesc(responseDesc);
        finacleTransaction.setUpdatedAt(OffsetDateTime.now());

        try {
            databaseService.updateDbRecord(entity);
            updateJposContext(ctx, rrn, status, responseDesc);
        } catch (Exception e) {
            log.error("{}: DB update failed after Finacle failure: {}", rrn, e.getMessage(), e);
            updateJposContext(ctx, rrn, status, "Finacle failed; DB update error: " + e.getMessage());
        }
    }

    private void updateJposContext(Context ctx, String rrn, TransactionStatus status, String message) {
        if (status == TransactionStatus.FAILURE ||
                status == TransactionStatus.TIMEOUT ||
                status == TransactionStatus.REVERSED_NOK) {
            log.error("{}: {}", rrn, message);
        } else {
            log.info("{}: {}", rrn, message);
        }

        String statusCode = status.getCode();
        if (status == TransactionStatus.FINACLE_TIMEOUT) {
            statusCode = TransactionStatus.TIMEOUT.getCode();
        }

        // Put status values into context for next participants
        ctx.put(JposConstants.TXN_STATUS, status);
        ctx.put(JposConstants.STATUS_CODE, statusCode);
        ctx.put(JposConstants.STATUS_MESSAGE, message);
    }
}
