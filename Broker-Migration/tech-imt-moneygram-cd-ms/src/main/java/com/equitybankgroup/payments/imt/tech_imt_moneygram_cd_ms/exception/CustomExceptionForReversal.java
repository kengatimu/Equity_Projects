package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.exception;

public class CustomExceptionForReversal extends Exception {
    private final String message;

    public CustomExceptionForReversal(String message) {
        super(message);
        this.message = message;
    }

    @Override
    public String getMessage() {
        return message;
    }
}
