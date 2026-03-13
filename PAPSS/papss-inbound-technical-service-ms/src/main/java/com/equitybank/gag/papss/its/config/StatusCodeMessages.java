package com.equitybank.gag.papss.its.config;

public final class StatusCodeMessages {

    // Private constructor to prevent instantiation of this utility class.
    private StatusCodeMessages() {
    }

    public static final String DEFAULT_CHANNEL_ID = "API";
    public static final String DEFAULT_SOURCE_SYSTEM_ID = "API";
    public static final String DEFAULT_BANK_ID_KE = "54";
    public static final String DEFAULT_CURRENCY_KE = "KES";
    public static final String DEFAULT_REFERENCE_CURRENCY_USD= "USD";

    // --- PAPSS IDENTIFIER TYPES ---
    // Constants defining PAPSS identifier types used throughout the application.
    public static final String PAPSS_ID = "KE1011";
    public static final String PAPSS_ID_PROD = "KE100030";
    public static final String PAPSS_SCHEMA_NAME = "BBAN";
    public static final String PAPSS_RTP_VERSION = "1";
    public static final String PACS008_MESSAGE_TYPE = "pacs.008";
    public static final String ACMT0024_MESSAGE_TYPE = "acmt.024";
    public static final String PACS002_MESSAGE_TYPE = "pacs.002";
    public static final String ACMT0023_MESSAGE_TYPE = "acmt.023";
    public static final String PACS004_MESSAGE_TYPE = "pacs.004";
    public static final String CLEARING_SYSTEM_ID = "PAPSS";
    public static final String PARTICIPANT_CLEARING_SYSTEM_ID = "XA0001";
    public static final String EQUITY_SWIFT_BIC_CODE = "EQBLKENA";

    // Default PAPSS error codes/messages
    public static final String DEFAULT_PAPSS_STATUS_CODE = "RJCT";
    public static final String DEFAULT_PAPSS_ERROR_CODE = "100";
    public static final String DEFAULT_PAPSS_DE_DUP_ERROR_CODE = "1011";
    public static final String DEFAULT_PAPSS_ERROR_MESSAGE = "Internal processing error";

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
    public static final String HTTP_ERROR = "Internal Error: HTTP Call To The URL Was Unsuccessful. ";
    public static final String DEFAULT_PROCESSING_FAILURE = "Internal Error: Could not process the request. ";
    public static final String DEFAULT_PAC002_RESPONSE_FAILURE = "PACS002InboundResponseError: ";
    public static final String DUPLICATE_RECORD = "De-Dup! The request is a duplicate and has already been processed.";
    public static final String DEFAULT_DATABASE_ERROR = "Internal Database Error: Error occurred while saving transaction: ";
    public static final String DIGITAL_SIGNATURE_GENERATION_FAILURE = "Internal Error: Could Not Generate Digital Signature. ";
    public static final String DEFAULT_RESPONSE_PROCESSING_FAILURE = "Internal Error: Could not process the received response. ";
    public static final String PAPSS_TIMEOUT_ERROR = "Inbound Service did not receive a response from papss, possibly due to timeout. ";
    public static final String PAPSS_DEFAULT_ERROR = "Inbound Service received an empty response from papss. ";
    public static final String FINACLE_TIMEOUT_ERROR = "Inbound Service did not receive a response from Finacle, possibly due to timeout. ";
    public static final String CHANNEL_TIMEOUT_ERROR = "Inbound Service did not receive a response from the channel, possibly due to timeout. ";
    public static final String SIGNATURE_VALIDATION_ERROR = "Signature Validation Failed: ";

    // --- LOGGING TEMPLATES ---
    // Templates for consistent log message formatting.
    public static final String HTTP_RESPONSE_LOG_TEMPLATE = "HTTP Response: \n STATUS CODE: %s\n STATUS MESSAGE: %s\n RESPONSE BODY STRING: %s\n";
}