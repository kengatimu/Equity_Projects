package com.equitybank.gag.telco_b2c.ISO8583.configs;

public final class Constants {

    // Default values
    public static final String DEFAULT_BANK_ID = "43";
    public static final String DEFAULT_BANK_CODE = "CD";
    public static final String DEFAULT_IMT_CHANNEL_CODE = "IMT";
    public static final String DEFAULT_GAG_CHANNEL_CODE = "TPG";
    public static final String DEFAULT_RATE_CODE = "TERMID01";
    public static final String DEFAULT_THUNES_CHARGE_CODE = "THUNES";
    public static final String DEFAULT_MONEYGRAM_CHARGE_CODE = "MONEYGRAM";
    public static final String FLOAT_CHARGE_CODE = "FLOAT";
    public static final String DEFAULT_PROCESSING_CODE = "400000";
    public static final String DEFAULT_CHARGE_TYPE_PREFIX_CODE = "01";
    public static final long FINACLE_TRANSACTION_REQUEST_TIMEOUT = 40000L;
    public static final long FINACLE_STATUS_CHECK_INQUIRE_TIMEOUT = 5000L;
    public static final String DEFAULT_MESSAGE_TYPE_INDICATOR_MTI = "1200";
    public static final String DEFAULT_IMT_NARRATION_MSG = "IMT_TRANSACTION";
    public static final String DEFAULT_B2C_NARRATION_MSG = "B2C_TRANSACTION";
    public static final String DEFAULT_AIRTIME_NARRATION_MSG = "AIRTIME_TOP_UP";
    public static final String DEFAULT_START_OF_DATA_TYPE_SECTION_DELIMITER = "D";
    public static final String DEFAULT_NETWORK_INTERNATIONAL_IDENTIFIER_NII = "200";
    public static final String DEFAULT_FIXED_LENGTH_PADDING_PLACEHOLDER = "00000000D";
    public static final String DEFAULT_PRIMARY_ACCOUNT_NUMBER_PAN = "4478150000000000";
    public static final String DEFAULT_ACQUIRING_INSTITUTION_IDENTIFICATION_CODE = "627851";

    // Constants for ISO 8583 message reversal fields
    public static final String PADDING = "000000";
    public static final String REVERSAL_INDICATOR = "6";
    public static final String REVERSAL_TRANSACTION_TYPE_CODE = "400";
    public static final String REVERSAL_DEFAULT_MESSAGE_TYPE_INDICATOR_MTI = "1420";
    
    public static final String INVALID_INPUT = "Invalid Input";

    private Constants() {
    }
}
