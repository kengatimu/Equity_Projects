package com.equitybank.gag.papss.its.jpos.space.participants.creditTransferFlow;

import com.equitybank.gag.papss.its.jpos.space.configs.JposConstants;
import com.equitybank.gag.papss.its.jpos.space.configs.SpringBeanLoader;
import com.equitybank.gag.papss.its.jpos.jposService.ISOMessageBuilderService;
import com.equitybank.gag.papss.its.jpos.jposService.ISOMsgSerializerAndDeserializerService;
import com.equitybank.gag.papss.its.entity.TransactionPayload;
import com.equitybank.gag.papss.its.entity.TransactionMaster;
import com.equitybank.gag.papss.its.enums.TransactionStatus;
import com.equitybank.gag.papss.its.enums.TransactionType;
import com.equitybank.gag.papss.its.exception.CustomException;
import com.equitybank.gag.papss.its.pojo.accountDetails.AccountDetails;
import com.equitybank.gag.papss.its.service.DatabaseService;
import org.jpos.iso.ISOMsg;
import org.jpos.transaction.Context;
import org.jpos.transaction.TransactionParticipant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;

import java.io.Serializable;
import java.time.OffsetDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import static com.equitybank.gag.papss.its.config.StatusCodeMessages.*;
import static com.equitybank.gag.papss.its.enums.PapssStatusCodes.RJCT;

/**
 * Builds ISO 8583 message for Finacle from requestMap, serializes it, logs it, and stores in DB/context.
 */
public final class ISO8583MessageBuilderParticipant implements TransactionParticipant {
    private static final Logger log = LoggerFactory.getLogger(ISO8583MessageBuilderParticipant.class);

    private ISOMessageBuilderService isoMessageBuilderService;
    private ISOMsgSerializerAndDeserializerService isoMsgSerializerAndDeserializerService;
    private DatabaseService databaseService;

    // Critical keys required for building ISO 8583
    private static final List<String> REQUIRED_KEYS = Arrays.asList("transactionCurrency", "receiverAmount", "narration");

    public ISO8583MessageBuilderParticipant() {
        ApplicationContext context = SpringBeanLoader.getApplicationContext();
        if (context != null) {
            try {
                this.isoMessageBuilderService = context.getBean(ISOMessageBuilderService.class);
                this.isoMsgSerializerAndDeserializerService = context.getBean(ISOMsgSerializerAndDeserializerService.class);
                this.databaseService = context.getBean(DatabaseService.class);
                log.info("Spring beans successfully loaded.");
            } catch (Exception e) {
                log.error("Failed to load beans: {}", e.getMessage());
            }
        } else {
            log.error("ApplicationContext is null.");
        }
    }

