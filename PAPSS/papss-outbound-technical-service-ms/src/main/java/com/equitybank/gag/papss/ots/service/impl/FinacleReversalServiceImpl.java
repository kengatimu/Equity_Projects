package com.equitybank.gag.papss.ots.service.impl;

import com.equitybank.gag.papss.ots.dto.channelResponse.ChannelResponse;
import com.equitybank.gag.papss.ots.entity.FinacleTransaction;
import com.equitybank.gag.papss.ots.entity.TransactionMaster;
import com.equitybank.gag.papss.ots.entity.TransactionPayload;
import com.equitybank.gag.papss.ots.enums.TransactionStatus;
import com.equitybank.gag.papss.ots.enums.TransactionType;
import com.equitybank.gag.papss.ots.exception.CustomException;
import com.equitybank.gag.papss.ots.jpos.jposService.ISOMessageBuilderService;
import com.equitybank.gag.papss.ots.jpos.jposService.ISOMsgSerializerAndDeserializerService;
import com.equitybank.gag.papss.ots.jpos.jposService.SendToFinacleService;
import com.equitybank.gag.papss.ots.jpos.space.configs.JposConstants;
import com.equitybank.gag.papss.ots.service.DatabaseService;
import com.equitybank.gag.papss.ots.service.FinacleReversalService;
import com.google.gson.Gson;
import org.jpos.iso.ISOMsg;
import org.jpos.transaction.Context;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.time.OffsetDateTime;
import java.util.Map;

import static com.equitybank.gag.papss.ots.jpos.space.configs.JposConstants.NEEDS_FINACLE_CHARGES_LEG_REVERSAL;
import static com.equitybank.gag.papss.ots.jpos.space.configs.JposConstants.NEEDS_FINACLE_TRANSACTION_LEG_REVERSAL;

@Service
public class FinacleReversalServiceImpl implements FinacleReversalService {
    private static final Logger log = LoggerFactory.getLogger(FinacleReversalServiceImpl.class);

    private final Gson gson;
    private final DatabaseService databaseService;
    private final ISOMessageBuilderService isoMessageBuilderService;
    private final ISOMsgSerializerAndDeserializerService isoMsgSerializerAndDeserializerService;
    private final SendToFinacleService sendToFinacleService;
    private final Map<String, String> finacleErrorMapping;

    public FinacleReversalServiceImpl(Gson gson,
                                      DatabaseService databaseService,
                                      ISOMessageBuilderService isoMessageBuilderService,
                                      ISOMsgSerializerAndDeserializerService isoMsgSerializerAndDeserializerService,
                                      SendToFinacleService sendToFinacleService,
                                      @Value("#{finacleErrorMapping}") Map<String, String> finacleErrorMapping) {
        this.gson = gson;
        this.databaseService = databaseService;
        this.isoMessageBuilderService = isoMessageBuilderService;
        this.isoMsgSerializerAndDeserializerService = isoMsgSerializerAndDeserializerService;
        this.sendToFinacleService = sendToFinacleService;
        this.finacleErrorMapping = finacleErrorMapping;
    }

