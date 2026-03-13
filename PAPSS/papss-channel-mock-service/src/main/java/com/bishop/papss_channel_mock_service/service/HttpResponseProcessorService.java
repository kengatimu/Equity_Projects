package com.bishop.papss_channel_mock_service.service;

import com.bishop.papss_channel_mock_service.dto.channelResponse.ChannelResponse;
import com.bishop.papss_channel_mock_service.exception.CustomException;
import org.apache.http.client.methods.CloseableHttpResponse;

public interface HttpResponseProcessorService {
    ChannelResponse processNamecheckResponse(CloseableHttpResponse response) throws CustomException;

    ChannelResponse processTransactionResponse(CloseableHttpResponse response) throws CustomException;

    ChannelResponse processStatusCheckResponse(CloseableHttpResponse response) throws CustomException;
}
