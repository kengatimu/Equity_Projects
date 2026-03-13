package com.equitybank.gag.papss.ots.jpos.space.configs;

/**
 * Centralized constants specific to the jPOS transaction pipeline and Context keys.
 * This class is final and cannot be instantiated.
 */
public final class JposConstants {

    // Private constructor to prevent instantiation of this utility class.
    private JposConstants() {
    }

    // --- JPOS CONTEXT KEYS ---

    // Space name
    public static final String SHARED_SPACE_NAME = "GLOBAL_TXN_SPACE";

    // Keys for core transaction identification and status management within the jPOS Context.
    public static final String RRN = "rrn";
    public static final String TXN_TYPE = "txnType";
    public static final String TXN_STATUS = "txnStatus";
    public static final String STATUS_CODE = "statusCode";
    public static final String STATUS_MESSAGE = "statusMessage";
    public static final String TRANSACTION_CONTEXT = "transactionContext";
    public static final String TRANSACTION_ENTITY_CONTEXT = "transactionEntityContext";

    // Keys for storing Finacle-related ISO 8583 messages in the jPOS Context.
    public static final String ISO_MESSAGE_FINACLE_TRANSACTION_REQUEST = "isoMessageFinacleTransactionRequest";
    public static final String ISO_MESSAGE_FINACLE_CHARGES_REQUEST = "isoMessageFinacleChargesRequest";
    public static final String ISO_MESSAGE_FINACLE_CHARGES_RESPONSE = "isoMessageFinacleChargesResponse";
    public static final String ISO_MESSAGE_FINACLE_TRANSACTION_RESPONSE = "isoMessageFinacleTransactionResponse";

    // --- New keys for Finacle reversal messages ---
    public static final String ISO_MESSAGE_FINACLE_REVERSAL_REQUEST = "isoMessageFinacleReversalRequest";
    public static final String ISO_MESSAGE_FINACLE_REVERSAL_RESPONSE = "isoMessageFinacleReversalResponse";
    public static final String FINACLE_REVERSAL_STATUS = "finacleReversalStatus";

    // Keys for storing PAPSS-related ISO 20022 (XML) messages and HTTP details in the jPOS Context.
    public static final String ISO20022_PACS008_TXN_CREATION_DATE_AND_TIME = "iso20022Pacs008TxnCreationDateAndTime";
    public static final String ISO20022_PACS008_TXN_ORIGINAL_MESSAGE_ID = "iso20022Pacs008TxnOriginalMessageId";
    public static final String ISO20022_PACS008_STATUS_REASON_CODE = "iso20022Pacs008StatusReasonCode";
    public static final String ISO20022_PACS008_END_TO_END_ID = "iso20022Pacs008EndToEndId";
    public static final String ISO20022_PACS008_REQUEST_XML = "iso20022MessagePapssRequest";
    public static final String ISO20022_SIGNED_PACS008_XML = "iso20022SignedPacs008Request";
    public static final String ISO20022_PACS002_RESPONSE_XML = "iso20022MessagePapssResponse";
    public static final String CHANNEL_RESPONSE_CONTEXT = "channelResponse";
    public static final String HTTP_RESPONSE = "httpResponse";

    public static final String HTTP_RESPONSE_STATUS_CODE = "httpResponseStatusCode";

    // Keys for conditional flow control flags within the jPOS Context.
    public static final String NEEDS_FINACLE_TRANSACTION_LEG_REVERSAL = "needsFinacleTransactionLegReversal";
    public static final String NEEDS_FINACLE_CHARGES_LEG_REVERSAL = "needsFinacleChargesLegReversal";
    public static final String NEEDS_PAPSS_PROCESSING = "needsPapssProcessing";
}