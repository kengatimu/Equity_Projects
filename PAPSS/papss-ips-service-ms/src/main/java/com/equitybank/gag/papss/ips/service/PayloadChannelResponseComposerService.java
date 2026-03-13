package com.equitybank.gag.papss.ips.service;

import com.equitybank.gag.papss.ips.pojo.channelResponse.ChannelResponse;

import java.util.Map;

public interface PayloadChannelResponseComposerService {
    ChannelResponse composeNamecheckResponse(String rrn, Map<String, String> resultMap, String type);

    ChannelResponse composeTransactionResponse(String rrn, Map<String, String> resultMap, String type);

    ChannelResponse composeStatusCheckResponse(String rrn, Map<String, String> resultMap, String type);
}
