package com.equitybank.gag.telco_b2c.dto.thunes.response;

import com.google.gson.JsonElement;

import java.io.Serializable;

public class ChannelResponse implements Serializable {
    private final static long serialVersionUID = 1L;

    private JsonElement rawResponse; // holds raw IMT/Wallet JSON (object or array)
    private ChannelStatusInfo channelStatusInfo;

    public JsonElement getRawResponse() {
        return rawResponse;
    }

    public void setRawResponse(JsonElement rawResponse) {
        this.rawResponse = rawResponse;
    }

    public ChannelStatusInfo getChannelStatusInfo() {
        return channelStatusInfo;
    }

    public void setChannelStatusInfo(ChannelStatusInfo channelStatusInfo) {
        this.channelStatusInfo = channelStatusInfo;
    }
}

