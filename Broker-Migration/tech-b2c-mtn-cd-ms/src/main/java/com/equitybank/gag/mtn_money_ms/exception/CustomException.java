package com.equitybank.gag.mtn_money_ms.exception;

public class CustomException extends Exception {
    private final String message;

    public CustomException(String message) {
        super(message);
        this.message = message;
    }

    @Override
    public String getMessage() {
        return message;
    }
}
