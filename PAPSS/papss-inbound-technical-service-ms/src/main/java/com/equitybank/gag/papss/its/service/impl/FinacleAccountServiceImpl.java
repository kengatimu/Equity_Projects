package com.equitybank.gag.papss.its.service.impl;

import com.equitybank.gag.papss.its.enums.AccountStatus;
import com.equitybank.gag.papss.its.enums.TransactionType;
import com.equitybank.gag.papss.its.exception.CustomException;
import com.equitybank.gag.papss.its.jpos.jposService.ISOMessageBuilderService;
import com.equitybank.gag.papss.its.jpos.jposService.SendToFinacleService;
import com.equitybank.gag.papss.its.pojo.accountDetails.AccountDetails;
import com.equitybank.gag.papss.its.service.FinacleAccountService;
import org.jpos.iso.ISOMsg;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.concurrent.TimeUnit;

import static com.equitybank.gag.papss.its.config.StatusCodeMessages.DEFAULT_ERROR;

@Service
public class FinacleAccountServiceImpl implements FinacleAccountService {
    private static final Logger log = LoggerFactory.getLogger(FinacleAccountServiceImpl.class);

    private final SendToFinacleService sendToFinacleService;
    private final ISOMessageBuilderService isoMessageBuilderService;

    private static final int MAX_RETRIES = 3;
    private static final long RETRY_DELAY_MS = 1000; // 1 second

    public FinacleAccountServiceImpl(SendToFinacleService sendToFinacleService,
                                     ISOMessageBuilderService isoMessageBuilderService) {
        this.sendToFinacleService = sendToFinacleService;
        this.isoMessageBuilderService = isoMessageBuilderService;
    }

    @Override
    public AccountDetails getAccountDetails(String rrn, String accountNumber) throws CustomException {
        String bankId = "54";
        String operation = "accountEnquiry";
        ISOMsg accountEnquiryISOMessage;
        try {
            // Build ISO8583 account enquiry message only once
            accountEnquiryISOMessage = isoMessageBuilderService.buildAccountEnquiryMessage(rrn, accountNumber);
        } catch (Exception e) {
            log.error("{}: Failed to build account enquiry ISO message: {}", rrn, e.getMessage());
            throw new CustomException(DEFAULT_ERROR + "Failed to build account enquiry ISO message: " + e.getMessage());
        }

        // Send the message to Finacle, retrying on network/system errors or incomplete data
        ISOMsg isoResponse = sendAccountEnquiryWithRetry(rrn, accountEnquiryISOMessage, accountNumber, operation, bankId);

        if (isoResponse == null) {
            log.warn("{}: No valid response from Finacle after retries for account {}. Returning UNKNOWN_ACCT_STATUS.", rrn, accountNumber);
            return new AccountDetails(null, null, AccountStatus.UNKNOWN_ACCT_STATUS, accountNumber, null, null, null, null);
        }

        String responseCode = isoResponse.getString(39);
        log.info("{}: Final Finacle response code after retries: {}", rrn, responseCode);

        // Handle INVALID account (Field 39 = 114)
        if ("114".equals(responseCode)) {
            log.warn("{}: Finacle account {} is invalid (F39=114).", rrn, accountNumber);
            return new AccountDetails(null, null, AccountStatus.INVALID_ACCT, accountNumber, null, null, null, "114");
        }

        // Handle only SUCCESS (Field 39 = 000)
        if ("000".equals(responseCode)) {
            String field127 = isoResponse.getString(127);

            // If missing, after retrying, still treat as UNKNOWN
            if (field127 == null || field127.isEmpty()) {
                log.warn("{}: Finacle F39=000, but no customer details in field 127. Returning UNKNOWN_ACCT_STATUS.", rrn);
                return new AccountDetails(null, null, AccountStatus.UNKNOWN_ACCT_STATUS, accountNumber, null, null, null, "000");
            }

            // Parse account details from field 127
            return parseAccountDetailsFromField127(field127, accountNumber, responseCode, rrn);
        }

        // For all other response codes, treat as UNKNOWN status
        log.warn("{}: Finacle returned F39='{}' for account {}. Returning UNKNOWN_ACCT_STATUS.", rrn, responseCode, accountNumber);
        return new AccountDetails(null, null, AccountStatus.UNKNOWN_ACCT_STATUS, accountNumber, null, null, null, responseCode);
    }

    // Handles retry for account enquiry.
    // Retries for null response, F39=907/909/911, or F39=000 and field127 is missing.
    private ISOMsg sendAccountEnquiryWithRetry(String rrn, ISOMsg isoRequest, String accountNumber, String operation, String bankId) throws CustomException {
        ISOMsg isoMsgResponse;
        int attempt = 0;

        while (attempt <= MAX_RETRIES) {
            try {
                log.info("{}: Sending Finacle account enquiry (Attempt {}/{}) for account {}", rrn, attempt + 1, MAX_RETRIES, accountNumber);
                isoMsgResponse = sendToFinacleService.sendAccountEnquiry(rrn, isoRequest, bankId, TransactionType.NAMECHECK);

                String responseCode = (isoMsgResponse != null) ? isoMsgResponse.getString(39) : null;
                log.info("{}: Attempt {}/{} - Finacle response code: {}", rrn, attempt + 1, MAX_RETRIES, responseCode);

                // Return iso msg response if retry condition don't apply
                if (!shouldRetry(isoMsgResponse)) {
                    return isoMsgResponse;
                }

                String code = (isoMsgResponse == null) ? "null" : isoMsgResponse.getString(39);
                log.warn("{}: Retrying Finacle account enquiry due to response code '{}', attempt {}", rrn, code, attempt + 1);
                TimeUnit.MILLISECONDS.sleep(RETRY_DELAY_MS);
            } catch (Exception e) {
                log.error("{}: Error during Finacle enquiry attempt {}: {}", rrn, attempt + 1, e.getMessage());
                if (attempt == MAX_RETRIES) {
                    throw new CustomException(DEFAULT_ERROR + "Finacle enquiry failed after retries: " + e.getMessage());
                }
                try {
                    TimeUnit.MILLISECONDS.sleep(RETRY_DELAY_MS);
                } catch (InterruptedException ignored) {
                }
            }
            attempt++;
        }
        return null;
    }

