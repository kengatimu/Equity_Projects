package com.equitybank.gag.papss.its.enums;

public enum OperationType {
    OUTBOUND ("OUTBOUND"),
    INBOUND ("INBOUND");

    private final String description;

    OperationType(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
