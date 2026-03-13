
package com.equitybank.gag.telco_b2c.dto.thunes.discovery.countries;

import com.equitybank.gag.telco_b2c.dto.thunes.discovery.services.Receiver;
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
    "channelInfo",
    "signature"
})
public class ListOfThunesCountries implements Serializable {
    private final static long serialVersionUID = 8737599524457273910L;

    @Valid
    @NotNull(message = "Channel information is mandatory")
    @JsonProperty("channelInfo")
    private ChannelInfo channelInfo;

    @NotBlank(message = "Signature is mandatory")
    @Size(max = 1000, message = "Signature must be less than 1000 characters")
    @JsonProperty("signature")
    private String signature;

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
