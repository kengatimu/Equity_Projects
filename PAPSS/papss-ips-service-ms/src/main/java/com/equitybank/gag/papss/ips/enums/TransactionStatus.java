package com.equitybank.gag.papss.ips.enums;

public enum TransactionStatus {
    SUCCESS("The transaction was completed successfully."),
    FAILURE("The transaction failed due to an error."),
    PENDING("The transaction is still in progress or awaiting confirmation."),
    TIMEOUT("The transaction did not receive a response within the expected time."),
    INITIALIZED("The transaction has been initialized and processing has started.");

    private final String description;

    TransactionStatus(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
