package com.equitybank.gag.mtn_money_ms.exception;

import com.equitybank.gag.mtn_money_ms.entity.TransactionDetails;
import com.equitybank.gag.mtn_money_ms.mapper.CustomMapperService;
import com.equitybank.gag.mtn_money_ms.service.DatabaseService;
import com.equitybank.gag.mtn_money_ms.service.ExceptionReaderService;
import com.equitybank.gag.mtn_money_ms.service.PayloadService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;

import java.util.Map;

import static com.equitybank.gag.mtn_money_ms.config.StatusCodeMessages.DEFAULT_HTTP_STATUS_CODE;
import static com.equitybank.gag.mtn_money_ms.enums.TransactionStatus.ERROR;
import static com.equitybank.gag.mtn_money_ms.enums.TransactionStatus.TIMEOUT;

@ControllerAdvice
public class GlobalExceptionHandler {
    private static final Logger log = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    private final ExceptionReaderService exceptionReaderService;
    private final CustomMapperService customMapperService;
    private final DatabaseService databaseService;
    private final PayloadService payloadService;

    @Autowired
    public GlobalExceptionHandler(ExceptionReaderService exceptionReaderService,
                                  CustomMapperService customMapperService,
                                  DatabaseService databaseService,
                                  PayloadService payloadService) {
        this.exceptionReaderService = exceptionReaderService;
        this.customMapperService = customMapperService;
        this.databaseService = databaseService;
        this.payloadService = payloadService;
    }

