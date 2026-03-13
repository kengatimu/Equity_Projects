package com.equitybank.gag.papss.ots.config;

/**
 * Centralized constants for general application settings, including status codes, error messages, logging templates, and transaction types.
 * This class is final and cannot be instantiated.
 */
public final class ApplicationConstants {

    // Private constructor to prevent instantiation of this utility class.
    private ApplicationConstants() {
    }

    // Test signature
    public static final String TEST_SIGNATURE = "HnNDt4RW8RTRGSWVJ0pwfs/HGeictD7kuclixp/vl8NDAYbGVJaZNeF9eidHixKbmG6T+PYAcUlXZtG79i8gimiB2JO6YWO76fXU+e+6UxRjGjT4vCtIJdstDUTFGBnCJiwKp46VazN61trEdz7rz9lymnA7qFyzLhwePRiT5Q0SM2XH4b6btYrPdTmUTbBsrUx7izVEf7ROytjkGti+o4j2dqUrCKqKTRmxnuOUJiSjTM8W4IY13r6Y9K15lDOVr+KLjdAwH0AFeUNhCLCuqYL5G8AmTnPW24jfFYCaabwojixdFFLuLPhIssuNi+BJnnpMJhz2nM4zBhGr8QVWmQ==";

    // General constants
    public static final String TAX_RATE = "0.15"; // 15% tax
    public static final String DEFAULT_COUNTRY_CODE = "KE";
    public static final String DEFAULT_LOCAL_CURRENCY = "KES";
    public static final String DEFAULT_TRANSACTION_CURRENCY = "USD";
    public static final String INTERNAL_STATUS_CHECK_TYPE = "internal_status_check";

    // --- PAPSS IDENTIFIER TYPES ---
    // Constants definaing PAPSS identifier types used throughout the application.
    public static final String PAPSS_RTP_VERSION = "1";
//    public static final String DEFAULT_PAPSS_PURPOSE_CODE = "RCPT";
    public static final String DEFAULT_PAPSS_PURPOSE_CODE = "CASH";
    public static final String DEFAULT_USD_INSTRUMENT_CODE = "USDP";
    public static final String DEFAULT_LOCAL_INSTRUMENT_CODE = "SSA3";
//    public static final String DEFAULT_PAPSS_CATEGORY_PURPOSE = "SUPP";
    public static final String DEFAULT_PAPSS_CATEGORY_PURPOSE = "ADVA";
//    public static final String DEFAULT_PAPSS_TRANSACTION_CHANNEL = "API";
//    public static final String DEFAULT_PAPSS_TRANSACTION_CHANNEL = "vi-papss";
    public static final String DEFAULT_PAPSS_TRANSACTION_CHANNEL = "MOBILE_BANKING";
    public static final String DEFAULT_PAPSS_CLEARING_SYSTEM_ID = "XA0001";

    // --- STATUS CODES & RELATED CONSTANTS ---
    // General numeric/string codes for transaction outcomes.
    public static final String DEFAULT_ERROR_CODE = "01";
    public static final String TIMEOUT_STATUS_CODE = "-3";
    public static final String DEFAULT_SUCCESS_CODE = "00";
    public static final String DEFAULT_PENDING_CODE = "-11";
    public static final int DEFAULT_HTTP_STATUS_CODE = 400;
    public static final String SIGNATURE_VALIDATION_STATUS_CODE = "401";

    // --- APPLICATION ERROR MESSAGES ---
    // Standard error message prefixes and full messages for various application failures.
    public static final String DEFAULT_ERROR = "Internal Error: ";
    public static final String ISO_DEFAULT_ERROR = "ISO Internal Error: ";
    public static final String FIELD_VALIDATION_ERROR = "Internal Error: Field Validation Failed. ";
    public static final String RECORD_NOT_FOUND = "Transaction with the provided rrn does not exist.";
    public static final String HTTP_ERROR = "Internal Error: HTTP call to the url was unsuccessful. ";
    public static final String CONNECTION_REFUSED_ERROR = "HTTP call to the url was unsuccessful. Connection refused";
    public static final String DEFAULT_PROCESSING_FAILURE = "Internal Error: Could not process the request. ";
    public static final String DUPLICATE_RECORD = "409|De-Dup! The request is a duplicate and has already been processed.";
    public static final String DEFAULT_DATABASE_ERROR = "Internal Database Error: Error occurred while saving transaction: ";
    public static final String DIGITAL_SIGNATURE_GENERATION_FAILURE = "Internal Error: Could not generate digital signature. ";
    public static final String DEFAULT_RESPONSE_PROCESSING_FAILURE = "Internal Error: Could not process the received response. ";
    public static final String PAPSS_TIMEOUT_ERROR = "Outbound Service did not receive a response from papss, possibly due to timeout. ";
    public static final String PAPSS_DEFAULT_ERROR = "Outbound Service received an empty or error response from papss. ";
    public static final String FINACLE_TIMEOUT_ERROR = "Outbound Service did not receive a response from Finacle, possibly due to timeout. ";
    public static final String CHANNEL_TIMEOUT_ERROR = "Outbound Service did not receive a response from the channel, possibly due to timeout. ";
    public static final String SIGNATURE_VALIDATION_ERROR = "Signature Validation Failed: ";

    // --- LOGGING TEMPLATES ---
    // Templates for consistent log message formatting.
    public static final String HTTP_RESPONSE_LOG_TEMPLATE = "HTTP Response: \n STATUS CODE: %s\n STATUS MESSAGE: %s\n RESPONSE BODY STRING: %s\n";
}