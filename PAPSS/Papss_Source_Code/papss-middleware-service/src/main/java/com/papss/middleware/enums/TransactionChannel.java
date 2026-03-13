package com.papss.middleware.enums;

import lombok.Getter;

@Getter
public enum TransactionChannel {

    CORE_BANKING("Core banking system backend"),
    INTERNET_BANKING("Web-based internet banking"),
    MOBILE_BANKING("Mobile banking application"),
    POS("Point of Sale terminal"),
    ATM("Automated Teller Machine"),
    BRANCH("Bank branch or teller assisted"),
    API("System-to-system API integration"),
    USSD("Mobile USSD (short code based)"),
    SWITCH("Routed through payment switch"),
    BULK_TRANSFER("Batch or file-based transfer"),
    MIDDLEWARE("Through middleware like PAPSS Adapter"),
    CHATBOT("Chatbot or conversational interface"),
    CALL_CENTER("Initiated via call center"),
    WALLET("Digital or mobile wallet"),
    AGENT_NETWORK("Field agent assisted transactions"),
    CARD_PAYMENT("Credit or Debit Card payments"),
    QR_CODE("QR Code-based payments"),
    PAYMENT_LINK("Payment links via social platforms or web");


    private final String description;

    TransactionChannel(String description) {
        this.description = description;
    }

    public static TransactionChannel findByValue(String value) {
        TransactionChannel result = null;
        for (TransactionChannel channel : values()) {
            if (channel.name().equalsIgnoreCase(value)) {
                result = channel;
                break;
            }
        }
        return result;
    }
}