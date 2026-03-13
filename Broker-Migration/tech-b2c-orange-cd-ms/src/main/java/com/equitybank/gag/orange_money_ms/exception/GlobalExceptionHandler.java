package com.equitybank.gag.orange_money_ms.exception;

import com.equitybank.gag.orange_money_ms.dto.channel.response.ChannelResponseDto;
import com.equitybank.gag.orange_money_ms.dto.channel.response.response;
import com.equitybank.gag.orange_money_ms.entity.TransactionDetails;
import com.equitybank.gag.orange_money_ms.mapper.CustomMapperService;
import com.equitybank.gag.orange_money_ms.service.DatabaseService;
import com.equitybank.gag.orange_money_ms.service.ExceptionReaderService;
import com.equitybank.gag.orange_money_ms.service.XmlMapperService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;

import java.util.Map;

import static com.equitybank.gag.orange_money_ms.config.StatusCodeMessages.*;
import static com.equitybank.gag.orange_money_ms.enums.TransactionStatus.*;

@ControllerAdvice
public class GlobalExceptionHandler {
    private static final Logger log = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    private final ExceptionReaderService exceptionReaderService;
    private final XmlMapperService xmlMapperService;
    private final CustomMapperService customMapperService;
    private final DatabaseService databaseService;

    @Autowired
    public GlobalExceptionHandler(ExceptionReaderService exceptionReaderService,
                                  XmlMapperService xmlMapperService,
                                  CustomMapperService customMapperService,
                                  DatabaseService databaseService) {
        this.exceptionReaderService = exceptionReaderService;
        this.xmlMapperService = xmlMapperService;
        this.customMapperService = customMapperService;
        this.databaseService = databaseService;
    }

    @ExceptionHandler(CustomException.class)
    public ResponseEntity<?> handleCustomException(CustomException e, WebRequest request) {
        String rrn = (String) request.getAttribute("rrn", WebRequest.SCOPE_REQUEST);
        String errorMessage = e.getMessage();

        // Get the errorCode and errorDesc
        Map<String, String> errorMap = exceptionReaderService.readExceptionMessage(errorMessage);
        String errorCode = errorMap.get("errorCode");
        String errorDescription = errorMap.get("errorDescription");
        int httpStatusCode = Integer.parseInt(errorMap.get("httpStatusCode"));

        // Get error response object
        response res = composeResponseObject(rrn, errorCode, errorDescription);

        // Get the xml response string
        String responseXml = xmlMapperService.mapBusinessServiceFailureResponseObjToXml(res);

        // Compose entity for the db update
        TransactionDetails entity = customMapperService.composeEntityForErrorResponseUpdate(responseXml, rrn, errorCode, errorDescription);

        // Update the database with the entity object
        updateDatabase(entity, rrn);

        // Log response xml to console and return it to channel
        logResponse(res);
        return new ResponseEntity<>(res, HttpStatusCode.valueOf(httpStatusCode));
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<?> handleAllExceptions(Exception e, WebRequest request) {
        String rrn = (String) request.getAttribute("rrn", WebRequest.SCOPE_REQUEST);
        log.error("{} Unhandled Exception Occurred: {}", rrn, e.getMessage());
        String defaultErrorMessage = "Request Failed. Internal Exception Occurred: ";

        String errorMessage = e.getMessage();
        String errorCode = "500";

        //split errorMessage on column delimiter
        String[] errorArray = errorMessage.split(":");

        String errorDescription = errorArray.length > 1 ?
                defaultErrorMessage + errorArray[0] :
                defaultErrorMessage;

        log.error("{} {}{}", rrn, defaultErrorMessage, errorMessage);
        response res = composeResponseObject(rrn, errorCode, errorDescription);

        // Get the xml response string
        String responseXml = xmlMapperService.mapBusinessServiceFailureResponseObjToXml(res);

        // Compose entity for the db update
        TransactionDetails entity = customMapperService.composeEntityForErrorResponseUpdate(responseXml, rrn, errorCode, errorDescription);

        // Update the database with the entity object
        updateDatabase(entity, rrn);

        // Log response xml to console and return it to channel
        logResponse(res);
        return new ResponseEntity<>(res, HttpStatus.INTERNAL_SERVER_ERROR);
    }

    private response composeResponseObject(String rrn, String errorCode, String errorDescription) {
        String status = ERROR + "|" + errorCode;

        if (errorCode.equals(TIMEOUT_STATUS_CODE)) {
            status = TIMEOUT.toString();
        }
        response res = new response();
        ChannelResponseDto responseDto = new ChannelResponseDto();

        // Set ChannelResponseDto object values
        responseDto.setStatus(status);
        responseDto.setResponseCode(errorCode);
        responseDto.setResponseDesc(errorDescription);

        // Set response object values
        res.setMsgId(rrn);
        res.setEazzycashres(responseDto);
        return res;
    }

    @Transactional
    private void updateDatabase(TransactionDetails entity, String rrn) {
        if (entity != null) {
            log.info("{} Saving the error object in database", rrn);
            databaseService.updateTransactionRecord(entity);
        } else {
            log.info("{} Could not Save the error object in database. Returned entity is null", rrn);
        }
    }

    private void logResponse(response res) {
        try {
            log.info("Returned Channel Transaction Failed Response XML: \n{}", xmlMapperService.mapBusinessServiceFailureResponseObjToXml(res));
        } catch (Exception e) {
            log.error("Error logging Channel Transaction Failed Response: {}", e.getMessage());
        }
    }
}
