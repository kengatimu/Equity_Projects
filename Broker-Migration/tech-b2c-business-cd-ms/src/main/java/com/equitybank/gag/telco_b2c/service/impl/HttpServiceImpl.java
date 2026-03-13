package com.equitybank.gag.telco_b2c.service.impl;

import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.exception.CustomExceptionForReversal;
import com.equitybank.gag.telco_b2c.mapper.CustomMapperService;
import com.equitybank.gag.telco_b2c.service.*;
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
import org.springframework.core.task.TaskExecutor;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

import static com.equitybank.gag.telco_b2c.config.ApplicationConstants.*;
import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.*;
import static com.equitybank.gag.telco_b2c.enums.TransactionStatus.*;

@Service
public class HttpServiceImpl implements HttpService {
    private static final Logger log = LoggerFactory.getLogger(HttpServiceImpl.class);

    // Guard map to prevent duplicate background updates per RRN
    private final ConcurrentMap<String, Boolean> inProgressMap = new ConcurrentHashMap<>();

    private final TaskExecutor taskExecutor;
    private final DebitCreditService debitCreditService;
    private final CloseableHttpClient closeableHttpClient;
    private final TypeResolverService typeResolverService;
    private final CustomMapperService customMapperService;
    private final XmlReaderService xmlReaderService;
    private final DatabaseService databaseService;
    private final PayloadService payloadService;
    private final EurekaInstanceAndUrlService eurekaInstanceAndUrlService;

    @Autowired
    public HttpServiceImpl(@Qualifier("taskExecutor") TaskExecutor taskExecutor,
                           DebitCreditService debitCreditService,
                           @Qualifier("closeableHttpClient1") CloseableHttpClient closeableHttpClient,
                           TypeResolverService typeResolverService,
                           CustomMapperService customMapperService,
                           XmlReaderService xmlReaderService,
                           DatabaseService databaseService,
                           PayloadService payloadService,
                           EurekaInstanceAndUrlService eurekaInstanceAndUrlService) {
        this.taskExecutor = taskExecutor;
        this.debitCreditService = debitCreditService;
        this.closeableHttpClient = closeableHttpClient;
        this.typeResolverService = typeResolverService;
        this.customMapperService = customMapperService;
        this.xmlReaderService = xmlReaderService;
        this.databaseService = databaseService;
        this.payloadService = payloadService;
        this.eurekaInstanceAndUrlService = eurekaInstanceAndUrlService;
    }

    @Override
    public String httpCall(String requestBodyString, String telco, String rrn, String type, String bankId, String channelId) throws CustomException, CustomExceptionForReversal {
        CloseableHttpResponse response = null;
        try {
            // Check instance status of the telco technical service
            eurekaInstanceAndUrlService.checkInstanceStatus(telco, rrn);

            // Compose the URL based on the type
            String url = eurekaInstanceAndUrlService.getUrl(telco, type);

            // Log message to console
            log.info("{}: Sending {} Post HTTP Request to {} Via: {}", rrn, type, telco, url);

            // Create HTTP post request
            HttpPost httpPost = getPostRequestHeaders(url, new StringEntity(requestBodyString), requestBodyString);

            // Do a http post call to the telco technical service
            response = closeableHttpClient.execute(httpPost);

            // Process the HTTP response
            return processResponse(response, telco, rrn, type, bankId, channelId);
        } catch (IOException | CustomException e) {
            log.error("Exception occurred when sending HTTP request: " + e.getMessage());

            // Handle timeouts and other exceptions
            String errorDescription = e.getMessage();

            if (errorDescription.contains("timeout")
                    || errorDescription.contains("time out")
                    || errorDescription.contains("timed out")) {
                throw new CustomException(BS_TIMEOUT_ERROR);
            }

            // Handle exceptions that don't require transaction reversal
            if (typeResolverService.isNonReversalType(type)) {
                throw new CustomException(e.getMessage());
            }
            // Handle other exceptions that require transaction reversal
            throw new CustomExceptionForReversal(e.getMessage());
        } finally {
            // Ensure the response is closed quietly
            closeQuietly(response);
        }
    }

