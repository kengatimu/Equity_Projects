package com.equitybank.gag.papss.ots.jpos.space.participants;

import com.equitybank.gag.papss.ots.jpos.space.configs.JposConstants;
import com.equitybank.gag.papss.ots.jpos.space.configs.SpringBeanLoader;
import com.equitybank.gag.papss.ots.dto.channelResponse.ChannelResponse;
import com.equitybank.gag.papss.ots.entity.TransactionMaster;
import com.equitybank.gag.papss.ots.enums.TransactionStatus;
import com.equitybank.gag.papss.ots.enums.TransactionType;
import com.equitybank.gag.papss.ots.exception.CustomException;
import com.equitybank.gag.papss.ots.service.DatabaseService;
import com.equitybank.gag.papss.ots.service.HttpResponseProcessorService;
import com.google.gson.Gson;
import org.jpos.transaction.Context;
import org.jpos.transaction.TransactionParticipant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;

import java.io.Serializable;
import java.time.OffsetDateTime;

import static com.equitybank.gag.papss.ots.enums.TransactionStatus.FINACLE_DEBITED;

public class ProcessHttpResponseParticipant implements TransactionParticipant {

    private static final Logger log = LoggerFactory.getLogger(ProcessHttpResponseParticipant.class);

    private HttpResponseProcessorService httpResponseProcessorService;
    private DatabaseService databaseService;
    private Gson gson;

