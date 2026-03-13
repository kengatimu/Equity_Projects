package com.equitybank.gag.papss.ots.exception;

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
