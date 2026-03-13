package com.equitybank.gag.papss.ips.config;

public final class StatusCodeMessages {

    // Status codes
    public static final String DEFAULT_ERROR_CODE = "01";
    public static final String TIMEOUT_STATUS_CODE = "-3";
    public static final String DEFAULT_SUCCESS_CODE = "00";
    public static final String DEFAULT_PENDING_CODE = "001";
    public static final int DEFAULT_HTTP_STATUS_CODE = 400;
    public static final String CBS_REVERSED_SUCCESS_CODE = "000_REV";

    // Application errors
    public static final String DEFAULT_ERROR = "400|Internal Error: ";
    public static final String FIELD_VALIDATION_ERROR = "400|Internal Error: Field Validation Failed. ";
    public static final String RECORD_NOT_FOUND = "404|Transaction with the provided rrn does not exist.";
    public static final String HTTP_ERROR = "400|Internal Error: HTTP Call To The URL Was Unsuccessful. ";
    public static final String DEFAULT_TRANSACTION_TYPE_ERROR = "400|Internal Error: Invalid transaction type: ";
    public static final String DEFAULT_PROCESSING_FAILURE = "400|Internal Error: Could not process the request. ";
    public static final String DUPLICATE_RECORD = "409|De-Dup! The request is a duplicate and has already been processed.";
    public static final String DEFAULT_DATABASE_ERROR = "400|Internal Database Error: Error occurred while saving transaction: ";
    public static final String DIGITAL_SIGNATURE_GENERATION_FAILURE = "400|Internal Error: Could Not Generate Digital Signature. ";
    public static final String DEFAULT_RESPONSE_PROCESSING_FAILURE = "400|Internal Error: Could not process the received response. ";
    public static final String EQUITY_TIMEOUT_ERROR = "408|Outbound service did not receive a response from equity bank, possibly due to timeout. ";
    public static final String CHANNEL_TIMEOUT_ERROR = "408|Outbound service did not receive a response from the channel, possibly due to timeout. ";
    public static final String SIGNATURE_VALIDATION_ERROR = "401|Unauthorized: Signature Validation Failed";
    private StatusCodeMessages() {
    }
}
