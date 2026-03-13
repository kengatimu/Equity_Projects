package com.equitybank.gag.papss.ips.pojo.channelResponse;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import java.io.Serializable;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
        "tranId",
        "status"
})
public class IpsStatusInfo implements Serializable {
    private final static long serialVersionUID = 7040068064730140166L;

    @JsonProperty("tranId")
    private String tranId;

    @JsonProperty("status")
    private Status status;


    public String getTranId() {
        return tranId;
    }

    public void setTranId(String tranId) {
        this.tranId = tranId;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }
}
