package com.equitybank.gag.papss.ots.jpos.space.participants;

import com.equitybank.gag.papss.ots.dto.channelRequest.statusCheck.ChannelStatusCheckDetailsReq;
import com.equitybank.gag.papss.ots.dto.channelRequest.statusCheck.OriginalTxnInfo;
import com.equitybank.gag.papss.ots.dto.channelResponse.ChannelResponse;
import com.equitybank.gag.papss.ots.dto.channelResponse.ChannelStatusInfo;
import com.equitybank.gag.papss.ots.jpos.space.configs.JposConstants;
import com.equitybank.gag.papss.ots.jpos.space.configs.SpringBeanLoader;
import com.equitybank.gag.papss.ots.entity.TransactionMaster;
import com.equitybank.gag.papss.ots.enums.*;
import com.equitybank.gag.papss.ots.service.DatabaseService;
import com.equitybank.gag.papss.ots.service.HttpAdapterService;
import com.equitybank.gag.papss.ots.service.RequestProcessorService;
import com.google.gson.Gson;
import org.jpos.transaction.Context;
import org.jpos.transaction.TransactionParticipant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;

import java.io.Serializable;
import java.time.OffsetDateTime;

import static com.equitybank.gag.papss.ots.config.ApplicationConstants.INTERNAL_STATUS_CHECK_TYPE;
import static com.equitybank.gag.papss.ots.config.ApplicationConstants.TIMEOUT_STATUS_CODE;
import static com.equitybank.gag.papss.ots.enums.TransactionStatus.*;

public class FinalTransactionStatusConsolidatorParticipant implements TransactionParticipant {

    private static final Logger log = LoggerFactory.getLogger(FinalTransactionStatusConsolidatorParticipant.class);

    private Gson gson;
    private DatabaseService databaseService;
    private HttpAdapterService httpAdapterService;
    private RequestProcessorService requestProcessorService;

    public FinalTransactionStatusConsolidatorParticipant() {
        // Load DatabaseService from Spring context
        ApplicationContext context = SpringBeanLoader.getApplicationContext();
        if (context != null) {
            try {
                this.gson = (Gson)context.getBean("gson");
                this.databaseService = context.getBean(DatabaseService.class);
                this.httpAdapterService = context.getBean(HttpAdapterService.class);
                this.requestProcessorService = context.getBean(RequestProcessorService.class);
                log.info("Spring beans loaded successfully.");
            } catch (Exception e) {
                log.error("Failed to load Spring beans: {}", e.getMessage(), e);
            }
        } else {
            log.error("ApplicationContext is null.");
        }
    }

