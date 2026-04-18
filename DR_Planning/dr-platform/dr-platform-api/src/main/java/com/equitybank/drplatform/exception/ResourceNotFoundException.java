package com.equitybank.drplatform.exception;

import org.springframework.http.HttpStatus;
import java.util.UUID;

public class ResourceNotFoundException extends DrPlatformException {
    public ResourceNotFoundException(String resourceType, UUID id) {
        super(resourceType + " not found: " + id, HttpStatus.NOT_FOUND);
    }
    public ResourceNotFoundException(String message) {
        super(message, HttpStatus.NOT_FOUND);
    }
}
