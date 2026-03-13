package com.equitybank.gag.papss.ots.jpos.space.participants;

import com.equitybank.gag.papss.ots.dto.channelRequest.transaction.ChannelCreditTransferDetailsReq;
import com.equitybank.gag.papss.ots.dto.channelResponse.ChannelResponse;
import com.equitybank.gag.papss.ots.dto.channelResponse.ChannelStatusInfo;
import com.equitybank.gag.papss.ots.entity.TransactionMaster;
import com.equitybank.gag.papss.ots.enums.TransactionStatus;
import com.equitybank.gag.papss.ots.enums.TransactionType;
import com.equitybank.gag.papss.ots.exception.CustomException;
import com.equitybank.gag.papss.ots.jpos.jposService.ISOMessageBuilderService;
import com.equitybank.gag.papss.ots.jpos.jposService.ISOMsgSerializerAndDeserializerService;
import com.equitybank.gag.papss.ots.jpos.jposService.SendToFinacleService;
import com.equitybank.gag.papss.ots.jpos.space.configs.JposConstants;
import com.equitybank.gag.papss.ots.jpos.space.configs.SpringBeanLoader;
import com.equitybank.gag.papss.ots.service.DatabaseService;
import com.equitybank.gag.papss.ots.service.FinacleReversalService;
import com.equitybank.gag.papss.ots.service.HttpAdapterService;
import com.google.gson.Gson;
import org.jpos.transaction.AbortParticipant;
import org.jpos.transaction.Context;
import org.jpos.transaction.TransactionParticipant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;

import java.io.Serializable;
import java.time.OffsetDateTime;
import java.util.Map;

import static com.equitybank.gag.papss.ots.config.ApplicationConstants.TIMEOUT_STATUS_CODE;
import static com.equitybank.gag.papss.ots.enums.TransactionStatus.TIMEOUT;

public class TransactionErrorHandlingParticipant implements TransactionParticipant, AbortParticipant {

    private static final Logger log = LoggerFactory.getLogger(TransactionErrorHandlingParticipant.class);

    private Gson gson;
    private DatabaseService databaseService;
    private FinacleReversalService finacleReversalService;
    private ISOMessageBuilderService isoMessageBuilderService;
    private ISOMsgSerializerAndDeserializerService isoMsgSerializerAndDeserializerService;
    private SendToFinacleService sendToFinacleService;
    private HttpAdapterService httpAdapterService;
    private Map<String, String> finacleErrorMapping;

    public TransactionErrorHandlingParticipant() {
        // Load Spring beans
        ApplicationContext context = SpringBeanLoader.getApplicationContext();
        if (context != null) {
            try {
                this.gson = (Gson) context.getBean("gson");
                this.databaseService = context.getBean(DatabaseService.class);
                this.finacleReversalService = context.getBean(FinacleReversalService.class);
                this.isoMessageBuilderService = context.getBean(ISOMessageBuilderService.class);
                this.isoMsgSerializerAndDeserializerService = context.getBean(ISOMsgSerializerAndDeserializerService.class);
                this.sendToFinacleService = context.getBean(SendToFinacleService.class);
                this.httpAdapterService = context.getBean(HttpAdapterService.class);
                this.finacleErrorMapping = (Map<String, String>) context.getBean("finacleErrorMapping");
                log.info("Spring beans loaded successfully.");
            } catch (Exception e) {
                log.error("Bean initialization failed: {}", e.getMessage(), e);
            }
        } else {
            log.error("Spring ApplicationContext is null — participant cannot function.");
        }
    }

    @Override
    public int prepare(long id, Serializable serialisedContext) {
        // No pre-processing required
        Context ctx = (Context) serialisedContext;
        String rrn = (String) ctx.get(JposConstants.RRN);
        log.debug("{}: Prepare phase — no operation.", rrn);
        return PREPARED;
    }

    @Override
    public void commit(long id, Serializable ctx) {
        // This participant only works in abort()
        String rrn = (String) ((Context) ctx).get(JposConstants.RRN);
        log.info("{}: Commit phase — no action.", rrn);
    }

