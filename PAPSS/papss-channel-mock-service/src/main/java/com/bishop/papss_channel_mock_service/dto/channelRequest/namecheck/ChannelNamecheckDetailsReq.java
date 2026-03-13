
package com.bishop.papss_channel_mock_service.dto.channelRequest.namecheck;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;

import java.io.Serializable;

@JsonPropertyOrder({
        "sender",
        "receiver",
        "channelInfo",
        "signature"
})

public class ChannelNamecheckDetailsReq implements Serializable {
    private final static long serialVersionUID = -4319514356488698257L;

    @Valid
    @NotNull(message = "Sender information is mandatory")
    @JsonProperty("sender")
    private Sender sender;

    @Valid
    @NotNull(message = "Receiver information is mandatory")
    @JsonProperty("receiver")
    private Receiver receiver;

    @Valid
    @NotNull(message = "Channel information is mandatory")
    @JsonProperty("channelInfo")
    private ChannelInfo channelInfo;

    @JsonProperty("signature")
    private String signature;

    public Sender getSender() {
        return sender;
    }

    public void setSender(Sender sender) {
        this.sender = sender;
    }

    public Receiver getReceiver() {
        return receiver;
    }

    public void setReceiver(Receiver receiver) {
        this.receiver = receiver;
    }

    public ChannelInfo getChannelInfo() {
        return channelInfo;
    }

    public void setChannelInfo(ChannelInfo channelInfo) {
        this.channelInfo = channelInfo;
    }

    public String getSignature() {
        return signature;
    }

    public void setSignature(String signature) {
        this.signature = signature;
    }
}
