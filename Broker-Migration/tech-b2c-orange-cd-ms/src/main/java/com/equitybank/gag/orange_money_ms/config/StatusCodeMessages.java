package com.equitybank.gag.orange_money_ms.config;

public final class StatusCodeMessages {

    // Status codes
    public static final String TIMEOUT_STATUS_CODE = "-3";
    public static final String SUCCESS_STATUS_CODE = "00";
    public static final String PENDING_STATUS_CODE = "01";
    public static final String DEFAULT_STATUS_CODE = "500";
    public static final String INITIALIZED_STATUS_CODE = "02";
    public static final String SIGNATURE_VALIDATION_STATUS_CODE = "-6";

    // Application errors
    public static final String EUREKA_FAILURE = "500|Service Eureka Failure: ";
    public static final String FIELD_VALIDATION_ERROR = "400|Validation Failure: ";
    public static final String DEFAULT_HTTP_ERROR = "500|Http exception occurred: ";
    public static final String NOT_FOUND = "404|Transaction with the provided rrn does not exist.";
    public static final String DEFAULT_PROCESSING_FAILURE = "500|An internal processing error occurred: ";
    public static final String SIGNATURE_VALIDATION_ERROR = "401|Unauthorized: Signature Validation Failed";
    public static final String SIGNATURE_GENERATION_ERROR = "401|Unauthorized: Signature Generation Failed";
    public static final String DUPLICATE_ERROR = "409|De-Dup! The request is a duplicate and has already been processed.";
    public static final String BS_TIMEOUT_ERROR = "408|Business service did not receive a response possibly due to timeout.";
    public static final String TS_TIMEOUT_ERROR = "408|Technical service did not receive a response from telco, possibly due to timeout.";

    // Telco service errors
    public static final String TELCO_UNAUTHORIZED = "401|Request is unauthorized from the remote telco service.";
    public static final String TELCO_NOT_FOUND = "404|The requested resource could not be found by remote telco service.";
    public static final String TELCO_UNSUPPORTED_MEDIA_TYPE = "415|Unsupported Media Type. Media type not supported by telco.";
    public static final String TELCO_BAD_REQUEST = "400|A request parameter is invalid or missing from the remote telco service.";
    public static final String TELCO_LIMITS_ERROR = "422|Transaction Violates Account's Minimum Balance. Request cannot be processed by telco";
    public static final String TELCO_REQUEST_TIMEOUT = "408|Operation in Timeout from telco service. Use TransferStatusInquiry to check status.";
    public static final String TELCO_INSUFFICIENT_BALANCE_ERROR = "402|Insufficient Balance. Request could not be processed by the remote telco";
    public static final String TELCO_OPERATION_NOT_PERMITTED = "403|Unauthorized Request on Account (crossed thresholds). Operation not permitted by the telco.";
    public static final String TELCO_INTERNAL_SERVER_ERROR = "500|An unexpected error occurred during the processing of the request by the remote telco service.";
    public static final String TELCO_FINAL_STATUS_ERROR = "500|Error from Telco: ";

    private StatusCodeMessages() {
    }
}