    @Override
    public void callbackHttpCall(String callbackUrl, String requestBodyString, String rrn, String tranType) {
        String tranStatus;
        String statusMessage;
        CloseableHttpResponse response = null;
        String type = tranType.toLowerCase().contains("moneygram") ? "moneygram-channel-callback" : tranType;

        try {
            // Log message to console
            log.info("{}: Sending Callback Response to Channel Via: {}", rrn, callbackUrl);

            // Create HTTP post request
            HttpPost httpPost = getPostRequestHeaders(callbackUrl, new StringEntity(requestBodyString), requestBodyString);

            // Do a http post call to the telco technical service
            response = closeableHttpClient.execute(httpPost);

            // Get received status code
            int statusCode = response.getStatusLine().getStatusCode();

            // Process the response
            processStatusCode(rrn, statusCode, requestBodyString, type);

        } catch (IOException e) {
            // Handle timeouts and other exceptions
            String errorDescription = e.getMessage();
            if (errorDescription.contains("timeout")
                    || errorDescription.contains("time out")
                    || errorDescription.contains("timed out")) {
                tranStatus = TIMEOUT.toString();
                statusMessage = "Timeout occurred during callback to channel";
                log.error("{}: Business Service did not receive any response from channel after callback call. Possible timeout", rrn);
            } else {
                tranStatus = ERROR.toString();
                statusMessage = "Callback to channel failed due exception";
                log.error("{}: Error Occurred During Callback Call to Channel: {}", rrn, errorDescription);
            }
            // Update the database
            updateDatabaseWithCallbackDetails(rrn, tranStatus, statusMessage, requestBodyString, type);

        } finally {
            closeQuietly(response);
        }
    }

    @Override
    public void telcoCallbackHttpCall(Map<String, String> xmlTagsMap, String callbackUrl, String responseXmlString, String rrn, String type) {
        CloseableHttpResponse response = null;
        try {
            // Log message to console
            log.info("{}: Sending Telco Callback Response to Channel Via: {}", rrn, callbackUrl);

            // Create HTTP post request
            HttpPost httpPost = getPostRequestHeaders(callbackUrl, new StringEntity(responseXmlString), responseXmlString);

            // Do a http post call to the telco technical service
            response = closeableHttpClient.execute(httpPost);

            // Get received status code
            int statusCode = response.getStatusLine().getStatusCode();
            log.info("Received HTTP Status Code: " + statusCode);
        } catch (Exception e) {
            String errorDescription = e.getMessage();
            if (errorDescription.contains("timeout")
                    || errorDescription.contains("time out")
                    || errorDescription.contains("timed out")) {
                log.error("{}: Business Service did not receive any response from channel after callback call. Possible timeout", rrn);
            } else {
                log.error("{}: Error Occurred During Callback Call to Channel: {}", rrn, errorDescription);
            }

        } finally {
            closeQuietly(response);
        }
    }

    private void processStatusCode(String rrn, int statusCode, String requestBodyString, String type) {
        String tranStatus;
        String statusMessage;
        if (statusCode != 200) {
            tranStatus = ERROR.toString();
            statusMessage = "Callback to channel failed";
            log.error("{}: {}. HttpStatus Code: {}", rrn, statusMessage, statusCode);
        } else {
            tranStatus = OK.toString();
            statusMessage = "Callback to channel was successful";
            log.info("{}: Callback to channel was successful: HttpStatus Code: {}", rrn, statusCode);
        }
        // Update the database
        updateDatabaseWithCallbackDetails(rrn, tranStatus, statusMessage, requestBodyString, type);
    }

    @Override
    public String finacleHttpCall(String finacleRequestXml, String finacleFIEndpoint) throws CustomException {
        CloseableHttpResponse response = null;

        // Log message to console
        log.info("Sending Fx_Rate_Req Post HTTP Request to Finacle Via: {}", finacleFIEndpoint);

        try {
            // Create HTTP post request
            HttpPost httpPost = getPostRequestHeaders(finacleFIEndpoint, new StringEntity(finacleRequestXml), finacleRequestXml);

            // Do a http post call to the telco technical service
            response = closeableHttpClient.execute(httpPost);

            // Process and return finacle response
            return processFinacleResponse(response);
        } catch (IOException e) {
            // Handle timeouts and other exceptions
            String errorDescription = e.getMessage().toLowerCase();
            if (errorDescription.contains("timeout")
                    || errorDescription.contains("time out")
                    || errorDescription.contains("timed out")) {
                log.error("Did not receive any response from finacle. Possible timeout");
            }
            throw new CustomException(e.getMessage());
        } finally {
            closeQuietly(response);
        }
    }

