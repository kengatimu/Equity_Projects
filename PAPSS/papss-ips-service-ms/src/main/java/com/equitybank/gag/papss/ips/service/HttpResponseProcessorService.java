package com.equitybank.gag.papss.ips.service;

import com.equitybank.gag.papss.ips.exception.CustomException;
import com.equitybank.gag.papss.ips.pojo.channelResponse.ChannelResponse;
import org.apache.http.client.methods.CloseableHttpResponse;

public interface HttpResponseProcessorService {
    ChannelResponse processNamecheckResponse(String rrn, CloseableHttpResponse response, String type) throws CustomException;

    ChannelResponse processTransactionResponse(String rrn, CloseableHttpResponse response, String type) throws CustomException;

    ChannelResponse processStatusCheckResponse(String rrn, CloseableHttpResponse response, String type) throws CustomException;
}
