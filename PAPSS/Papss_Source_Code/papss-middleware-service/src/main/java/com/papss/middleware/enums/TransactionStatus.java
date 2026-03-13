package com.papss.middleware.enums;

public enum TransactionStatus {
    //ACTC(""),
    RJCT("TRANSACTION_REJECTED"),
    PDNG("TRANSACTION_PENDING, NEITHER BEEN REJECTED OR ACCEPTED"),
    ACCP("ACCEPT STATUS COMPLETED, FOR INSTANT TRANSACTIONS"),
    ACSP("ACCEPT STATUS POSTPONED, NON-INSTANT TRANSACTION WILL BE ON POSTPONED STATUS FOR AT LEAST 24 HOURS, AND WILL BE COMPLETED AFTER THE NEXT SETTLEMENT"),
    ACSC("ACCEPT STATUS COMPLETE, NON-INSTANT TRANSACTION HAS BEEN SETTLED AND IS NOW COMPLETE");
    //ACWC("");


    //Direct Payment: Is when sending a payment and the senders amount is your concern. What the receiver gets is not the issue, depending on current exchange rate of that sender

    //Invoice Payment: Is when you ensure that the receiver is credited with the exact amount. Example is when paying goods and services.
    //Invoice payments used mostly on PAPSS.
    //Invoice Payment Category purpose: SUPP Desc, Purpose Code: RCPT Desc

    public String value;

    TransactionStatus(final String value) {
        this.value = value;
    }
}
