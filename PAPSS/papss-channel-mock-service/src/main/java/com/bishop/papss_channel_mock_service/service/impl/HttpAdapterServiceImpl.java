package com.bishop.papss_channel_mock_service.service.impl;

import com.bishop.papss_channel_mock_service.dto.channelRequest.namecheck.ChannelNamecheckDetailsReq;
import com.bishop.papss_channel_mock_service.dto.channelRequest.statusCheck.ChannelStatusCheckDetailsReq;
import com.bishop.papss_channel_mock_service.dto.channelRequest.transaction.ChannelCreditTransferDetailsReq;
import com.bishop.papss_channel_mock_service.dto.channelResponse.ChannelResponse;
import com.bishop.papss_channel_mock_service.exception.CustomException;
import com.bishop.papss_channel_mock_service.service.HttpResponseProcessorService;
import com.bishop.papss_channel_mock_service.service.HttpAdapterService;
import com.google.gson.Gson;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;

import java.io.IOException;

import static com.bishop.papss_channel_mock_service.config.ApplicationConstants.HTTP_ERROR;
import static com.bishop.papss_channel_mock_service.config.ApplicationConstants.TIMEOUT_ERROR;

@Service
public class HttpAdapterServiceImpl implements HttpAdapterService {
    private static final Logger log = LoggerFactory.getLogger(HttpAdapterServiceImpl.class);

    private final Gson gson;
    private final String namecheckUrl;
    private final String transactionUrl;
    private final String statusCheckUrl;
    private final CloseableHttpClient closeableHttpClient;
    private final HttpResponseProcessorService httpResponseProcessorService;

    public HttpAdapterServiceImpl(Gson gson,
                                  @Value("${urls.namecheck:}") String namecheckUrl,
                                  @Value("${urls.transaction:}") String transactionUrl,
                                  @Value("${urls.statusCheck:}") String statusCheckUrl,
                                  @Qualifier("closeableHttpClient") CloseableHttpClient closeableHttpClient,
                                  HttpResponseProcessorService httpResponseProcessorService) {
        this.gson = gson;
        this.namecheckUrl = namecheckUrl;
        this.transactionUrl = transactionUrl;
        this.statusCheckUrl = statusCheckUrl;
        this.closeableHttpClient = closeableHttpClient;
        this.httpResponseProcessorService = httpResponseProcessorService;
    }

    @Override
    public ChannelResponse sendNamecheckRequest(ChannelNamecheckDetailsReq namecheckRequest) throws CustomException {
        String rrn = namecheckRequest.getChannelInfo().getRrn();
        String request = gson.toJson(namecheckRequest);
        log.info("{}: Http Namecheck Request: {}", rrn, request);

        try {
            HttpPost httpPost = getPostRequestHeaders(namecheckUrl, new StringEntity(request));

            log.info("{}: Sending Namecheck Post HTTP Request Via: {}", rrn, namecheckUrl);
            try (CloseableHttpResponse response = closeableHttpClient.execute(httpPost)) {
                return httpResponseProcessorService.processNamecheckResponse(response);
            }
        } catch (CustomException | IOException e) {
            handleHttpException(rrn, e);
            return null; // Exception will be thrown, therefore unreachable
        }
    }

    @Override
    public ChannelResponse sendTransactionRequest(ChannelCreditTransferDetailsReq transactionRequest) throws CustomException {
        String rrn = transactionRequest.getChannelInfo().getRrn();
        String request = gson.toJson(transactionRequest);
        log.info("{}: Http Transaction Request: {}", rrn, request);

        try {
            HttpPost httpPost = getPostRequestHeaders(transactionUrl, new StringEntity(request));

            log.info("{}: Sending Transaction Request Post HTTP Via: {}", rrn, transactionUrl);
            try (CloseableHttpResponse response = closeableHttpClient.execute(httpPost)) {
                return httpResponseProcessorService.processTransactionResponse(response);
            }
        } catch (CustomException | IOException e) {
            handleHttpException(rrn, e);
            return null; // Exception will be thrown, therefore unreachable
        }
    }

    @Override
    public ChannelResponse sendStatusCheckRequest(ChannelStatusCheckDetailsReq statusCheckDetailsReq) throws CustomException {
        String rrn = statusCheckDetailsReq.getChannelInfo().getRrn();
        String request = gson.toJson(statusCheckDetailsReq);
        log.info("{}: Http Status Check Request: {}", rrn, request);

        try {
            HttpPost httpPost = getPostRequestHeaders(statusCheckUrl, new StringEntity(request));

            log.info("{}: Sending Status Check Request Post HTTP Via: {}", rrn, statusCheckUrl);
            try (CloseableHttpResponse response = closeableHttpClient.execute(httpPost)) {
                return httpResponseProcessorService.processStatusCheckResponse(response);
            }
        } catch (CustomException | IOException e) {
            handleHttpException(rrn, e);
            return null; // Exception will be thrown, therefore unreachable
        }
    }

    // Builds a basic HTTP POST request with content-type header
    private HttpPost getPostRequestHeaders(String url, StringEntity stringEntity) {
        HttpPost httpPost = new HttpPost(url);
        httpPost.setEntity(stringEntity);
        httpPost.setHeader("Content-Type", MediaType.APPLICATION_JSON_VALUE);
        return httpPost;
    }

    // Handles exception logic common to both signature and jwt calls
    private void handleHttpException(String rrn, Exception e) throws CustomException {
        log.error("{}: Exception occurred when sending HTTP request: {}", rrn, e.getMessage());

        String errorDescription = e.getMessage();
        if (errorDescription != null &&
                (errorDescription.contains("timeout")
                        || errorDescription.contains("time out")
                        || errorDescription.contains("timed out"))) {
            throw new CustomException(TIMEOUT_ERROR + e.getMessage());
        }
        throw new CustomException(HTTP_ERROR + e.getMessage());
    }
}
