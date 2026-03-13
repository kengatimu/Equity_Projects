
package com.equitybank.gag.papss.its.pojo.channelResponse;

import java.io.Serializable;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "rrn",
    "ipsStatusInfo",
    "receiver",
    "channelStatusInfo"
})
public class ChannelResponse implements Serializable {
    private final static long serialVersionUID = 5925085769294697638L;

    @JsonProperty("rrn")
    private String rrn;

    @JsonProperty("ipsStatusInfo")
    private IpsStatusInfo ipsStatusInfo;

    @JsonProperty("receiver")
    private Receiver receiver;

    @JsonProperty("channelStatusInfo")
    private ChannelStatusInfo channelStatusInfo;

    @JsonProperty("rrn")
    public String getRrn() {
        return rrn;
    }

    @JsonProperty("rrn")
    public void setRrn(String rrn) {
        this.rrn = rrn;
    }

    @JsonProperty("ipsStatusInfo")
    public IpsStatusInfo getIpsStatusInfo() {
        return ipsStatusInfo;
    }

    @JsonProperty("ipsStatusInfo")
    public void setIpsStatusInfo(IpsStatusInfo ipsStatusInfo) {
        this.ipsStatusInfo = ipsStatusInfo;
    }

    @JsonProperty("receiver")
    public Receiver getReceiver() {
        return receiver;
    }

    @JsonProperty("receiver")
    public void setReceiver(Receiver receiver) {
        this.receiver = receiver;
    }

    @JsonProperty("channelStatusInfo")
    public ChannelStatusInfo getChannelStatusInfo() {
        return channelStatusInfo;
    }

    @JsonProperty("channelStatusInfo")
    public void setChannelStatusInfo(ChannelStatusInfo channelStatusInfo) {
        this.channelStatusInfo = channelStatusInfo;
    }

}
