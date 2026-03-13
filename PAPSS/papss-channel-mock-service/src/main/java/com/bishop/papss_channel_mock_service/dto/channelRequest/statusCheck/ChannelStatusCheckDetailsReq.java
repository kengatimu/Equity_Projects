
package com.bishop.papss_channel_mock_service.dto.channelRequest.statusCheck;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

import java.io.Serializable;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "sender",
    "receiver",
    "channelInfo",
    "originalTxnInfo",
    "signature"
})
public class ChannelStatusCheckDetailsReq implements Serializable {
    private final static long serialVersionUID = -4167142129849587127L;

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

    @Valid
    @NotNull(message = "OriginalTxnInfo information is mandatory")
    @JsonProperty("originalTxnInfo")
    private OriginalTxnInfo originalTxnInfo;

    @NotBlank(message = "Signature is mandatory")
    @Size(max = 1000, message = "Signature must be less than 1000 characters")
    @JsonProperty("signature")
    private String signature;

    @JsonProperty("sender")
    public Sender getSender() {
        return sender;
    }

    @JsonProperty("sender")
    public void setSender(Sender sender) {
        this.sender = sender;
    }

    @JsonProperty("receiver")
    public Receiver getReceiver() {
        return receiver;
    }

    @JsonProperty("receiver")
    public void setReceiver(Receiver receiver) {
        this.receiver = receiver;
    }

    @JsonProperty("channelInfo")
    public ChannelInfo getChannelInfo() {
        return channelInfo;
    }

    @JsonProperty("channelInfo")
    public void setChannelInfo(ChannelInfo channelInfo) {
        this.channelInfo = channelInfo;
    }

    @JsonProperty("originalTxnInfo")
    public OriginalTxnInfo getOriginalTxnInfo() {
        return originalTxnInfo;
    }

    @JsonProperty("originalTxnInfo")
    public void setOriginalTxnInfo(OriginalTxnInfo originalTxnInfo) {
        this.originalTxnInfo = originalTxnInfo;
    }

    @JsonProperty("signature")
    public String getSignature() {
        return signature;
    }

    @JsonProperty("signature")
    public void setSignature(String signature) {
        this.signature = signature;
    }

}
