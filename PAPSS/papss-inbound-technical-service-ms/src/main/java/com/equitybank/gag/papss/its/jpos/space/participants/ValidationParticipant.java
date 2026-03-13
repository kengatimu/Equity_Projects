package com.equitybank.gag.papss.its.jpos.space.participants;

import com.equitybank.gag.papss.its.enums.TransactionStatus;
import com.equitybank.gag.papss.its.enums.TransactionType;
import com.equitybank.gag.papss.its.jpos.space.configs.JposConstants;
import com.equitybank.gag.papss.its.jpos.space.configs.SpringBeanLoader;
import com.equitybank.gag.papss.its.service.XmlReaderService;
import org.jpos.transaction.Context;
import org.jpos.transaction.TransactionParticipant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;

import java.io.Serializable;
import java.util.Map;

import static com.equitybank.gag.papss.its.config.StatusCodeMessages.*;
import static com.equitybank.gag.papss.its.enums.PapssStatusCodes.RJCT;

/**
 * ValidationParticipant checks that required fields are present before processing continues.
 */
public final class ValidationParticipant implements TransactionParticipant {
    private static final Logger log = LoggerFactory.getLogger(ValidationParticipant.class);

    private XmlReaderService xmlReaderService;

    public ValidationParticipant() {
        ApplicationContext context = SpringBeanLoader.getApplicationContext();
        if (context != null) {
            try {
                this.xmlReaderService = context.getBean(XmlReaderService.class);
                log.info("Spring beans successfully loaded.");
            } catch (Exception e) {
                log.error("Failed to load the necessary spring beans: {}", e.getMessage());
            }
        } else {
            log.error("ApplicationContext is null.");
        }
    }

    @Override
    public int prepare(long id, Serializable serialisedContext) {
        Context ctx = (Context) serialisedContext;
        String rrn = (String) ctx.get(JposConstants.RRN);
        String messageType = (String) ctx.get(JposConstants.MESSAGE_TYPE);
        String payloadXml = (String) ctx.get(JposConstants.REQUEST_PAYLOAD_CONTEXT);

        log.info("{}: Starting Validation Participant.", rrn);

        try {
            // Validate payloadXml
            if (isBlank(payloadXml)) {
                updateJposContext(ctx, rrn, "Payload is required.", false);
                return ABORTED;
            }

            // Validate messageType
            if (isBlank(messageType)) {
                updateJposContext(ctx, rrn, "messageType is required.", true);
                return ABORTED;
            }

            // Put the payloadXml details in a map
            Map<String, String> requestMap;
            if (PACS008_MESSAGE_TYPE.equalsIgnoreCase(messageType) ) {
                requestMap = xmlReaderService.processInboundXml(rrn, payloadXml, TransactionType.CREDIT_TRANSFER.name());
                ctx.put(JposConstants.PACS008_REQUEST_MAP, requestMap);
            } else {
                requestMap = xmlReaderService.processInboundXml(rrn, payloadXml, TransactionType.NAMECHECK.name());
                ctx.put(JposConstants.NAMECHECK_REQUEST_MAP, requestMap);
            }

            // Log the map details
            log.info("Map Details: " + requestMap);

            // Validate rrn
            if (isBlank(rrn)) {
                updateJposContext(ctx, "", "RRN is required.", true);
                return ABORTED;
            }

            log.info("{}: RRN, MessageType, and Payload Validation Passed.", rrn);
            ctx.put(JposConstants.TRANSACTION_PREPARED, true);
            return PREPARED;
        } catch (Exception e) {
            log.error("{}: Exception while validating the required fields: {}", rrn, e.getMessage());
            updateJposContext(ctx, rrn, e.getMessage(), false);
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

    // Helper method to check for null or empty
    private boolean isBlank(String str) {
        return str == null || str.trim().isEmpty();
    }

    // Helper method to update the jPOS Context with transaction status, code, and message.
    private void updateJposContext(Context ctx, String rrn, String message, boolean sendMessageToPapss) {
        log.error("{}: {}", rrn, message);
        ctx.put(JposConstants.STATUS_MESSAGE, message);
        ctx.put(JposConstants.TXN_STATUS, TransactionStatus.FAILURE);
        ctx.put(JposConstants.STATUS_CODE, TransactionStatus.FAILURE.getCode());

        // Papss Error Code
        ctx.put(JposConstants.SENT_PAPSS_STATUS_CODE, RJCT);
        ctx.put(JposConstants.PAPSS_ERROR_CODE, DEFAULT_PAPSS_ERROR_CODE);
        ctx.put(JposConstants.PAPSS_ERROR_MESSAGE, DEFAULT_PAPSS_ERROR_MESSAGE);

        // This does not need finacle reversal
        ctx.put(JposConstants.NEEDS_FINACLE_REVERSAL, false);

        // Send a RJCT status to PAPS after abort for this participant
        ctx.put(JposConstants.HTTP_POSTING_REQUIRED_ON_ABORT, sendMessageToPapss);
    }
}
