package com.equitybank.gag.papss.ots.jpos.space.participants;

import com.equitybank.gag.papss.ots.jpos.space.configs.JposConstants;
import com.equitybank.gag.papss.ots.jpos.space.configs.SpringBeanLoader;
import com.equitybank.gag.papss.ots.dto.channelRequest.transaction.ChannelCreditTransferDetailsReq;
import com.equitybank.gag.papss.ots.entity.TransactionMaster;
import com.equitybank.gag.papss.ots.enums.TransactionStatus;
import com.equitybank.gag.papss.ots.exception.CustomException;
import com.equitybank.gag.papss.ots.service.DatabaseService;
import com.equitybank.gag.papss.ots.service.EntityMapperService;
import org.jpos.transaction.Context;
import org.jpos.transaction.TransactionParticipant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;

import java.io.Serializable;

/**
 * jPOS Transaction Participant responsible for persisting the initial state of a credit transfer request to the database.
 */
public class InitialTransactionPersistenceParticipant implements TransactionParticipant {
    private static final Logger log = LoggerFactory.getLogger(InitialTransactionPersistenceParticipant.class);

    private DatabaseService databaseService;
    private EntityMapperService entityMapperService;

    public InitialTransactionPersistenceParticipant() {
        // participants are instantiated by jPOS, so we get Spring beans via SpringBeanLoader
        ApplicationContext context = SpringBeanLoader.getApplicationContext();
        if (context != null) {
            try {
                this.databaseService = context.getBean(DatabaseService.class);
                this.entityMapperService = context.getBean(EntityMapperService.class);
                log.info("Initialized with DatabaseService and EntityMapperService from Spring context.");
            } catch (Exception e) {
                log.error("Failed to retrieve Spring beans - DatabaseService and EntityMapperService from Spring context. Error: {}", e.getMessage());
            }
        } else {
            log.error("Spring ApplicationContext is null. Cannot initialize services.");
        }
    }

    @Override
    public int prepare(long id, Serializable serialisedContext) {
        Context ctx = (Context) serialisedContext;
        String rrn = (String) ctx.get(JposConstants.RRN);
        ChannelCreditTransferDetailsReq channelRequest = (ChannelCreditTransferDetailsReq) ctx.get(JposConstants.TRANSACTION_CONTEXT);
        log.info("{}: Starting initial transaction persistence.", rrn);

        // Critical check: Ensure required services are initialized
        if (databaseService == null || entityMapperService == null) {
            String errorMsg = "Required database services not initialized. Aborting transaction.";
            updateJposContext(ctx, rrn, TransactionStatus.FAILURE, errorMsg);
            return ABORTED;
        }

        // Critical check: Ensure channelRequest is available from previous participant
        if (channelRequest == null) {
            String errorMsg = "Channel request not found in context. Aborting transaction.";
            updateJposContext(ctx, rrn, TransactionStatus.FAILURE, errorMsg);
            return ABORTED;
        }

        try {
            // Map DTO to Entity
            TransactionMaster transactionEntity = entityMapperService.composeInitialCreditTransferEntity(channelRequest);

            // Persist Entity to Database
            databaseService.saveInitialCreditTransferEntity(rrn, transactionEntity);

            // Store the saved entity in the jPOS Context for subsequent participants
            ctx.put(JposConstants.TRANSACTION_ENTITY_CONTEXT, transactionEntity);

            // Status should already be PENDING from ValidationParticipant. This is a confirmation.
            String statusMsg = String.format("Successfully persisted initial transaction record. Status set to %s.", TransactionStatus.PENDING.name());
            updateJposContext(ctx, rrn, TransactionStatus.PENDING, statusMsg);
            return PREPARED;

        } catch (CustomException e) {
            String errorMsg = String.format("DB Error: %s", e.getMessage());
            updateJposContext(ctx, rrn, TransactionStatus.FAILURE, errorMsg);
            return ABORTED;
        } catch (Exception e) {
            String errorMsg = String.format("Unexpected Error during persistence: %s", e.getMessage());
            updateJposContext(ctx, rrn, TransactionStatus.FAILURE, errorMsg);
            return ABORTED;
        }
    }

    @Override
    public void commit(long id, Serializable serialisedContext) {
        Context ctx = (Context) serialisedContext;
        String rrn = (String) ctx.get(JposConstants.RRN);
        log.info("{}: Commit phase (no action).", rrn);
    }

    @Override
    public void abort(long id, Serializable serialisedContext) {
        Context ctx = (Context) serialisedContext;
        String rrn = (String) ctx.get(JposConstants.RRN);
        log.info("{}: Abort phase (no action).", rrn);
    }

    //Helper method to update the jPOS Context with transaction status, code, and message.
    private void updateJposContext(Context ctx, String rrn, TransactionStatus status, String message) {
        // Log the message with appropriate level
        if (status.equals(TransactionStatus.FAILURE)) {
            log.error("{}: {}", rrn, message);
        } else {
            log.info("{}: {}", rrn, message);
        }

        // Set the context variables
        ctx.put(JposConstants.TXN_STATUS, status);
        ctx.put(JposConstants.STATUS_CODE, status.getCode());
        ctx.put(JposConstants.STATUS_MESSAGE, message);
    }
}