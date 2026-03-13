package com.equitybank.gag.papss.ips.enums;

public enum TransactionType {
    NAMECHECK ("namecheck"),
    STATUS_CHECK("status_check"),
    CREDIT_TRANSFER ("credit_transfer"),
    CREDIT_TRANSFER_CALLBACK ("credit_transfer_callback");

    private final String description;

    TransactionType(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
