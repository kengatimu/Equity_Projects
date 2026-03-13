package com.equitybank.gag.mtn_money_ms.config;

public final class StatusCodeMessages {
    // Status codes
    public static final String PENDING_CODE = "001";
    public static final String SUCCESS_CODE = "000";
    public static final String DEFAULT_STATUS_CODE = "00";
    public static final String TIMEOUT_STATUS_CODE = "-3";
    public static final int DEFAULT_HTTP_STATUS_CODE = 400;
    public static final String CBS_REVERSED_SUCCESS_CODE = "000_REV";
    public static final String SIGNATURE_VALIDATION_STATUS_CODE = "-6";

    // ISO8583 errors
    public static final String ISO8583_FINACLE_TIMEOUT = "408|";

    // Application errors
    public static final String TELCO_ERROR = "400|Request failed from Telco: ";
    public static final String EUREKA_FAILURE = "400|Service Eureka Failure: ";
    public static final String DEFAULT_MONEYGRAM_FAILURE = "400|Moneygram Error: ";
    public static final String FIELD_VALIDATION_ERROR = "400|Validation Failure: ";
    public static final String DEFAULT_HTTP_ERROR = "400|Http exception occurred: ";
    public static final String DEFAULT_PROCESSING_FAILURE = "400|Could not process the request: ";
    public static final String NOT_FOUND = "404|Transaction with the provided rrn does not exist.";
    public static final String AMOUNT_MISMATCH = "400|The supplied amount does match the original amount.";
    public static final String SIGNATURE_VALIDATION_ERROR = "401|Unauthorized: Signature Validation Failed";
    public static final String SIGNATURE_GENERATION_ERROR = "401|Unauthorized: Signature Generation Failed";
    public static final String INVALID_NUMBER_ERROR = "400|Invalid MSISDN: Could not resolve telco provider.";
    public static final String ID_MISMATCH = "400|The supplied mgiTransactionSessionID does match the original id.";
    public static final String REFERENCE_NOT_FOUND = "404|Transaction with the provided imt reference does not exist.";
    public static final String CURRENCY_MISMATCH = "400|The supplied currency does match the original sender currency.";
    public static final String DUPLICATE_ERROR = "409|De-Dup! The request is a duplicate and has already been processed.";
    public static final String TELCO_TIMEOUT_ERROR = "408|Did not receive a response from the remote Telco, possibly due to timeout.";
    public static final String TELCO_REQUEST_TIMEOUT = "408|Did not receive a response from the remote Telco, possibly due to timeout.";
    public static final String IMT_REFERENCE_NUMBER_MISMATCH = "400|The supplied reference number does match the original reference Number.";

    private StatusCodeMessages() {
    }
}
