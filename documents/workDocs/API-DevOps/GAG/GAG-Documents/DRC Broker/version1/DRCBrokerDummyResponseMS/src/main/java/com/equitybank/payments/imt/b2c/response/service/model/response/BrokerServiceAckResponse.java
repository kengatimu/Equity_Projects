
package com.equitybank.payments.imt.b2c.response.service.model.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import javax.annotation.Generated;
import java.io.Serializable;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "OriginTransactionID",
    "TransactionID"
})
@Generated("jsonschema2pojo")
public class BrokerServiceAckResponse implements Serializable
{

    @JsonProperty("OriginTransactionID")
    private String originTransactionID;
    @JsonProperty("TransactionID")
    private String transactionID;
    private final static long serialVersionUID = 1713168500046398663L;

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

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(BrokerServiceAckResponse.class.getName()).append('@').append(Integer.toHexString(System.identityHashCode(this))).append('[');
        sb.append("originTransactionID");
        sb.append('=');
        sb.append(((this.originTransactionID == null)?"<null>":this.originTransactionID));
        sb.append(',');
        sb.append("transactionID");
        sb.append('=');
        sb.append(((this.transactionID == null)?"<null>":this.transactionID));
        sb.append(',');
        if (sb.charAt((sb.length()- 1)) == ',') {
            sb.setCharAt((sb.length()- 1), ']');
        } else {
            sb.append(']');
        }
        return sb.toString();
    }

}
