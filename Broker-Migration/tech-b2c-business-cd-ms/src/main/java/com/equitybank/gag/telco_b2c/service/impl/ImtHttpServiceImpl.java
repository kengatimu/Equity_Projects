package com.equitybank.gag.telco_b2c.service.impl;

import com.equitybank.gag.telco_b2c.dto.thunes.creditParties.creditPartyInfo.CreditPartyInformation;
import com.equitybank.gag.telco_b2c.dto.thunes.creditParties.creditPartyVerify.CreditPartyVerify;
import com.equitybank.gag.telco_b2c.dto.thunes.discovery.bic.BicLookup;
import com.equitybank.gag.telco_b2c.dto.thunes.discovery.countries.ListOfThunesCountries;
import com.equitybank.gag.telco_b2c.dto.thunes.discovery.details.PayerDetails;
import com.equitybank.gag.telco_b2c.dto.thunes.discovery.payers.ThunesPayers;
import com.equitybank.gag.telco_b2c.dto.thunes.discovery.rates.PayerRates;
import com.equitybank.gag.telco_b2c.dto.thunes.discovery.services.ListOfThunesServices;
import com.equitybank.gag.telco_b2c.dto.thunes.transfer.quotation.CreateQuoteDto;
import com.equitybank.gag.telco_b2c.dto.thunes.transfer.transaction.TransactionRequestDto;
import com.equitybank.gag.telco_b2c.dto.wendi.namecheck.NamecheckRequest;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.service.EurekaInstanceAndUrlService;
import com.equitybank.gag.telco_b2c.service.PayloadService;
import com.equitybank.gag.telco_b2c.service.ImtHttpService;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

import static com.equitybank.gag.telco_b2c.config.ApplicationConstants.*;
import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.*;

@Service
public class ImtHttpServiceImpl implements ImtHttpService {
    private static final Logger log = LoggerFactory.getLogger(ImtHttpServiceImpl.class);

    private final String PER_PAGE = "500";

    private final Gson gson;
    private final PayloadService payloadService;
    private final CloseableHttpClient closeableHttpClient;
    private final EurekaInstanceAndUrlService eurekaInstanceAndUrlService;

    public ImtHttpServiceImpl(Gson gson,
                              PayloadService payloadService,
                              CloseableHttpClient closeableHttpClient,
                              EurekaInstanceAndUrlService eurekaInstanceAndUrlService) {
        this.gson = gson;
        this.payloadService = payloadService;
        this.closeableHttpClient = closeableHttpClient;
        this.eurekaInstanceAndUrlService = eurekaInstanceAndUrlService;
    }

    @Override
    public String thunesServicesHttpCall(String rrn, ListOfThunesServices listOfThunesServices, String type) throws CustomException {
        return executeImtHttpCall(rrn, listOfThunesServices, type);
    }

    @Override
    public String thunesPayersHttpCall(String rrn, ThunesPayers thunesPayers, String type) throws CustomException {
        return executeImtHttpCall(rrn, thunesPayers, type);
    }

    @Override
    public String thunesPayerRatesHttpCall(String rrn, PayerRates payerRates, String type) throws CustomException {
        return executeImtHttpCall(rrn, payerRates, type);
    }

    @Override
    public String thunesPayerDetailsHttpCall(String rrn, PayerDetails payerDetails, String type) throws CustomException {
        return executeImtHttpCall(rrn, payerDetails, type);
    }

    @Override
    public String thunesListOfCountriesHttpCall(String rrn, ListOfThunesCountries listOfThunesCountries, String type) throws CustomException {
        return executeImtHttpCall(rrn, listOfThunesCountries, type);
    }

    @Override
    public String thunesBicLookupHttpCall(String rrn, BicLookup bicLookup, String type) throws CustomException {
        return executeImtHttpCall(rrn, bicLookup, type);
    }

    @Override
    public String thunesCreditPartyInfoHttpCall(String rrn, CreditPartyInformation creditPartyInformation, String type) throws CustomException {
        return executeImtHttpCall(rrn, creditPartyInformation, type);
    }

    @Override
    public String thunesCreditPartyVerifyHttpCall(String rrn, CreditPartyVerify creditPartyVerify, String type) throws CustomException {
        return executeImtHttpCall(rrn, creditPartyVerify, type);
    }

    @Override
    public String thunesCreateQuoteHttpCall(String rrn, CreateQuoteDto createQuoteDto, String type) throws CustomException {
        return executeImtHttpCall(rrn, createQuoteDto, type);
    }

