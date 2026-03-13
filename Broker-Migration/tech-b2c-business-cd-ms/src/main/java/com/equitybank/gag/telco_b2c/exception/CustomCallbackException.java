package com.equitybank.gag.telco_b2c.exception;

public class CustomCallbackException extends Exception {
    private final String message;

    public CustomCallbackException(String message) {
        super(message);
        this.message = message;
    }

    @Override
    public String getMessage() {
        return message;
    }
}