    @ExceptionHandler(CustomException.class)
    public ResponseEntity<?> handleCustomException(CustomException e, WebRequest request) {
        String rrn = (String) request.getAttribute("rrn", WebRequest.SCOPE_REQUEST);
        String type = (String) request.getAttribute("type", WebRequest.SCOPE_REQUEST);
        String version = (String) request.getAttribute("version", WebRequest.SCOPE_REQUEST);
        String errorMessage = e.getMessage();

        // Get the errorCode and errorDesc
        Map<String, String> errorMap = exceptionReaderService.readExceptionMessage(errorMessage);
        String errorCode = errorMap.get("errorCode");
        String errorDescription = errorMap.get("errorDescription");
        int httpStatusCode = DEFAULT_HTTP_STATUS_CODE;
        if (errorMap.get("httpStatusCode") != null && !errorMap.get("httpStatusCode").isEmpty()) {
            httpStatusCode = Integer.parseInt(errorMap.get("httpStatusCode"));

            // Check if the HTTP status code is valid (within range 100-599)
            if (httpStatusCode < 100 || httpStatusCode > 599) {
                httpStatusCode = DEFAULT_HTTP_STATUS_CODE;  // Invalid status code, set to 400
            }
        }

        // Compose error responses based on request types
        String responseXml = composeErrorResponse(type != null ? type : "", version != null ? version : "", rrn, errorCode, errorDescription, request);

        // Do an update of specific failures
        databaseUpdate(responseXml, rrn, errorCode, errorDescription, type);

        // Log response xml to console and return it to channel
//        e.printStackTrace(System.out);
        log.info("Returned " + type + " Failure Response To Channel: \n{}", responseXml);
        return new ResponseEntity<>(responseXml, getCspHeaders(), HttpStatusCode.valueOf(httpStatusCode));
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<?> handleAllExceptions(Exception e, WebRequest request) {
        String rrn = (String) request.getAttribute("rrn", WebRequest.SCOPE_REQUEST);
        String type = (String) request.getAttribute("type", WebRequest.SCOPE_REQUEST);
        String version = (String) request.getAttribute("version", WebRequest.SCOPE_REQUEST);
        log.error("{} {} Unhandled Exception Occurred: {}", rrn, type, e.getMessage());
        e.printStackTrace(System.out);
        String defaultErrorMessage = "Request Failed. Internal Exception Occurred: ";

        String errorMessage = e.getMessage();
        String errorCode = String.valueOf(DEFAULT_HTTP_STATUS_CODE);

        // Split errorMessage on column delimiter
        String[] errorArray = errorMessage.split(":");

        String errorDescription = errorArray.length > 1 ?
                defaultErrorMessage + errorArray[0] :
                defaultErrorMessage;

        log.error("{} {}{}", rrn, defaultErrorMessage, errorMessage);

        // Compose error responses based on request types
        String responseXml = composeErrorResponse(type != null ? type : "", version != null ? version : "", rrn, errorCode, errorDescription, request);

        // Only do an update in-case of signature validation, or timeout failures
        databaseUpdate(responseXml, rrn, errorCode, errorDescription, type);

        // Log response xml to console and return it to channel
        log.info("Returned " + type + " Failure Response XML To Channel: \n{}", responseXml);
        return new ResponseEntity<>(responseXml, getCspHeaders(), HttpStatus.INTERNAL_SERVER_ERROR);
    }

    private String composeErrorResponse(String type, String version, String rrn, String errorCode, String errorDesc, WebRequest request) {
        // Handle database dreadlocks
        String errorDescription = errorDesc;
        if (errorDesc.contains("ORA-00060")) {
            errorDescription = "Oracle Database Timeout Occurred";
        }

        if ("floatPurchase".equalsIgnoreCase(type)) {
            return composeFloatPurchaseErrorResponse(rrn, errorCode, errorDescription);
        } else {
            return composeFloatStatusCheckErrorResponse(rrn, errorCode, errorDescription);
        }
    }

    private void databaseUpdate(String responseXml, String rrn, String errorCode, String errorDescription, String type) {
        // Do not update Db for below request types
        if ("floatPurchase-status".equalsIgnoreCase(type)
                || type == null
                || type.isEmpty()) {
            log.info("No DB update for transaction type: {}", type != null ? type : "null or empty");
            return;
        }

        // Continue with Db update
        String errorMessage = errorDescription;
        String status = ERROR.toString();
        if (errorDescription.contains("timeout")
                || errorDescription.contains("time out")
                || errorDescription.contains("timed out")) {
            status = TIMEOUT.toString();
        }

        // Handle database dreadlocks
        if (errorDescription.contains("ORA-00060")) {
            errorMessage = "Database Timeout Occurred";
            status = TIMEOUT.toString();
        }

        // Trim the error desc to 255 characters
        String errorDesc = trimErrorMessage(errorMessage);

        // Compose entity for the db update
        TransactionDetails entity = customMapperService.composeEntityForErrorResponseUpdate(responseXml, rrn, errorCode, errorDesc, status, type);

        // Update the database with the entity object
        if (entity != null) {
            updateDatabase(entity, rrn);
        } else {
            log.warn("{}: TransactionDetails Entity is null or empty, skipping database update", rrn);
        }
    }

    private void updateDatabase(TransactionDetails entity, String rrn) {
        if (entity != null) {
            log.info("{}: Saving the error object in database", rrn);
            databaseService.updateTransactionRecord(entity);
        } else {
            log.info("{}: Could not Save the error object in database. Returned entity is null", rrn);
        }
    }

    private String trimErrorMessage(String errorMessage) {
        // Trim the message if it exceeds the column length of 255
        if (errorMessage != null && errorMessage.length() > 255) {
            return errorMessage.substring(0, 255);
        }
        return errorMessage;
    }

    private String composeFloatPurchaseErrorResponse(String rrn, String errorCode, String errorDescription) {
        return payloadService.composeFloatPurchaseErrorResponse(rrn, errorCode, errorDescription);
    }

    private String composeFloatStatusCheckErrorResponse(String rrn, String errorCode, String errorDescription) {
        return payloadService.composeFloatStatusCheckDefaultErrorResponse(rrn, errorCode, errorDescription);
    }

    private HttpHeaders getCspHeaders() {
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Security-Policy", "default-src 'none';");
        return headers;
    }
}