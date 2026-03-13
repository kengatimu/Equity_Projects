package com.papss.middleware.exception;

import jakarta.xml.bind.JAXBException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@ControllerAdvice
public class ExceptionHandler extends ResponseEntityExceptionHandler {

    private static final String RESPONSE_STATUS = "ResponseStatus";

    @Override
    protected ResponseEntity<Object> handleMethodArgumentNotValid(MethodArgumentNotValidException exception,
                                                                  HttpHeaders httpHeaders, HttpStatusCode httpStatus, WebRequest webRequest) {
        Map<String, Object> objectBody = new LinkedHashMap<>();
        objectBody.put(RESPONSE_STATUS, httpStatus.value());

        // Get all errors
        List<Map<String, String>> details = new ArrayList<>();
        exception.getBindingResult().getAllErrors().forEach((error) -> {
            Map<String, String> err = new LinkedHashMap<>();
            err.put("field", error instanceof FieldError ? ((FieldError) error).getField() : error.getObjectName());
            err.put("message", error.getDefaultMessage());
            details.add(err);
        });

        objectBody.put("Errors", details);

        return new ResponseEntity<>(objectBody, HttpStatus.BAD_REQUEST);
    }

    @org.springframework.web.bind.annotation.ExceptionHandler(JAXBException.class)
    protected ResponseEntity<Object> handelJaxbException(JAXBException jaxbException) {
        Map<String, Object> objectBody = new LinkedHashMap<>();
        objectBody.put(RESPONSE_STATUS, HttpStatus.BAD_REQUEST.value());
        objectBody.put("Error", jaxbException.getMessage());
        return new ResponseEntity<>(objectBody, HttpStatus.BAD_REQUEST);
    }

    @Override
    protected ResponseEntity<Object> handleHttpMessageNotReadable(HttpMessageNotReadableException ex, HttpHeaders headers, HttpStatusCode status, WebRequest request) {
        log.error("HttpMessageNotReadableException occurred", ex);
        Map<String, Object> objectBody = new LinkedHashMap<>();
        objectBody.put(RESPONSE_STATUS, HttpStatus.BAD_REQUEST.value());
        objectBody.put("Error", ex.getMostSpecificCause() != null ? ex.getMostSpecificCause().getMessage() : ex.getMessage());
        return new ResponseEntity<>(objectBody, HttpStatus.BAD_REQUEST);
    }


    @org.springframework.web.bind.annotation.ExceptionHandler(Exception.class)
    protected ResponseEntity<Object> handleGeneralExceptions(Exception exception) {
        log.error("Unhandled exception", exception);
        Map<String, Object> objectBody = new LinkedHashMap<>();
        objectBody.put(RESPONSE_STATUS, HttpStatus.EXPECTATION_FAILED.value());
        objectBody.put("Error", exception.getMessage());
        return new ResponseEntity<>(objectBody, HttpStatus.EXPECTATION_FAILED);
    }
}
