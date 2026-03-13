package com.equitybank.gag.papss.ots.jpos.space.participants;

import com.equitybank.gag.papss.ots.dto.channelRequest.transaction.ChannelCreditTransferDetailsReq;
import com.equitybank.gag.papss.ots.entity.TransactionMaster;
import com.equitybank.gag.papss.ots.entity.TransactionPayload;
import com.equitybank.gag.papss.ots.enums.TransactionStatus;
import com.equitybank.gag.papss.ots.enums.TransactionType;
import com.equitybank.gag.papss.ots.exception.CustomException;
import com.equitybank.gag.papss.ots.jpos.jposService.ISOMessageBuilderService;
import com.equitybank.gag.papss.ots.jpos.jposService.ISOMsgSerializerAndDeserializerService;
import com.equitybank.gag.papss.ots.jpos.space.configs.JposConstants;
import com.equitybank.gag.papss.ots.jpos.space.configs.SpringBeanLoader;
import com.equitybank.gag.papss.ots.service.DatabaseService;
import org.jpos.iso.ISOMsg;
import org.jpos.transaction.Context;
import org.jpos.transaction.TransactionParticipant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;

import java.io.Serializable;
import java.time.OffsetDateTime;

import static com.equitybank.gag.papss.ots.service.impl.ISOPayloadXmlComposerServiceImpl.generateMessageId;

/**
 * Builds ISO 8583 message for Finacle, serializes it, logs it, and stores in DB and jPOS context.
 */
public class ISO8583MessageBuilderParticipant implements TransactionParticipant {
    private static final Logger log = LoggerFactory.getLogger(ISO8583MessageBuilderParticipant.class);

    private String papssId;
    private ISOMessageBuilderService isoMessageBuilderService;
    private ISOMsgSerializerAndDeserializerService isoMsgSerializerAndDeserializerService;
    private DatabaseService databaseService;

    public ISO8583MessageBuilderParticipant() {
        ApplicationContext context = SpringBeanLoader.getApplicationContext();
        if (context != null) {
            try {
                this.papssId = context.getEnvironment().getProperty("papss.equity-bank-id");
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
        ChannelCreditTransferDetailsReq channelRequest = (ChannelCreditTransferDetailsReq) ctx.get(JposConstants.TRANSACTION_CONTEXT);

        log.info("{}: Starting ISO 8583 message build.", rrn);

        // Abort if any required services are missing
        if (isoMessageBuilderService == null || isoMsgSerializerAndDeserializerService == null || databaseService == null) {
            updateJposContext(ctx, rrn, TransactionStatus.FAILURE, "Required services not initialized.");
            return ABORTED;
        }

        // Abort if channel request is missing
        if (channelRequest == null) {
            updateJposContext(ctx, rrn, TransactionStatus.FAILURE, "Channel request missing in context.");
            return ABORTED;
        }

        // Get the latest entity version from DB inorder to preventing optimistic locking errors
        TransactionMaster transactionEntity;
        try {
            transactionEntity = databaseService.getSavedRecord(rrn, TransactionType.CREDIT_TRANSFER);
            ctx.put(JposConstants.TRANSACTION_ENTITY_CONTEXT, transactionEntity);
            log.info("{}: Loaded latest TransactionMaster from DB.", rrn);
        } catch (Exception e) {
            updateJposContext(ctx, rrn, TransactionStatus.FAILURE, "Failed to load latest transaction from DB: " + e.getMessage());
            return ABORTED;
        }

        try {
            // Generate and put papss end to end message id in the context
            String messageId = generateMessageId(papssId);
            ctx.put(JposConstants.ISO20022_PACS008_TXN_ORIGINAL_MESSAGE_ID, messageId);

            // Build ISO 8583 request for Finacle
            ISOMsg principalIsoMsg = isoMessageBuilderService.buildPrincipalISOMessage(channelRequest, messageId);
            ISOMsg chargeIsoMsg = isoMessageBuilderService.buildChargesISOMessage(channelRequest, messageId);

            // Serialize to byte[] for storage
            byte[] transactionIsoMsgBytes = isoMsgSerializerAndDeserializerService.serializeISOMsg(principalIsoMsg);
            byte[] chargesIsoMsgBytes = isoMsgSerializerAndDeserializerService.serializeISOMsg(chargeIsoMsg);

            // Update database table with ISO request payload
            TransactionPayload transactionPayload = transactionEntity.getTransactionPayload();
            transactionPayload.setFinTxnIsoRequest(transactionIsoMsgBytes);
            transactionPayload.setFinChargesIsoRequest(chargesIsoMsgBytes);
            transactionPayload.setUpdatedAt(OffsetDateTime.now());
            databaseService.updateDbRecord(transactionEntity);

            // Store ISO message and bytes in jPOS context
            ctx.put(JposConstants.ISO_MESSAGE_FINACLE_TRANSACTION_REQUEST, principalIsoMsg);
            ctx.put(JposConstants.ISO_MESSAGE_FINACLE_CHARGES_REQUEST, chargeIsoMsg);
            ctx.put(JposConstants.ISO_MESSAGE_FINACLE_TRANSACTION_REQUEST + "_BYTES", "[Transaction ISOMsg content excluded]");
            ctx.put(JposConstants.ISO_MESSAGE_FINACLE_CHARGES_REQUEST + "_BYTES", "[Charges ISOMsg content excluded]");

            // Update jpos context with Pending status
            updateJposContext(ctx, rrn, TransactionStatus.PENDING, "ISO 8583 build and persistence successful.");
            return PREPARED;

        } catch (CustomException e) {
            updateJposContext(ctx, rrn, TransactionStatus.FAILURE, "Error building ISO: " + e.getMessage());
            return ABORTED;
        } catch (Exception e) {
            log.error("{}: Unexpected error: {}", rrn, e.getMessage(), e);
            updateJposContext(ctx, rrn, TransactionStatus.FAILURE, "Unexpected error: " + e.getMessage());
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

    private void updateJposContext(Context ctx, String rrn, TransactionStatus status, String message) {
        if (status == TransactionStatus.FAILURE) {
            log.error("{}: {}", rrn, message);
        } else {
            log.info("{}: {}", rrn, message);
        }
        ctx.put(JposConstants.TXN_STATUS, status);
        ctx.put(JposConstants.STATUS_CODE, status.getCode());
        ctx.put(JposConstants.STATUS_MESSAGE, message);
    }
}
