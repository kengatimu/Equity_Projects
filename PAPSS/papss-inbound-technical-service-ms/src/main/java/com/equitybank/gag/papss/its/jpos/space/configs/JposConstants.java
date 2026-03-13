package com.equitybank.gag.papss.its.jpos.space.configs;

public final class JposConstants {

    // Prevent instantiation
    private JposConstants() {
    }

    // Space name
    public static final String SHARED_SPACE_NAME_INBOUND = "GLOBAL_TXN_SPACE_INBOUND";

    // Core transaction keys
    public static final String RRN = "rrn";
    public static final String STATE_KEY = "stateKey";                                  // For jPOS state transitions
    public static final String TXN_STATUS = "txnStatus";
    public static final String STATUS_CODE = "statusCode";
    public static final String MESSAGE_TYPE = "messageType";
    public static final String STATUS_MESSAGE = "statusMessage";
    public static final String PAPSS_ERROR_CODE = "papssErrorCode";
    public static final String ISO_BUILD_SUCCESS = "isoBuildSuccess";
    public static final String SENT_PAPSS_STATUS_CODE = "sentPapssStatusCode";                         // ISO20022 status code eg ACCP
    public static final String RECEIVED_PAPSS_STATUS_CODE = "receivedPapssStatusCode";                         // ISO20022 status code eg ACCP
    public static final String PAPSS_ERROR_MESSAGE = "papssErrorMessage";
    public static final String REQUEST_PAYLOAD_CONTEXT = "requestPayloadContext";       // Inbound message/request object or XML
    public static final String PAPSS_HTTP_STATUS_CODE = "papssHttpStatusCode";          // returned http status code from papss
    public static final String PAPSS_HTTP_ACK_STATUS_CODE = "papssHttpAckStatusCode";          // returned http status code from papss
    public static final String PAPSS_HTTP_RESPONSE_STRING = "papssHttpResponseString"; // returned response string from papss
    public static final String PAPSS_HTTP_ACK_RESPONSE_STRING = "papssHttpAckResponseString"; // returned response string from papss
    public static final String HTTP_POSTING_REQUIRED_ON_ABORT = "httpPostingRequiredOnAbort"; // Post to papss on abort flag
    public static final String TRANSACTION_ENTITY_CONTEXT = "transactionEntityContext";

    // acmt.024 (Namecheck) specific keys
    public static final String ACCOUNT_NUMBER = "accountNumber";
    public static final String ACCOUNT_STATUS = "accountStatus";                        // e.g. ACTIVE or INACTIVE
    public static final String ACCOUNT_KYC_DATA = "accountKycData";                     // KYC details from Finacle
    public static final String NAMECHECK_REQUEST_MAP = "namecheckRequestMap";           // Hashmap to hold namecheck request details
    public static final String ACMT_RESPONSE_XML_CONTEXT = "acmtResponseXmlContext";    // acmt0023 response
    public static final String SIGNED_ACMT_RESPONSE_XML_CONTEXT = "signedAcmtResponseXmlContext";    // singed acmt message

    // pacs.008 (Credit Transfer) specific keys
    public static final String PACS008_REQUEST_MAP = "pacs008RequestMap";           // Hashmap to hold credit transfer request details
    public static final String PACS008_RESPONSE_MAP = "pacs008ResponseMap";           // Hashmap to hold credit transfer response details
    public static final String TRANSACTION_PREPARED = "transactionPrepared";           // Set flag to show prepared successful
    public static final String NEEDS_FINACLE_REVERSAL = "needsFinacleReversal";           // Reverse from finacle flag
    public static final String PACS_RESPONSE_XML_CONTEXT = "pacsResponseXmlContext";
    public static final String PACS004_RESPONSE_XML_CONTEXT = "pacs004ResponseXmlContext";
    public static final String SIGNED_PACS_RESPONSE_XML_CONTEXT = "pacsSignedResponseXmlContext";

    // Keys for storing Finacle-related ISO 8583 messages in the jPOS Context.
    public static final String ISO_MESSAGE_FINACLE_REQUEST = "isoMessageFinacleRequest";
    public static final String ISO_MESSAGE_FINACLE_RESPONSE = "isoMessageFinacleResponse";

}
