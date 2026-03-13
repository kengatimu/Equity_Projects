package com.equitybank.gag.orange_money_ms.service.impl;

import com.equitybank.gag.orange_money_ms.dto.channel.response.ChannelResponseDto;
import com.equitybank.gag.orange_money_ms.dto.channel.response.response;
import com.equitybank.gag.orange_money_ms.entity.TransactionDetails;
import com.equitybank.gag.orange_money_ms.enums.TransactionStatus;
import com.equitybank.gag.orange_money_ms.exception.CustomException;
import com.equitybank.gag.orange_money_ms.mapper.CustomMapperService;
import com.equitybank.gag.orange_money_ms.service.DatabaseService;
import com.equitybank.gag.orange_money_ms.service.HttpStatusCheckService;
import com.equitybank.gag.orange_money_ms.service.XmlMapperService;
import org.apache.http.HttpEntity;
import org.apache.http.client.ClientProtocolException;
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
public class HttpStatusCheckServiceImpl implements HttpStatusCheckService {
    
    @Value("${equity-orange.endpoint.status}")
    private String url;
    
    private static final Logger log = LoggerFactory.getLogger(HttpStatusCheckServiceImpl.class);

    private final XmlMapperService xmlMapperService;
    private final CloseableHttpClient closeableHttpClient;
    private final CustomMapperService customMapperService;
    private final DatabaseService databaseService;

    public HttpStatusCheckServiceImpl(XmlMapperService xmlMapperService,
                                      @Qualifier("closeableHttpClient1") CloseableHttpClient closeableHttpClient,
                                      CustomMapperService customMapperService,
                                      DatabaseService databaseService) {
        this.xmlMapperService = xmlMapperService;
        this.closeableHttpClient = closeableHttpClient;
        this.customMapperService = customMapperService;
        this.databaseService = databaseService;
    }

    @Override
    public String getTransactionFinalStatus(String telcoReferenceNumber, String rrn) throws CustomException {
        long startTime = System.currentTimeMillis();
        long endTime = startTime + REQUEST_HOLD_TIME_MS; // For 10 seconds
        CloseableHttpResponse response = null;

        while (System.currentTimeMillis() < endTime) {
            try {
                // Compose telco status check request string
                String requestStatusXmlString = composeTelcoStatusCheckReqString(rrn);

                // Execute the http get request
                HttpPost httpPost = getPostRequestHeaders(requestStatusXmlString, url);
                log.info("Sending status check request to {} on URL: {}", TELCO, url);
                response = closeableHttpClient.execute(httpPost);

                // Process the response http status code
                HttpEntity entity = response.getEntity();
                int statusCode = response.getStatusLine().getStatusCode();
                String httpStatusMsg = response.getStatusLine().getReasonPhrase();
                log.info("{}: Received status check response http status code: {}", rrn, statusCode);

                // Process the status codes
                processStatusCodes(statusCode, entity);

                // Get the response string
                String telcoResponseString = EntityUtils.toString(entity);
                log.info(String.format(HTTP_RESPONSE_LOG_TEMPLATE, statusCode, httpStatusMsg, telcoResponseString));

                // Extract the response values
                Map<String, String> statusResponseMap = extractResponseValues(rrn, telcoResponseString);
                String responseCode = statusResponseMap.get("responseCode");
                String responseMessage = statusResponseMap.get("responseMessage");
                String originalTransactionRef = statusResponseMap.get("CBAReferenceNo");

                // Check for error status codes
                validateResponse(rrn, responseCode, responseMessage, originalTransactionRef);

                // Return success response
                if ("000".equals(responseCode)) {
                    // Compose business service response
                    String xmlResponse = composeSuccessResponseXml(originalTransactionRef, rrn);

                    // Update database with the status and payloads
                    updateDbWithFinalSuccessStatus(statusResponseMap, xmlResponse, rrn);
                    return xmlResponse;
                }
            } catch (IOException | CustomException e) {
                // Check if the current time exceeds the end time after the exception. In case the remote service takes more time to respond
                long currentTime = System.currentTimeMillis();
                if (currentTime >= endTime) {
                    log.warn("Remote service has taken more than {}ms to respond. Exiting the loop and sending success response to business service", REQUEST_HOLD_TIME_MS);
                    return composeSuccessResponseXml(telcoReferenceNumber, rrn);
                }
                throw new CustomException(e.getMessage());
            } finally {
                closeQuietly(rrn, response);
            }
            sleepBeforeNextTask(); // Sleep the loop for 1 second
        }
        // If status is not determined within 10 sec, return success to business service
        log.warn("Status check function exceeded {}ms. Exiting the loop and sending success response to business service", REQUEST_HOLD_TIME_MS);
        return composeSuccessResponseXml(telcoReferenceNumber, rrn);
    }

    private String composeTelcoStatusCheckReqString(String rrn) throws CustomException {
        return customMapperService.composeTelcoStatusCheckRequestString(rrn);
    }

