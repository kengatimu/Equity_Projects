package com.equitybank.gag.papss.its.enums;

public enum PapssStatusCodes {
    RJCT("TRANSACTION_REJECTED"),
    PDNG("TRANSACTION_PENDING, NEITHER BEEN REJECTED OR ACCEPTED"),
    ACCP("ACCEPT STATUS COMPLETED, FOR INSTANT TRANSACTIONS"),
    ACSP("ACCEPT STATUS POSTPONED, NON-INSTANT TRANSACTION WILL BE ON POSTPONED STATUS FOR AT LEAST 24 HOURS, AND WILL BE COMPLETED AFTER THE NEXT SETTLEMENT"),
    ACSC("ACCEPT STATUS COMPLETE, NON-INSTANT TRANSACTION HAS BEEN SETTLED AND IS NOW COMPLETE"),
    COMPLETED ("Transaction processed and completed successfully"),
    REJECTED ("Transaction processed. Final status was REJECTED");

    private final String description;

    PapssStatusCodes(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