    @Override
    public void abort(long id, Serializable serialisedContext) {
        Context ctx = (Context) serialisedContext;
        String rrn = (String) ctx.get(JposConstants.RRN);

        log.error("{}: Abort initiated. Starting error handling sequence.", rrn);

        // Ensure all beans are loaded
        if (databaseService == null
                || gson == null
                || finacleReversalService == null
                || isoMessageBuilderService == null
                || isoMsgSerializerAndDeserializerService == null
                || sendToFinacleService == null
                || httpAdapterService == null
                || finacleErrorMapping == null) {

            log.error("{}: Missing Spring beans. Cannot proceed.", rrn);
            return;
        }

        try {
            // Load fresh DB record
            TransactionMaster entity;
            try {
                entity = databaseService.getSavedRecord(rrn, TransactionType.CREDIT_TRANSFER);
                ctx.put(JposConstants.TRANSACTION_ENTITY_CONTEXT, entity);
                log.info("{}: Loaded latest TransactionMaster.", rrn);
            } catch (Exception e) {
                // No DB record = cannot reverse anything. Only send callback
                log.error("{}: No DB record found. Skipping reversal.", rrn);
                sendChannelCallbackForRecordNotExistingInDB(ctx, rrn);
                return;
            }

            // Read reversal flags from context
            Boolean reverseTxnLeg = (Boolean) ctx.get(JposConstants.NEEDS_FINACLE_TRANSACTION_LEG_REVERSAL);
            Boolean reverseChargesLeg = (Boolean) ctx.get(JposConstants.NEEDS_FINACLE_CHARGES_LEG_REVERSAL);

            // If ANY reversal is required, delegate to FinacleReversalService once
            if (Boolean.TRUE.equals(reverseTxnLeg) || Boolean.TRUE.equals(reverseChargesLeg)) {
                log.info("{}: Reversal required. Calling FinacleReversalService for reversals", rrn);
                finacleReversalService.handleJposAbortReversal(ctx, rrn);
            } else {
                // No reversal required, finalize transaction status
                log.info("{}: No reversal required. Proceeding with final status update.", rrn);
                ctx.put(JposConstants.TRANSACTION_ENTITY_CONTEXT, entity);
            }

            // Update final status
            updateFinalStatus(ctx, rrn);

            // Always send callback after reversal or finalization
            sendChannelCallback(ctx, rrn);
            log.info("{}: Abort handling completed. Final status={}, message={}", rrn, entity.getStatus(), entity.getResponseMessage());

        } catch (Exception e) {
            log.error("{}: Fatal abort handler error: {}", rrn, e.getMessage(), e);
        } finally {
            log.info("{}: Abort handler finished.", rrn);
        }
    }

    // Fallback callback when DB entry missing
    private void sendChannelCallbackForRecordNotExistingInDB(Context ctx, String rrn) {
        try {
            TransactionStatus finalStatus = (TransactionStatus) ctx.get(JposConstants.TXN_STATUS);
            String statusCode = (String) ctx.get(JposConstants.STATUS_CODE);
            String statusMessage = (String) ctx.get(JposConstants.STATUS_MESSAGE);

            ChannelResponse response = new ChannelResponse();
            ChannelStatusInfo statusInfo = new ChannelStatusInfo();
            statusInfo.setStatus(finalStatus.name());
            statusInfo.setCode(statusCode);
            statusInfo.setDescription(statusMessage);
            response.setRrn(rrn);
            response.setChannelStatusInfo(statusInfo);

            ChannelCreditTransferDetailsReq req = (ChannelCreditTransferDetailsReq) ctx.get(JposConstants.TRANSACTION_CONTEXT);

            if (req != null && req.getChannelInfo() != null) {
                String callbackUrl = req.getChannelInfo().getCallbackURL();
                if (callbackUrl != null) {
                    httpAdapterService.sendHttpChannelCallbackResponse(rrn, callbackUrl, response);
                    log.info("{}: Sent fallback callback (no DB record).", rrn);
                } else {
                    log.warn("{}: Missing callback URL.", rrn);
                }
            }
        } catch (Exception ex) {
            log.error("{}: Failed fallback callback: {}", rrn, ex.getMessage());
        }
    }

