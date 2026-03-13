package com.equitybank.gag.papss.ots.service.impl;

import com.equitybank.gag.papss.ots.dto.channelRequest.fxRate.GetFxRateReq;
import com.equitybank.gag.papss.ots.dto.channelRequest.getParticipants.GetPapssParticipantsReq;
import com.equitybank.gag.papss.ots.enums.TransactionType;
import com.equitybank.gag.papss.ots.exception.CustomException;
import com.equitybank.gag.papss.ots.dto.channelResponse.ChannelResponse;
import com.equitybank.gag.papss.ots.jpos.space.configs.JposConstants;
import com.equitybank.gag.papss.ots.service.HttpAdapterService;
import com.google.gson.Gson;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.util.EntityUtils;
import org.jpos.transaction.Context;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import static com.equitybank.gag.papss.ots.config.ApplicationConstants.HTTP_RESPONSE_LOG_TEMPLATE;
import static com.equitybank.gag.papss.ots.config.ApplicationConstants.*;

@Service
public class HttpAdapterServiceImpl implements HttpAdapterService {
    private static final Logger log = LoggerFactory.getLogger(HttpAdapterServiceImpl.class);

    private final Gson gson;
    private final String papssId;
    private final String commonUrl;
    private final String fxRateBaseUrl;
    private final String participantsBaseUrl;
    private final CloseableHttpClient closeableHttpClient;

    @Autowired
    public HttpAdapterServiceImpl(Gson gson,
                                  @Value("${papss.equity-bank-id}") String papssId,
                                  @Value("${service.urls.common-url}") String commonUrl,
                                  @Value("${service.urls.fx-rate-base-url}") String fxRateBaseUrl,
                                  @Value("${service.urls.participants-base-url}") String participantsBaseUrl,
                                  @Qualifier("closeableHttpClient") CloseableHttpClient closeableHttpClient) {
        this.gson = gson;
        this.papssId = papssId;
        this.commonUrl = commonUrl;
        this.fxRateBaseUrl = fxRateBaseUrl;
        this.participantsBaseUrl = participantsBaseUrl;
        this.closeableHttpClient = closeableHttpClient;
    }

    @Override
    public String sendHttpGetParticipants(String rrn, GetPapssParticipantsReq getPapssParticipantsReq) throws CustomException {
        return sendGetParticipants(rrn, getPapssParticipantsReq);
    }

    @Override
    public String sendHttpFxRateRequest(String rrn, GetFxRateReq getFxRateReq) throws CustomException {
        return sendGetFxRateHttpRequest(rrn, getFxRateReq);
    }

    @Override
    public String sendHttpNamecheckRequest(String rrn, String signedAcmt023XmlReq, String type) throws CustomException {
        return sendHttpRequest(new Context(), rrn, signedAcmt023XmlReq, type, commonUrl, "SendHttpNamecheckRequest");
    }

    @Override
    public String sendHttpTransactionRequest(Context ctx, String rrn, String signedPacs008XmlReq, String type) throws CustomException {
        return sendHttpRequest(ctx, rrn, signedPacs008XmlReq, type, commonUrl, "SendHttpTransactionRequest");
    }

    @Override
    public void sendHttpChannelCallbackResponse(String rrn, String channelCallbackUrl, ChannelResponse channelResponse) throws CustomException {
        sendCallbackHttpRequest(rrn, channelCallbackUrl, channelResponse);
    }

    @Override
    public String sendHttpStatusCheckRequest(String rrn, String signedPacs028XmlReq, String type) throws CustomException {
        return sendHttpRequest(new Context(), rrn, signedPacs028XmlReq, type, commonUrl, "sendHttpStatusCheckRequest");
    }

