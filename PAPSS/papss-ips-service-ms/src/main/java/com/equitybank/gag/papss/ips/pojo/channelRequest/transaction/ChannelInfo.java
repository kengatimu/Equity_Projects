
package com.equitybank.gag.papss.ips.pojo.channelRequest.transaction;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import org.hibernate.validator.constraints.URL;

import java.io.Serializable;

@JsonPropertyOrder({
    "rrn",
    "bankId",
    "channelId",
    "sourceSystemId",
    "callbackURL",
})
public class ChannelInfo implements Serializable {
    private final static long serialVersionUID = -1316455895000520133L;

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

    @NotBlank(message = "Callback URL is mandatory")
    @URL(message = "Callback URL must be a valid URL")
    @JsonProperty("callbackURL")
    private String callbackURL;

    public String getRrn() {
        return rrn;
    }

    public void setRrn(String rrn) {
        this.rrn = rrn;
    }

    public String getBankId() {
        return bankId;
    }

    public void setBankId(String bankId) {
        this.bankId = bankId;
    }

    public String getChannelId() {
        return channelId;
    }

    public void setChannelId(String channelId) {
        this.channelId = channelId;
    }

    public String getSourceSystemId() {
        return sourceSystemId;
    }

    public void setSourceSystemId(String sourceSystemId) {
        this.sourceSystemId = sourceSystemId;
    }

    public String getCallbackURL() {
        return callbackURL;
    }

    public void setCallbackURL(String callbackURL) {
        this.callbackURL = callbackURL;
    }
}
