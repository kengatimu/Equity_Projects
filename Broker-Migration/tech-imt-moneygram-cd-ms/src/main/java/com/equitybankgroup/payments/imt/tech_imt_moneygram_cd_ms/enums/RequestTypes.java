package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.enums;

public enum RequestTypes {

    B2C("Bank To Wallet Transaction."),
    BUY_FLOAT("Buy Float Transaction."),
    IMT_INWARD("IMT inward transactions"),
    AIRTIME("Airtime topup transaction."),
    IMT_OUTWARD("IMT outward transactions");

    private final String description;

    RequestTypes(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }
}
