package com.equitybank.gag.telco_b2c.config;

public final class ApplicationConstants {

    // Dev configs;
    public static final String SIGNATURE_ALGORITHM = "SHA256withRSA";

    // Default IMT names
    public static final String WENDI = "WENDI";
    public static final String THUNES = "THUNES";
    public static final String MONEY_GRAM = "MONEYGRAM";
    public static final String MASTER_CARD = "MASTERCARD";
    public static final String DEFAULT_FIN_CHANNEL = "FINACLE";
    public static final String DEFAULT_SAFARICOM_KE = "MPESA-KE";
    public static final String DEFAULT_VODACOM_CD = "VODACOM-MONEY";

    // Finacle Default values
    public static final String FINACLE_RATE_CODE = "ZTB";
    public static final String FINACLE_RATE_CODE_CHANNEL_ID = "OMN";

    // Default values
    public static final String STATUS_UP = "UP";
    public static final String DEFAULT_BANK_ID = "43";
    public static final String DEFAULT_CURRENCY = "CDF";
    public static final String DEFAULT_CHARGE_FLAG = "N";
    public static final String DEFAULT_CHANNEL_ID = "OMNI";
    public static final String DEFAULT_COUNTRY_CODE = "CD";
    public static final String DEFAULT_CLIENT_TYPE = "customer";
    public static final String DEFAULT_RATE_CONFIG_ID = "usd_cdf_fx_rate";
    public static final String DEFAULT_IMT_REQUEST_TYPE = "imt-money-gram";
    public static final String WENDI_B2C_NAMECHECK_ACTION = "ACCT_VALIDATE";
    public static final String DEFAULT_THUNES_QUOTATION_MODE = "SOURCE_AMOUNT";
    public static final String DEFAULT_FLOAT_PURCHASE_NARRATION = " float purchase";
    public static final String DEFAULT_BANK_TO_WALLET_NARRATION = " bank to wallet";
    public static final String DEFAULT_AIRTIME_PURCHASE_NARRATION = " airtime topup";
    public static final String WENDI_B2C_TRANSACTION_ACTION = "WND_PAYMENT_CUSTOMER";
    public static final String HTTP_RESPONSE_LOG_TEMPLATE = "HTTP Response: \n STATUS CODE: %s\n STATUS MESSAGE: %s\n RESPONSE BODY STRING: %s\n";

    // Eureka configs - application names
    public static final String WENDI_APPLICATION_NAME = "WENDI-WALLET-MS";
    public static final String THUNES_APPLICATION_NAME = "THUNES-IMT-MS";
    public static final String MTN_MONEY_APPLICATION_NAME = "MTN-MONEY-B2C-MS";
    public static final String MONEY_GRAM_APPLICATION_NAME = "MONEYGRAM-IMT-MS";
    public static final String ORANGE_MONEY_APPLICATION_NAME = "ORANGE-MONEY-B2C-MS";
    public static final String AIRTEL_MONEY_APPLICATION_NAME = "AIRTEL-MONEY-B2C-MS";
    public static final String VODACOM_MONEY_APPLICATION_NAME = "VODACOM-MONEY-B2C-MS";
    public static final String AFRICELL_MONEY_APPLICATION_NAME = "AFRICELL-MONEY-B2C-MS";
    public static final String SAFARICOM_MPESA_APPLICATION_NAME = "SAFARICOM-MPESA-B2B-MS";

    // Eureka configs - b2c namecheck service endpoints
    public static final String VODACOM_MONEY_B2C_NAMECHECK_SERVICE = "/api/v1/namecheck";
    public static final String MTN_MONEY_B2C_NAMECHECK_SERVICE = "/api/v1/banktowallet/namecheck";
    public static final String ORANGE_MONEY_B2C_NAMECHECK_SERVICE = "/api/v1/banktowallet/namecheck";
    public static final String AIRTEL_MONEY_B2C_NAMECHECK_SERVICE = "/api/v1/banktowallet/namecheck";
    public static final String AFRICELL_MONEY_B2C_NAMECHECK_SERVICE = "/api/v1/banktowallet/namecheck";