    /**
     * Handles reversal during jPOS Abort phase.
     * Supports:
     * - Transaction leg reversal
     * - Charges leg reversal (new)
     */
    @Override
    public void handleJposAbortReversal(Context ctx, String rrn) {

        Boolean needsTxnLegReversal = (Boolean) ctx.get(NEEDS_FINACLE_TRANSACTION_LEG_REVERSAL);
        Boolean needsChargesReversal = (Boolean) ctx.get(NEEDS_FINACLE_CHARGES_LEG_REVERSAL);

        // === PRINCIPAL LEG REVERSAL ================================================================
        if (Boolean.TRUE.equals(needsTxnLegReversal)) {
            log.info("{}: Principal Transaction reversal flagged. Initiating Finacle transaction reversal leg.", rrn);
            try {
                performFinacleReversal(ctx, rrn);
                log.info("{}: Principal Transaction reversal leg completed successfully.", rrn);
            } catch (Exception e) {
                log.error("{}: Transaction reversal failed leg: {}", rrn, e.getMessage(), e);
                updateReversalFailureStatus(ctx, rrn, e.getMessage());
            } finally {
                ctx.put(NEEDS_FINACLE_TRANSACTION_LEG_REVERSAL, false);
                log.info("{}: Cleared principal reversal flag.", rrn);
            }
        }

        // === CHARGES LEG REVERSAL (NEW) ===========================================================
        if (Boolean.TRUE.equals(needsChargesReversal)) {
            log.info("{}: Charges reversal flagged. Initiating Charges Finacle reversal leg.", rrn);
            try {
                performFinacleChargesReversal(ctx, rrn);
                log.info("{}: Charges reversal leg completed successfully.", rrn);
            } catch (Exception e) {
                log.error("{}: Charges reversal leg failed: {}", rrn, e.getMessage(), e);
                updateReversalFailureStatus(ctx, rrn, e.getMessage());
            } finally {
                ctx.put(NEEDS_FINACLE_CHARGES_LEG_REVERSAL, false);
                log.info("{}: Cleared charges reversal flag.", rrn);
            }
        }
    }

    /**
     * Existing conditional reversal for PAPSS Status Check.
     */
    @Override
    public void performConditionalStatusCheckReversal(String rrn, TransactionMaster existingRecord, ChannelResponse channelResponse) throws CustomException {
        // ORIGINAL LOGIC UNTOUCHED
        if (existingRecord == null) {
            throw new CustomException("Transaction record not found for RRN: " + rrn);
        }

        if (channelResponse == null) {
            throw new CustomException("ChannelResponse object not found for RRN: " + rrn);
        }

        String papssStatus = channelResponse.getIpsStatusInfo().getStatus().getType();
        boolean isFinacleDebited = existingRecord.getFinacleStatus() == TransactionStatus.FINACLE_DEBITED;
        boolean isPapssRejected = "RJCT".equalsIgnoreCase(papssStatus);

        log.debug("{}: Reversal condition check => PAPSS='{}', Finacle='{}'.", rrn, papssStatus, existingRecord.getFinacleStatus());

        if (isPapssRejected && isFinacleDebited) {
            log.warn("{}: Reversal required! PAPSS='{}', FINACLE='{}'.", rrn, existingRecord.getIpsStatus(), existingRecord.getFinacleStatus());

            Context dummyContext = new Context();
            dummyContext.put(JposConstants.RRN, rrn);
            dummyContext.put(JposConstants.TRANSACTION_ENTITY_CONTEXT, existingRecord);
            dummyContext.put(JposConstants.TXN_STATUS, existingRecord.getStatus());
            dummyContext.put(JposConstants.STATUS_CODE, existingRecord.getResponseCode());
            dummyContext.put(JposConstants.STATUS_MESSAGE, existingRecord.getResponseMessage());
            dummyContext.put(JposConstants.ISO20022_PACS008_TXN_ORIGINAL_MESSAGE_ID, existingRecord.getPapssMessageId());
            dummyContext.put(JposConstants.ISO20022_PACS008_TXN_CREATION_DATE_AND_TIME, existingRecord.getPapssTxnCreationTime());

            try {
                performFinacleReversal(dummyContext, rrn);
                log.info("{}: Conditional reversal completed successfully.", rrn);
            } catch (Exception e) {
                log.error("{}: Conditional reversal failed: {}", rrn, e.getMessage(), e);
                updateReversalFailureStatus(dummyContext, rrn, e.getMessage());
                throw new CustomException("Conditional reversal failed for RR: " + rrn + ": " + e.getMessage());
            }
        } else {
            log.info("{}: Reversal not required. Conditions not met.", rrn);
        }
    }