    private String sendGetParticipants(String rrn, GetPapssParticipantsReq getPapssParticipantsReq) throws CustomException {
        try {
            String bic = getPapssParticipantsReq.getReceiver().getBic();
            String countryCode = getPapssParticipantsReq.getReceiver().getCountryCode();

            // Start with base URL
            StringBuilder urlBuilder = new StringBuilder(participantsBaseUrl);
//            urlBuilder.append("?online=true&type=BANK");
            urlBuilder.append("?online=true");

            if (bic != null && !bic.trim().isEmpty()) {
                urlBuilder.append("&bic=").append(URLEncoder.encode(bic, StandardCharsets.UTF_8));
            }
            if (countryCode != null && !countryCode.trim().isEmpty()) {
                urlBuilder.append("&countryCode=").append(URLEncoder.encode(countryCode, StandardCharsets.UTF_8));
            }

            // Compose full Url
            String fullUrl = urlBuilder.toString();

            // Compose header values
            HttpGet request = new HttpGet(fullUrl);
            request.setHeader("X-PAPSSRTP-Channel", papssId);
            request.setHeader("X-PAPSS-RTP-Version", PAPSS_RTP_VERSION);

            log.info("{}: Calling PAPSS Get Participants URL: {}", rrn, fullUrl);

            try (CloseableHttpResponse response = closeableHttpClient.execute(request)) {
                HttpEntity entity = response.getEntity();
                int statusCode = response.getStatusLine().getStatusCode();
                String httpStatusMsg = response.getStatusLine().getReasonPhrase();

                logStatusAndUpdateJposContext(new Context(), response, statusCode, httpStatusMsg, TransactionType.GET_PARTICIPANT.name());

                if (statusCode == 0) {
                    throw new CustomException(PAPSS_TIMEOUT_ERROR);
                }

                if (entity == null || entity.getContentLength() == 0) {
                    log.error("{}: An empty response was returned from Http call", rrn);
                    throw new CustomException(PAPSS_DEFAULT_ERROR);
                }

                String responseString = EntityUtils.toString(entity);
                log.info(String.format(HTTP_RESPONSE_LOG_TEMPLATE, statusCode, httpStatusMsg, responseString));

                if (statusCode != 200) {
                    throw new CustomException("Calling PAPSS Get Participants returned a Non-200 response: " + statusCode);
                }

                return responseString.replaceAll("&", "and");

            }
        } catch (Exception e) {
            handleHttpException(rrn, "sendGetParticipants", e);
            return ""; // unreachable line
        }
    }

    private String sendGetFxRateHttpRequest(String rrn, GetFxRateReq getFxRateReq) throws CustomException {

        try {
            // Determine the right instrument code
            String instrumentCode = DEFAULT_LOCAL_INSTRUMENT_CODE;
            String senderCurrency = getFxRateReq.getSender().getCurrency();
            String receiverCurrency = getFxRateReq.getReceiver().getCurrency();
            if ("USD".equalsIgnoreCase(senderCurrency) || "USD".equalsIgnoreCase(receiverCurrency)) {
                instrumentCode = DEFAULT_USD_INSTRUMENT_CODE;
            }

            // Extract isInvoice (validated as "true"/"false")
            String isInvoice = getFxRateReq.getSender().getIsInvoice();

            // Construct the full URL with encoded query params
            StringBuilder urlBuilder = new StringBuilder();
            urlBuilder.append(fxRateBaseUrl).append("?")
                    .append("SenderCountry=").append(URLEncoder.encode(getFxRateReq.getSender().getCountryCode(), StandardCharsets.UTF_8)).append("&")
                    .append("SenderCurrency=").append(URLEncoder.encode(getFxRateReq.getSender().getCurrency(), StandardCharsets.UTF_8)).append("&")
                    .append("ReceiverCountry=").append(URLEncoder.encode(getFxRateReq.getReceiver().getCountryCode(), StandardCharsets.UTF_8)).append("&")
                    .append("ReceiverCurrency=").append(URLEncoder.encode(getFxRateReq.getReceiver().getCurrency(), StandardCharsets.UTF_8)).append("&")
                    .append("ReceiverBank=").append(URLEncoder.encode(getFxRateReq.getReceiver().getInstitutionId(), StandardCharsets.UTF_8)).append("&")
                    .append("LclInstrm=").append(URLEncoder.encode(instrumentCode, StandardCharsets.UTF_8)).append("&")
                    .append("amount=").append(URLEncoder.encode(getFxRateReq.getSender().getAmount(), StandardCharsets.UTF_8)).append("&")
                    .append("isInvoice=").append(URLEncoder.encode(isInvoice, StandardCharsets.UTF_8));

            // When isInvoice = true → PAPSS requires invoiceCurrency = CURR
            if ("true".equalsIgnoreCase(isInvoice)) {
                urlBuilder.append("&invoiceCurrency=CURR");
            }

            String url = urlBuilder.toString();

            HttpGet request = new HttpGet(url);
            request.setHeader("X-PAPSSRTP-Channel", papssId);
            request.setHeader("X-PAPSS-RTP-Version", PAPSS_RTP_VERSION);

            log.info("{}: Sending FX Rate GET request to PAPSS via Url: {}", rrn, url);

            try (CloseableHttpResponse response = closeableHttpClient.execute(request)) {
                HttpEntity entity = response.getEntity();
                int statusCode = response.getStatusLine().getStatusCode();
                String httpStatusMsg = response.getStatusLine().getReasonPhrase();

                logStatusAndUpdateJposContext(new Context(), response, statusCode, httpStatusMsg, TransactionType.GET_FX_RATE.name());

                if (statusCode == 0) {
                    throw new CustomException(PAPSS_TIMEOUT_ERROR);
                }

                if (entity == null || entity.getContentLength() == 0) {
                    log.error("{}: An empty response was returned from Http call", rrn);
                    throw new CustomException(PAPSS_DEFAULT_ERROR);
                }

                String responseString = EntityUtils.toString(entity);
                log.info(String.format(HTTP_RESPONSE_LOG_TEMPLATE, statusCode, httpStatusMsg, responseString));

                if (statusCode != 200) {
                    throw new CustomException("Calling PAPSS Get Fx Rate returned a Non-200 status code");
                }

                return responseString;
            }
        } catch (Exception e) {
            handleHttpException(rrn, "SendHttpGetFxRateRequest", e);
            return null; // unreachable line
        }
    }

