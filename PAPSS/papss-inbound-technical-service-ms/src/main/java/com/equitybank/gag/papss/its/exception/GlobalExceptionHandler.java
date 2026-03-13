package com.equitybank.gag.papss.its.exception;

import com.equitybank.gag.papss.its.entity.TransactionMaster;
import com.equitybank.gag.papss.its.enums.TransactionType;
import com.equitybank.gag.papss.its.pojo.channelResponse.ChannelResponse;
import com.equitybank.gag.papss.its.pojo.channelResponse.ChannelStatusInfo;
import com.equitybank.gag.papss.its.service.DatabaseService;
import com.equitybank.gag.papss.its.service.EntityMapperService;
import com.equitybank.gag.papss.its.service.PayloadXmlComposerService;
import com.google.gson.Gson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.task.TaskExecutor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;

import java.util.HashMap;
import java.util.Map;

import static com.equitybank.gag.papss.its.config.StatusCodeMessages.*;
import static com.equitybank.gag.papss.its.enums.TransactionStatus.*;


@RestControllerAdvice
public class GlobalExceptionHandler {
    private static final Logger log = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    private final Gson gson;
    private final TaskExecutor taskExecutor;
    private final DatabaseService databaseService;
    private final EntityMapperService entityMapperService;
    private final PayloadXmlComposerService payloadXmlComposerService;

    @Autowired
    public GlobalExceptionHandler(Gson gson,
                                  @Qualifier("taskExecutor") TaskExecutor taskExecutor,
                                  DatabaseService databaseService,
                                  EntityMapperService entityMapperService,
                                  PayloadXmlComposerService payloadXmlComposerService) {
        this.gson = gson;
        this.taskExecutor = taskExecutor;
        this.databaseService = databaseService;
        this.entityMapperService = entityMapperService;
        this.payloadXmlComposerService = payloadXmlComposerService;
    }

    @ExceptionHandler(CustomException.class)
    public ResponseEntity<?> handleCustomExceptions(CustomException e, WebRequest request) {
        String rrn = (String) request.getAttribute("rrn", WebRequest.SCOPE_REQUEST);
        Map<String, String> requestMap = (Map<String, String>) request.getAttribute("requestMap", WebRequest.SCOPE_REQUEST);
        TransactionType type = (TransactionType) request.getAttribute("type", WebRequest.SCOPE_REQUEST);

        // Parse error code and message from exception
        Map<String, String> errorMap = getErrorDesc(e.getMessage());
        String errorMessage = errorMap.getOrDefault("message", "An unexpected error occurred");
        String httpStatusCode = errorMap.getOrDefault("code", "400");

        if ("0".equals(httpStatusCode) || httpStatusCode.isBlank()) {
            httpStatusCode = String.valueOf(DEFAULT_HTTP_STATUS_CODE);
        }

        // Check if the HTTP status code is valid (within range 100-599)
        if (Integer.parseInt(httpStatusCode) < 100 || Integer.parseInt(httpStatusCode) > 599) {
            httpStatusCode = String.valueOf(DEFAULT_HTTP_STATUS_CODE);
        }

        // Compose namecheck acmt.024 response and return
        String responseXml = composeResponseXml(rrn, requestMap, e.getMessage());

        // Construct the response
        ChannelResponse channelResponse = generateResponse(errorMessage, rrn);

        // Update Db status for credit transfer only
        updateDbStatus(rrn, channelResponse, type);

        log.info("{}: Returned {} Response To PAPSS: {}", rrn, type, responseXml);
        return new ResponseEntity<>(responseXml, HttpStatus.valueOf(Integer.parseInt(httpStatusCode)));
    }

    private String composeResponseXml(String rrn, Map<String, String> requestMap, String errorMessage) {
        try {
            String errorCode;

            if (errorMessage.contains("401")) {
                errorCode = "3003"; // Invalid digital signature
            } else if (errorMessage.contains("408")) {
                errorCode = "1015"; // Request timeout
            } else if (errorMessage.contains("402")) {
                errorCode = "1009"; // invalid account
            } else {
                errorCode = "100";  // Generic processing error
            }

            return payloadXmlComposerService.composeAcmt024NamecheckFailureResponse(rrn, requestMap, errorCode);
        } catch (Exception e) {
            log.error("{}: Exception Occurred: {}", rrn, e.getMessage());
            return "";
        }
    }

    private void updateDbStatus(String rrn, ChannelResponse channelResponse, TransactionType type) {
        if (type == null || type.equals(TransactionType.NAMECHECK)) {
            return;
        }

        taskExecutor.execute(() -> {
            try {
                TransactionMaster existingRecord = databaseService.getSavedRecord(rrn, type);
                TransactionMaster entity = entityMapperService.composeDbStatusDetailsEntity(rrn, channelResponse, existingRecord);

                log.info("{}: Updating Database Status For Record With RRN: {}", rrn, rrn);
                databaseService.updateDbRecord(entity);

            } catch (Exception e) {
                log.error("{}: Failed to update database record asynchronously for RRN: {}. Error: {}", rrn, rrn, e.getMessage());
            }
        });
    }

    private ChannelResponse generateResponse(String errorMessage, String rrn) {
        String errorCode = DEFAULT_ERROR_CODE;
        String errorStatus = String.valueOf(FAILURE);

        // Update error code for timeout and authorization
        if (errorMessage.contains("timeout")
                || errorMessage.contains("time out")
                || errorMessage.contains("timed out")) {
            errorCode = TIMEOUT_STATUS_CODE;
            errorStatus = String.valueOf(TIMEOUT);
        }

        ChannelStatusInfo statusInfo = new ChannelStatusInfo();
        statusInfo.setStatus(errorStatus);
        statusInfo.setCode(errorCode);
        statusInfo.setDescription(errorMessage);

        ChannelResponse channelResponse = new ChannelResponse();
        channelResponse.setRrn(rrn);
        channelResponse.setChannelStatusInfo(statusInfo);

        return channelResponse;
    }

    private Map<String, String> getErrorDesc(String errorMessage) {
        Map<String, String> errorMap = new HashMap<>();

        if (errorMessage == null || errorMessage.isEmpty()) {
            errorMessage = DEFAULT_PROCESSING_FAILURE;
        }

        String[] parts = errorMessage.split("\\|", 2); // Limit to 2 parts

        if (parts.length == 2) {
            errorMap.put("code", parts[0]);
            errorMap.put("message", parts[1]);
        } else {
            // Fallback if format is not as expected
            errorMap.put("code", "400");
            errorMap.put("message", "Internal Error: Could not process the request");
        }

        return errorMap;
    }
}
