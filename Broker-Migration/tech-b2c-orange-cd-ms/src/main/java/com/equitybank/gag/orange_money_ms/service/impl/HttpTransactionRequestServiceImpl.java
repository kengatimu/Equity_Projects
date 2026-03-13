package com.equitybank.gag.orange_money_ms.service.impl;

import com.equitybank.gag.orange_money_ms.entity.TransactionDetails;
import com.equitybank.gag.orange_money_ms.exception.CustomException;
import com.equitybank.gag.orange_money_ms.mapper.CustomMapperService;
import com.equitybank.gag.orange_money_ms.service.DatabaseService;
import com.equitybank.gag.orange_money_ms.service.HttpStatusCheckService;
import com.equitybank.gag.orange_money_ms.service.HttpTransactionRequestService;
import com.equitybank.gag.orange_money_ms.service.XmlMapperService;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Map;

import static com.equitybank.gag.orange_money_ms.config.ApplicationConstants.*;
import static com.equitybank.gag.orange_money_ms.config.StatusCodeMessages.*;
import org.springframework.beans.factory.annotation.Value;

@Service
public class HttpTransactionRequestServiceImpl implements HttpTransactionRequestService {
    
    @Value("${equity-orange.endpoint.transactions}")
    private String url;
    
    private static final Logger log = LoggerFactory.getLogger(HttpTransactionRequestServiceImpl.class);

    private final HttpStatusCheckService httpStatusCheckService;
    private final CloseableHttpClient closeableHttpClient;
    private final CustomMapperService customMapperService;
    private final XmlMapperService xmlMapperService;
    private final DatabaseService databaseService;

    public HttpTransactionRequestServiceImpl(HttpStatusCheckService httpStatusCheckService,
                                             @Qualifier("closeableHttpClient1") CloseableHttpClient closeableHttpClient,
                                             CustomMapperService customMapperService,
                                             XmlMapperService xmlMapperService,
                                             DatabaseService databaseService) {
        this.httpStatusCheckService = httpStatusCheckService;
        this.closeableHttpClient = closeableHttpClient;
        this.customMapperService = customMapperService;
        this.xmlMapperService = xmlMapperService;
        this.databaseService = databaseService;
    }

    @Override
    public String transactionRequestHttpCall(String requestBody, String rrn) throws CustomException {
        HttpPost httpPost;
        CloseableHttpResponse response = null;
        try {
            // Compose post request headers
            httpPost = getPostRequestHeaders(requestBody, url);

            // Execute the HTTP POST request
            log.info("{}: Sending transaction request to {} on URL: {}", rrn, TELCO, url);
            response = closeableHttpClient.execute(httpPost);

            // Update database with PENDING status
            UpdateDbPendingStatus(rrn);

            // Return the closeable http response
            return processResponse(response, rrn);
        } catch (IOException | CustomException e) {
            String errorDescription = e.getMessage();
            if (errorDescription.contains("timeout")
                    || errorDescription.contains("time out")
                    || errorDescription.contains("timed out")) {
                throw new CustomException(TELCO_REQUEST_TIMEOUT);
            }
            throw new CustomException(e.getMessage());
        } finally {
            closeQuietly(rrn, response);
        }
    }

    private HttpPost getPostRequestHeaders(String requestBody, String url) throws CustomException {
        try {
            HttpEntity stringHttpEntity = new StringEntity(requestBody);
            String contentType = MediaType.APPLICATION_XML_VALUE;
            HttpPost httpPost = new HttpPost(url);
            httpPost.setEntity(stringHttpEntity);
            httpPost.setHeader("Accept", contentType);
            httpPost.setHeader("Content-Type", contentType);
            return httpPost;
        } catch (UnsupportedEncodingException e) {
            throw new CustomException(String.format("%sEncoding request body to string failed: %s", DEFAULT_PROCESSING_FAILURE, e.getMessage()));
        }
    }

    @Transactional
    private void UpdateDbPendingStatus(String rrn) {
        // Compose entity for database update
        TransactionDetails entity = customMapperService.composeEntityForPendingResponseUpdate(rrn);

        // Update the database table
        if (entity != null) {
            log.info("{}: Saving the pending status object in database", rrn);
            databaseService.updateTransactionRecord(entity);
        } else {
            log.info("{}: Could not save the pending status object in database. Returned entity is null", rrn);
        }
    }