    private String processFinacleResponse(CloseableHttpResponse response) throws CustomException {
        try {
            HttpEntity entity = response.getEntity();
            int statusCode = response.getStatusLine().getStatusCode();
            String httpStatusMsg = response.getStatusLine().getReasonPhrase();

            // Check for empty or null response entity, which may indicate a timeout
            if (entity == null || entity.getContentLength() == 0 || statusCode == 0) {
                throw new CustomException("Did not receive any response from finacle. Possible timeout");
            }

            // Log the HTTP response. Lowercase inorder to handle the error cases
            String responseXmlString = EntityUtils.toString(entity).toLowerCase();
            log.info(String.format(HTTP_RESPONSE_LOG_TEMPLATE, statusCode, httpStatusMsg, responseXmlString));

            // Throw error if response contains error
            if (responseXmlString.contains("error")
                    || responseXmlString.contains("fault")
                    || responseXmlString.contains("exception")
                    || responseXmlString.contains("failed")
                    || responseXmlString.contains("failure")) {
                throw new CustomException("Finacle responded with an error.");
            }

            // Return the received xml response
            return responseXmlString;

        } catch (IOException e) {
            // Catch and rethrow IOException as a CustomException with additional context
            throw new CustomException(e.getMessage());
        }
    }

    private HttpPost getPostRequestHeaders(String url, StringEntity stringEntity, String requestBody) {
        String contentType = requestBody.startsWith("{") ? MediaType.APPLICATION_JSON_VALUE : MediaType.APPLICATION_XML_VALUE;
        HttpPost httpPost = new HttpPost(url);
        httpPost.setEntity(stringEntity);
        httpPost.setHeader("Accept", contentType);
        httpPost.setHeader("Content-Type", contentType);
        return httpPost;
    }

    private String processResponse(CloseableHttpResponse response, String telco, String rrn, String type, String bankId, String channelId) throws CustomException {
        try {
            HttpEntity entity = response.getEntity();
            int statusCode = response.getStatusLine().getStatusCode();
            String httpStatusMsg = response.getStatusLine().getReasonPhrase();

            log.info("Response Entity ::: {}", response.getEntity());
            log.info("statusCode: {}", statusCode);
            log.info("httpStatusMsg: {}", httpStatusMsg);

            // Differentiate timeout vs. HTTP errors
            if (statusCode == 0) {
                throw new CustomException(BS_TIMEOUT_ERROR);
            }

            if (entity == null || entity.getContentLength() == 0) {
                // No body but valid status: treat as HTTP error instead of timeout
                throw new CustomException(statusCode + "|" + (httpStatusMsg != null ? httpStatusMsg : "Empty response"));
            }

            String responseXmlString = EntityUtils.toString(entity);
            log.info(String.format(HTTP_RESPONSE_LOG_TEMPLATE, statusCode, httpStatusMsg, responseXmlString));

            // Shortcut return for namecheck types
            if (type.equals("bank-to-wallet-namecheck") ||
                    type.equals("airtime-topup-namecheck") ||
                    type.equals("float-purchase-namecheck")) {
                return responseXmlString;
            }

            // Shortcut return for status check types
            if (type.toLowerCase().contains("status-check")) {
                databaseServiceUpdate(rrn, responseXmlString, type);
                return responseXmlString;
            }

            // Handle MoneyGram
            if (typeResolverService.isMoneyGramService(type)) {
                return (statusCode != 200)
                        ? payloadService.defaultTechnicalServiceErrorResponse(String.valueOf(DEFAULT_HTTP_STATUS_CODE), responseXmlString)
                        : responseXmlString;
            }

            // Handle error response
            if (responseXmlString.toUpperCase().contains("ERROR|") || statusCode != 200) {
                Map<String, String> receivedValuesMap = xmlReaderService.parseXml(responseXmlString, type, rrn);
                String errorCode = receivedValuesMap.get("responseCode");
                String errorDesc = receivedValuesMap.get("responseDesc");
                log.error("{}: Received Error from telco technical service:\nError Code = {},\nError Description = {}", rrn, errorCode, errorDesc);

                // Update database
                databaseServiceUpdate(rrn, responseXmlString, type);

                // Do not reverse for Finacle over-the-counter float purchase
                if (!DEFAULT_FIN_CHANNEL.equals(channelId)) {

                    // Reverse only floatPurchase transactions
                    if ("floatPurchase".equalsIgnoreCase(type)) {

                        // Skip reversal if error code is -3 (timeout) or -11 (pending)
                        if (!errorCode.equals("-3") && !errorCode.equals("-11")) {
                            log.info("{}: Initializing reversal for the float purchase transaction...", rrn);
                            debitCreditService.doReversal(rrn, type, bankId);
                        }
                    }
                    return responseXmlString;
                }
            }

            // Handle pending
            if (responseXmlString.toUpperCase().contains("PENDING")) {
                log.info("{}: Received PENDING Status from tech service", rrn);
                return responseXmlString;
            }

//            // Handle pending
//            if (responseXmlString.toUpperCase().contains("PENDING")) {
//                log.info("{}: Updating database With PENDING Status...", rrn);
//                updateDatabaseWithPendingStatus(responseXmlString, rrn, type);
//                return responseXmlString;
//            }

            // Success fallback
            databaseServiceUpdate(rrn, responseXmlString, type);
            return responseXmlString;

        } catch (Exception e) {
            throw new CustomException(String.format("%s%s", DEFAULT_RESPONSE_PROCESSING_FAILURE, e.getMessage()));
        }
    }