    @Override
    public String thunesCreateQuoteHttpCall(String rrn, TransactionRequestDto transactionRequestDto, String type) throws CustomException {
        return executeImtHttpCall(rrn, transactionRequestDto, type);
    }

    @Override
    public String wendiB2CNamecheckHttpCall(String rrn, NamecheckRequest namecheckRequest, String type) throws CustomException {
        return executeImtHttpCall(rrn, namecheckRequest, type);
    }

    private String executeImtHttpCall(String rrn, Object requestObject, String type) throws CustomException {
       String telco = type.toLowerCase().contains("thunes") ? THUNES : WENDI;
        HttpGet httpGet;
        HttpPost httpPost;

        try {
            // Check instance status of the telco technical service
            eurekaInstanceAndUrlService.checkInstanceStatus(telco, rrn);

            // Compose the URL based on the type
            String baseUrl = eurekaInstanceAndUrlService.getUrl(telco, type);

            // For testing purpose, do a direct call to thunes
//            String baseUrl = "https://api-pre.mm.transferto.com" + eurekaInstanceAndUrlService.getUrl(telco, type);
//            String baseUrl = "https://api-pre.mm.transferto.com" + "/v2/money-transfer/quotations";

            // Check http method
            boolean isPost = checkIfPost(type);
            if (isPost) {
                // Create HTTP GET request
                httpPost = getPostRequestHeaders(rrn, baseUrl, requestObject, telco, type);

                // Execute HTTP call inside try-with-resources so response closes automatically
                try (CloseableHttpResponse response = closeableHttpClient.execute(httpPost)) {
                    return processResponse(response, telco, rrn, type);
                }

            } else {
                // Create HTTP GET request
                httpGet = getRequestHeaders(rrn, baseUrl, requestObject, telco, type);

                // Execute HTTP call inside try-with-resources so response closes automatically
                try (CloseableHttpResponse response = closeableHttpClient.execute(httpGet)) {
                    return processResponse(response, telco, rrn, type);
                }
            }

        } catch (Exception e) {
            String errorDescription = e.getMessage();
            if (errorDescription != null) {
                if (errorDescription.contains("timeout")
                        || errorDescription.contains("time out")
                        || errorDescription.contains("timed out")) {
                    throw new CustomException(BS_TIMEOUT_ERROR);
                }

                if (errorDescription.contains("connection refused")) {
                    throw new CustomException(CONNECTION_REFUSED_ERROR);
                }
            }
            throw new CustomException(errorDescription);
        }
    }

    private boolean checkIfPost(String type) {
        return "thunes-credit-party-information".equalsIgnoreCase(type)
                || "thunes-credit-party-verify".equalsIgnoreCase(type)
                || "thunes-create-quote".equalsIgnoreCase(type)
                || "thunes-send-transaction".equalsIgnoreCase(type)
                || "wendi-b2c-namecheck".equalsIgnoreCase(type)
                || "wendi-b2c-transaction".equalsIgnoreCase(type);
    }

    private String processResponse(CloseableHttpResponse response, String telco, String rrn, String type) throws CustomException {
        try {
            // Validate HTTP response basics
            if (response == null || response.getStatusLine() == null) {
                throw new CustomException(BS_TIMEOUT_ERROR);
            }

            int statusCode = response.getStatusLine().getStatusCode();
            String httpStatusMsg = response.getStatusLine().getReasonPhrase();
            HttpEntity entity = response.getEntity();

            if (entity == null || entity.getContentLength() == 0 || statusCode == 0) {
                throw new CustomException(BS_TIMEOUT_ERROR);
            }

            // Convert entity to String
            String responseBody = EntityUtils.toString(entity);
            log.info(String.format(HTTP_RESPONSE_LOG_TEMPLATE, statusCode, httpStatusMsg, responseBody));

            // Handle non-200 responses explicitly
            if (statusCode != 200 && statusCode != 201) {
                // Try to extract Thunes error message if available
                String errorMessage = extractThunesErrorMessage(responseBody);

                // If no readable message, use generic fallback
                if (errorMessage == null || errorMessage.isBlank()) {
                    errorMessage = String.format("Calling Thunes - %s returned a failure status. Status code: %d", type, statusCode);
                }
                throw new CustomException(errorMessage);
            }

            // Return valid body for 200 OK
            return responseBody;

        } catch (Exception e) {
            // Wrap all exceptions in a CustomException for uniform handling
            throw new CustomException(String.format("%s", e.getMessage()));
        }
    }