    // Standard callback using DB record
    private void sendChannelCallback(Context ctx, String rrn) {
        log.info("{}: Calling channel for callback", rrn);
        try {
            TransactionStatus finalStatus = (TransactionStatus) ctx.get(JposConstants.TXN_STATUS);
            String statusCode = (String) ctx.get(JposConstants.STATUS_CODE);
            String statusMessage = (String) ctx.get(JposConstants.STATUS_MESSAGE);

            TransactionMaster entity = databaseService.getSavedRecord(rrn, TransactionType.CREDIT_TRANSFER);

            ctx.put(JposConstants.TRANSACTION_ENTITY_CONTEXT, entity);
            log.info("{}: Reloaded entity for callback.", rrn);

            if (entity.getChannelInfo() == null || entity.getChannelInfo().getCallbackUrl() == null) {
                log.warn("{}: No callback URL available. Aborting callback call to channel", rrn);
                return;
            }

            String callbackUrl = entity.getChannelInfo().getCallbackUrl();
            ChannelResponse response = generateResponse(rrn, finalStatus, statusCode, statusMessage);

            httpAdapterService.sendHttpChannelCallbackResponse(rrn, callbackUrl, response);
            log.info("{}: Callback sent to {}", rrn, callbackUrl);

            entity.getTransactionPayload().setChannelResponse(gson.toJson(response));
            databaseService.updateDbRecord(entity);

        } catch (Exception e) {
            log.error("{}: Callback send failure: {}", rrn, e.getMessage(), e);
        }
    }

    private ChannelResponse generateResponse(String rrn, TransactionStatus finalStatus, String statusCode, String statusMessage) {
        String errorCode = statusCode;
        String errorStatus = finalStatus.name();

        if (statusMessage != null) {
            String lower = statusMessage.toLowerCase();
            if (lower.contains("timeout") || lower.contains("time out") || lower.contains("timed out")) {
                errorCode = TIMEOUT_STATUS_CODE;
                errorStatus = TIMEOUT.name();
            }
        }

        ChannelStatusInfo info = new ChannelStatusInfo();
        info.setStatus(errorStatus);
        info.setCode(errorCode);
        info.setDescription(statusMessage);

        ChannelResponse response = new ChannelResponse();
        response.setRrn(rrn);
        response.setChannelStatusInfo(info);
        return response;
    }

    private void updateFinalStatus(Context ctx, String rrn) throws CustomException {
        try {
            // Get the fresh entity from db to avoid stale updates
            log.info("{}: Getting the latest db entity record", rrn);
            TransactionMaster entity = databaseService.getSavedRecord(rrn, TransactionType.CREDIT_TRANSFER);

            TransactionStatus finalStatus = (TransactionStatus) ctx.get(JposConstants.TXN_STATUS);
            String statusCode = (String) ctx.get(JposConstants.STATUS_CODE);
            String statusMessage = (String) ctx.get(JposConstants.STATUS_MESSAGE);
            String endToEndId = (String) ctx.get(JposConstants.ISO20022_PACS008_END_TO_END_ID);
            String papssMessageId = (String) ctx.get(JposConstants.ISO20022_PACS008_TXN_ORIGINAL_MESSAGE_ID);
            String txnCreationTime = (String) ctx.get(JposConstants.ISO20022_PACS008_TXN_CREATION_DATE_AND_TIME);

            log.info("{}: Updating final status: {}", rrn, finalStatus);

            ChannelResponse response = generateResponse(rrn, finalStatus, statusCode, statusMessage);

            entity.setStatus(finalStatus);
            entity.setEndToEndId(endToEndId);
            entity.setResponseCode(statusCode);
            entity.setResponseMessage(statusMessage);
            entity.setUpdatedAt(OffsetDateTime.now());
            entity.setCompletedAt(OffsetDateTime.now());
            entity.setPapssMessageId(papssMessageId);
            entity.setPapssTxnCreationTime(txnCreationTime);
            entity.getTransactionPayload().setChannelResponse(gson.toJson(response));

            databaseService.updateDbRecord(entity);

            ctx.put(JposConstants.NEEDS_FINACLE_TRANSACTION_LEG_REVERSAL, false);
            ctx.put(JposConstants.NEEDS_FINACLE_CHARGES_LEG_REVERSAL, false);
        } catch (Exception e) {
            log.error("{}: Exception occurred during final status update: {}", rrn, e.getMessage());
            throw new CustomException(e.getMessage());
        }
    }
}
