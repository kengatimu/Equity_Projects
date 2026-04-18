package com.equitybank.drplatform.exception;

import org.springframework.http.HttpStatus;

public class ValidationException extends DrPlatformException {
    public ValidationException(String message) {
        super(message, HttpStatus.BAD_REQUEST);
    }
}
