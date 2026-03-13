package com.equitybank.gag.papss.ots.enums;

public enum TransactionType {
    NAMECHECK ("namecheck"),
    STATUS_CHECK("status_check"),
    CREDIT_TRANSFER ("credit_transfer"),
    CREDIT_TRANSFER_CALLBACK ("credit_transfer_callback"),
    GET_FX_RATE ("get_fx_rate"),
    UPDATE_FX_RATE ("update_fx_rate"),
    GET_PARTICIPANT ("get_participant"),
    GET_PARTICIPANT_LIST ("get_participant_list");

    private final String description;

    TransactionType(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
