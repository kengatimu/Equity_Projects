package com.bishop.papss_channel_mock_service.service.impl;

import com.bishop.papss_channel_mock_service.dto.channelResponse.ChannelResponse;
import com.bishop.papss_channel_mock_service.exception.CustomException;
import com.bishop.papss_channel_mock_service.service.HttpResponseProcessorService;
import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.io.IOException;

import static com.bishop.papss_channel_mock_service.config.ApplicationConstants.*;

@Service
public class HttpResponseProcessorServiceImpl implements HttpResponseProcessorService {
    private static final Logger log = LoggerFactory.getLogger(HttpResponseProcessorServiceImpl.class);

    private final Gson gson;

    public HttpResponseProcessorServiceImpl(Gson gson) {
        this.gson = gson;
    }

    @Override
    public ChannelResponse processNamecheckResponse(CloseableHttpResponse response) throws CustomException {
        return processCommonResponse(response);
    }

    @Override
    public ChannelResponse processTransactionResponse(CloseableHttpResponse response) throws CustomException {
        return processCommonResponse(response);
    }

    @Override
    public ChannelResponse processStatusCheckResponse(CloseableHttpResponse response) throws CustomException {
        return processCommonResponse(response);
    }

    private ChannelResponse processCommonResponse(CloseableHttpResponse response) throws CustomException {
        try {
            HttpEntity entity = response.getEntity();
            int statusCode = response.getStatusLine().getStatusCode();
            String httpStatusMsg = response.getStatusLine().getReasonPhrase();

            if (entity == null || entity.getContentLength() == 0 || statusCode == 0) {
                throw new CustomException(TIMEOUT_ERROR);
            }

            String responseJsonString = EntityUtils.toString(entity);
            log.info(String.format(HTTP_RESPONSE_LOG_TEMPLATE, statusCode, httpStatusMsg, responseJsonString));

            return gson.fromJson(responseJsonString, ChannelResponse.class);

        } catch (JsonSyntaxException | IOException e) {
            log.error("Exception occurred while processing HTTP response: "+ e.getMessage());
            throw new CustomException(DEFAULT_PROCESSING_FAILURE + e.getMessage());
        } catch (Exception e) {
            log.error("Unexpected exception occurred: " + e.getMessage());
            throw new CustomException(DEFAULT_PROCESSING_FAILURE + e.getMessage());
        }
    }
}
