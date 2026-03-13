
package com.equitybank.gag.dummy_telco_b2c_ms.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import java.io.Serializable;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "operationId"
})
public class TelcoPendingStatusResOk implements Serializable {
    private final static long serialVersionUID = -5814379058639575445L;

    @JsonProperty("operationId")
    public String operationId;

    public String getOperationId() {
        return operationId;
    }

    public void setOperationId(String operationId) {
        this.operationId = operationId;
    }
}
