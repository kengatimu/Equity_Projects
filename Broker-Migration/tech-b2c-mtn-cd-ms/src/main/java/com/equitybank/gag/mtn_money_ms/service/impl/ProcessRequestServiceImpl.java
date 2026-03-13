package com.equitybank.gag.mtn_money_ms.service.impl;

import com.equitybank.gag.mtn_money_ms.entity.TransactionDetails;
import com.equitybank.gag.mtn_money_ms.exception.CustomException;
import com.equitybank.gag.mtn_money_ms.mapper.CustomMapperService;
import com.equitybank.gag.mtn_money_ms.service.*;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Base64;
import java.util.Map;

import static com.equitybank.gag.mtn_money_ms.config.ApplicationConstants.HTTP_RESPONSE_LOG_TEMPLATE;
import static com.equitybank.gag.mtn_money_ms.config.StatusCodeMessages.*;

@Service
public class ProcessRequestServiceImpl implements ProcessRequestService {
    private static final Logger log = LoggerFactory.getLogger(ProcessRequestServiceImpl.class);

    private final String userName;
    private final String password;
    private final String namecheckUrl;
    private final String floatPurchaseUrl;
    private final String floatPurchaseStatusUrl;
    private final CloseableHttpClient closeableHttpClient;
    private final PayloadService payloadService;
    private final DatabaseService databaseService;
    private final XmlReaderService xmlReaderService;
    private final CustomMapperService customMapperService;
    private final InitialValidatorService initialValidatorService;

    @Autowired
    public ProcessRequestServiceImpl(@Value("${mtn.ss.credentials.username}") String userName,
                                     @Value("${mtn.ss.credentials.password}") String password,
                                     @Value("${mtn.ss.namecheck.url}") String namecheckUrl,
                                     @Value("${mtn.ss.float.buy.url}") String floatPurchaseUrl,
                                     @Value("${mtn.ss.float.status.url}") String floatPurchaseStatusUrl,
                                     @Qualifier("closeableHttpClient1") CloseableHttpClient closeableHttpClient,
                                     PayloadService payloadService,
                                     DatabaseService databaseService,
                                     XmlReaderService xmlReaderService,
                                     CustomMapperService customMapperService,
                                     InitialValidatorService initialValidatorService) {
        this.userName = userName;
        this.password = password;
        this.namecheckUrl = namecheckUrl;
        this.floatPurchaseUrl = floatPurchaseUrl;
        this.floatPurchaseStatusUrl = floatPurchaseStatusUrl;
        this.closeableHttpClient = closeableHttpClient;
        this.payloadService = payloadService;
        this.databaseService = databaseService;
        this.xmlReaderService = xmlReaderService;
        this.customMapperService = customMapperService;
        this.initialValidatorService = initialValidatorService;
    }