    // ============================================================================================
    // PRINCIPAL LEG REVERSAL
    // ============================================================================================
    private void performFinacleReversal(Context ctx, String rrn) throws CustomException {
        try {
            // Get fresh entity record from db
            TransactionMaster entity = databaseService.getSavedRecord(rrn, TransactionType.CREDIT_TRANSFER);

            // Get some original parameters
            String bankId = entity.getBankId();
            TransactionPayload payload = entity.getTransactionPayload();

            log.info("{}: Building principal reversal leg iso message.", rrn);
            // Retrieve original charges iso request from DB
            byte[] originalRequestBytes = payload.getFinTxnIsoRequest();
            if (originalRequestBytes == null) {
                throw new CustomException("Original transaction ISO request missing. Cannot reverse transaction leg.");
            }

            // Deserialize the bytes
            ISOMsg originalRequestIso = isoMsgSerializerAndDeserializerService.deserializeISOMsg(originalRequestBytes);

            // Build Reversal ISO From Original ISO msg
            ISOMsg reversalRequest = isoMessageBuilderService.buildReversalFromOriginalIso(originalRequestIso, rrn);

            // Update payload with txn reversal request
            payload.setFinTxnReversalIsoRequest(isoMsgSerializerAndDeserializerService.serializeISOMsg(reversalRequest));

            // Send reversal request to finacle
            ISOMsg reversalResponse = sendToFinacleService.sendReversalRequest(rrn, reversalRequest, bankId, TransactionType.CREDIT_TRANSFER, "Transaction Reversal Leg");

            // Update txn reversal iso message
            payload.setFinTxnReversalIsoResponse(isoMsgSerializerAndDeserializerService.serializeISOMsg(reversalResponse));

            String f39 = reversalResponse.getString(39);
            if ("000".equals(f39)) {
                updateReversalSuccess(ctx, rrn, "Transaction leg");
                return;
            }

            String errorDesc = finacleErrorMapping.getOrDefault(f39, "Unknown Finacle error: " + f39);
            updateReversalFailureStatus(ctx, rrn, errorDesc);
            throw new CustomException("Finacle transaction leg reversal failed: " + errorDesc);
        } catch (Exception e) {
            throw new CustomException(e.getMessage());
        }
    }

    // ============================================================================================
    // CHARGES LEG REVERSAL
    // ============================================================================================
    private void performFinacleChargesReversal(Context ctx, String rrn) throws CustomException {
        try {
            // Get fresh entity record from db
            TransactionMaster entity = databaseService.getSavedRecord(rrn, TransactionType.CREDIT_TRANSFER);

            // Get the payload object
            TransactionPayload payload = entity.getTransactionPayload();

            // Retrieve original charges iso request from DB
            byte[] originalChargesBytes = payload.getFinChargesIsoRequest();
            if (originalChargesBytes == null) {
                throw new CustomException("Original charges ISO request missing. Cannot reverse charges leg.");
            }

            // Deserialize the bytes
            ISOMsg originalChargesIso = isoMsgSerializerAndDeserializerService.deserializeISOMsg(originalChargesBytes);

            // Build charges reversal ISO using your existing utility
            log.info("{}: Building CHARGES reversal message.", rrn);
            ISOMsg chargesReversalIso = isoMessageBuilderService.buildReversalFromOriginalIso(originalChargesIso, rrn);

            // Update the payload object
            payload.setFinChargesReversalIsoRequest(isoMsgSerializerAndDeserializerService.serializeISOMsg(chargesReversalIso));

            // Get the bank
            String bankId = entity.getBankId();

            log.info("{}: Sending CHARGES reversal request to Finacle...", rrn);
            ISOMsg chargesResponse = sendToFinacleService.sendReversalRequest(rrn, chargesReversalIso, bankId, TransactionType.CREDIT_TRANSFER, "Charges Reversal Leg");

            // Update the payload object
            payload.setFinChargesReversalIsoResponse(isoMsgSerializerAndDeserializerService.serializeISOMsg(chargesResponse));

            // Process the iso response
            String f39 = chargesResponse.getString(39);
            if ("000".equals(f39)) {
                updateReversalSuccess(ctx, rrn, "Charges leg");
                log.info("{}: Finacle charges reversal leg successful.", rrn);
            } else {
                String errorDesc = finacleErrorMapping.getOrDefault(f39, "Unknown Finacle error: " + f39);
                updateReversalFailureStatus(ctx, rrn, errorDesc);
                throw new CustomException("Finacle charges reversal leg failed: " + errorDesc);
            }
        } catch (Exception e) {
            throw new CustomException(e.getMessage());
        }
    }

