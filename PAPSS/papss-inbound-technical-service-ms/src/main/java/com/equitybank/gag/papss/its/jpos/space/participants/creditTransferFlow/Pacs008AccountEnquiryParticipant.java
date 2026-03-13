package com.equitybank.gag.papss.its.jpos.space.participants.creditTransferFlow;

import com.equitybank.gag.papss.its.enums.AccountStatus;
import com.equitybank.gag.papss.its.enums.TransactionStatus;
import com.equitybank.gag.papss.its.jpos.space.configs.JposConstants;
import com.equitybank.gag.papss.its.jpos.space.configs.SpringBeanLoader;
import com.equitybank.gag.papss.its.exception.CustomException;
import com.equitybank.gag.papss.its.pojo.accountDetails.AccountDetails;
import com.equitybank.gag.papss.its.service.FinacleAccountService;
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
 * Pacs008AccountEnquiryParticipant:
 * Checks the beneficiary/credit account status via Finacle.
 * - If ACTIVE, sets account details in context and proceeds.
 * - If not ACTIVE, aborts and requires RJCT posting to PAPSS.
 */
public final class Pacs008AccountEnquiryParticipant implements TransactionParticipant {
    private static final Logger log = LoggerFactory.getLogger(Pacs008AccountEnquiryParticipant.class);

    // PAPSS error codes/messages
    private static final String INVALID_ACCOUNT_ERROR_CODE = "1009";
    private static final String INVALID_ACCOUNT_ERROR_MESSAGE = "The creditor Account or IBAN is invalid.";

    private FinacleAccountService finacleAccountService;

    public Pacs008AccountEnquiryParticipant() {
        // Load FinacleAccountService from Spring context
        ApplicationContext context = SpringBeanLoader.getApplicationContext();
        if (context != null) {
            try {
                this.finacleAccountService = context.getBean(FinacleAccountService.class);
                log.info("FinacleAccountService bean loaded for Pacs008PAccountStatusCheckParticipant.");
            } catch (Exception e) {
                log.error("Failed to load FinacleAccountService: {}", e.getMessage());
            }
        } else {
            log.error("ApplicationContext is null.");
        }
    }

    @Override
    public int prepare(long id, Serializable serialisedContext) {
        Context ctx = (Context) serialisedContext;
        String rrn = (String) ctx.get(JposConstants.RRN);

        log.info("{}: Starting Pacs008AccountEnquiry Participant.", rrn);

        try {
            // Retrieve the PACS.008 requestMap from context
            @SuppressWarnings("unchecked")
            Map<String, String> requestMap = (Map<String, String>) ctx.get(JposConstants.PACS008_REQUEST_MAP);

            // Abort if requestMap is missing/empty
            if (requestMap == null || requestMap.isEmpty()) {
                updateJposContext(ctx, rrn, DEFAULT_PAPSS_ERROR_CODE, DEFAULT_PAPSS_ERROR_MESSAGE, "RequestMap missing in context.");
                return ABORTED;
            }

            // Extract creditor account number (beneficiary account)
            String receiverAccountNumber = requestMap.get("receiverAccount");
            if (receiverAccountNumber == null || receiverAccountNumber.isEmpty()) {
                updateJposContext(ctx, rrn, DEFAULT_PAPSS_ERROR_CODE, DEFAULT_PAPSS_ERROR_MESSAGE,"Receiver account number missing from request map.");
                return ABORTED;
            }

            // Call Finacle for account status check
            log.info("{}: Performing Account Enquiry For The Receiver Account: {}", rrn, receiverAccountNumber);
            AccountDetails accountDetails = finacleAccountService.getAccountDetails(rrn, receiverAccountNumber);

            // If account details are missing, treat as unknown and abort
            if (accountDetails == null) {
                updateJposContext(ctx, rrn, INVALID_ACCOUNT_ERROR_CODE, INVALID_ACCOUNT_ERROR_MESSAGE, "Processing failed. Account status is unknown.");
                return ABORTED;
            }

            // Store account status and details in context for downstream participants
            AccountStatus status = accountDetails.getStatus();
            ctx.put(JposConstants.ACCOUNT_STATUS, status);
            ctx.put(JposConstants.ACCOUNT_KYC_DATA, accountDetails);

            // If account is ACTIVE, proceed
            if (status == AccountStatus.ACTIVE
                    || status == AccountStatus.DORMANT
                    || status == AccountStatus.DEBIT_FROZEN) {

                log.info("{}: Credit account status {} allowed. Proceeding.", rrn, status);
                ctx.put(JposConstants.TRANSACTION_PREPARED, true);
                return PREPARED;
            }

            // Otherwise, abort and require RJCT posting to PAPSS
            log.warn("{}: Credit account is NOT ACTIVE (status={}). Aborting the transaction flow.", rrn, status);
            updateJposContext(ctx, rrn, INVALID_ACCOUNT_ERROR_CODE, INVALID_ACCOUNT_ERROR_MESSAGE,"Credit account not active (" + status + ")");
            return ABORTED;

        } catch (CustomException e) {
            updateJposContext(ctx, rrn, DEFAULT_PAPSS_ERROR_CODE, DEFAULT_PAPSS_ERROR_MESSAGE,"Exception during account status check: " + e.getMessage());
            return ABORTED;
        } catch (Exception e) {
            updateJposContext(ctx, rrn, DEFAULT_PAPSS_ERROR_CODE, DEFAULT_PAPSS_ERROR_MESSAGE,"Unexpected exception in Pacs008PAccountStatusCheckParticipant: " + e.getMessage());
            return ABORTED;
        }
    }

    @Override
    public void commit(long id, Serializable serialisedContext) {
        // No action required on commit for this participant
        Context ctx = (Context) serialisedContext;
        String rrn = (String) ctx.get(JposConstants.RRN);
        log.info("{}: Commit phase (no action).", rrn);
    }

    @Override
    public void abort(long id, Serializable serialisedContext) {
        // No action required on abort for this participant
        Context ctx = (Context) serialisedContext;
        String rrn = (String) ctx.get(JposConstants.RRN);
        log.info("{}: Abort phase (no action).", rrn);
    }

    // Helper to update context with error/status
    private void updateJposContext(Context ctx, String rrn, String papssErrorCode, String papssErrorDesc, String statusMessage) {
        log.error("{}: {}", rrn, statusMessage);
        ctx.put(JposConstants.STATUS_MESSAGE, statusMessage);
        ctx.put(JposConstants.TXN_STATUS, TransactionStatus.FAILURE);
        ctx.put(JposConstants.STATUS_CODE, TransactionStatus.FAILURE.getCode());

        // Set PAPSS RJCT fields for error reporting
        ctx.put(JposConstants.SENT_PAPSS_STATUS_CODE, RJCT);
        ctx.put(JposConstants.PAPSS_ERROR_CODE, papssErrorCode);
        ctx.put(JposConstants.PAPSS_ERROR_MESSAGE, papssErrorDesc);

        // Send a RJCT status to PAPSS after abort for this participant
        ctx.put(JposConstants.HTTP_POSTING_REQUIRED_ON_ABORT, true);

        // Set reversal flags
        ctx.put(JposConstants.NEEDS_FINACLE_REVERSAL, false);
    }

}