    @Override
    public String processNamecheckRequest(String nameCheckXmlRequest, Map<String, String> xmlMapValues, String type) throws CustomException {
        String rrn = xmlMapValues.getOrDefault("msgId", "");
        String telco = xmlMapValues.getOrDefault("telcom", "");
        CloseableHttpResponse response = null;

        try {
            // Construct telcom Xml Request String;
            String telcoXmlRequest = getTelcoXmlRequest(xmlMapValues, type);

            // Log message to console
            log.info("{}: Sending {} Post HTTP Request to {} Via: {}", rrn, type, telco, namecheckUrl);

            // Create HTTP post request
            HttpPost httpPost = getPostRequestHeaders(telcoXmlRequest, namecheckUrl);

            // Do a http post call to MTN
            response = closeableHttpClient.execute(httpPost);

            // Process the HTTP response
            return processResponse(xmlMapValues, response, rrn, type);
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

    @Override
    public String processFloatPurchaseRequest(String channelXmlRequest, Map<String, String> xmlMapValues, String rrn, String type) throws CustomException {
        String telco = xmlMapValues.getOrDefault("telco", "");
        CloseableHttpResponse response = null;

        try {
            // Verify if a transaction record exists in the database for the given RRN
            getSavedDbRecord(rrn, type);

            // Construct telcom Xml Request String;
            String telcoXmlRequest = getTelcoXmlRequest(xmlMapValues, type);

            // Log message to console
            log.info("{}: Sending {} Post HTTP Request to {} Via: {}", rrn, type, telco, floatPurchaseUrl);

            // Create HTTP post request
            HttpPost httpPost = getPostRequestHeaders(telcoXmlRequest, floatPurchaseUrl);

            // Do a http post call to MTN
            response = closeableHttpClient.execute(httpPost);

            // Process the HTTP response
            return processResponse(xmlMapValues, response, rrn, type);
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

    @Override
    public String processFloatPurchaseStatusRequest(String channelXmlRequest, Map<String, String> xmlMapValues, String rrn, String type) throws CustomException {
        String telco = xmlMapValues.getOrDefault("telco", "");
        CloseableHttpResponse response = null;

        try {
            // Construct telcom Xml Request String;
            String telcoXmlRequest = getTelcoXmlRequest(xmlMapValues, type);

            // Log message to console
            log.info("{}: Sending {} Post HTTP Request to {} Via: {}", rrn, type, telco, floatPurchaseStatusUrl);

            // Create HTTP post request
            HttpPost httpPost = getPostRequestHeaders(telcoXmlRequest, floatPurchaseStatusUrl);

            // Do a http post call to MTN
            response = closeableHttpClient.execute(httpPost);

            // Process the HTTP response
            return processResponse(xmlMapValues, response, rrn, type);
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

    private void getSavedDbRecord(String rrn, String type) throws CustomException {
        initialValidatorService.getDatabaseRecord(rrn, type);
    }

    private String getTelcoXmlRequest(Map<String, String> xmlMapValues, String type) {
        if ("float-purchase-namecheck".equalsIgnoreCase(type)) {
            return payloadService.composeTelcoFloatNamecheckTelcoRequest(xmlMapValues);
        } else if ("floatPurchase-status".equalsIgnoreCase(type)) {
            return payloadService.composeFloatStatusCheckTelcoRequest(xmlMapValues);
        }
        return payloadService.composeTelcoFloatPurchaseTelcoRequest(xmlMapValues);
    }

    private HttpPost getPostRequestHeaders(String requestBodyStr, String url) throws CustomException {
        String credentials = userName + ":" + password;
        try {
            // Convert request body to HttpEntity
            HttpEntity stringHttpEntity = new StringEntity(requestBodyStr);

            // Generate Basic Auth Header using username and password
            String authHeader = "Basic " + Base64.getEncoder().encodeToString(credentials.getBytes());

            // Create HttpPost object with the target URL
            HttpPost httpPost = new HttpPost(url);
            httpPost.setEntity(stringHttpEntity);
            httpPost.setHeader("Authorization", authHeader);
            httpPost.setHeader("Content-Type", MediaType.APPLICATION_XML_VALUE);
            return httpPost;
        } catch (UnsupportedEncodingException e) {
            throw new CustomException(DEFAULT_HTTP_ERROR);
        }
    }

    private String processResponse(Map<String, String> xmlMapValues, CloseableHttpResponse response, String rrn, String type) throws CustomException {
        HttpEntity entity = response.getEntity();
        Map<String, String> extractedTelcoResponseMap;
        int statusCode = response.getStatusLine().getStatusCode();
        String httpStatusMsg = response.getStatusLine().getReasonPhrase();
        log.info("{}: Received {} Http Status Code: {}", rrn, type, statusCode);

        try {
            // Check for empty or null response entity, which may indicate a timeout
            if (entity == null || entity.getContentLength() == 0 || statusCode == 0) {
                throw new CustomException(TELCO_TIMEOUT_ERROR);
            }

            // Convert the received entity to string
            String responseXmlString = EntityUtils.toString(entity);

            // Log the received http status code, http status message, and the converted response string to the console
            log.info(String.format(HTTP_RESPONSE_LOG_TEMPLATE, statusCode, httpStatusMsg, responseXmlString));

            // Return if response string contains errorResponse or status code is not 200
            if (responseXmlString.toLowerCase().contains("errorresponse") || statusCode != 200) {
                String telcoErrorMessage = getTelcoErrorMessage(responseXmlString);
                throw new CustomException(TELCO_ERROR + telcoErrorMessage);
            }

            if ("float-purchase-namecheck".equalsIgnoreCase(type)) {
                // Extract namecheck response details
                extractedTelcoResponseMap = xmlReaderService.parseXmlString(responseXmlString, "float-purchase-namecheck-success-response");

                // Check if customer is Active
                getCustomerStatus(extractedTelcoResponseMap);

                // Compose namecheck success return string
                return composeFloatNamecheckSuccessString(xmlMapValues, extractedTelcoResponseMap);
            }
            if ("floatPurchase-status".equalsIgnoreCase(type)) {
                // Extract namecheck response details
                extractedTelcoResponseMap = xmlReaderService.parseXmlString(responseXmlString, "status-check-success-response");

                // update the db with success status
                databaseUpdate(responseXmlString, extractedTelcoResponseMap, rrn, type);

                // Compose status check return string
                return composeStatusCheckResponseString(xmlMapValues, extractedTelcoResponseMap);
            }

            // Extract float purchase response details
            extractedTelcoResponseMap = xmlReaderService.parseXmlString(responseXmlString, "deposit-success-response");

            // update the db with success status
            databaseUpdate(responseXmlString, extractedTelcoResponseMap, rrn, type);

            // Compose float purchase success return string
            return composeFloatPurchaseSuccessString(xmlMapValues, extractedTelcoResponseMap);
        } catch (CustomException | IOException e) {
            throw new CustomException(e.getMessage());
        }
    }

    private String composeFloatNamecheckSuccessString(Map<String, String> xmlMapValues, Map<String, String> extractedTelcoResponseMap) {
        return payloadService.composeFloatPurchaseNameCheckSuccessResponse(xmlMapValues, extractedTelcoResponseMap);
    }

    private String composeStatusCheckResponseString(Map<String, String> xmlMapValues, Map<String, String> extractedTelcoResponseMap) {
        return payloadService.composeStatusCheckResponse(xmlMapValues, extractedTelcoResponseMap);
    }

    private String composeFloatPurchaseSuccessString(Map<String, String> xmlMapValues, Map<String, String> extractedTelcoResponseMap) {
        return payloadService.composeFloatPurchaseSuccessResponse(xmlMapValues, extractedTelcoResponseMap);

    }

    private String getTelcoErrorMessage(String responseXmlString) throws CustomException {
        Map<String, String> extractedTelcoResponseMap = xmlReaderService.parseXmlString(responseXmlString, "generic-failure-response");
        return extractedTelcoResponseMap.get("errorcode");
    }

    private void getCustomerStatus(Map<String, String> extractedTelcoResponseMap) throws CustomException {
        String status = extractedTelcoResponseMap.get("accountholderstatus");
        if (status.isEmpty() || !"ACTIVE".toUpperCase().equals(status)) {
            log.error("Customer Status IS INACTIVE. Received Status: " + status);
            throw new CustomException("500|Customer Status IS Not Active");
        }
    }

    private void databaseUpdate(String responseXmlString, Map<String, String> extractedTelcoResponseMap, String rrn, String type) {
        // Compose entity for the db update
        TransactionDetails entity = customMapperService.composeEntityForSuccessResponseUpdate(responseXmlString, extractedTelcoResponseMap, rrn, type);

        // Update the database with the entity object
        log.info("{}: Saving transaction status in the database", rrn);
        if (entity != null) {
            databaseService.updateTransactionRecord(entity);
        } else {
            log.warn("{}: TransactionDetails Entity is null or empty, skipping database update", rrn);
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

}