    // This will update the database in async (background thread). Therefore, not need for @Transaction annotation
    private void databaseServiceUpdate(String rrn, String responseXmlString, String type) {
        taskExecutor.execute(() -> {
            log.info("{}: Processing async response DB update", rrn);
            try {
                Map<String, String> receivedValuesMap = xmlReaderService.parseXml(responseXmlString, type, rrn);
                log.info("ResponseMap: " + receivedValuesMap);
                TransactionDetails entity = customMapperService.composeDbStatus(rrn, receivedValuesMap, responseXmlString, type);
                saveTransactionEntity(entity, rrn, "response");
            } catch (Exception e) {
                log.error("{}: Failed to process and update response for DB update: {}. Process Async", rrn, e.getMessage());
            }
        });
    }

    // This will update the database in async (background thread). Therefore, not need for @Transaction annotation
    private void updateDatabaseWithPendingStatus(String responseXmlString, String rrn, String type) {
        taskExecutor.execute(() -> {
            log.info("{}: Processing async pending status DB update", rrn);
            try {
                TransactionDetails entity = customMapperService.composeTelcoPendingStatusEntity(rrn, responseXmlString, type);
                saveTransactionEntity(entity, rrn, "pending status");
            } catch (Exception e) {
                log.error("{}: Failed to process and update pending transaction status: {}. Process Async", rrn, e.getMessage());
            }
        });
    }

    // This will update the database in async (background thread). Therefore, not need for @Transaction annotation
    private void updateDatabaseWithCallbackDetails(String rrn, String tranStatus, String statusMessage, String requestBodyString, String type) {
        taskExecutor.execute(() -> {
            log.info("{}: Processing async callback DB update", rrn);
            try {
                TransactionDetails entity = customMapperService.composeCallbackEntity(rrn, tranStatus, statusMessage, requestBodyString, type);
                saveTransactionEntity(entity, rrn, "callback");
            } catch (Exception e) {
                log.error("{}: Failed to process and update transaction record from callback: {}. Process Async", rrn, e.getMessage(), e);
            }
        });
    }

    // Shared helper method
    private void saveTransactionEntity(TransactionDetails entity, String rrn, String context) {
        if (entity != null) {
            log.info("{}: Saving {} entity record", rrn, context);
            databaseService.updateTransactionRecord(entity);
        } else {
            log.warn("{}: Skipping {} DB save — entity is null", rrn, context);
        }
    }

    private void closeQuietly(CloseableHttpResponse response) {
        if (response != null) {
            try {
                response.close();
            } catch (IOException e) {
                log.error("Failed to close response", e);
            }
        }
    }
}