    // Eureka configs - airtime namecheck service endpoints
    public static final String MTN_MONEY_AIRTIME_TOPUP_NAMECHECK_SERVICE = "/api/v1/airtimetopup/namecheck";
    public static final String ORANGE_MONEY_AIRTIME_TOPUP_NAMECHECK_SERVICE = "/api/v1/airtimetopup/namecheck";
    public static final String AIRTEL_MONEY_AIRTIME_TOPUP_NAMECHECK_SERVICE = "/api/v1/airtimetopup/namecheck";
    public static final String VODACOM_MONEY_AIRTIME_TOPUP_NAMECHECK_SERVICE = "/api/v1/airtimetopup/namecheck";
    public static final String AFRICELL_MONEY_AIRTIME_TOPUP_NAMECHECK_SERVICE = "/api/v1/airtimetopup/namecheck";

    // Eureka configs - float purchase namecheck service endpoints
    public static final String VODACOM_MONEY_FLOAT_PURCHASE_NAMECHECK_SERVICE = "/api/v1/floatpurchase/namecheck";
    public static final String SAFARICOM_MONEY_FLOAT_PURCHASE_NAMECHECK_SERVICE = "/api/v1/floatpurchase/namecheck";
    public static final String MTN_MONEY_FLOAT_PURCHASE_NAMECHECK_SERVICE = "/api/v1/floatpurchase/namecheck";
    public static final String ORANGE_MONEY_FLOAT_PURCHASE_NAMECHECK_SERVICE = "/api/v1/floatpurchase/namecheck";
    public static final String AIRTEL_MONEY_FLOAT_PURCHASE_NAMECHECK_SERVICE = "/api/v1/floatpurchase/namecheck";
    public static final String AFRICELL_MONEY_FLOAT_PURCHASE_NAMECHECK_SERVICE = "/api/v1/floatpurchase/namecheck";

    // Eureka configs - b2c service endpoints
    public static final String MTN_MONEY_B2C_SERVICE_TRANSACTION = "/api/v1/transaction";
    public static final String ORANGE_MONEY_B2C_SERVICE_TRANSACTION = "/api/v1/transaction";
    public static final String AIRTEL_MONEY_B2C_SERVICE_TRANSACTION = "/api/v1/transaction";
    public static final String VODACOM_MONEY_B2C_SERVICE_TRANSACTION = "/api/v1/transaction";
    public static final String AFRICELL_MONEY_B2C_SERVICE_TRANSACTION = "/api/v1/transaction";

    // Eureka configs - moneygram imt service endpoints
    public static final String MONEY_GRAM_FEE_LOOKUP = "/api/v1/feeLookup";
    public static final String MONEY_GRAM_DETAIL_LOOKUP = "/api/v1/detailLookup";
    public static final String MONEY_GRAM_CODE_TABLE_REQUEST = "/api/v1/codeTable";
    public static final String MONEY_GRAM_SEND_REVERSAL_REQUEST = "/api/v1/sendReversal";
    public static final String MONEY_GRAM_COMMIT_TRANSACTION = "/api/v1/commitTransaction";
    public static final String MONEY_GRAM_SEND_VALIDATION_REQUEST = "/api/v1/sendValidation";
    public static final String MONEY_GRAM_GET_FIELD_FOR_PRODUCT = "/api/v1/getFieldsForProduct";
    public static final String MONEY_GRAM_AMEND_TRANSACTION_REQUEST = "/api/v1/amendTransaction";
    public static final String MONEY_GRAM_REFERENCE_NUMBER_REQUEST = "/api/v1/receive/referenceNumber";
    public static final String MONEY_GRAM_RECEIVE_REVERSAL_REQUEST = "/api/v1/receive/receiveReversal";
    public static final String MONEY_GRAM_RECEIVE_VALIDATION_REQUEST = "/api/v1/receive/receiveValidation";
    public static final String MONEY_GRAM_RECEIVE_COMMIT_TRANSACTION = "/api/v1/receive/commitTransaction";
    public static final String MONEY_GRAM_RECEIVE_GET_FIELD_FOR_PRODUCT = "/api/v1/receive/getFieldsForProduct";

