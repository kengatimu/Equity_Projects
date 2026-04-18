package com.equitybank.drplatform.exception;

import org.springframework.http.HttpStatus;

public class ConflictException extends DrPlatformException {
    public ConflictException(String message) {
        super(message, HttpStatus.CONFLICT);
    }
}
