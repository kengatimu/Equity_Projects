package com.equitybank.gag.papss.ots.jpos.space.participants;

import com.equitybank.gag.papss.ots.jpos.space.configs.JposConstants;
import com.equitybank.gag.papss.ots.jpos.space.configs.SpringBeanLoader;
import com.equitybank.gag.papss.ots.jpos.jposService.ISOMsgSerializerAndDeserializerService;
import com.equitybank.gag.papss.ots.jpos.jposService.SendToFinacleService;
import com.equitybank.gag.papss.ots.dto.channelRequest.transaction.ChannelCreditTransferDetailsReq;
import com.equitybank.gag.papss.ots.entity.FinacleTransaction;
import com.equitybank.gag.papss.ots.entity.TransactionPayload;
import com.equitybank.gag.papss.ots.entity.TransactionMaster;
import com.equitybank.gag.papss.ots.enums.TransactionStatus;
import com.equitybank.gag.papss.ots.enums.TransactionType;
import com.equitybank.gag.papss.ots.exception.CustomException;
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

import static com.equitybank.gag.papss.ots.config.ApplicationConstants.FINACLE_TIMEOUT_ERROR;

/**
 * jPOS Transaction Participant that sends ISO 8583 requests to Finacle
 * for both principal and charges legs, and updates DB + context.
 */
public class SendToFinacleParticipant implements TransactionParticipant {
    private static final Logger log = LoggerFactory.getLogger(SendToFinacleParticipant.class);

    private SendToFinacleService sendToFinacleService;
    private DatabaseService databaseService;
    private ISOMsgSerializerAndDeserializerService isoMsgSerializerAndDeserializerService;
    private Map<String, String> finacleErrorMapping;

