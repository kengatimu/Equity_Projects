package com.equitybank.gag.telco_b2c.config;

public final class StatusCodeMessages {

    // Status codes
    public static final String PENDING_CODE = "-11";
    public static final String SUCCESS_CODE = "000";
    public static final String DEFAULT_STATUS_CODE = "00";
    public static final String TIMEOUT_STATUS_CODE = "-3";
    public static final int DEFAULT_HTTP_STATUS_CODE = 400;
    public static final String FINACLE_DEFAULT_FAILURE_CODE = "77";
    public static final String CBS_REVERSED_SUCCESS_CODE = "000_REV";
    public static final String SIGNATURE_VALIDATION_STATUS_CODE = "-6";

    // ISO8583 errors
    public static final String ISO8583_FINACLE_TIMEOUT = "408|";

    // Application errors
    public static final String EUREKA_FAILURE = "400|Service Eureka Failure: ";
    public static final String DEFAULT_MONEYGRAM_FAILURE = "400|Moneygram Error: ";
    public static final String FIELD_VALIDATION_ERROR = "400|Validation Failure: ";
    public static final String DEFAULT_PROCESSING_FAILURE = "400|Could not process the request: ";
    public static final String NOT_FOUND = "404|Transaction with the provided rrn does not exist.";
    public static final String INVALID_TELCO_ERROR = "400|Invalid Telco for the receiver number: ";
    public static final String DOWNSTREAM_SERVICE_FAILURE = "400|Received error from downstream service: ";
    public static final String AMOUNT_MISMATCH = "400|The supplied amount does match the original amount.";
    public static final String SIGNATURE_VALIDATION_ERROR = "401|Unauthorized: Signature Validation Failed";
    public static final String SIGNATURE_GENERATION_ERROR = "401|Unauthorized: Signature Generation Failed";
    public static final String DEFAULT_RESPONSE_PROCESSING_FAILURE = "400|Could not process the response: ";
    public static final String ID_MISMATCH = "400|The supplied mgiTransactionSessionID does match the original id.";
    public static final String REFERENCE_NOT_FOUND = "404|Transaction with the provided imt reference does not exist.";
    public static final String CURRENCY_MISMATCH = "400|The supplied currency does match the original sender currency.";
    public static final String INVALID_NUMBER_ERROR = "400|Invalid MSISDN: Could not resolve telco for provided number.";
    public static final String DUPLICATE_ERROR = "409|De-Dup! The request is a duplicate and has already been processed.";
    public static final String BS_TIMEOUT_ERROR = "408|Business service did not receive a response possibly due to timeout.";
    public static final String CONNECTION_REFUSED_ERROR = "400|HTTP call to the url was unsuccessful. Connection refused";
    public static final String IMT_REFERENCE_NUMBER_MISMATCH = "400|The supplied reference number does match the original reference Number.";

    private StatusCodeMessages() {
    }
}