    public ProcessHttpResponseParticipant() {
        ApplicationContext context = SpringBeanLoader.getApplicationContext();
        if (context != null) {
            try {
                this.httpResponseProcessorService = context.getBean(HttpResponseProcessorService.class);
                this.databaseService = context.getBean(DatabaseService.class);
                this.gson = (Gson)context.getBean("gson");
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

        // Validate required service beans
        if (httpResponseProcessorService == null || databaseService == null) {
            updateJposContextAndReversal(ctx, rrn, TransactionStatus.FAILURE, "Required services not available.", transactionEntity);
            return ABORTED;
        }

        // Retrieve the HTTP response from the context
        String httpResponseString = (String) ctx.get(JposConstants.HTTP_RESPONSE);
        if (httpResponseString == null) {
            updateJposContextAndReversal(ctx, rrn, TransactionStatus.FAILURE, "No HTTP response found in context.", transactionEntity);
            return ABORTED;
        }

        try  {
            ChannelResponse channelResponse = httpResponseProcessorService.processTransactionResponse(ctx, rrn, httpResponseString, TransactionType.CREDIT_TRANSFER.name());
            log.info("{}: ChannelResponse generated successfully from HTTP response.", rrn);

            // Update context with channel response object
            ctx.put(JposConstants.CHANNEL_RESPONSE_CONTEXT, channelResponse);

            // Update TransactionMaster with response status info
            if (transactionEntity != null) {
                transactionEntity.setIpsStatusCode(channelResponse.getIpsStatusInfo().getStatus().getCode());
                transactionEntity.setIpsStatusDescription(channelResponse.getIpsStatusInfo().getStatus().getDescription());
                transactionEntity.setIpsStatus(channelResponse.getIpsStatusInfo().getStatus().getType());
                transactionEntity.setIpsStatusReason(channelResponse.getIpsStatusInfo().getStatus().getReason());
                transactionEntity.setUpdatedAt(OffsetDateTime.now());

                TransactionStatus newStatus = TransactionStatus.valueOf(channelResponse.getChannelStatusInfo().getStatus());
                transactionEntity.setStatus(newStatus);
                transactionEntity.setResponseCode(channelResponse.getChannelStatusInfo().getCode());
                transactionEntity.setResponseMessage(channelResponse.getChannelStatusInfo().getDescription());

                transactionEntity.getTransactionPayload().setChannelResponse(gson.toJson(channelResponse));

                databaseService.updateDbRecord(transactionEntity);
                log.info("{}:TransactionMaster entity updated and saved. New status: {}", rrn, newStatus);
            } else {
                log.warn("{}: Transaction entity was null. Skipping DB update.", rrn);
            }

            ctx.put(JposConstants.TRANSACTION_ENTITY_CONTEXT, transactionEntity);
            updateJposContextAndReversal(ctx, rrn, TransactionStatus.valueOf(channelResponse.getChannelStatusInfo().getStatus()), channelResponse.getChannelStatusInfo().getDescription(), transactionEntity);

            // Remove response and pacs008 string from context
            ctx.put(JposConstants.HTTP_RESPONSE, "[PACS002 response content excluded]");
            ctx.put(JposConstants.ISO20022_SIGNED_PACS008_XML, "[Signed PACS008 context excluded]");

            // Check the final status
            TransactionStatus status = TransactionStatus.valueOf(channelResponse.getChannelStatusInfo().getStatus());

            // process papss status to determine if we should abort the transaction here
            boolean shouldAbort = processFinalStatus(rrn, status);
            return shouldAbort ? ABORTED : PREPARED;
        } catch (CustomException e) {
            log.error("{}: CustomException encountered while processing HTTP response: {}", rrn, e.getMessage());

            /// Remove response and pacs008 string from context
            ctx.put(JposConstants.HTTP_RESPONSE, "[PACS002 response content excluded]");
            ctx.put(JposConstants.ISO20022_SIGNED_PACS008_XML, "[Signed PACS008 context excluded]");
            return handleProcessingFailure(ctx, rrn, transactionEntity, "Could not process the response. CustomException: " + e.getMessage());
        } catch (Exception e) {
            log.error("{}: Unexpected error while processing HTTP response: {}", rrn, e.getMessage(), e);

            // Remove response and pacs008 string from context
            ctx.put(JposConstants.HTTP_RESPONSE, "[PACS002 response content excluded]");
            ctx.put(JposConstants.ISO20022_SIGNED_PACS008_XML, "[Signed PACS008 context excluded]");
            return handleProcessingFailure(ctx, rrn, transactionEntity, "Could not process the response. Exception occurred: " + e.getMessage());
        }
    }

    @Override
    public void commit(long id, Serializable ctx) {
        String rrn = (String) ((Context) ctx).get(JposConstants.RRN);
        log.info("{}: Commit phase — no action required (DB update done in prepare).", rrn);
    }

    @Override
    public void abort(long id, Serializable ctx) {
        String rrn = (String) ((Context) ctx).get(JposConstants.RRN);
        log.info("{}: Abort phase — no action needed.", rrn);
    }

    // The transaction should be aborted if final status is failure
    private boolean processFinalStatus(String rrn, TransactionStatus status) {
        log.info("{}: Transaction final status: {}. Aborting the transaction.", rrn, status);
        return status == TransactionStatus.FAILURE;
    }

    // Updates the context with transaction status, disables PAPSS processing on failure
    private void updateJposContext(Context ctx, String rrn, TransactionStatus status, String message) {
        if (status == TransactionStatus.FAILURE || status == TransactionStatus.TIMEOUT) {
            log.error("{}: {}", rrn, message);
        } else {
            log.info("{}: {}", rrn, message);
        }

        ctx.put(JposConstants.TXN_STATUS, status);
        ctx.put(JposConstants.STATUS_CODE, status.getCode());
        ctx.put(JposConstants.STATUS_MESSAGE, message);
        ctx.put(JposConstants.NEEDS_PAPSS_PROCESSING, (status != TransactionStatus.FAILURE && status != TransactionStatus.TIMEOUT));
    }

    // Updates context and sets reversal flag if failure occurred after Finacle debit
    private void updateJposContextAndReversal(Context ctx, String rrn, TransactionStatus status, String message, TransactionMaster entity) {
        updateJposContext(ctx, rrn, status, message);

        boolean needsReversal = entity != null
                && entity.getFinacleStatus() == FINACLE_DEBITED
                && status == TransactionStatus.FAILURE;

        ctx.put(JposConstants.NEEDS_FINACLE_TRANSACTION_LEG_REVERSAL, needsReversal);
        ctx.put(JposConstants.NEEDS_FINACLE_CHARGES_LEG_REVERSAL, needsReversal);
        if (needsReversal) {
            log.warn("{}: Reversal required — transaction failed after Finacle debit.", rrn);
        }
        log.info("{}: Transaction Reversal flag: {}", rrn, ctx.get(JposConstants.NEEDS_FINACLE_TRANSACTION_LEG_REVERSAL));
        log.info("{}: Charges Reversal flag: {}", rrn, ctx.get(JposConstants.NEEDS_FINACLE_CHARGES_LEG_REVERSAL));
    }

    // Handles failure during processing by updating status and attempting DB save
    private int handleProcessingFailure(Context ctx, String rrn, TransactionMaster entity, String reason) {
        updateJposContextAndReversal(ctx, rrn, TransactionStatus.PENDING, reason, entity);
        if (entity != null) {
            try {
                entity.setStatus(TransactionStatus.PENDING);
                entity.setResponseCode(TransactionStatus.PENDING.getCode());
                entity.setResponseMessage(reason);
                entity.setUpdatedAt(OffsetDateTime.now());
                entity.setCompletedAt(OffsetDateTime.now());
                databaseService.updateDbRecord(entity);
                log.info("{}: Failure status saved to DB.", rrn);
            } catch (Exception dbEx) {
                log.error("{}: Failed to save FAILURE status to DB: {}", rrn, dbEx.getMessage());
            }
        }
        // Am not doing reversal here since am not sure if transaction succeed or not. So we maintain the current PENDING status.
        return ABORTED;
    }
}
