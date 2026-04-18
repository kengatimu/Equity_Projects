
package com.equitybank.payments.imt.b2c.response.service.model.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import javax.annotation.Generated;
import java.io.Serializable;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "OriginTransactionID",
    "TransactionID",
    "Status"
})
@Generated("jsonschema2pojo")
public class BrokerServiceFinalResponse implements Serializable
{

    @JsonProperty("OriginTransactionID")
    private String originTransactionID;
    @JsonProperty("TransactionID")
    private String transactionID;
    @JsonProperty("Status")
    private String status;
    private final static long serialVersionUID = -1093672458007076523L;

    @JsonProperty("OriginTransactionID")
    public String getOriginTransactionID() {
        return originTransactionID;
    }

    @JsonProperty("OriginTransactionID")
    public void setOriginTransactionID(String originTransactionID) {
        this.originTransactionID = originTransactionID;
    }

    @JsonProperty("TransactionID")
    public String getTransactionID() {
        return transactionID;
    }

    @JsonProperty("TransactionID")
    public void setTransactionID(String transactionID) {
        this.transactionID = transactionID;
    }

    @JsonProperty("Status")
    public String getStatus() {
        return status;
    }

    @JsonProperty("Status")
    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(BrokerServiceFinalResponse.class.getName()).append('@').append(Integer.toHexString(System.identityHashCode(this))).append('[');
        sb.append("originTransactionID");
        sb.append('=');
        sb.append(((this.originTransactionID == null)?"<null>":this.originTransactionID));
        sb.append(',');
        sb.append("transactionID");
        sb.append('=');
        sb.append(((this.transactionID == null)?"<null>":this.transactionID));
        sb.append(',');
        sb.append("status");
        sb.append('=');
        sb.append(((this.status == null)?"<null>":this.status));
        sb.append(',');
        if (sb.charAt((sb.length()- 1)) == ',') {
            sb.setCharAt((sb.length()- 1), ']');
        } else {
            sb.append(']');
        }
        return sb.toString();
    }

}