    private void updateReversalSuccess(Context ctx, String rrn, String leg) {
        String msgId = (String) ctx.get(JposConstants.ISO20022_PACS008_TXN_ORIGINAL_MESSAGE_ID);
        String creationTime = (String) ctx.get(JposConstants.ISO20022_PACS008_TXN_CREATION_DATE_AND_TIME);

        try {
            // Get original entity record
            TransactionMaster entity = databaseService.getSavedRecord(rrn, TransactionType.CREDIT_TRANSFER);

            FinacleTransaction txn = entity.getFinacleTransaction();
            txn.setReversalStatus(TransactionStatus.REVERSED_OK);
            txn.setReversalResponseCode(TransactionStatus.REVERSED_OK.getCode());
            txn.setReversalResponseDesc(TransactionStatus.REVERSED_OK.getDescription());
            txn.setUpdatedAt(OffsetDateTime.now());
            txn.setReversalCompletedAt(OffsetDateTime.now());

            entity.setFinacleStatus(TransactionStatus.REVERSED_OK);
            entity.setFinacleResponseCode(TransactionStatus.REVERSED_OK.getCode());
            entity.setFinacleResponseMessage(TransactionStatus.REVERSED_OK.getDescription());
            entity.setCompletedAt(OffsetDateTime.now());
            entity.setPapssMessageId(msgId);
            entity.setPapssTxnCreationTime(creationTime);

            databaseService.updateDbRecord(entity);
            log.info("{}: {}, Reversal success saved.", rrn, leg);
        } catch (Exception e) {
            log.error("{}: Exception occurred during updating reversal success details in the db", rrn);
        }
    }

    private void updateReversalFailureStatus(Context ctx, String rrn, String failureReason) {
        String msgId = (String) ctx.get(JposConstants.ISO20022_PACS008_TXN_ORIGINAL_MESSAGE_ID);
        String creationTime = (String) ctx.get(JposConstants.ISO20022_PACS008_TXN_CREATION_DATE_AND_TIME);

        try {
            // Get original entity record
            TransactionMaster entity = databaseService.getSavedRecord(rrn, TransactionType.CREDIT_TRANSFER);

            FinacleTransaction txn = entity.getFinacleTransaction();
            txn.setReversalStatus(TransactionStatus.REVERSED_NOK);
            txn.setReversalResponseCode(TransactionStatus.REVERSED_NOK.getCode());
            txn.setReversalResponseDesc("Finacle reversal failed: " + failureReason);
            txn.setUpdatedAt(OffsetDateTime.now());
            txn.setReversalCompletedAt(OffsetDateTime.now());

            entity.setFinacleStatus(TransactionStatus.REVERSED_NOK);
            entity.setFinacleResponseCode(TransactionStatus.REVERSED_NOK.getCode());
            entity.setFinacleResponseMessage("Finacle reversal failed: " + failureReason);
            entity.setCompletedAt(OffsetDateTime.now());
            entity.setPapssMessageId(msgId);
            entity.setPapssTxnCreationTime(creationTime);

            databaseService.updateDbRecord(entity);
            log.info("{}: Reversal failure saved.", rrn);
        } catch (Exception e) {
            log.error("{}: Exception occurred during updating reversal success details in the db", rrn);
        }
    }
}
