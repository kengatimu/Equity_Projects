package com.equitybank.gag.papss.its.service;

import com.equitybank.gag.papss.its.exception.CustomException;
import com.equitybank.gag.papss.its.pojo.channelResponse.ChannelResponse;
import org.apache.http.client.methods.CloseableHttpResponse;

public interface HttpResponseProcessorService {
    ChannelResponse processNamecheckResponse(String rrn, CloseableHttpResponse response, String type) throws CustomException;

    ChannelResponse processTransactionResponse(String rrn, CloseableHttpResponse response, String type) throws CustomException;

    ChannelResponse processStatusCheckResponse(String rrn, CloseableHttpResponse response, String type) throws CustomException;
}
