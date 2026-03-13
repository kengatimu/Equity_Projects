package com.equitybank.gag.telco_b2c.exception;

import com.equitybank.gag.telco_b2c.dto.json.StatusResponse;
import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.enums.TransactionStatus;
import com.equitybank.gag.telco_b2c.mapper.CustomMapperService;
import com.equitybank.gag.telco_b2c.service.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.task.TaskExecutor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;

import java.util.Collections;
import java.util.Map;

import static com.equitybank.gag.telco_b2c.config.ApplicationConstants.DEFAULT_IMT_REQUEST_TYPE;
import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.DEFAULT_HTTP_STATUS_CODE;
import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.DEFAULT_PROCESSING_FAILURE;
import static com.equitybank.gag.telco_b2c.enums.TransactionStatus.ERROR;
import static com.equitybank.gag.telco_b2c.enums.TransactionStatus.TIMEOUT;

@ControllerAdvice
public class GlobalExceptionHandler {
    private static final Logger log = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    private final ExceptionReaderService exceptionReaderService;
    private final TypeResolverService typeResolverService;
    private final CustomMapperService customMapperService;
    private final DatabaseService databaseService;
    private final PayloadService payloadService;
    private final TaskExecutor taskExecutor;
    private final HttpService httpService;

    @Autowired
    public GlobalExceptionHandler(ExceptionReaderService exceptionReaderService,
                                  TypeResolverService typeResolverService,
                                  CustomMapperService customMapperService,
                                  DatabaseService databaseService,
                                  PayloadService payloadService,
                                  @Qualifier("taskExecutor") TaskExecutor taskExecutor,
                                  HttpService httpService) {
        this.exceptionReaderService = exceptionReaderService;
        this.typeResolverService = typeResolverService;
        this.customMapperService = customMapperService;
        this.databaseService = databaseService;
        this.payloadService = payloadService;
        this.taskExecutor = taskExecutor;
        this.httpService = httpService;
    }

    @ExceptionHandler(CustomException.class)
    public ResponseEntity<?> handleCustomException(CustomException e, WebRequest request) {
        String rrn = (String) request.getAttribute("rrn", WebRequest.SCOPE_REQUEST);
        String type = (String) request.getAttribute("type", WebRequest.SCOPE_REQUEST);
        String version = (String) request.getAttribute("version", WebRequest.SCOPE_REQUEST);
        String errorMessage = e.getMessage() == null ? DEFAULT_PROCESSING_FAILURE : e.getMessage();

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

        if ("airtime".equals(type)) {
            // For airtime, we return json object.
            String responseJson = composeErrorResponse(type, version != null ? version : "", rrn, errorCode, errorDescription, request);
            databaseUpdate(responseJson, rrn, errorCode, errorDescription, type);

            StatusResponse airtimeResponseObject = convertToJsonObject(rrn, responseJson);
            log.info("Returned " + type + " Failure Response To Channel: \n{}", responseJson);
            return new ResponseEntity<>(airtimeResponseObject, getCspHeaders(), HttpStatusCode.valueOf(httpStatusCode));
        }

        // Compose error responses based on request types
        String responseString = composeErrorResponse(type != null ? type : "", version != null ? version : "", rrn, errorCode, errorDescription, request);

        // Do an update of specific failures
        databaseUpdate(responseString, rrn, errorCode, errorDescription, type);

        // Log response xml to console and return it to channel
//        e.printStackTrace(System.out);
        log.info("Returned " + type + " Failure Response To Channel: \n{}", responseString);
        return new ResponseEntity<>(responseString, getCspHeaders(), HttpStatusCode.valueOf(httpStatusCode));
    }

    private StatusResponse convertToJsonObject(String rrn, String jsonString) {
        StatusResponse response = new StatusResponse();
        ObjectMapper objectMapper = new ObjectMapper();

        try {
            // Parse JSON into a Map
            Map<String, Object> map = objectMapper.readValue(jsonString, Map.class);

            // Log the parsed map for debugging
            log.info("Parsed Map: {}", map);

            // Populate the StatusResponse object from the Map
            response.setOriginatingTransactionID((String) map.getOrDefault("OriginTransactionID", null));
            response.setTransactionID((String) map.getOrDefault("TransactionID", null));
            response.setStatus((String) map.getOrDefault("Status", String.valueOf(DEFAULT_HTTP_STATUS_CODE)));  // Default to "400" if status is missing
            response.setTransactionStatus((String) map.getOrDefault("TransactionStatus", "0"));  // Default to "0"
            return response;

        } catch (Exception e) {
            log.error("{} Converting JSON to Object Failed. Returning error 400: {}", rrn, e.getMessage(), e);
            response.setOriginatingTransactionID(null);
            response.setTransactionID(null);
            response.setStatus(String.valueOf(DEFAULT_HTTP_STATUS_CODE));
            response.setTransactionStatus("0");
            return response;
        }
    }

