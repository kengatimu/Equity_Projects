package com.bishop.papss_channel_mock_service.enums;

public enum TransactionType {
    NAMECHECK("Namecheck"),
    CREDIT_TRANSFER("Credit Transfer"),
    STATUS_CHECK("Status Check");

    private final String description;

    TransactionType(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
