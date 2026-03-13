package com.equitybank.gag.papss.its.enums;

public enum TransactionStatus {
    // General transaction statuses
    FAILURE("01", "Transaction failed"),
    TIMEOUT("-3", "Transaction timed out"),
    SUCCESS("00", "Transaction completed successfully"),
    PENDING("-11", "Transaction has been accepted and is being processed"),

    // Finacle-specific statuses
    FINACLE_INITIAL("F02", "Finacle Initial status "),
    FINACLE_DEBITED("F00", "Finacle Debit Successful"),
    FINACLE_FAILED("F01", "Finacle Processing Failed"),
    FINACLE_TIMEOUT("F03", "Finacle Processing Timed Out"),
    REVERSED_NOK("01_REV", "Transaction reversal Failed"),
    REVERSED_OK("00_REV", "Transaction reversed successfully");

    private final String code;
    private final String description;

    TransactionStatus(String code, String description) {
        this.code = code;
        this.description = description;
    }

    public String getCode() {
        return code;
    }

    public String getDescription() {
        return description;
    }
}