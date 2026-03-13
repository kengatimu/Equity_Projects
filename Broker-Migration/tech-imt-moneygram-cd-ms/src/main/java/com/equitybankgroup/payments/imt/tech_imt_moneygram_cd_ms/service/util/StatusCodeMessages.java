package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.service.util;

public final class StatusCodeMessages {

    // Status codes
    public static final String PENDING_CODE = "001";
    public static final String SUCCESS_CODE = "000";
    public static final String TIMEOUT_STATUS_CODE = "-3";
    public static final String CBS_REVERSED_SUCCESS_CODE = "000_REV";
    public static final String SIGNATURE_VALIDATION_STATUS_CODE = "-6";

    // ISO8583 errors
    public static final String ISO8583_FINACLE_TIMEOUT = "408|";

    // Application errors
    public static final String EUREKA_FAILURE = "503|Service Eureka Failure: ";
    public static final String DEFAULT_MONEYGRAM_FAILURE = "503|Moneygram Error: ";
    public static final String FIELD_VALIDATION_ERROR = "400|Validation Failure: ";
    public static final String DEFAULT_PROCESSING_FAILURE = "503|Could not process the request: ";
    public static final String NOT_FOUND = "404|Transaction with the provided rrn does not exist.";
    public static final String AMOUNT_MISMATCH = "400|The supplied amount does match the original amount.";
    public static final String SIGNATURE_VALIDATION_ERROR = "401|Unauthorized: Signature Validation Failed";
    public static final String SIGNATURE_GENERATION_ERROR = "401|Unauthorized: Signature Generation Failed";
    public static final String ID_MISMATCH = "400|The supplied mgiTransactionSessionID does match the original id.";
    public static final String CURRENCY_MISMATCH = "400|The supplied currency does match the original sender currency.";
    public static final String DUPLICATE_ERROR = "409|De-Dup! The request is a duplicate and has already been processed.";
    public static final String BS_TIMEOUT_ERROR = "408|Business service did not receive a response possibly due to timeout.";
    public static final String IMT_REFERENCE_NUMBER_MISMATCH = "400|The supplied reference number does match the original reference Number.";

    private StatusCodeMessages() {
    }
}
