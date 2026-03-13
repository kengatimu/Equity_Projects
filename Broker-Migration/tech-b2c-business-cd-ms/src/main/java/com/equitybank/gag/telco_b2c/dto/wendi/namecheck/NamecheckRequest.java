
package com.equitybank.gag.telco_b2c.dto.wendi.namecheck;

import java.io.Serializable;
import javax.annotation.processing.Generated;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "receiver",
    "channelInfo",
    "signature"
})
@Generated("jsonschema2pojo")
public class NamecheckRequest implements Serializable {
    private final static long serialVersionUID = 2061731207471307269L;

    @Valid
    @NotNull(message = "Receiver information is mandatory")
    @JsonProperty("receiver")
    private Receiver receiver;

    @Valid
    @NotNull(message = "Channel information is mandatory")
    @JsonProperty("channelInfo")
    private ChannelInfo channelInfo;

    @NotBlank(message = "Signature is mandatory")
    @Size(max = 1000, message = "Signature must be less than 1000 characters")
    @JsonProperty("signature")
    private String signature;

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

    @JsonProperty("signature")
    public String getSignature() {
        return signature;
    }

    @JsonProperty("signature")
    public void setSignature(String signature) {
        this.signature = signature;
    }

}