    private String processResponse(CloseableHttpResponse response, String rrn) throws CustomException {
        HttpEntity entity = response.getEntity();
        int statusCode = response.getStatusLine().getStatusCode();
        String httpStatusMsg = response.getStatusLine().getReasonPhrase();
        log.info("{}: Received Transaction Request Http Status Code: {}", rrn, statusCode);

        try {
            // Process the received Http status code
            processStatusCodes(statusCode, entity);

            // Convert the received entity to string
            String responseString = getResponseString(entity);

            // Update database with initial telcoJsonRes payload
            updateDatabaseWithInitialTelcoResponse(rrn, responseString);

            // Log the received http status code, http status message, and the converted response string to the console
            log.info(String.format(HTTP_RESPONSE_LOG_TEMPLATE, statusCode, httpStatusMsg, responseString));

            // Read the response string values
            Map<String, String> responseMap = readResponseStringValues(rrn, responseString);

            // Process telco response
            processTelcoResponse(rrn, responseMap);

            // Get the tranId from the telco response
            String telcoReferenceNumber = getTelcoReferenceNumber(responseMap);

            // Update the tranId in the database table
            updateTranIdInDatabase(telcoReferenceNumber, rrn);

            // Do a status check from httpStatusCheckService
            return httpStatusCheckService.getTransactionFinalStatus(telcoReferenceNumber, rrn);

        } catch (CustomException e) {
            throw new CustomException(e.getMessage());
        }
    }

    private void closeQuietly(String rrn, CloseableHttpResponse response) {
        if (response != null) {
            try {
                response.close();
            } catch (IOException e) {
                log.warn("{}: Failed to close HTTP response: {}", rrn, e.getMessage());
            }
        }
    }

    private void processStatusCodes(int statusCode, HttpEntity entity) throws CustomException {
        if (statusCode == 401) {
            throw new CustomException(TELCO_UNAUTHORIZED);
        } else if (statusCode == 400) {
            throw new CustomException(TELCO_BAD_REQUEST);
        } else if (statusCode == 415) {
            throw new CustomException(TELCO_UNSUPPORTED_MEDIA_TYPE);
        } else if (statusCode == 404) {
            throw new CustomException(TELCO_NOT_FOUND);
        } else if (statusCode == 500) {
            throw new CustomException(TELCO_INTERNAL_SERVER_ERROR);
        } else if (entity == null || entity.getContentLength() == 0 || statusCode == 0) {
            throw new CustomException(TS_TIMEOUT_ERROR);
        } else if (statusCode != 200) {
            throw new CustomException(TELCO_INTERNAL_SERVER_ERROR);
        }
    }

    private String getResponseString(HttpEntity entity) throws CustomException {
        try {
            return EntityUtils.toString(entity);
        } catch (IOException e) {
            throw new CustomException(String.format("%sFailed to convert http response entity to string.", DEFAULT_PROCESSING_FAILURE));
        }
    }

    private void updateDatabaseWithInitialTelcoResponse(String rrn, String telcoJsonRes) {
        String message = String.format("%s: Updating db with telco response", rrn);

        // Prepare entity for database update
        TransactionDetails entity = customMapperService.composeEntityForTelcoResponseUpdate(rrn, telcoJsonRes);

        // Updating db with telco response
        updateDatabase(entity, message);
    }

    private Map<String, String> readResponseStringValues(String rrn, String responseString) throws CustomException {
        return xmlMapperService.readTelcoResponseXmlValues(rrn, responseString);
    }

    private void processTelcoResponse(String rrn, Map<String, String> responseMap) throws CustomException {
        String responseCode = responseMap.get("responseCode");
        String responseMessage = responseMap.get("responseMessage");
        String errorMessage = String.format("%s: Telco service returned and error with Response Code %s and Response Message %s", rrn, responseCode, responseMessage);
        String successMessage = String.format("%s: Telco service returned success for the initial transaction request. Calling status check api for the final transaction status", rrn);

        if (responseCode.equals("E11")) {
            log.error(errorMessage);
            throw new CustomException(TELCO_REQUEST_TIMEOUT);
        } else if (responseCode.equals("E13") || responseCode.equals("E14") || responseCode.equals("E15")) {
            log.error(errorMessage);
            throw new CustomException(TELCO_OPERATION_NOT_PERMITTED);
        } else if (responseCode.equals("E16")) {
            log.error(errorMessage);
            throw new CustomException(TELCO_INSUFFICIENT_BALANCE_ERROR);
        } else if (responseCode.equals("E22")) {
            log.error(errorMessage);
            throw new CustomException(TELCO_LIMITS_ERROR);
        } else if (!responseCode.equals("000")) {
            log.error(errorMessage);
            throw new CustomException(String.format("%s%s", TELCO_FINAL_STATUS_ERROR, responseMessage));
        }
        // Success status
        log.info(successMessage);
    }

    private String getTelcoReferenceNumber(Map<String, String> responseMap) {
        return responseMap.get("CBAReferenceNo");
    }

    @Transactional
    private void updateDatabase(TransactionDetails entity, String message) {
        if (entity != null) {
            log.info(message);
            databaseService.updateTransactionRecord(entity);
        }
    }

    @Transactional
    private void updateTranIdInDatabase(String operationId, String rrn) {
        TransactionDetails entity = customMapperService.composeEntityForTranIdUpdate(operationId, rrn);
        if (entity != null) {
            log.info("{}: Saving updated status object in database", rrn);
            databaseService.updateTransactionRecord(entity);
        } else {
            log.warn("{}: No record found for updating status", rrn);
        }
    }
}