    // Extracts the first error message from a Thunes JSON error response.
    // Example input: {"errors":[{"code":"1003010","message":"Destination currency not offered by payer"}]}
    private String extractThunesErrorMessage(String responseBody) {
        try {
            JsonObject json = JsonParser.parseString(responseBody).getAsJsonObject();

            // Defensive check if "errors" exists and is an array
            if (json.has("errors") && json.get("errors").isJsonArray()) {
                JsonArray errors = json.getAsJsonArray("errors");
                if (!errors.isEmpty()) {
                    JsonObject firstError = errors.get(0).getAsJsonObject();
                    if (firstError.has("message")) {
                        return firstError.get("message").getAsString();
                    }
                }
            }
        } catch (Exception e) {
            // ignore parse failures and fallback to generic
            log.warn("Failed to parse Thunes error message from response body: {}", e.getMessage());
        }
        return null; // fallback handled by caller
    }


    private HttpGet getRequestHeaders(String rrn, String baseUrl, Object object, String telco, String type) throws CustomException {
        String url = getFullUrl(baseUrl, object, type);
        HttpGet httpGet = new HttpGet(url);

        // Always accept any type
        httpGet.setHeader("Accept", "*/*");

        // Log message to console
        log.info("{}: Sending {} GET HTTP Request to {} Via: {}", rrn, type, telco, url);

        // TODO: only for dev. Build Basic Auth header with "key:value"
//        String auth = "4a3e8840-2f98-422c-806f-233644488956:85b3e738-d877-4160-a09b-b99ccb9a415e";
//        String encodedAuth = Base64.getEncoder().encodeToString(auth.getBytes(StandardCharsets.UTF_8));
//        httpGet.setHeader("Authorization", "Basic " + encodedAuth);

        return httpGet;
    }

    private HttpPost getPostRequestHeaders(String rrn, String baseUrl, Object requestObject, String telco, String type) throws CustomException, UnsupportedEncodingException {
        String url = baseUrl;
        HttpPost httpPost = new HttpPost(url);
        String requestString = "";

        // Get the body
        if ("thunes-credit-party-information".equalsIgnoreCase(type)) {
            url = getFullUrl(baseUrl, requestObject, type);
            CreditPartyInformation creditPartyInformation = (CreditPartyInformation) requestObject;
            requestString = payloadService.generateThunesCreditPartyInfoRequest(creditPartyInformation);
            log.info("{}: Thunes {} Http Request Body: \n{}", rrn, type, requestString);

        } else if ("thunes-credit-party-verify".equalsIgnoreCase(type)) {
            url = getFullUrl(baseUrl, requestObject, type);
            CreditPartyVerify creditPartyVerify = (CreditPartyVerify) requestObject;
            requestString = payloadService.generateThunesCreditPartyVerifyRequest(creditPartyVerify);
            log.info("{}: Thunes {} Http Request Body: \n{}", rrn, type, requestString);

        } else if ("thunes-create-quote".equalsIgnoreCase(type)) {
            CreateQuoteDto createQuoteDto = (CreateQuoteDto) requestObject;
            requestString = payloadService.generateThunesCreateQuoteRequest(createQuoteDto);
            log.info("{}: Thunes {} Http Request Body: \n{}", rrn, type, requestString);

        } else if ("thunes-send-transaction".equalsIgnoreCase(type)) {
            // Process transaction request differently - using a separate class

            TransactionRequestDto transactionRequestDto = (TransactionRequestDto) requestObject;
//            requestString = payloadService.generateThunesTransactionRequest(transactionRequestDto);
            log.info("{}: Thunes {} Http Request Body: \n{}", rrn, type, requestString);

        } else if ("wendi-b2c-namecheck".equalsIgnoreCase(type)) {
            NamecheckRequest namecheckRequest = (NamecheckRequest) requestObject;
            requestString = payloadService.generateWendiB2CNamecheckRequest(namecheckRequest);
            log.info("{}: {} Http Request Body: \n{}", rrn, type, requestString);

        }

        httpPost.setHeader("Content-Type", "application/json");
        httpPost.setHeader("Accept", "application/json");
        ;
        httpPost.setEntity(new StringEntity(requestString));

        // Log message to console
        log.info("{}: Sending {} POST HTTP Request to {} Via: {}", rrn, type, telco, url);

        // TODO: only for dev. Build Basic Auth header with "key:value"
//        String auth = "4a3e8840-2f98-422c-806f-233644488956:85b3e738-d877-4160-a09b-b99ccb9a415e";
//        String encodedAuth = Base64.getEncoder().encodeToString(auth.getBytes(StandardCharsets.UTF_8));
//        httpPost.setHeader("Authorization", "Basic " + encodedAuth);

        return httpPost;
    }

