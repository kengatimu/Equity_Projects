package com.equitybank.gag.papss.its.jpos.space.participants.namecheckFlow;

import com.equitybank.gag.papss.its.enums.AccountStatus;
import com.equitybank.gag.papss.its.enums.TransactionStatus;
import com.equitybank.gag.papss.its.enums.TransactionType;
import com.equitybank.gag.papss.its.jpos.space.configs.JposConstants;
import com.equitybank.gag.papss.its.jpos.space.configs.SpringBeanLoader;
import com.equitybank.gag.papss.its.pojo.accountDetails.AccountDetails;
import com.equitybank.gag.papss.its.service.ISOSignatureGenerationService;
import com.equitybank.gag.papss.its.service.PayloadXmlComposerService;
import org.jpos.transaction.Context;
import org.jpos.transaction.TransactionParticipant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;

import java.io.Serializable;
import java.util.Map;

import static com.equitybank.gag.papss.its.config.StatusCodeMessages.DEFAULT_PAPSS_ERROR_CODE;
import static com.equitybank.gag.papss.its.config.StatusCodeMessages.DEFAULT_PAPSS_ERROR_MESSAGE;
import static com.equitybank.gag.papss.its.enums.PapssStatusCodes.ACCP;
import static com.equitybank.gag.papss.its.enums.PapssStatusCodes.RJCT;

/**
 * ISO20022MessageBuilderParticipant:
 * Builds the ISO 20022 response XML for the current transaction, using context data.
 */
public final class ISO20022Acmt024BuilderParticipant implements TransactionParticipant {
    private static final Logger log = LoggerFactory.getLogger(ISO20022Acmt024BuilderParticipant.class);

    private ISOSignatureGenerationService signatureService;
    private PayloadXmlComposerService payloadXmlComposerService;

    public ISO20022Acmt024BuilderParticipant() {
        ApplicationContext context = SpringBeanLoader.getApplicationContext();
        if (context != null) {
            try {
                this.signatureService = context.getBean(ISOSignatureGenerationService.class);
                this.payloadXmlComposerService = context.getBean(PayloadXmlComposerService.class);
                log.info("PayloadXmlComposerService bean loaded.");
            } catch (Exception e) {
                log.error("Failed to load PayloadXmlComposerService: {}", e.getMessage());
            }
        } else {
            log.error("ApplicationContext is null.");
        }
    }

    @Override
    public int prepare(long id, Serializable serialisedContext) {
        Context ctx = (Context) serialisedContext;
        String rrn = (String) ctx.get(JposConstants.RRN);

        // For pacs008 message, go to the next participant
        String stateKey = ctx.get(JposConstants.STATE_KEY);
        if ("pacs008".equalsIgnoreCase(stateKey)) {
            return PREPARED;
        }

        log.info("{}: Starting ISO20022Acmt024Builder Participant.", rrn);

        try {
            // Retrieve the request map and KYC/account details from context
            @SuppressWarnings("unchecked")
            Map<String, String> requestMap = (Map<String, String>) ctx.get(JposConstants.NAMECHECK_REQUEST_MAP);
            AccountDetails accountDetails = (AccountDetails) ctx.get(JposConstants.ACCOUNT_KYC_DATA);
            AccountStatus accountStatus = (AccountStatus) ctx.get(JposConstants.ACCOUNT_STATUS);

            if (requestMap == null || accountStatus == null) {
                updateJposContext(ctx, rrn, "Missing requestMap or accountStatus in context.");
                return ABORTED;
            }

            // Build the correct XML response based on account status
            String acmt024ResponseXml;
            if (accountStatus == AccountStatus.ACTIVE) {
                // Success: Build verified acmt.023 response
                String accountCurrency = accountDetails.getAccountCurrency();
                String customerName = buildCustomerName(accountDetails);
                String email = "";

                requestMap.put("accountCurrency", accountCurrency);
                requestMap.put("name", customerName);
                requestMap.put("email", email);

                // Build acmt.023 success response xml
                acmt024ResponseXml = payloadXmlComposerService.composeAcmt024SuccessResponse(rrn, requestMap);
                ctx.put(JposConstants.SENT_PAPSS_STATUS_CODE, ACCP);
                log.info("{}: acmt.023 success response built.", rrn);
            } else {
                // Failure: Build acmt.024 failure response (using PAPSS error code from context if available)
                String papssErrorCode = (String) ctx.get(JposConstants.PAPSS_ERROR_CODE);
                if (papssErrorCode == null) {
                    papssErrorCode = DEFAULT_PAPSS_ERROR_CODE;
                }

                // Build acmt.023 failure response xml
                acmt024ResponseXml = payloadXmlComposerService.composeAcmt024NamecheckFailureResponse(rrn, requestMap, papssErrorCode);
                ctx.put(JposConstants.SENT_PAPSS_STATUS_CODE, RJCT);
                log.info("{}: acmt.023 failure response built. Code={}", rrn, papssErrorCode);
            }

            // Generate digital signature
            String signedAcmt024ResponseXml = signatureService.generateXMLDigitalSignature(rrn, acmt024ResponseXml, TransactionType.NAMECHECK.name());

            // Store signed XML in the resolved context key
            ctx.put(JposConstants.TRANSACTION_PREPARED, true);
            ctx.put(JposConstants.SIGNED_ACMT_RESPONSE_XML_CONTEXT, signedAcmt024ResponseXml);
            return PREPARED;

        } catch (Exception e) {
            log.error("{}: Exception while building acmt.023 response XML: {}", rrn, e.getMessage());
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

    // Helper: Build full name from account accountDetails (expand as needed)
    private String buildCustomerName(AccountDetails accountDetails) {
        if (accountDetails == null) {
            return "";
        }
        String firstName = accountDetails.getFirstName() == null ? "" : accountDetails.getFirstName();
        String lastName = accountDetails.getLastName() == null ? "" : accountDetails.getLastName();
        return (firstName + " " + lastName).trim();
    }

    // Helper to update the jPOS Context with all error fields and statuses.
    private void updateJposContext(Context ctx, String rrn, String statusMessage) {
        log.error("{}: {}", rrn, statusMessage);
        ctx.put(JposConstants.STATUS_MESSAGE, statusMessage);
        ctx.put(JposConstants.TXN_STATUS, TransactionStatus.FAILURE);
        ctx.put(JposConstants.STATUS_CODE, TransactionStatus.FAILURE.getCode());

        // Update context with papss error code and message
        ctx.put(JposConstants.SENT_PAPSS_STATUS_CODE, RJCT);
        ctx.put(JposConstants.PAPSS_ERROR_CODE, DEFAULT_PAPSS_ERROR_CODE);
        ctx.put(JposConstants.PAPSS_ERROR_MESSAGE, DEFAULT_PAPSS_ERROR_MESSAGE);

        // This does not need finacle reversal
        ctx.put(JposConstants.NEEDS_FINACLE_REVERSAL, false);

        // Send a RJCT status to PAPS after abort for this participant
        ctx.put(JposConstants.HTTP_POSTING_REQUIRED_ON_ABORT, true);
    }
}
