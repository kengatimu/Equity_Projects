package com.equitybank.gag.papss.ots.jpos.iso8583.configs;

/**
 * Centralized ISO8583 constants for PAPSS processing
 */
public final class ISOApplicationConstants {

    private ISOApplicationConstants() {
    }

    // Transport Protocol Data Unit (TPDU) Header
    public static final String ISO_TPDU_HEADER = "495379303036303030303430";

    // Default timeout values
    private static final int CONNECTION_TIMEOUT_MS = 5000;
    private static final int RESPONSE_TIMEOUT_MS = 10000;

    // Echo-specific constants
    public static final String ISO_MTI_ECHO = "1804";                    // MTI for echo request
    public static final long ECHO_INTERVAL_MS = 60_000L;                 // Echo interval in ms
    public static final String ISO_FIELD_24_ECHO = "831";                // NII for echo
    public static final String ISO_FIELD_123_ECHO = "SMS";               // Identifier for system sending echo
    public static final String ISO_FIELD_126_ECHO = "CAMPAIGN";          // Optional custom data
    public static final String ISO_RESPONSE_CODE_ECHO_SUCCESS = "800";   // Success response for echo

    // Transaction specific constants
    public static final String TRANSACTION_NII = "200";
    public static final String DEFAULT_NARRATION = "OTHERS";             // Fallback narration
    public static final String ISO_MTI_TRANSACTION = "1200";             // MTI for transaction request
    public static final String TRANSACTION_CHANNEL_CODE = "TPG";         // Default logical channel
//    public static final String TRANSACTION_CHARGE_CODE = "FLOAT";        // Default charge type
    public static final String TRANSACTION_CHARGES_CHARGE_CODE = "PAPSSFEE";        // Default charge type for charges leg
    public static final String TRANSACTION_PRINCIPAL_CHARGE_CODE = "PAPSS";        // Default charge type for principal leg
    public static final String TRANSACTION_ACQUIRER_ID_KE = "111111";       // Acquiring institution code
//    public static final String TRANSACTION_ACQUIRER_ID = "627851";       // Acquiring institution code
    public static final String TRANSACTION_TERMINAL_ID = "TERMID01";     // POS/ATM terminal ID
    public static final String TRANSACTION_PAN_KE = "6278000000001712";     // Generic PAN
//    public static final String TRANSACTION_PAN = "4478150000000000";     // Generic PAN
    public static final String ISO_MTI_TRANSACTION_REVERSAL = "1420";    // MTI for transaction reversal request
    public static final String TRANSACTION_CODE_IDENTIFIER_DRC = "400000";   // Standard fund transfer
    public static final String TRANSACTION_CODE_IDENTIFIER = "440000";   // Standard fund transfer

    // Constants for ISO 8583 message reversal fields
    public static final String PADDING = "000000";                       // Padding character used by Finacle
    public static final String REVERSAL_INDICATOR = "6";
    public static final String REVERSAL_TRANSACTION_TYPE_CODE = "400";
    public static final String REVERSAL_DEFAULT_MESSAGE_TYPE_INDICATOR_MTI = "1420";

    // Status check specific constants
    public static final String ISO_MTI_STATUS_INQUIRY = "1220";          // MTI for status checks
    public static final String STATUS_CHECK_CODE_IDENTIFIER = "390000";  // Standard fund transfer

    // Inquiry specific constants
    public static final String ISO_MTI_ACCOUNT_INQUIRY = "1200";         // Use 1300, If using custom MTI for KYC/inquiry
    public static final String ACCT_INQUIRY_CODE_IDENTIFIER = "310000";  // Standard fund transfer

}
