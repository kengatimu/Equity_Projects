package com.equitybank.gag.papss.its.jpos.space.participants.creditTransferFlow;

import com.equitybank.gag.papss.its.enums.TransactionStatus;
import com.equitybank.gag.papss.its.enums.TransactionType;
import com.equitybank.gag.papss.its.jpos.space.configs.JposConstants;
import com.equitybank.gag.papss.its.jpos.space.configs.SpringBeanLoader;
import com.equitybank.gag.papss.its.exception.CustomException;
import com.equitybank.gag.papss.its.service.DatabaseService;
import com.equitybank.gag.papss.its.service.XmlReaderService;
import com.equitybank.gag.papss.its.service.EntityMapperService;
import com.equitybank.gag.papss.its.entity.TransactionMaster;
import org.jpos.transaction.Context;
import org.jpos.transaction.TransactionParticipant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;

import java.io.Serializable;
import java.util.Map;

import static com.equitybank.gag.papss.its.config.StatusCodeMessages.DEFAULT_PAPSS_ERROR_CODE;
import static com.equitybank.gag.papss.its.config.StatusCodeMessages.DEFAULT_PAPSS_ERROR_MESSAGE;
import static com.equitybank.gag.papss.its.enums.PapssStatusCodes.RJCT;

/**
 * InitialTransactionPersistenceParticipant:
 * - Parses inbound pacs.008 request XML, checks for duplicates, persists initial DB entity.
 * - Updates context with failure codes and aborts if a duplicate is detected.
 */
public final class InitialTransactionPersistenceParticipant implements TransactionParticipant {
    private static final Logger log = LoggerFactory.getLogger(InitialTransactionPersistenceParticipant.class);

    private static final String DE_DUP_ERROR_CODE = "1011";
    private static final String DE_DUP_ERROR_MESSAGE = "De Dup. A payment with the same reference has been detected as already processed";

    private XmlReaderService xmlReaderService;
    private DatabaseService databaseService;
    private EntityMapperService entityMapperService;

    public InitialTransactionPersistenceParticipant() {
        ApplicationContext context = SpringBeanLoader.getApplicationContext();
        if (context != null) {
            try {
                this.xmlReaderService = context.getBean(XmlReaderService.class);
                this.databaseService = context.getBean(DatabaseService.class);
                this.entityMapperService = context.getBean(EntityMapperService.class);
                log.info("Beans loaded for InitialTransactionPersistenceParticipant.");
            } catch (Exception e) {
                log.error("Failed to load the necessary beans for InitialTransactionPersistenceParticipant: {}", e.getMessage());
            }
        } else {
            log.error("ApplicationContext is null.");
        }
    }

    @Override
    public int prepare(long id, Serializable serialisedContext) {
        Context ctx = (Context) serialisedContext;
        String rrn = (String) ctx.get(JposConstants.RRN);
        String creditTransferRequestXml = (String) ctx.get(JposConstants.REQUEST_PAYLOAD_CONTEXT);
        @SuppressWarnings("unchecked")
        Map<String, String> requestMap = (Map<String, String>) ctx.get(JposConstants.PACS008_REQUEST_MAP);

        log.info("{}: Starting InitialTransactionPersistence Participant.", rrn);

        try {
            // Abort if rrn is missing
            if (rrn == null || rrn.isEmpty()) {
                updateJposContext(ctx, "", DEFAULT_PAPSS_ERROR_CODE, DEFAULT_PAPSS_ERROR_MESSAGE, "RRN missing from context. Cannot proceed.");
                return ABORTED;
            }

            // Parse XML into requestMap
            if (requestMap == null || requestMap.isEmpty()) {
                requestMap = xmlReaderService.processInboundXml(rrn, creditTransferRequestXml, TransactionType.CREDIT_TRANSFER.name());
            }

            // Abort if requestMap is missing
            if (requestMap == null || requestMap.isEmpty()) {
                updateJposContext(ctx, rrn, DEFAULT_PAPSS_ERROR_CODE, DEFAULT_PAPSS_ERROR_MESSAGE, "RequestMap is missing in request.");
                return ABORTED;
            }

            // Check for duplicates
            try {
                databaseService.checkTransactionExists(rrn, TransactionType.CREDIT_TRANSFER);
            } catch (CustomException e) {
                // Duplicate found - update context with RJCT and abort
                updateJposContext(ctx, rrn, DE_DUP_ERROR_CODE, DE_DUP_ERROR_MESSAGE, "Duplicate credit transfer detected: " + e.getMessage());
                return ABORTED;
            }

            // Build and save initial TransactionMaster entity using requestMap
            TransactionMaster entity = entityMapperService.composeInitialCreditTransferEntity(rrn, requestMap);
            databaseService.saveInitialCreditTransferEntity(rrn, entity);

            // Store requestMap for downstream participants
            ctx.put(JposConstants.PACS008_REQUEST_MAP, requestMap);
            ctx.put(JposConstants.TRANSACTION_PREPARED, true);
            log.info("{}: Initial pacs.008 transaction persisted. Proceeding...", rrn);
            return PREPARED;
        } catch (Exception e) {
            updateJposContext(ctx, rrn, DEFAULT_PAPSS_ERROR_CODE, DEFAULT_PAPSS_ERROR_MESSAGE, "Exception in InitialTransactionPersistenceParticipant: " + e.getMessage());
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

    // Helper to update the jPOS Context with all error fields and statuses.
    private void updateJposContext(Context ctx, String rrn, String papssErrorCode, String papssErrorMessage, String statusMessage) {
        log.error("{}: {}", rrn, statusMessage);
        ctx.put(JposConstants.STATUS_MESSAGE, statusMessage);
        ctx.put(JposConstants.TXN_STATUS, TransactionStatus.FAILURE);
        ctx.put(JposConstants.STATUS_CODE, TransactionStatus.FAILURE.getCode());

        // Update papss error code and message
        ctx.put(JposConstants.SENT_PAPSS_STATUS_CODE, RJCT);
        ctx.put(JposConstants.PAPSS_ERROR_CODE, papssErrorCode);
        ctx.put(JposConstants.PAPSS_ERROR_MESSAGE, papssErrorMessage);

        // Send a RJCT status to PAPSS after abort for this participant
        ctx.put(JposConstants.HTTP_POSTING_REQUIRED_ON_ABORT, true);

        // Set reversal flag
        ctx.put(JposConstants.NEEDS_FINACLE_REVERSAL, false);
    }
}