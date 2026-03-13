package com.equitybank.gag.papss.its.jpos.space.participants.namecheckFlow;

import com.equitybank.gag.papss.its.enums.AccountStatus;
import com.equitybank.gag.papss.its.enums.TransactionStatus;
import com.equitybank.gag.papss.its.jpos.space.configs.JposConstants;
import com.equitybank.gag.papss.its.jpos.space.configs.SpringBeanLoader;
import com.equitybank.gag.papss.its.pojo.accountDetails.AccountDetails;
import com.equitybank.gag.papss.its.service.FinacleAccountService;
import com.equitybank.gag.papss.its.service.XmlReaderService;
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
 * NamecheckParticipant: Handles PAPSS acmt.024 name check requests.
 * Queries Finacle for account details and updates the jPOS context
 * with result and KYC data for downstream participants.
 */
public final class NamecheckParticipant implements TransactionParticipant {
    private static final Logger log = LoggerFactory.getLogger(NamecheckParticipant.class);

    private XmlReaderService xmlReaderService;
    private FinacleAccountService finacleAccountService;

    // Default PAPSS error codes/messages
    private static final String INVALID_ACCOUNT_ERROR_CODE = "1009";
    private static final String INVALID_ACCOUNT_ERROR_MESSAGE = "The creditor Account or IBAN is invalid.";

    public NamecheckParticipant() {
        ApplicationContext context = SpringBeanLoader.getApplicationContext();
        if (context != null) {
            try {
                this.xmlReaderService = context.getBean(XmlReaderService.class);
                this.finacleAccountService = context.getBean(FinacleAccountService.class);
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
        String namecheckRequestPayloadXml = (String) ctx.get(JposConstants.REQUEST_PAYLOAD_CONTEXT);

        // For pacs008 message, go to the next participant
        String stateKey = ctx.get(JposConstants.STATE_KEY);
        if ("pacs008".equalsIgnoreCase(stateKey)) {
            return PREPARED;
        }

        log.info("{}: Starting Namecheck Participant.", rrn);

        if (finacleAccountService == null) {
            updateJposContext(ctx, rrn, DEFAULT_PAPSS_ERROR_CODE, DEFAULT_PAPSS_ERROR_MESSAGE, "Finacle service bean unavailable.");
            return ABORTED;
        }

        try {
            // Extract the requestMap from context
            Map<String, String> requestMap = (Map<String, String>) ctx.get(JposConstants.NAMECHECK_REQUEST_MAP);

            // Abort if requestMap is missing
            if (requestMap == null || requestMap.isEmpty()) {
                updateJposContext(ctx, rrn, DEFAULT_PAPSS_ERROR_CODE, DEFAULT_PAPSS_ERROR_MESSAGE, "RequestMap is missing in request.");
                return ABORTED;
            }

            // Extract account number from the incoming payload
            String accountNumber = requestMap.get("accountNumber");

            // Abort if account number is missing
            if (accountNumber == null || accountNumber.isEmpty()) {
                updateJposContext(ctx, rrn, DEFAULT_PAPSS_ERROR_CODE, DEFAULT_PAPSS_ERROR_MESSAGE, "Account number is missing in request.");
                return ABORTED;
            }

            // Query Finacle for account details
            log.info("{}: Performing name check for account number: {}", rrn, accountNumber);
            AccountDetails accountDetails = finacleAccountService.getAccountDetails(rrn, accountNumber);
            if (accountDetails == null) {
                updateJposContext(ctx, rrn, DEFAULT_PAPSS_ERROR_CODE, DEFAULT_PAPSS_ERROR_MESSAGE, "Name check failed. Account status is unknown.");
                return ABORTED;
            }

            // Set account status and details in context for downstream use
            AccountStatus status = accountDetails.getStatus();
            ctx.put(JposConstants.ACCOUNT_STATUS, status);
            ctx.put(JposConstants.ACCOUNT_KYC_DATA, accountDetails);

            // Proceed if account is ACTIVE
            if (status == AccountStatus.ACTIVE) {
                log.info("{}: Name check passed. Account is ACTIVE.", rrn);
                ctx.put(JposConstants.TRANSACTION_PREPARED, true);
                return PREPARED;
            }

            // If account is INVALID, set PAPSS-specific error code/message and abort
            if (status == AccountStatus.INVALID_ACCT) {
                log.info("{}: Name check failed. Finacle Status {}. Account Status: {}", rrn, accountDetails.getFinacleStatusCode(), status);
                updateJposContext(ctx, rrn, INVALID_ACCOUNT_ERROR_CODE, INVALID_ACCOUNT_ERROR_MESSAGE, "Invalid account.");
                return ABORTED;
            }

            // If account is INVALID, set PAPSS-specific error code/message and abort
            if (status == AccountStatus.UNKNOWN_ACCT_STATUS) {
                log.info("{}: Name check failed. Finacle Status {}. Account Status: {}", rrn, accountDetails.getFinacleStatusCode(), status);
                updateJposContext(ctx, rrn, "101", "Account on Name Inquiry cannot be verified", "Account not active.");
                return ABORTED;
            }

            // For any other status (frozen, unknown, etc.), set generic error and abort
            log.info("{}: Name check failed. Finacle Status {}. Account Status: {}", rrn, accountDetails.getFinacleStatusCode(), status);
            updateJposContext(ctx, rrn, "1009", "The creditor Account is invalid", "Account not active.");
            return ABORTED;

        } catch (Exception e) {
            // Catch-all: log and set context with generic error for downstream handler
            updateJposContext(ctx, rrn, DEFAULT_PAPSS_ERROR_CODE, DEFAULT_PAPSS_ERROR_MESSAGE, "Namecheck exception occurred: " + e.getMessage());
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

        // This does not need finacle reversal
        ctx.put(JposConstants.NEEDS_FINACLE_REVERSAL, false);

        // Send a RJCT status to PAPS after abort for this participant
        ctx.put(JposConstants.HTTP_POSTING_REQUIRED_ON_ABORT, true);
    }
}
