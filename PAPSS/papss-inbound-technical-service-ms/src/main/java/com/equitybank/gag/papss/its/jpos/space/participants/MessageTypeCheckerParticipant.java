package com.equitybank.gag.papss.its.jpos.space.participants;

import com.equitybank.gag.papss.its.enums.TransactionStatus;
import com.equitybank.gag.papss.its.jpos.space.configs.JposConstants;
import org.jpos.transaction.Context;
import org.jpos.transaction.TransactionParticipant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.Serializable;

import static com.equitybank.gag.papss.its.config.StatusCodeMessages.*;
import static com.equitybank.gag.papss.its.enums.PapssStatusCodes.RJCT;

/**
 * MessageTypeCheckerParticipant:
 * Decides the transaction branch in the state machine based on the ISO 20022 message type.
 * This enables dynamic routing of acmt.024 (name check) and pacs.008 (credit transfer) requests.
 */
public final class MessageTypeCheckerParticipant implements TransactionParticipant {
    private static final Logger log = LoggerFactory.getLogger(MessageTypeCheckerParticipant.class);

    @Override
    public int prepare(long id, Serializable serialisedContext) {
        Context ctx = (Context) serialisedContext;
        String rrn = (String) ctx.get(JposConstants.RRN);
        String messageType = (String) ctx.get(JposConstants.MESSAGE_TYPE);

        log.info("{}: Starting MessageTypeChecker Participant.", rrn);

        // Abort if message type is missing or blank
        if (messageType == null || messageType.trim().isEmpty()) {
            updateJposContext(ctx, rrn, "MessageType is missing or empty. Cannot route transaction.");
            return ABORTED;
        }

        // Route based on ISO 20022 message type
        if (messageType.contains(ACMT0023_MESSAGE_TYPE)) {
            ctx.put(JposConstants.STATE_KEY, "acmt023");
            log.info("{}: MessageType is acmt.023. Routing to 'acmt023' state flow.", rrn);
        } else if (messageType.contains(PACS008_MESSAGE_TYPE)) {
            ctx.put(JposConstants.STATE_KEY, "pacs008");
            log.info("{}: MessageType is pacs.008. Routing to 'pacs008' state flow.", rrn);
        } else {
            // For unsupported types, abort and set context for rejection handling
            ctx.put(JposConstants.STATE_KEY, "default");
            updateJposContext(ctx, rrn, "Unsupported MessageType: " + messageType);
            return ABORTED;
        }

        // Ready for next state if routed successfully
        log.info("{}: Prepared for next transition.", rrn);
        ctx.put(JposConstants.TRANSACTION_PREPARED, true);
        return PREPARED;
    }

    @Override
    public void commit(long id, Serializable serialisedContext) {
        // No transactional side effects needed in commit phase for this participant
        Context ctx = (Context) serialisedContext;
        String rrn = (String) ctx.get(JposConstants.RRN);
        log.info("{}: Commit phase (no action).", rrn);
    }

    @Override
    public void abort(long id, Serializable serialisedContext) {
        // No transactional side effects needed in abort phase for this participant
        Context ctx = (Context) serialisedContext;
        String rrn = (String) ctx.get(JposConstants.RRN);
        log.info("{}: Abort phase (no action).", rrn);
    }

   // Update the jPOS context with failure codes and messages for downstream error handling.
    private void updateJposContext(Context ctx, String rrn, String message) {
        log.error("{}: {}", rrn, message);

        // Mark transaction as failed and set status code/message
        ctx.put(JposConstants.TXN_STATUS, TransactionStatus.FAILURE);
        ctx.put(JposConstants.STATUS_CODE, TransactionStatus.FAILURE.getCode());
        ctx.put(JposConstants.STATUS_MESSAGE, message);

        // Set standard PAPSS error codes/messages for RJCT response
        ctx.put(JposConstants.SENT_PAPSS_STATUS_CODE, RJCT);
        ctx.put(JposConstants.PAPSS_ERROR_CODE, "100");
        ctx.put(JposConstants.PAPSS_ERROR_MESSAGE, "Internal processing error");

        // This does not need finacle reversal
        ctx.put(JposConstants.NEEDS_FINACLE_REVERSAL, false);

        // Send a RJCT status to PAPSS after abort for this participant
        ctx.put(JposConstants.HTTP_POSTING_REQUIRED_ON_ABORT, true);
    }
}
