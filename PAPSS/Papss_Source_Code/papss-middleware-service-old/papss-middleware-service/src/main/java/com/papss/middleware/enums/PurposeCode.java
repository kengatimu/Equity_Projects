package com.papss.middleware.enums;

public enum PurposeCode {

    RCPT("Receipt"),
    ADVA("Advance Payment");

    private final String description;

    PurposeCode(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