    // The status of this stage will remain Pending in case of failures.
    // No reversal should happen at this stage.
    @Override
    public int prepare(long id, Serializable serializedContext) {
        Context ctx = (Context) serializedContext;
        String rrn = (String) ctx.get(JposConstants.RRN);
        log.info("{}: Starting prepare phase.", rrn);

        // Abort if a critical service is unavailable
        if (gson == null || databaseService == null || httpAdapterService == null || requestProcessorService == null) {
            String errorMsg = "Critical service not initialized.";
            updateJposContext(ctx, rrn, PENDING, PENDING.getCode(), errorMsg);
            ctx.put(JposConstants.NEEDS_FINACLE_TRANSACTION_LEG_REVERSAL, false);
            ctx.put(JposConstants.NEEDS_FINACLE_CHARGES_LEG_REVERSAL, false);
            return ABORTED;
        }

        // Get the latest entity version from DB inorder to preventing optimistic locking errors
        TransactionMaster entity;
        try {
            entity = databaseService.getSavedRecord(rrn, TransactionType.CREDIT_TRANSFER);
            ctx.put(JposConstants.TRANSACTION_ENTITY_CONTEXT, entity);
            log.info("{}: Loaded latest TransactionMaster from DB.", rrn);
        } catch (Exception e) {
            String errorMsg = "Error fetching transaction from DB: " + e.getMessage();
            updateJposContext(ctx, rrn, PENDING, PENDING.getCode(), errorMsg);
            ctx.put(JposConstants.NEEDS_FINACLE_TRANSACTION_LEG_REVERSAL, false);
            ctx.put(JposConstants.NEEDS_FINACLE_CHARGES_LEG_REVERSAL, false);
            return ABORTED;
        }

        // Abort if still null after fallback
        if (entity == null) {
            String errorMsg = "Transaction entity is null after DB fallback.";
            updateJposContext(ctx, rrn, PENDING, PENDING.getCode(), errorMsg);
            ctx.put(JposConstants.NEEDS_FINACLE_TRANSACTION_LEG_REVERSAL, false);
            ctx.put(JposConstants.NEEDS_FINACLE_CHARGES_LEG_REVERSAL, false);
            return ABORTED;
        }

        try {
            // Get the final status from context
            TransactionStatus finalStatus = (TransactionStatus) ctx.get(JposConstants.TXN_STATUS);
            String statusCode = (String) ctx.get(JposConstants.STATUS_CODE);
            String statusMessage = (String) ctx.get(JposConstants.STATUS_MESSAGE);

            // Handle potentially missing (optional) context variables gracefully
            String EndToEndId = (String) ctx.get(JposConstants.ISO20022_PACS008_END_TO_END_ID);
            String papssOriginalMessageId = (String) ctx.get(JposConstants.ISO20022_PACS008_TXN_ORIGINAL_MESSAGE_ID);
            String papssTxnCreationTime = (String) ctx.get(JposConstants.ISO20022_PACS008_TXN_CREATION_DATE_AND_TIME);
            log.info("{}: Consolidating final statuses: \nFinal Status: {}, \nStatus Code: {}, \nStatus Message: {}", rrn, finalStatus, statusCode, statusMessage);

            // Save updated status to DB
            entity.setStatus(finalStatus);
            entity.setEndToEndId(EndToEndId);
            entity.setResponseCode(statusCode);
            entity.setResponseMessage(statusMessage);
            entity.setUpdatedAt(OffsetDateTime.now());
            entity.setCompletedAt(OffsetDateTime.now());
            entity.setPapssMessageId(papssOriginalMessageId);
            entity.setPapssTxnCreationTime(papssTxnCreationTime);

            log.info("{}: Final status saved: {} (Code: {})", rrn, finalStatus, statusCode);

            // Update jPOS context with final outcome
            updateJposContext(ctx, rrn, finalStatus, statusCode, statusMessage);

            // Perform PAPSS status check for CREDIT_TRANSFER types only
            ChannelResponse papssFinalResponse = new ChannelResponse();
            TransactionType txnType = (TransactionType) ctx.get(JposConstants.TXN_TYPE);
            if (txnType == TransactionType.CREDIT_TRANSFER) {
                log.info("{}: Triggering internal PAPSS status check before finalizing transaction.", rrn);
                try {
                    // Prepare ChannelStatusCheckDetailsReq object
                    ChannelStatusCheckDetailsReq statusReq = new ChannelStatusCheckDetailsReq();
                    statusReq.setOriginalTxnInfo(new OriginalTxnInfo());
                    statusReq.getOriginalTxnInfo().setOriginalRrn(rrn);

                    // Call status check internally
                    papssFinalResponse = requestProcessorService.processStatusCheckRequest(statusReq, null, INTERNAL_STATUS_CHECK_TYPE);
                    log.info("{}: PAPSS status check completed. Final IPS Status: {}", rrn, papssFinalResponse.getIpsStatusInfo().getStatus().getType());

                    // Immediately send updated status to channel
                    String callbackUrl = entity.getChannelInfo().getCallbackUrl();
                    httpAdapterService.sendHttpChannelCallbackResponse(rrn, callbackUrl, papssFinalResponse);

                } catch (Exception e) {
                    log.error("{}: Internal PAPSS status check failed: {}", rrn, e.getMessage(), e);
                }
            } else {
                // For non-CREDIT_TRANSFER transactions, we still need to send the final status to the channel
                sendChannelCallback(ctx, rrn, entity);
            }

            // Update db record
            entity.getTransactionPayload().setChannelResponse(gson.toJson(papssFinalResponse));
            databaseService.updateDbRecord(entity);

            // Final participant in flow — no reversal needed beyond this point
            ctx.put(JposConstants.NEEDS_FINACLE_TRANSACTION_LEG_REVERSAL, false);
            ctx.put(JposConstants.NEEDS_FINACLE_CHARGES_LEG_REVERSAL, false);
            return PREPARED;

        } catch (Exception e) {
            // Handle unexpected consolidation errors
            log.error("{}: Error during status consolidation: {}", rrn, e.getMessage());

            // Prepare error data for DB update
            String originalMessage = entity.getResponseMessage() != null ? entity.getResponseMessage() + ". " : "";
            String errorMessage = originalMessage + "Internal consolidation failed: " + e.getMessage();

            try {
                // Safely update the entity to FAILURE before aborting
                entity.setStatus(FAILURE);
                entity.setResponseCode(FAILURE.getCode());
                entity.setResponseMessage(errorMessage);
                entity.setUpdatedAt(OffsetDateTime.now());
                databaseService.updateDbRecord(entity);
                log.info("{}: FAILURE status saved to DB after consolidation error.", rrn);
            } catch (Exception dbEx) {
                log.error("{}: Failed to persist FAILURE status after consolidation error: {}", rrn, dbEx.getMessage());
            }

            // Update jPOS context for the next abort handler
            updateJposContext(ctx, rrn, FAILURE, FAILURE.getCode(), errorMessage);
            ctx.put(JposConstants.NEEDS_FINACLE_TRANSACTION_LEG_REVERSAL, false);
            ctx.put(JposConstants.NEEDS_FINACLE_CHARGES_LEG_REVERSAL, false);
            return ABORTED;
        }
    }

