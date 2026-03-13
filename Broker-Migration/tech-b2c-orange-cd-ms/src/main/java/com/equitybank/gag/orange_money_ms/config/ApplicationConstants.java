package com.equitybank.gag.orange_money_ms.config;

public final class ApplicationConstants {

    // Default configs
    public static final String DEFAULT_LANGUAGE = "en";
    public static final String TELCO = "ORANGEMONEYML";
    public static final String DEFAULT_CURRENCY = "CDF";
    public static final String DEFAULT_USER_TYPE = "customer";
    public static final String DEFAULT_TRANSACTION_TYPE = "A2W";
    public static final String DEFAULT_BANK_AFFILIATE_CODE = "EML";
    public static final String DEFAULT_STATUS_CHECK_TYPE = "TRANINQ";
    public static final String JAXB_NAMESPACE_PREFIX_MAPPER = "com.sun.xml.bind.namespacePrefixMapper";
    public static final String HTTP_RESPONSE_LOG_TEMPLATE = "HTTP Response: \n STATUS CODE: %s\n STATUS MESSAGE: %s\n RESPONSE BODY STRING: %s\n";

    // Endpoint configs
    public static final int THREAD_SLEEP_TIME_MS = 1000; //1 second
    public static final int REQUEST_HOLD_TIME_MS = 10000; //10 seconds
    public static final String ORANGE_TRANSACTION_URL = "http://localhost:8072/api/v1/bank/transactions";
    public static final String ORANGE_STATUS_URL = "http://localhost:8072/api/v1/bank/transactions/status";

    private ApplicationConstants() {}
}
