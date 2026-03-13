package com.equitybank.gag.papss.its.jpos.space.participants;

import com.equitybank.gag.papss.its.enums.TransactionStatus;
import com.equitybank.gag.papss.its.jpos.space.configs.JposConstants;
import com.equitybank.gag.papss.its.jpos.space.configs.SpringBeanLoader;
import com.equitybank.gag.papss.its.service.ISO20022ValidateSignatureService;
import org.jpos.transaction.Context;
import org.jpos.transaction.TransactionParticipant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;

import java.io.Serializable;

import static com.equitybank.gag.papss.its.enums.PapssStatusCodes.RJCT;

/**
 * Validates the digital signature of the incoming ISO 20022 XML payload using a trusted certificate.
 * This is a critical participant for message authenticity and integrity.
 */
public final class ISO20022SignatureValidationParticipant implements TransactionParticipant {
    private static final Logger log = LoggerFactory.getLogger(ISO20022SignatureValidationParticipant.class);

    private ISO20022ValidateSignatureService iSO20022ValidateSignatureService;

    public ISO20022SignatureValidationParticipant() {
        // Load the Spring-managed signature validation service via the static Q2 SpringBeanLoader
        ApplicationContext context = SpringBeanLoader.getApplicationContext();
        if (context != null) {
            try {
                this.iSO20022ValidateSignatureService = context.getBean(ISO20022ValidateSignatureService.class);
                log.info("Successfully Loaded ISO20022ValidateSignatureService Bean.");
            } catch (Exception e) {
                log.error("Could not load ISO20022ValidateSignatureService Bean. Exception Occurred: {}", e.getMessage());
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
        String payload = (String) ctx.get(JposConstants.REQUEST_PAYLOAD_CONTEXT);

        log.info("{}: Starting ISO20022SignatureValidation Participant.", rrn);


        if (iSO20022ValidateSignatureService == null) {
            updateJposContext(ctx, rrn, "Signature validation service bean unavailable.");
            return ABORTED;
        }
        if (payload == null || payload.trim().isEmpty()) {
            updateJposContext(ctx, rrn, "Message payload is missing for signature validation.");
            return ABORTED;
        }

        try {
            iSO20022ValidateSignatureService.validateSignature(rrn, payload);
            log.info("{}: ISO20022 signature validation PASSED for message type: {}", rrn, messageType);
            ctx.put(JposConstants.TRANSACTION_PREPARED, true);
            return PREPARED;
        } catch (Exception e) {
            updateJposContext(ctx, rrn, e.getMessage());
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

    // Helper method to update the jPOS Context with transaction status, code, and message.
    private void updateJposContext(Context ctx, String rrn, String message) {
        log.error("{}: {}", rrn, message);
        ctx.put(JposConstants.TXN_STATUS, TransactionStatus.FAILURE);
        ctx.put(JposConstants.STATUS_CODE, TransactionStatus.FAILURE.getCode());
        ctx.put(JposConstants.STATUS_MESSAGE, message);

        // Papss Error Code
        ctx.put(JposConstants.SENT_PAPSS_STATUS_CODE, RJCT);
        ctx.put(JposConstants.PAPSS_ERROR_CODE, "3003");
        ctx.put(JposConstants.PAPSS_ERROR_MESSAGE, "Invalid digital signature");

        // This does not need finacle reversal
        ctx.put(JposConstants.NEEDS_FINACLE_REVERSAL, false);

        // Send a RJCT status to PAPS after abort for this participant
        ctx.put(JposConstants.HTTP_POSTING_REQUIRED_ON_ABORT, true);
    }
}
