package com.equitybank.gag.mtn_money_ms.enums;

public enum TransactionStatus {
    
    INITIALIZED("Initial status when the request is received from the calling channel."),
    PENDING("Initial status when the request is sent to the telco."),
    CHANNEL_CALLBACK_SUCCESS("When the callback to the calling channel with the final status is successful."),
    CHANNEL_CALLBACK_FAILED("When the callback to the calling channel with the final status fails."),
    CHANNEL_STATUS_CHECK_REQUESTED("When the calling channel requests a status check."),
    TELCO_STATUS_CHECK_REQUESTED("When Telco-B2C-MS requests a status check to telco."),
    TELCO_STATUS_CHECK_COMPLETED("When the status check response is sent to Telco-B2C-MS from telco."),
    OK("When the entire transaction process is successfully completed."),
    ERROR("When the entire transaction process fails and cannot be completed."),
    TIMEOUT("Timeout");

    private final String description;

    TransactionStatus(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