    // Eureka configs - thunes imt service endpoints
    public static final String THUNES_PAYERS = "/v2/money-transfer/payers";
    public static final String THUNES_PAYER_RATES = "/v2/money-transfer/payers/";
    public static final String THUNES_PAYER_DETAILS = "/v2/money-transfer/payers/";
    public static final String THUNES_BIC_LOOKUP = "/v2/money-transfer/lookups/BIC/";
    public static final String THUNES_LIST_OF_SERVICES = "/v2/money-transfer/services";
    public static final String THUNES_LIST_OF_COUNTRIES = "/v2/money-transfer/countries";
    public static final String THUNES_CREDIT_PARTY_VERIFY = "/v2/money-transfer/payers/";
    public static final String THUNES_CREDIT_PARTY_INFORMATION = "/v2/money-transfer/payers/";
    public static final String THUNES_CREATE_QUOTATION = "/v2/money-transfer/quotations";
    public static final String THUNES_SEND_TRANSACTION = "/v2/money-transfer/quotations/{id}/transactions";

    // Eureka configs - wendi wallet service endpoints
    public static final String WENDI_B2C_NAMECHECK = "/api/v1/b2c/namecheck";
    public static final String WENDI_B2C_TRANSACTION = "/api/v1/b2c/transaction";

    // Eureka configs - airtime service endpoints
    public static final String MTN_MONEY_B2C_SERVICE_AIRTIME_TOP_UP = "/api/AirTimeTopUpWSService/AirTimeTopUp";
    public static final String ORANGE_MONEY_B2C_SERVICE_AIRTIME_TOP_UP = "/api/AirTimeTopUpWSService/AirTimeTopUp";
    public static final String AIRTEL_MONEY_B2C_SERVICE_AIRTIME_TOP_UP = "/api/AirTimeTopUpWSService/AirTimeTopUp";
    public static final String VODACOM_MONEY_B2C_SERVICE_AIRTIME_TOP_UP = "/api/AirTimeTopUpWSService/AirTimeTopUp";
    public static final String AFRICELL_MONEY_B2C_SERVICE_AIRTIME_TOP_UP = "/api/AirTimeTopUpWSService/AirTimeTopUp";

    // Eureka configs - float purchase endpoints
    public static final String MTN_MONEY_FLOAT_PURCHASE_TRANSACTION = "/api/v1/buyfloat";
    public static final String ORANGE_MONEY_FLOAT_PURCHASE_TRANSACTION = "/api/v1/buyfloat";
    public static final String AIRTEL_MONEY_FLOAT_PURCHASE_TRANSACTION = "/api/v1/buyfloat";
    public static final String VODACOM_MONEY_FLOAT_PURCHASE_TRANSACTION = "/api/v1/buyfloat";
    public static final String SAFARICOM_MONEY_FLOAT_PURCHASE_TRANSACTION = "/api/v1/buyfloat";
    public static final String AFRICELL_MONEY_FLOAT_PURCHASE_TRANSACTION = "/api/v1/buyfloat";

    // Eureka configs - status check service endpoints
    public static final String MTN_MONEY_FLOAT_STATUS_CHECK_SERVICE = "/api/v1/buyfloat/status";
    public static final String AIRTEL_MONEY_BANK_TO_WALLET_STATUS_CHECK_SERVICE = "/api/v1/banktowallet/status";
    public static final String VODACOM_MONEY_BANK_TO_WALLET_STATUS_CHECK_SERVICE = "/api/v1/banktowallet/status";
    public static final String AIRTEL_MONEY_FLOAT_PURCHASE_STATUS_CHECK_SERVICE = "/api/v1/floatpurchase/status";


    // Define constants for new moneygram field values
    public static final String UNIT_PROFILE_ID = "184750";
    public static final String AGENT_ID = "43293913";
    public static final String AGENT_SEQUENCE = "11";
    public static final String TOKEN = "TEST";
    public static final String API_VERSION = "11";
    public static final String CLIENT_SOFTWARE_VERSION = "1.1";
    public static final String CHANNEL_TYPE = "LOCATION";
    public static final String INFO_KEY = "key";
    public static final String INFO_VALUE = "value";

    private ApplicationConstants() {
    }
}