    private String sendHttpRequest(Context ctx, String rrn, String signedXml, String type, String url, String logPrefix) throws CustomException {
        // Prepare the HTTP POST request with XML body
        HttpPost httpPost = getPostRequestHeaders(url, new StringEntity(signedXml, StandardCharsets.UTF_8));
        log.info("{}: Sending {} Post HTTP Request to Papss Via: {}", rrn, type, url);
        log.info("{}: Transaction Post Body: {}", rrn, signedXml);

        // Automatically close the response resource after use
        try (CloseableHttpResponse response = closeableHttpClient.execute(httpPost)) {

            if (response != null) {
                HttpEntity entity = response.getEntity();
                int statusCode = response.getStatusLine().getStatusCode();
                String httpStatusMsg = response.getStatusLine().getReasonPhrase();

                logStatusAndUpdateJposContext(ctx, response, statusCode, httpStatusMsg, type);

                if (statusCode == 0) {
                    throw new CustomException(PAPSS_TIMEOUT_ERROR);
                }

                if (entity == null || entity.getContentLength() == 0) {
                    log.error("{}: An empty response was returned from Http call", rrn);
                    throw new CustomException(PAPSS_DEFAULT_ERROR);
                }

                if (statusCode != 200) {
                    log.error("{}: Papss returned an error status. StatusCode: {}", rrn, statusCode);
                    throw new CustomException(PAPSS_DEFAULT_ERROR);
                }

                String responseXmlString = EntityUtils.toString(entity);
                log.info(String.format(HTTP_RESPONSE_LOG_TEMPLATE, statusCode, httpStatusMsg, responseXmlString));
                return responseXmlString;
            }
            log.error("{}: Did not receive HTTP response: {}", rrn, type);
            throw new CustomException(PAPSS_TIMEOUT_ERROR + "Did not receive HTTP response");
        } catch (Exception e) {
            handleHttpException(rrn, logPrefix, e);
            return null; // unreachable line
        }
    }

    private void sendCallbackHttpRequest(String rrn, String channelCallbackUrl, ChannelResponse channelResponse) throws CustomException {
        try {
            // Convert response object to JSON
            String jsonPayload = gson.toJson(channelResponse);

            // Prepare HTTP POST request with JSON body
            HttpPost httpPost = getPostRequestHeaders(channelCallbackUrl, new StringEntity(jsonPayload, StandardCharsets.UTF_8));

            log.info("{}: Generated Channel Callback Response {}", rrn, jsonPayload);
            log.info("{}: Sending {} Post HTTP Response to Channel Via: {}", rrn, TransactionType.CREDIT_TRANSFER_CALLBACK, channelCallbackUrl);

            try (CloseableHttpResponse response = closeableHttpClient.execute(httpPost)) {
                HttpEntity entity = response.getEntity();
                int statusCode = response.getStatusLine().getStatusCode();
                String httpStatusMsg = response.getStatusLine().getReasonPhrase();

                // Timeout-like case: either no entity OR bad status
                if (entity == null || statusCode == 0) {
                    throw new CustomException(CHANNEL_TIMEOUT_ERROR);
                }

                // Extract body safely
                String channelResponseString = EntityUtils.toString(entity);

                // Fail if status code is not in 2xx range
                if (statusCode < 200 || statusCode >= 300) {
                    String errorMessage = String.format("Channel callback failed. HTTP %d %s. Response: %s", statusCode, httpStatusMsg, channelResponseString);
                    log.error("{}: {}", rrn, errorMessage);
                    throw new CustomException(errorMessage);
                }

                // Log successful callback
                log.info(String.format(HTTP_RESPONSE_LOG_TEMPLATE, statusCode, httpStatusMsg, channelResponseString));
            }

        } catch (Exception e) {
            log.error("{}: Exception occurred when sending callback to channel: {}", rrn, e.getMessage());
        }
    }