    @Override
    public int prepare(long id, Serializable serialisedContext) {
        Context ctx = (Context) serialisedContext;
        String rrn = (String) ctx.get(JposConstants.RRN);

        log.info("{}: Starting ISO8583MessageBuilder Participant.", rrn);

        // Abort if services are missing
        if (isoMessageBuilderService == null || isoMsgSerializerAndDeserializerService == null || databaseService == null) {
            updateJposContext(ctx, rrn, "Required beans/services not initialized.");
            return ABORTED;
        }

        // Retrieve requestMap from context
        @SuppressWarnings("unchecked")
        Map<String, String> requestMap = (Map<String, String>) ctx.get(JposConstants.PACS008_REQUEST_MAP);
        if (requestMap == null || requestMap.isEmpty()) {
            updateJposContext(ctx, rrn, "Request map missing in context.");
            return ABORTED;
        }

        // Validate required PACS.008 fields
        for (String key : REQUIRED_KEYS) {
            if (!requestMap.containsKey(key) || requestMap.get(key) == null || requestMap.get(key).isBlank()) {
                updateJposContext(ctx, rrn, "Missing required PACS.008 field from the requestMap: " + key);
                return ABORTED;
            }
        }

        // Load the latest transaction entity from DB
        TransactionMaster transactionEntity;
        try {
            transactionEntity = databaseService.getSavedRecord(rrn, TransactionType.CREDIT_TRANSFER);
            ctx.put(JposConstants.TRANSACTION_ENTITY_CONTEXT, transactionEntity);
            log.info("{}: Loaded latest TransactionMaster from DB.", rrn);
        } catch (Exception e) {
            updateJposContext(ctx, rrn, "Failed to load latest transaction from DB. Exception occurred: " + e.getMessage());
            return ABORTED;
        }

        try {
            // Set default transaction currency
            String transactionCurrency = DEFAULT_CURRENCY_KE;

            // Get account kyc details from context
            AccountDetails accountDetails = (AccountDetails) ctx.get(JposConstants.ACCOUNT_KYC_DATA);
            if (accountDetails != null && accountDetails.getAccountCurrency() != null) {
                transactionCurrency = accountDetails.getAccountCurrency();
            }

            // Build ISO message from requestMap
            ISOMsg isoMsg = isoMessageBuilderService.buildTransactionMessage(rrn, requestMap, transactionCurrency);

            // Serialize ISO message
            byte[] isoMsgBytes = isoMsgSerializerAndDeserializerService.serializeISOMsg(isoMsg);

            // Update DB payload
            TransactionPayload transactionPayload = transactionEntity.getTransactionPayload();
            transactionPayload.setFinTxnIsoRequest(isoMsgBytes);
            transactionPayload.setUpdatedAt(OffsetDateTime.now());
            databaseService.updateDbRecord(transactionEntity);

            // Store ISO message in context
            ctx.put(JposConstants.ISO_BUILD_SUCCESS, true);
            ctx.put(JposConstants.ISO_MESSAGE_FINACLE_REQUEST, isoMsg);
            ctx.put(JposConstants.ISO_MESSAGE_FINACLE_REQUEST + "_BYTES", "[ISOMsg content excluded]");

            log.info("{}: ISO 8583 build and persistence successful.", rrn);
            ctx.put(JposConstants.TRANSACTION_PREPARED, true);
            return PREPARED;

        } catch (CustomException e) {
            updateJposContext(ctx, rrn, "Failed to build ISO request (CustomException): " + e.getMessage());
            return ABORTED;
        } catch (Exception e) {
            updateJposContext(ctx, rrn, "Failed to build ISO request (Exception): " + e.getMessage());
            return ABORTED;
        }
    }

    @Override
    public void commit(long id, Serializable serialisedContext) {
        // No transactional side-effects needed in commit phase for this participant
        Context ctx = (Context) serialisedContext;
        String rrn = (String) ctx.get(JposConstants.RRN);
        log.info("{}: Commit phase (no action).", rrn);
    }

    @Override
    public void abort(long id, Serializable serialisedContext) {
        // No transactional side-effects needed in abort phase for this participant
        Context ctx = (Context) serialisedContext;
        String rrn = (String) ctx.get(JposConstants.RRN);
        log.info("{}: Abort phase (no action).", rrn);
    }

    // Helper to update context with error/status
    private void updateJposContext(Context ctx, String rrn, String statusMessage) {
        log.error("{}: {}", rrn, statusMessage);
        ctx.put(JposConstants.STATUS_MESSAGE, statusMessage);
        ctx.put(JposConstants.TXN_STATUS, TransactionStatus.FAILURE);
        ctx.put(JposConstants.STATUS_CODE, TransactionStatus.FAILURE.getCode());

        // Update context with papss error code and message
        ctx.put(JposConstants.SENT_PAPSS_STATUS_CODE, RJCT);
        ctx.put(JposConstants.PAPSS_ERROR_CODE, DEFAULT_PAPSS_ERROR_CODE);
        ctx.put(JposConstants.PAPSS_ERROR_MESSAGE, DEFAULT_PAPSS_ERROR_MESSAGE);

        // Send a RJCT status to PAPSS after abort for this participant
        ctx.put(JposConstants.HTTP_POSTING_REQUIRED_ON_ABORT, true);

        // Set reversal flags
        ctx.put(JposConstants.NEEDS_FINACLE_REVERSAL, false);
    }
}
