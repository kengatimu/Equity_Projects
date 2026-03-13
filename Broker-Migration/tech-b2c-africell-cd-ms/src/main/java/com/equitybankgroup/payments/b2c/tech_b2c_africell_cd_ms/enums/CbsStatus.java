package com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.enums;

public enum CbsStatus {

    requestMessage(""),
    responseMessage(""),
    FAILED("Transaction processing failed."),
    ERROR("Transaction final status is Failure."),
    PENDING("Transaction final status is unknown."),
    TIMEOUT("Transaction timeout during processing."),
    COMPLETED("Transaction processed successfully by Finacle."),
    REVERSED("Reversing original transaction and charges successful."),
    REVERSAL_FAILURE("Reversing original transaction and charges failed."),
    REVERSAL_COMPLETED("Reversing original transaction and charges successful.");

    private final String description;

    CbsStatus(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
