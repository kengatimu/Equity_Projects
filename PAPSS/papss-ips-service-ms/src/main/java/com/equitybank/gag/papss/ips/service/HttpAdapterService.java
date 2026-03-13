package com.equitybank.gag.papss.ips.service;

import com.equitybank.gag.papss.ips.exception.CustomException;
import com.equitybank.gag.papss.ips.pojo.channelResponse.ChannelResponse;

public interface HttpAdapterService {
    ChannelResponse sendHttpNamecheckRequest(String rrn, String signedAcmt023XmlReq, String type) throws CustomException;

    ChannelResponse sendHttpTransactionRequest(String rrn, String signedPacs008XmlReq, String type) throws CustomException;

    void sendHttpChannelCallbackResponse(String rrn, String channelCallbackUrl, ChannelResponse channelResponse) throws CustomException;

    ChannelResponse sendHttpStatusCheckRequest(String rrn, String signedPacs028XmlReq, String type) throws CustomException;
}