    private String getFullUrl(String baseUrl, Object object, String type) throws CustomException {
        if (type == null) {
            throw new CustomException("Type cannot be null");
        }

        switch (type.toLowerCase()) {
            case "thunes-list-of-countries":
                return baseUrl;
            case "thunes-list-of-services": {
                if (!(object instanceof ListOfThunesServices listOfThunesServices)) {
                    throw new CustomException("Invalid object for thunes-list-of-services");
                }
                String countryCode = listOfThunesServices.getReceiver().getCountryCode();
                return baseUrl + "?country_iso_code=" + countryCode;
            }
            case "thunes-payer_rates": {
                if (!(object instanceof PayerRates payerRates)) {
                    throw new CustomException("Invalid object for thunes-payer_rates");
                }
                return baseUrl + payerRates.getReceiver().getPayerId() + "/rates";
            }
            case "thunes-payer_details": {
                if (!(object instanceof PayerDetails payerDetails)) {
                    throw new CustomException("Invalid object for thunes-payer_details");
                }
                return baseUrl + payerDetails.getReceiver().getPayerId();
            }
            case "thunes-bic-lookup": {
                if (!(object instanceof BicLookup bicLookup)) {
                    throw new CustomException("Invalid object for thunes-bic-lookup");
                }
                return baseUrl + bicLookup.getReceiver().getBic();
            }
            case "thunes-credit-party-verify": {
                if (!(object instanceof CreditPartyVerify creditPartyVerify)) {
                    throw new CustomException("Invalid object for thunes-credit-party-verify");
                }
                return baseUrl + creditPartyVerify.getReceiver().getPayerId() + "/" +
                        creditPartyVerify.getReceiver().getTransactionType() + "/credit-party-verification";
            }
            case "thunes-credit-party-information": {
                if (!(object instanceof CreditPartyInformation creditPartyInformation)) {
                    throw new CustomException("Invalid object for thunes-credit-party-information");
                }
                return baseUrl + creditPartyInformation.getReceiver().getPayerId() + "/" +
                        creditPartyInformation.getReceiver().getTransactionType() + "/credit-party-information";
            }
            case "thunes-get-payers": {
                if (!(object instanceof ThunesPayers thunesPayers)) {
                    throw new CustomException("Invalid object for thunes-get-payers");
                }
                String currency = thunesPayers.getReceiver().getCurrency();
                String serviceId = thunesPayers.getReceiver().getServiceId();
                String countryCode = thunesPayers.getReceiver().getCountryCode();

                // Case a: serviceId + countryCode + currency
                if (isNotBlank(serviceId) && isNotBlank(countryCode) && isNotBlank(currency)) {
                    return String.format("%s?service_id=%s&country_iso_code=%s&currency=%s&per_page=%s", baseUrl, serviceId, countryCode, currency, PER_PAGE);
                }

                // Case b: countryCode + currency
                else if (isNotBlank(countryCode) && isNotBlank(currency)) {
                    return String.format("%s?country_iso_code=%s&currency=%s&per_page=%s", baseUrl, countryCode, currency, PER_PAGE);
                }

                // Case c: serviceId + countryCode
                else if (isNotBlank(serviceId) && isNotBlank(countryCode)) {
                    return String.format("%s?service_id=%s&country_iso_code=%s&per_page=%s", baseUrl, serviceId, countryCode, PER_PAGE);
                }

                // Case d: countryCode
                else if (isNotBlank(countryCode)) {
                    return String.format("%s?country_iso_code=%s&per_page=%s", baseUrl, countryCode, PER_PAGE);
                }

                // Case e: none provided. Return all payers
                else {
                    return baseUrl + "?per_page=" + PER_PAGE;
                }
            }
            default:
                throw new CustomException(DEFAULT_PROCESSING_FAILURE + "Unsupported type: " + type);
        }
    }

    private boolean isNotBlank(String value) {
        return value != null && !value.trim().isEmpty();
    }
}