    @ExceptionHandler(CustomCallbackException.class)
    public void handleCustomCallbackException(CustomException e, Map<String, String> detailsMap, String type) {
        String rrn = detailsMap.getOrDefault("rrn", "");
        String callbackUrl = detailsMap.getOrDefault("callbackUrl", "");
        String errorMessage = e.getMessage() == null ? DEFAULT_PROCESSING_FAILURE : e.getMessage();

        // Get the errorCode and errorDesc
        Map<String, String> errorMap = exceptionReaderService.readExceptionMessage(errorMessage);
        String errorCode = errorMap.get("errorCode");
        String errorDescription = errorMap.get("errorDescription");

        // Compose error responses based on request types
        String responseXml = composeErrorResponse(type, "", rrn, errorCode, errorDescription, null);

        // Do an update of specific failures
        databaseUpdate(responseXml, rrn, errorCode, errorDescription, type);

        // Log response xml to console and return it to channel
//        e.printStackTrace(System.out);
        log.info("Sending Callback To Channel With Failed Response XML: \n{}", responseXml);
        httpService.callbackHttpCall(callbackUrl, responseXml, rrn, type);
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

        if ("airtime".equals(type)) {
            // For airtime, we return json object.
            String responseJson = composeErrorResponse(type, version != null ? version : "", rrn, errorCode, errorDescription, request);
            databaseUpdate(responseJson, rrn, errorCode, errorDescription, type);

            StatusResponse airtimeResponseObject = convertToJsonObject(rrn, responseJson);
            log.info("Returned " + type + " Failure Response To Channel: \n{}", responseJson);
            return new ResponseEntity<>(airtimeResponseObject, getCspHeaders(), HttpStatusCode.valueOf(DEFAULT_HTTP_STATUS_CODE));
        }

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

        switch (type) {
            case "wendi-b2c-namecheck",
                    "wendi-b2c-transaction":
                return composeWendiErrorResponse(rrn, errorCode, errorDescription);

            case "thunes-credit-party-information",
                    "thunes-credit-party-verify",
                    "thunes-list-of-services",
                    "thunes-bic-lookup",
                    "thunes-list-of-countries",
                    "thunes-payer_details",
                    "thunes-payer_rates",
                    "thunes-get-payers",
                    "thunes-static-data-id-type",
                    "thunes-static-data-purpose-of-payment",
                    "thunes-static-data-bank-account-type",
                    "thunes-create-quote",
                    "thunes-send-transaction":
                return composeThunesErrorResponse(rrn, errorCode, errorDescription);

            case "status-check-banktowallet",
                    "status-check-airtime",
                    "status-check-floatpurchase":
                return composeStatusCheckErrorResponse(rrn, errorCode, errorDescription);

            case "floatPurchase": {
                @SuppressWarnings("unchecked")
                Map<String, String> finFloatXmlTagsMap = (Map<String, String>) request.getAttribute("finXmlTagsMap", WebRequest.SCOPE_REQUEST);
                if (finFloatXmlTagsMap == null) {
                    finFloatXmlTagsMap = Collections.emptyMap();
                }
                String channel = (String) request.getAttribute("channel", WebRequest.SCOPE_REQUEST);
                return composeFloatPurchaseErrorResponse(rrn, errorCode, errorDescription, finFloatXmlTagsMap, channel);
            }

            case "bank-to-wallet-namecheck",
                    "airtime-topup-namecheck",
                    "float-purchase-namecheck": {
                // Handle name check types
                @SuppressWarnings("unchecked")
                Map<String, String> finXmlTagsMap = (Map<String, String>) request.getAttribute("finXmlTagsMap", WebRequest.SCOPE_REQUEST);

                if (finXmlTagsMap == null) {
                    finXmlTagsMap = Collections.emptyMap();
                }
                String mobileNumber = (String) request.getAttribute("mobileNumber", WebRequest.SCOPE_REQUEST);
                String channel = (String) request.getAttribute("channel", WebRequest.SCOPE_REQUEST);
                String telcom = (String) request.getAttribute("telcom", WebRequest.SCOPE_REQUEST);
                return composeNameCheckErrorResponse(rrn, telcom, channel, mobileNumber, type, finXmlTagsMap, errorDescription);
            }

            case "transaction":
                return composeTransactionErrorResponse(rrn, errorCode, errorDescription);

            case "airtime":
                return composeAirtimeTopUpErrorResponse(version, errorCode, errorDescription);

            default:
                return typeResolverService.isMoneyGramService(type)
                        ? composeImtErrorResponse(rrn, errorCode, errorDescription)
                        : defaultErrorString(errorCode, errorDescription);
        }
    }