    private void logStatusAndUpdateJposContext(Context ctx, CloseableHttpResponse response, int statusCode, String httpStatusMsg, String type) {
        // Log basic HTTP response details
        log.info("Response Entity: {}", response.getEntity());
        log.info("statusCode: {}", statusCode);
        log.info("httpStatusMsg: {}", httpStatusMsg);

        // Extract and log all response headers
        Header[] headers = response.getAllHeaders();
        if (headers != null && headers.length > 0) {
            StringBuilder headerLog = new StringBuilder("HTTP Response Headers:\n");
            String reqStsValue = null; // Will hold the X-PAPSSRTP-ReqSts value if found

            for (Header header : headers) {
                headerLog.append("   ").append(header.getName()).append(": ").append(header.getValue()).append("\n");

                // Capture the PAPSS RTP status header (e.g., RJCT/1013)
                if ("X-PAPSSRTP-ReqSts".equalsIgnoreCase(header.getName())) {
                    reqStsValue = header.getValue();
                }
            }

            // Print all headers to logs
            log.info(headerLog.toString().trim());

            // Only update the jPOS context for CREDIT_TRANSFER transactions
            if (TransactionType.CREDIT_TRANSFER.name().equalsIgnoreCase(type)) {
                if (reqStsValue != null && !reqStsValue.isBlank()) {
                    // Split value safely — some headers might only have "RJCT" without a slash
                    String[] parts = reqStsValue.split("/", 2);
                    String statusType = parts.length > 0 ? parts[0].trim() : "";
                    String statusCodePart = parts.length > 1 ? parts[1].trim() : "";

                    // Put extracted values into jPOS context
                    ctx.put(JposConstants.ISO20022_PACS008_STATUS_REASON_CODE, statusCodePart);

                    log.info("Extracted PAPSS status for CREDIT_TRANSFER => type={}, code={}", statusType, statusCodePart);
                } else {
                    // Header missing, blank, or invalid — default both values to empty
                    ctx.put(JposConstants.ISO20022_PACS008_STATUS_REASON_CODE, "");
                    log.info("X-PAPSSRTP-ReqSts header missing or invalid; defaulted to empty values for CREDIT_TRANSFER");
                }
            } else {
                // Skip PAPSS status updates for non-credit-transfer transaction types
                log.debug("Skipping PAPSS status extraction: transaction type is {}", type);
            }

        } else {
            // No headers returned at all
            log.info("HTTP Response Headers: No headers returned");

            // If it's a CREDIT_TRANSFER, still clear the context values
            if (TransactionType.CREDIT_TRANSFER.name().equalsIgnoreCase(type)) {
                ctx.put(JposConstants.ISO20022_PACS008_STATUS_REASON_CODE, "");
            }
        }
    }

    private HttpPost getPostRequestHeaders(String url, StringEntity stringEntity) {
        HttpPost httpPost = new HttpPost(url);
        httpPost.setEntity(stringEntity);
        httpPost.setHeader("Content-Type", MediaType.APPLICATION_XML_VALUE);
        httpPost.setHeader("X-PAPSSRTP-Channel", papssId);
        httpPost.setHeader("X-PAPSS-RTP-Version", PAPSS_RTP_VERSION);
        httpPost.setHeader("Accept", "*/*");
        httpPost.setHeader("Accept-Encoding", "gzip");
        return httpPost;
    }

    private void handleHttpException(String rrn, String method, Exception exception) throws CustomException {
        // Log the error with request reference number and method
        log.error("{}: Exception occurred on {} method: {}", rrn, method, exception.getMessage());

        String message = exception.getMessage();
        if (message == null) {
            throw new CustomException(HTTP_ERROR + "Unknown error");
        }

        // Normalize to lower-case for easier checks
        String lowerMessage = message.toLowerCase();

        // Handle timeout-related errors
        if (lowerMessage.contains("timeout") || lowerMessage.contains("time out") || lowerMessage.contains("timed out")) {
            throw new CustomException(com.equitybank.gag.papss.ots.config.ApplicationConstants.PAPSS_TIMEOUT_ERROR + message);
        }

        // Handle connection refused
        if (lowerMessage.contains("connection refused")) {
            throw new CustomException(CONNECTION_REFUSED_ERROR);
        }

        // Fallback for generic HTTP errors
        throw new CustomException(HTTP_ERROR + message);
    }


}
