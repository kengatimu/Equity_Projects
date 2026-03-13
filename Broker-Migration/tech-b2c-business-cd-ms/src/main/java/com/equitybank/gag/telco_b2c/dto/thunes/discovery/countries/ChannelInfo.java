
package com.equitybank.gag.telco_b2c.dto.thunes.discovery.countries;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

import java.io.Serializable;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "rrn",
    "bankId",
    "channelId",
    "sourceSystemId"
})
public class ChannelInfo implements Serializable {
    private final static long serialVersionUID = -7431517277305181086L;

    @NotBlank(message = "RRN is mandatory")
    @Size(min= 12, max = 12, message = "RRN must be 12 characters")
    @Pattern(regexp = "^[a-zA-Z0-9]+$", message = "RRN contains invalid characters")
    @JsonProperty("rrn")
    private String rrn;

    @NotBlank(message = "Bank ID is mandatory")
    @Pattern(regexp = "^[a-zA-Z0-9]+$", message = "Bank ID contains invalid characters")
    @JsonProperty("bankId")
    private String bankId;

    @NotBlank(message = "Channel ID is mandatory")
    @Pattern(regexp = "^[a-zA-Z0-9-]+$", message = "Channel ID contains invalid characters")
    @JsonProperty("channelId")
    private String channelId;

    @NotBlank(message = "Source System ID is mandatory")
    @Pattern(regexp = "^[a-zA-Z0-9-]+$", message = "Source System ID contains invalid characters")
    @JsonProperty("sourceSystemId")
    private String sourceSystemId;

    @JsonProperty("rrn")
    public String getRrn() {
        return rrn;
    }

    @JsonProperty("rrn")
    public void setRrn(String rrn) {
        this.rrn = rrn;
    }

    @JsonProperty("bankId")
    public String getBankId() {
        return bankId;
    }

    @JsonProperty("bankId")
    public void setBankId(String bankId) {
        this.bankId = bankId;
    }

    @JsonProperty("channelId")
    public String getChannelId() {
        return channelId;
    }

    @JsonProperty("channelId")
    public void setChannelId(String channelId) {
        this.channelId = channelId;
    }

    @JsonProperty("sourceSystemId")
    public String getSourceSystemId() {
        return sourceSystemId;
    }

    @JsonProperty("sourceSystemId")
    public void setSourceSystemId(String sourceSystemId) {
        this.sourceSystemId = sourceSystemId;
    }

}