    // Determines if we should retry based on response.
    private boolean shouldRetry(ISOMsg isoResponse) {
        if (isoResponse == null) {
            return true;
        }

        // Get field 39 value
        String code = isoResponse.getString(39);

        // Retry on Finacle system/network issues
        if ("907".equals(code) || "909".equals(code) || "911".equals(code)) {
            return true;
        }

        // Retry if success but field 127 (customer name/details) missing
        if ("000".equals(code)) {
            String f127 = isoResponse.getString(127);
            return (f127 == null || f127.isEmpty());
        }
        return false;
    }

    // Parses field 127 string into AccountDetails object, enforcing all rules.
    private AccountDetails parseAccountDetailsFromField127(String field127, String accountNumber, String responseCode, String rrn) {
        // Remove leading/trailing slashes, split by "/"
        String cleanF127 = removeSlash(field127);
        String[] fields = cleanF127.split("/");

        String accountSchemeCode = getValueFromArray(2, fields);
        String accountName = getValueFromArray(3, fields);
        String finacleAccountStatus = getValueFromArray(5, fields);
        String accountCurrency = getValueFromArray(6, fields);
        String accountFreezeCode = getValueFromArray(7, fields);

        // Sanitize accountName
        String firstName = null, lastName = null;
        if (accountName != null && !accountName.isEmpty()) {
            String sanitizedName = accountName.replace("&", "and").replaceAll("[^a-zA-Z0-9 ]", "");
            String[] accountNameParts = truncateString(sanitizedName, 70).split(" ", 2);
            firstName = accountNameParts[0];
            if (accountNameParts.length > 1) lastName = accountNameParts[1];
        }

        // Block all loan accounts
        if (accountSchemeCode != null && accountSchemeCode.startsWith("LA")) {
            log.warn("{}: Account {} is a loan account ({}). Payment prohibited.", rrn, accountNumber, accountSchemeCode);
            return new AccountDetails(firstName, lastName, AccountStatus.INVALID_ACCT, accountNumber, accountCurrency, accountSchemeCode, accountFreezeCode, responseCode);
        }

        String statusCode = finacleAccountStatus != null ? finacleAccountStatus.trim().toUpperCase() : null;
        String freezeCode = accountFreezeCode != null ? accountFreezeCode.trim().toUpperCase() : null;

        // Credit or Total freeze - BLOCK
        if ("C".equals(freezeCode)) {
            log.warn("{}: Account {} is CREDIT FROZEN.", rrn, accountNumber);
            return new AccountDetails(firstName, lastName, AccountStatus.CREDIT_FROZEN, accountNumber, accountCurrency, accountSchemeCode, freezeCode, responseCode);
        }

        if ("T".equals(freezeCode)) {
            log.warn("{}: Account {} is TOTAL FROZEN.", rrn, accountNumber);
            return new AccountDetails(firstName, lastName, AccountStatus.TOTAL_FROZEN, accountNumber, accountCurrency, accountSchemeCode, freezeCode, responseCode);
        }

        // Debit frozen - Allowed by business to credit
        if ("D".equals(freezeCode) && "A".equals(statusCode)) {
            log.info("{}: Account {} is DEBIT FROZEN but allowed for credit by Business.", rrn, accountNumber);
            return new AccountDetails(firstName, lastName, AccountStatus.DEBIT_FROZEN, accountNumber, accountCurrency, accountSchemeCode, freezeCode, responseCode);
        }

        // Dormant (status=D, no freeze) - Allowed by business to credit
        if ("D".equals(statusCode)) {
            log.info("{}: Account {} is DORMANT but allowed for credit by Business.", rrn, accountNumber);
            return new AccountDetails(firstName, lastName, AccountStatus.DORMANT, accountNumber, accountCurrency, accountSchemeCode, null, responseCode);
        }

        // Active
        if ("A".equals(statusCode)) {
            log.info("{}: Account {} is ACTIVE.", rrn, accountNumber);
            return new AccountDetails(firstName, lastName, AccountStatus.ACTIVE, accountNumber, accountCurrency, accountSchemeCode, null, responseCode);
        }

        return new AccountDetails(firstName, lastName, AccountStatus.UNKNOWN_ACCT_STATUS, accountNumber, accountCurrency, accountSchemeCode, freezeCode, responseCode);
    }

    // Remove leading/trailing slash
    private String removeSlash(String str) {
        if (str == null) return null;
        return str.replaceAll("^/|/$", "");
    }

    // Get value safely from array
    private String getValueFromArray(int index, String[] array) {
        if (array != null && index >= 0 && index < array.length) {
            return array[index];
        }
        return null;
    }

    // Truncate string to maxLength
    private String truncateString(String str, int maxLength) {
        if (str == null) return null;
        return str.length() > maxLength ? str.substring(0, maxLength) : str;
    }
}
