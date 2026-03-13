package com.equitybank.gag.papss.its.enums;

public enum AccountStatus {
    ACTIVE ("ACTIVE"),
    FROZEN ("FROZEN"),
    DORMANT ("DORMANT"),
    DEBIT_FROZEN ("DEBIT_FROZEN"),
    CREDIT_FROZEN ("CREDIT_FROZEN"),
    TOTAL_FROZEN ("TOTAL_FROZEN"),
    INVALID_ACCT ("INVALID_ACCT"),
    UNKNOWN_ACCT_STATUS ("UNKNOWN_ACCT_STATUS");

    private final String description;

    AccountStatus(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
