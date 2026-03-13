package com.papss.middleware.exception;

public class GenericExceptionHandler extends RuntimeException {
    public GenericExceptionHandler(String message) {
        super(message);
    }
}
