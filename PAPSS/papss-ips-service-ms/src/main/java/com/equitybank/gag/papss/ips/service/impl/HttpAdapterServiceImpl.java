package com.equitybank.gag.papss.ips.service.impl;

import com.equitybank.gag.papss.ips.service.HttpAdapterService;
import com.equitybank.gag.papss.ips.enums.TransactionType;
import com.equitybank.gag.papss.ips.exception.CustomException;
import com.equitybank.gag.papss.ips.pojo.channelResponse.ChannelResponse;
import com.equitybank.gag.papss.ips.service.HttpResponseProcessorService;
import com.google.gson.Gson;
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

import static com.equitybank.gag.papss.ips.config.ApplicationConstants.HTTP_RESPONSE_LOG_TEMPLATE;
import static com.equitybank.gag.papss.ips.config.StatusCodeMessages.*;

@Service
public class HttpAdapterServiceImpl implements HttpAdapterService {
    private static final Logger log = LoggerFactory.getLogger(HttpAdapterServiceImpl.class);

    private final Gson gson;
    private final String namecheckUrl;
    private final String transactionUrl;
    private final String statusCheckUrl;
    private final CloseableHttpClient closeableHttpClientForCallback;
    private final HttpResponseProcessorService httpResponseProcessorService;

    @Autowired
    public HttpAdapterServiceImpl(Gson gson,
                                  @Value("${equity.urls.namecheck}") String namecheckUrl,
                                  @Value("${equity.urls.transaction}") String transactionUrl,
                                  @Value("${equity.urls.status-check}") String statusCheckUrl,
                                  @Qualifier("closeableHttpClient") CloseableHttpClient closeableHttpClientForCallback,
                                  HttpResponseProcessorService httpResponseProcessorService) {
        this.gson = gson;
        this.namecheckUrl = namecheckUrl;
        this.transactionUrl = transactionUrl;
        this.statusCheckUrl = statusCheckUrl;
        this.closeableHttpClientForCallback = closeableHttpClientForCallback;
        this.httpResponseProcessorService = httpResponseProcessorService;
    }

    @Override
    public ChannelResponse sendHttpNamecheckRequest(String rrn, String signedAcmt023XmlReq, String type) throws CustomException {
        return sendHttpRequest(rrn, signedAcmt023XmlReq, type, namecheckUrl, "SendHttpNamecheckRequest");
    }

    @Override
    public ChannelResponse sendHttpTransactionRequest(String rrn, String signedPacs008XmlReq, String type) throws CustomException {
        return sendHttpRequest(rrn, signedPacs008XmlReq, type, transactionUrl, "SendHttpTransactionRequest");
    }

    @Override
    public void sendHttpChannelCallbackResponse(String rrn, String channelCallbackUrl, ChannelResponse channelResponse) throws CustomException {
        sendCallbackHttpRequest(rrn, channelCallbackUrl, channelResponse);
    }

    @Override
    public ChannelResponse sendHttpStatusCheckRequest(String rrn, String signedPacs028XmlReq, String type) throws CustomException {
        return sendHttpRequest(rrn, signedPacs028XmlReq, type, statusCheckUrl, "sendHttpStatusCheckRequest");
    }

    private ChannelResponse sendHttpRequest(String rrn, String signedXml, String type, String url, String logPrefix) throws CustomException {
        CloseableHttpResponse response = null;
        try {
            HttpPost httpPost = getPostRequestHeaders(url, new StringEntity(signedXml));
            log.info("{}: Sending {} Post HTTP Request to Papss Via: {}", rrn, type, url);
            response = closeableHttpClientForCallback.execute(httpPost);

            switch (type.toUpperCase()) {
                case "NAMECHECK":
                    return httpResponseProcessorService.processNamecheckResponse(rrn, response, type);
                case "CREDIT_TRANSFER":
                    return httpResponseProcessorService.processTransactionResponse(rrn, response, type);
                case "STATUS_CHECK":
                    return httpResponseProcessorService.processStatusCheckResponse(rrn, response, type);
                default:
                    log.warn("{}: Unknown transaction type received: {}", rrn, type);
                    throw new CustomException(DEFAULT_ERROR + "Unsupported transaction type. " + type);
            }

        } catch (CustomException | IOException e) {
            log.error("{}: Exception Occurred on {} Method: {}", rrn, logPrefix, e.getMessage());

            String errorDescription = e.getMessage();
            if (errorDescription != null && (
                    errorDescription.contains("timeout")
                            || errorDescription.contains("time out")
                            || errorDescription.contains("timed out"))) {
                throw new CustomException(EQUITY_TIMEOUT_ERROR + e.getMessage());
            }
            throw new CustomException(HTTP_ERROR + e.getMessage());
        } finally {
            closeQuietly(rrn, response);
        }
    }

    private void sendCallbackHttpRequest(String rrn, String channelCallbackUrl, ChannelResponse channelResponse) throws CustomException {
        CloseableHttpResponse response = null;
        try {
            HttpPost httpPost = getPostRequestHeaders(channelCallbackUrl, new StringEntity(gson.toJson(channelResponse)));
            log.info("{}: Generated Channel Callback Response {}", rrn, gson.toJson(channelResponse));
            log.info("{}: Sending {} Post HTTP Response to Channel Via: {}", rrn, TransactionType.CREDIT_TRANSFER_CALLBACK, channelCallbackUrl);
            response = closeableHttpClientForCallback.execute(httpPost);

            HttpEntity entity = response.getEntity();
            int statusCode = response.getStatusLine().getStatusCode();
            String httpStatusMsg = response.getStatusLine().getReasonPhrase();

            if (entity == null || entity.getContentLength() == 0 || statusCode == 0) {
                throw new CustomException(CHANNEL_TIMEOUT_ERROR);
            }

            String channelResponseString = EntityUtils.toString(entity);
            log.info(String.format(HTTP_RESPONSE_LOG_TEMPLATE, statusCode, httpStatusMsg, channelResponseString));

        } catch (CustomException | IOException e) {
            log.error("{}: Exception Occurred on {} Method: {}", rrn, "sendCallbackHttpRequest", e.getMessage());

            String errorDescription = e.getMessage();
            if (errorDescription != null && (
                    errorDescription.contains("timeout")
                            || errorDescription.contains("time out")
                            || errorDescription.contains("timed out"))) {
                throw new CustomException(CHANNEL_TIMEOUT_ERROR + e.getMessage());
            }
            throw new CustomException(HTTP_ERROR + e.getMessage());
        } finally {
            closeQuietly(rrn, response);
        }
    }

    private HttpPost getPostRequestHeaders(String url, StringEntity stringEntity) {
        HttpPost httpPost = new HttpPost(url);
        httpPost.setEntity(stringEntity);
        httpPost.setHeader("Content-Type", MediaType.APPLICATION_XML_VALUE);
        return httpPost;
    }


    private void closeQuietly(String rrn, CloseableHttpResponse response) {
        if (response != null) {
            try {
                response.close();
            } catch (IOException e) {
                log.error("{}: Failed to close CloseableHttpResponse: {}", rrn, e.getMessage());
            }
        }
    }
}
