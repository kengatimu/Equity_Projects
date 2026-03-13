package com.equitybank.gag.papss.ots.dto.channelResponse;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import java.io.Serializable;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
        "originalRrn",
        "status",
        "code",
        "description"
})
public class OriginalTxnStatusInfo implements Serializable {
    private final static long serialVersionUID = 1L;

    @JsonProperty("originalRrn")
    private String originalRrn;

    @JsonProperty("status")
    private String status;

    @JsonProperty("code")
    private String code;

    @JsonProperty("description")
    private String description;

    @JsonProperty("originalRrn")
    public String getOriginalRrn() {
        return originalRrn;
    }

    @JsonProperty("originalRrn")
    public void setOriginalRrn(String originalRrn) {
        this.originalRrn = originalRrn;
    }

    @JsonProperty("status")
    public String getStatus() {
        return status;
    }

    @JsonProperty("status")
    public void setStatus(String status) {
        this.status = status;
    }

    @JsonProperty("code")
    public String getCode() {
        return code;
    }

    @JsonProperty("code")
    public void setCode(String code) {
        this.code = code;
    }

    @JsonProperty("description")
    public String getDescription() {
        return description;
    }

    @JsonProperty("description")
    public void setDescription(String description) {
        this.description = description;
    }
}
