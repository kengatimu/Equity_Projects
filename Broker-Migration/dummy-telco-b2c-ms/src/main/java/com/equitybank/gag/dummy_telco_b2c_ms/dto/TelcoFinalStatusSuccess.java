
package com.equitybank.gag.dummy_telco_b2c_ms.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import java.io.Serializable;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "operationId",
    "operationStatus",
    "message"
})
public class TelcoFinalStatusSuccess implements Serializable {
    private final static long serialVersionUID = 1128236387978648752L;

    @JsonProperty("operationId")
    public String operationId;

    @JsonProperty("operationStatus")
    public String operationStatus;

    @JsonProperty("message")
    public String message;

    public String getOperationId() {
        return operationId;
    }

    public void setOperationId(String operationId) {
        this.operationId = operationId;
    }

    public String getOperationStatus() {
        return operationStatus;
    }

    public void setOperationStatus(String operationStatus) {
        this.operationStatus = operationStatus;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