    @Override
    public void commit(long id, Serializable ctx) {
        // Nothing to commit — DB already updated in prepare()
        String rrn = (String) ((Context) ctx).get(JposConstants.RRN);
        log.info("{}: Commit phase — DB update already done.", rrn);
    }

    @Override
    public void abort(long id, Serializable ctx) {
        // No rollback logic needed here
        String rrn = (String) ((Context) ctx).get(JposConstants.RRN);
        log.info("{}: Abort phase — no rollback needed.", rrn);
    }

    // Sends the final failure response back to the channel.
    private void sendChannelCallback(Context ctx, String rrn, TransactionMaster entity) {
        try {
            // Get final status details from context
            TransactionStatus finalStatus = (TransactionStatus) ctx.get(JposConstants.TXN_STATUS);
            String statusCode = (String) ctx.get(JposConstants.STATUS_CODE);
            String statusMessage = (String) ctx.get(JposConstants.STATUS_MESSAGE);

            if (entity == null || entity.getChannelInfo() == null || entity.getChannelInfo().getCallbackUrl() == null) {
                log.warn("{}: Cannot send channel callback. Transaction entity or callback URL is missing.", rrn);
                return;
            }

            String channelCallbackUrl = entity.getChannelInfo().getCallbackUrl();
            ChannelResponse channelResponse = generateResponse(rrn, finalStatus, statusCode, statusMessage);

            // Send callback response to originating channel
            httpAdapterService.sendHttpChannelCallbackResponse(rrn, channelCallbackUrl, channelResponse);

            log.info("{}: Successfully sent failure callback to channel at: {}", rrn, channelCallbackUrl);
        } catch (Exception e) {
            log.error("{}: Failed to send channel callback response: {}", rrn, e.getMessage(), e);
        }
    }

    // Creates the ChannelResponse DTO from transaction status details.
    private ChannelResponse generateResponse(String rrn, TransactionStatus finalStatus, String statusCode, String statusMessage) {
        String code = statusCode;
        TransactionStatus status = finalStatus;

        // Update error code for timeout
        if (statusMessage != null) {
            String lowerMessage = statusMessage.toLowerCase();
            if (lowerMessage.contains("timeout")
                    || lowerMessage.contains("time out")
                    || lowerMessage.contains("timed out")) {
                code = TIMEOUT_STATUS_CODE;
                status = TIMEOUT;
            }
        }

        ChannelStatusInfo statusInfo = new ChannelStatusInfo();
        statusInfo.setStatus(String.valueOf(status));
        statusInfo.setCode(code);
        statusInfo.setDescription(statusMessage);

        ChannelResponse channelResponse = new ChannelResponse();
        channelResponse.setRrn(rrn);
        channelResponse.setChannelStatusInfo(statusInfo);

        return channelResponse;
    }

    private void updateJposContext(Context ctx, String rrn, TransactionStatus status, String code, String message) {
        if (status == FAILURE || status == TIMEOUT) {
            log.error("{}: {}", rrn, message);
        } else {
            log.info("{}: {}", rrn, message);
        }

        ctx.put(JposConstants.TXN_STATUS, status);
        ctx.put(JposConstants.STATUS_CODE, code);
        ctx.put(JposConstants.STATUS_MESSAGE, message);
        ctx.put(JposConstants.NEEDS_PAPSS_PROCESSING, false);
    }
}
