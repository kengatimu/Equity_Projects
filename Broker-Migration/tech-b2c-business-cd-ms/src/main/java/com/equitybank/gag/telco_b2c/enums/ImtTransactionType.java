package com.equitybank.gag.telco_b2c.enums;

public enum ImtTransactionType {

    C2C("Person-to-person transaction"),
    C2B("Person-to-business transaction"),
    B2C("Business-to-person transaction"),
    B2B("Business-to-business transaction");

    private final String description;

    ImtTransactionType(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}