    private void databaseUpdate(String responseXml, String rrn, String errorCode, String errorDescription, String type) {
        //Do not update database for duplicate error
        if (errorCode.contains("409")) {
            log.info("No DB update for error code: " + errorCode);
            return;
        }

        // Do not update Db for below request types
        if (typeResolverService.isNonDatabaseUpdateType(type)
                || type == null
                || type.isEmpty()) {
            log.info("No DB update for transaction type: {}", type != null ? type : "null or empty");
            return;
        }

        String tranType = type.toLowerCase().contains("moneygram") ? DEFAULT_IMT_REQUEST_TYPE : type;

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

        // Update the database with the entity object
        updateDatabase(rrn, responseXml, errorCode, errorDesc, status, tranType);
    }

    // This will update the database in async (background thread). Therefore, not need for @Transaction annotation
    private void updateDatabase(String rrn, String responseXml, String errorCode, String errorDesc, String status, String tranType) {
        taskExecutor.execute(() -> {
            TransactionDetails entity = customMapperService.composeEntityForErrorResponseUpdate(responseXml, rrn, errorCode, errorDesc, status, tranType);
            log.info("{}: Saving transaction status in the database", rrn);
            if (entity != null) {
                databaseService.updateTransactionRecord(entity);
            } else {
                log.warn("{}: TransactionDetails Entity is null or empty, skipping database update", rrn);
            }
        });
    }

    private String trimErrorMessage(String errorMessage) {
        // Trim the message if it exceeds the column length of 255
        if (errorMessage != null && errorMessage.length() > 255) {
            return errorMessage.substring(0, 255);
        }
        return errorMessage;
    }

    private String composeWendiErrorResponse(String rrn, String errorCode, String errorDescription) {
        return payloadService.wendiErrorResponseXml(rrn, errorCode, errorDescription);
    }

    private String composeThunesErrorResponse(String rrn, String errorCode, String errorDescription) {
        return payloadService.thunesErrorResponseXml(rrn, errorCode, errorDescription);
    }

    private String composeTransactionErrorResponse(String rrn, String errorCode, String errorDescription) {
        return payloadService.transactionErrorResponseXml(rrn, errorCode, errorDescription);
    }

    private String composeStatusCheckErrorResponse(String rrn, String errorCode, String errorDescription) {
        return payloadService.statusCheckErrorResponseXml(rrn, errorCode, errorDescription);
    }

    private String composeAirtimeTopUpErrorResponse(String version, String errorCode, String errorDescription) {
        return payloadService.airtimeTopUpErrorResponseXml(version, errorCode, errorDescription);
    }

    private String composeImtErrorResponse(String rrn, String errorCode, String errorDescription) {
        return payloadService.imtDefaultErrorResponseXml(rrn, errorCode, errorDescription, TransactionStatus.ERROR);
    }

    private String composeFloatPurchaseErrorResponse(String rrn, String errorCode, String errorDescription, Map<String, String> finFloatXmlTagsMap, String channel) {
        return payloadService.composeFloatPurchaseErrorResponse(rrn, errorCode, errorDescription, finFloatXmlTagsMap, channel);
    }

    private String composeNameCheckErrorResponse(String rrn, String telcom, String channel, String mobileNumber, String type, Map<String, String> finXmlTagsMap, String errorDescription) {
        return payloadService.composeNameCheckErrorResponse(rrn, telcom, channel, mobileNumber, type, finXmlTagsMap, errorDescription);
    }

    private String defaultErrorString(String errorCode, String errorDescription) {
        return payloadService.composeDefaultErrorResponse(errorCode, errorDescription);
    }

    private HttpHeaders getCspHeaders() {
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Security-Policy", "default-src 'none';");
        return headers;
    }
}