    private CloseableHttpResponse executeStatusCheck(String requestString, String url) throws CustomException {
        try {
            HttpPost httpPost = getPostRequestHeaders(requestString, url);
            log.info("Sending status check request to {} on URL: {}", TELCO, url);
            return closeableHttpClient.execute(httpPost);
        } catch (IOException e) {
            throw new CustomException(String.format("%s%s", DEFAULT_HTTP_ERROR, e.getMessage()));
        }
    }

    private Map<String, String> extractResponseValues(String rrn, String telcoResponseString) throws CustomException {
        return xmlMapperService.readTelcoResponseXmlValues(rrn, telcoResponseString);
    }

    private void validateResponse(String rrn, String responseCode, String responseMessage, String originalTransactionRef) throws CustomException {
        String errorMessage = String.format("%s: Telco service returned an error with Response Code %s and Response Message %s", rrn, responseCode, responseMessage);

        // For timeout, sleep for a second then continue with the loop
        if ("E11".equals(responseCode)) {
            log.warn("{}: Status check returned a timeout. The final status is still unknown. Proceeding with the next polling cycle.", rrn);
            sleepBeforeNextTask(); // Sleep for 1 second before the next iteration
            return;
        }

        if (originalTransactionRef == null || originalTransactionRef.isBlank()) {
            log.error("{}: Original transaction not found or not valid", rrn);
            throw new CustomException(TELCO_NOT_FOUND);
        } else if ("E13".equals(responseCode) || "E14".equals(responseCode) || "E15".equals(responseCode)) {
            log.error(errorMessage);
            throw new CustomException(TELCO_OPERATION_NOT_PERMITTED);
        } else if ("E16".equals(responseCode)) {
            log.error(errorMessage);
            throw new CustomException(TELCO_INSUFFICIENT_BALANCE_ERROR);
        } else if ("E22".equals(responseCode)) {
            log.error(errorMessage);
            throw new CustomException(TELCO_LIMITS_ERROR);
        } else if (!"000".equals(responseCode)) {
            log.error(errorMessage);
            throw new CustomException(String.format("%s%s", TELCO_FINAL_STATUS_ERROR, responseMessage));
        }
    }

    private HttpPost getPostRequestHeaders(String requestString, String url) throws CustomException {
        try {
            HttpEntity stringHttpEntity = new StringEntity(requestString);
            String contentType = MediaType.APPLICATION_XML_VALUE;
            HttpPost httpPost = new HttpPost(url);
            httpPost.setEntity(stringHttpEntity);
            httpPost.setHeader("Accept", contentType);
            httpPost.setHeader("Content-Type", contentType);
            return httpPost;
        } catch (UnsupportedEncodingException e) {
            throw new CustomException(String.format("%sFailed to create HttpEntity object: %s", DEFAULT_PROCESSING_FAILURE, e.getMessage()));
        }
    }

    private void processStatusCodes(int statusCode, HttpEntity entity) throws CustomException {
        if (statusCode == 401) {
            throw new CustomException(TELCO_UNAUTHORIZED);
        } else if (statusCode == 400) {
            throw new CustomException(TELCO_BAD_REQUEST);
        } else if (statusCode == 404) {
            throw new CustomException(TELCO_NOT_FOUND);
        } else if (statusCode == 415) {
            throw new CustomException(TELCO_UNSUPPORTED_MEDIA_TYPE);
        } else if (statusCode == 500) {
            throw new CustomException(TELCO_INTERNAL_SERVER_ERROR);
        } else if (entity == null || entity.getContentLength() == 0 || statusCode == 0) {
            throw new CustomException(TS_TIMEOUT_ERROR);
        } else if (statusCode != 200) {
            throw new CustomException(TELCO_INTERNAL_SERVER_ERROR);
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

    private void sleepBeforeNextTask() {
        try {
            Thread.sleep(THREAD_SLEEP_TIME_MS); // Sleep for 1 second
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            log.error("Thread was interrupted while waiting for status check: {}", e.getMessage());
        }
    }

    private String composeSuccessResponseXml(String telcoReferenceNumber, String rrn) throws CustomException {
        ChannelResponseDto responseDto = new ChannelResponseDto();
        responseDto.setWalletTranID(telcoReferenceNumber);
        responseDto.setResponseCode(SUCCESS_STATUS_CODE);
        responseDto.setStatus(TransactionStatus.OK.toString() + "|" + telcoReferenceNumber);
        responseDto.setResponseDesc(TransactionStatus.OK.getDescription());

        response res = new response();
        res.setMsgId(rrn);
        res.setEazzycashres(responseDto);

        return xmlMapperService.mapBusinessServiceSuccessResponseObjToXml(res);
    }

    @Transactional
    private void updateDbWithFinalSuccessStatus(Map<String, String> responseMap, String xmlResponse, String rrn) {
        String telcoResponseString = responseMap.get("responseString");
        TransactionDetails entity = customMapperService.composeEntityForFinalStatusSuccess(telcoResponseString, xmlResponse, rrn);
        if (entity != null) {
            log.info("{}: Saving updated status object in database", rrn);
            databaseService.updateTransactionRecord(entity);
        } else {
            log.warn("{}: No record found for updating status", rrn);
        }
    }
}