    public SendToFinacleParticipant() {
        // Load Spring-managed beans for Finacle communication and DB writes
        ApplicationContext context = SpringBeanLoader.getApplicationContext();
        if (context != null) {
            try {
                sendToFinacleService = context.getBean(SendToFinacleService.class);
                databaseService = context.getBean(DatabaseService.class);
                isoMsgSerializerAndDeserializerService = context.getBean(ISOMsgSerializerAndDeserializerService.class);
                this.finacleErrorMapping = (Map<String, String>) context.getBean("finacleErrorMapping");
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
        Context ctx = (Context) serializedContext;
        String rrn = (String) ctx.get(JposConstants.RRN);

        log.info("{}: Starting ISO 8583 send to Finacle.", rrn);

        // Retrieve ISO messages and channel request from context
        ISOMsg requestTransactionIsoMessage = (ISOMsg) ctx.get(JposConstants.ISO_MESSAGE_FINACLE_TRANSACTION_REQUEST);
        ISOMsg requestChargesIsoMessage = (ISOMsg) ctx.get(JposConstants.ISO_MESSAGE_FINACLE_CHARGES_REQUEST);
        ChannelCreditTransferDetailsReq request = (ChannelCreditTransferDetailsReq) ctx.get(JposConstants.TRANSACTION_CONTEXT);

        // Validate required Spring services
        if (sendToFinacleService == null || databaseService == null || isoMsgSerializerAndDeserializerService == null) {
            updateJposContext(ctx, rrn, TransactionStatus.FAILURE, "Required Spring services not available.");
            return ABORTED;
        }

        // Validate mandatory request object
        if (request == null) {
            updateJposContext(ctx, rrn, TransactionStatus.FAILURE, "Transaction context missing.");
            return ABORTED;
        }

        // Validate principal ISO request
        if (requestTransactionIsoMessage == null) {
            updateJposContext(ctx, rrn, TransactionStatus.FAILURE, "Transaction ISO request is missing from context.");
            return ABORTED;
        }

        // Validate charges ISO request
        if (requestChargesIsoMessage == null) {
            updateJposContext(ctx, rrn, TransactionStatus.FAILURE, "Charges ISO request is missing from context.");
            return ABORTED;
        }

        TransactionMaster entity;
        try {
            // Reload latest entity to avoid stale updates
            entity = databaseService.getSavedRecord(rrn, TransactionType.CREDIT_TRANSFER);
            ctx.put(JposConstants.TRANSACTION_ENTITY_CONTEXT, entity);
            log.info("{}: Loaded latest TransactionMaster from DB.", rrn);
        } catch (Exception e) {
            updateJposContext(ctx, rrn, TransactionStatus.FAILURE, "Failed to load latest transaction from DB: " + e.getMessage());
            return ABORTED;
        }

        // Extract payload for writing ISO request/response
        TransactionPayload transactionPayload = entity.getTransactionPayload();
        if (transactionPayload == null) {
            updateJposContext(ctx, rrn, TransactionStatus.FAILURE, "Payload is missing from TransactionMaster.");
            return ABORTED;
        }

        String bankId = request.getChannelInfo().getBankId();

        try {
            // -------- PRINCIPAL LEG --------
            log.info("{}: Sending principal debit ISO to Finacle.", rrn);
            ISOMsg principalResponseIsoMsg = sendToFinacleService.sendTransaction(rrn, requestTransactionIsoMessage, bankId, TransactionType.CREDIT_TRANSFER, "Transaction Leg");

            // Save principal ISO response to payload
            byte[] principalResponseBytes = isoMsgSerializerAndDeserializerService.serializeISOMsg(principalResponseIsoMsg);
            transactionPayload.setFinTxnIsoResponse(principalResponseBytes);
            transactionPayload.setUpdatedAt(OffsetDateTime.now());

            // Put principal response in context
            ctx.put(JposConstants.ISO_MESSAGE_FINACLE_TRANSACTION_RESPONSE, principalResponseIsoMsg);
            ctx.put(JposConstants.ISO_MESSAGE_FINACLE_TRANSACTION_RESPONSE + "_BYTES", "[ISOMsg content excluded]");

            // Validate principal F39
            String f39Principal = principalResponseIsoMsg.getString(39);
            if (!"000".equals(f39Principal)) {
                // Get finacle error description
                String errorDesc = finacleErrorMapping.getOrDefault(f39Principal, "Unknown Finacle error: " + f39Principal);
                log.info("{}: Finacle charges posting unsuccessful. Finacle status code: {}: {}", rrn, f39Principal, errorDesc);

                updateJposContext(ctx, rrn, TransactionStatus.FAILURE, "Finacle principal posting failed: " + f39Principal);
                ctx.put(JposConstants.NEEDS_FINACLE_TRANSACTION_LEG_REVERSAL, false);
                return ABORTED;
            }

            log.info("{}: Finacle principal posting successful. Finacle status code: {}", rrn, f39Principal);

            // -------- CHARGES LEG --------
            log.info("{}: Sending transaction charges debit ISO to Finacle.", rrn);
            ISOMsg responseChargesIso = sendToFinacleService.sendTransaction(rrn, requestChargesIsoMessage, bankId, TransactionType.CREDIT_TRANSFER, "Charges Leg");

            // Save charges ISO response to payload
            byte[] responseChargesBytes = isoMsgSerializerAndDeserializerService.serializeISOMsg(responseChargesIso);
            transactionPayload.setFinChargesIsoResponse(responseChargesBytes);
            transactionPayload.setUpdatedAt(OffsetDateTime.now());

            // Put charges response in context
            ctx.put(JposConstants.ISO_MESSAGE_FINACLE_CHARGES_RESPONSE, responseChargesIso);
            ctx.put(JposConstants.ISO_MESSAGE_FINACLE_CHARGES_RESPONSE + "_BYTES", "[ISOMsg content excluded]");

            // Validate charges F39
            String f39Charges = responseChargesIso.getString(39);
            if (!"000".equals(f39Charges)) {
                // Get finacle error description
                String errorDesc = finacleErrorMapping.getOrDefault(f39Charges, "Unknown Finacle error: " + f39Charges);
                log.info("{}: Finacle charges posting unsuccessful. Finacle status code: {}: {}", rrn, f39Charges, errorDesc);

                updateJposContext(ctx, rrn, TransactionStatus.FAILURE, "Finacle charges posting failed: " + f39Charges);
                ctx.put(JposConstants.NEEDS_FINACLE_TRANSACTION_LEG_REVERSAL, true);
                ctx.put(JposConstants.NEEDS_FINACLE_CHARGES_LEG_REVERSAL, false);
                return ABORTED;
            }

            log.info("{}: Finacle charges posting successful.Finacle status code: {}", rrn, f39Principal);

            // Both principal and charges succeeded
            entity.setStatus(TransactionStatus.PENDING);
            entity.setResponseCode(TransactionStatus.PENDING.getCode());
            entity.setResponseMessage(TransactionStatus.PENDING.getDescription());
            entity.setUpdatedAt(OffsetDateTime.now());

            databaseService.updateDbRecord(entity);
            updateJposContext(ctx, rrn, TransactionStatus.PENDING, "Finacle principal and charges posted successfully.");

            return PREPARED;

        } catch (CustomException e) {
            // Finacle-specific timeout or comms error
            handleFinacleException(ctx, rrn, entity, transactionPayload, e);
            ctx.put(JposConstants.ISO_MESSAGE_FINACLE_TRANSACTION_REQUEST, "Removed isoMessageFinacleTransactionRequest from context");
            ctx.put(JposConstants.ISO_MESSAGE_FINACLE_CHARGES_REQUEST, "Removed isoMessageFinacleChargesRequest from context");
            return ABORTED;

        } catch (Exception e) {
            // Unexpected runtime error
            handleUnexpectedException(ctx, rrn, entity, transactionPayload, e);
            ctx.put(JposConstants.ISO_MESSAGE_FINACLE_TRANSACTION_REQUEST, "Removed isoMessageFinacleTransactionRequest from context");
            ctx.put(JposConstants.ISO_MESSAGE_FINACLE_CHARGES_REQUEST, "Removed isoMessageFinacleChargesRequest from context");
            return ABORTED;
        }
    }

    @Override
    public void commit(long id, Serializable ctx) {
        // Nothing required during commit for Finacle posting
        String rrn = (String) ((Context) ctx).get(JposConstants.RRN);
        log.info("{}: Commit phase (no action).", rrn);
    }

    @Override
    public void abort(long id, Serializable ctx) {
        // Reversal is handled by TransactionErrorHandlingParticipant
        String rrn = (String) ((Context) ctx).get(JposConstants.RRN);
        log.info("{}: Abort phase (no action).", rrn);
    }

    // Write context state for downstream participants
    private void updateJposContext(Context ctx, String rrn, TransactionStatus status, String message) {
        if (status == TransactionStatus.FAILURE || status == TransactionStatus.TIMEOUT || status == TransactionStatus.FINACLE_TIMEOUT) {
            log.error("{}: {}", rrn, message);
        } else {
            log.info("{}: {}", rrn, message);
        }
        ctx.put(JposConstants.TXN_STATUS, status);
        ctx.put(JposConstants.STATUS_CODE, status.getCode());
        ctx.put(JposConstants.STATUS_MESSAGE, message);
    }

    // Handle Finacle timeout or communication-related errors
    private void handleFinacleException(Context ctx, String rrn, TransactionMaster entity, TransactionPayload transactionPayload, CustomException e) {
        boolean isTimeout = e.getMessage() != null && e.getMessage().contains(FINACLE_TIMEOUT_ERROR);
        TransactionStatus status = isTimeout ? TransactionStatus.FINACLE_TIMEOUT : TransactionStatus.FAILURE;
        String message = e.getMessage();

        entity.setStatus(status);
        entity.setResponseCode(status.getCode());
        entity.setResponseMessage(message);
        entity.setFinacleStatus(status);
        entity.setFinacleResponseCode(status.getCode());
        entity.setFinacleResponseMessage(message);
        entity.setCompletedAt(OffsetDateTime.now());
        entity.setUpdatedAt(OffsetDateTime.now());

        transactionPayload.setFinTxnIsoResponse(null);
        transactionPayload.setUpdatedAt(OffsetDateTime.now());

        FinacleTransaction finacleTransaction = entity.getFinacleTransaction();
        if (finacleTransaction != null) {
            finacleTransaction.setFinacleStatus(status);
            finacleTransaction.setFinacleResponseCode(status.getCode());
            finacleTransaction.setFinacleResponseDesc(message);
            finacleTransaction.setUpdatedAt(OffsetDateTime.now());
        }

        try {
            databaseService.updateDbRecord(entity);
            updateJposContext(ctx, rrn, status, message);
        } catch (Exception ex) {
            log.error("{}: Failed to persist after Finacle error: {}", rrn, ex.getMessage(), ex);
            updateJposContext(ctx, rrn, TransactionStatus.FAILURE, "Finacle error, DB update also failed.");
        }
    }

    // Handle unknown/unexpected runtime errors
    private void handleUnexpectedException(Context ctx, String rrn, TransactionMaster entity, TransactionPayload transactionPayload, Exception e) {
        String message = "Unexpected Finacle error: " + e.getMessage();
        log.error("{}: {}", rrn, message, e);

        entity.setStatus(TransactionStatus.FAILURE);
        entity.setResponseCode(TransactionStatus.FAILURE.getCode());
        entity.setResponseMessage(message);
        entity.setFinacleStatus(TransactionStatus.FAILURE);
        entity.setFinacleResponseCode(TransactionStatus.FAILURE.getCode());
        entity.setFinacleResponseMessage(message);
        entity.setCompletedAt(OffsetDateTime.now());
        entity.setUpdatedAt(OffsetDateTime.now());

        if (transactionPayload != null) {
            transactionPayload.setFinTxnIsoResponse(null);
            transactionPayload.setUpdatedAt(OffsetDateTime.now());
        }

        FinacleTransaction finacleTransaction = entity.getFinacleTransaction();
        if (finacleTransaction != null) {
            finacleTransaction.setFinacleStatus(TransactionStatus.FAILURE);
            finacleTransaction.setFinacleResponseCode(TransactionStatus.FAILURE.getCode());
            finacleTransaction.setFinacleResponseDesc(message);
            finacleTransaction.setUpdatedAt(OffsetDateTime.now());
        }

        try {
            databaseService.updateDbRecord(entity);
            updateJposContext(ctx, rrn, TransactionStatus.FAILURE, message);
        } catch (Exception ex) {
            log.error("{}: DB update failed after unexpected error: {}", rrn, ex.getMessage(), ex);
            updateJposContext(ctx, rrn, TransactionStatus.FAILURE, "Unexpected error, DB update failed too.");
        }
    }
}
