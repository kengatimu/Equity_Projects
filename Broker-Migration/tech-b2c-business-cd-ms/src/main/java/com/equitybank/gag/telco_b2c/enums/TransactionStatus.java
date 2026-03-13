package com.equitybank.gag.telco_b2c.enums;

public enum TransactionStatus {

    OK("COMPLETED_SUCCESSFULLY."),
    TIMEOUT("When a timeout occurs when calling telco."),
    ERROR("Processing the request resulted in an error."),
    FEE_LOOKUP_SUCCESS("Fee lookup request was successfully processed"),
    INITIALIZED("The request has been received by the business service."),
    FIELD_FOR_PRODUCT_SUCCESS("Field for product request was successfully processed"),
    PENDING("Transaction received. Processing started. Final status to be determined."),
    SEND_VALIDATION_REQUEST_SUCCESS("Send validation request was successfully processed"),
    RECEIVE_VALIDATION_REQUEST_SUCCESS("Receive validation request was successfully processed"),
    INBOUND_REFERENCE_NUMBER_REQUEST("Inbound reference number request was successfully processed");

    private final String description;

    TransactionStatus(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
