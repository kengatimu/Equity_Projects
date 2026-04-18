
package com.equitybank.payments.imt.b2c.drcbroker.service.model.response;

import java.io.Serializable;
import javax.annotation.Generated;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
        "OriginTransactionID",
        "TransactionID",
        "Status",
        "TransactionStatus"
})
@Generated("jsonschema2pojo")
public class FinalResponse implements Serializable {

    @JsonProperty("OriginTransactionID")
    private String OriginTransactionID;
    @JsonProperty("TransactionID")
    private String TransactionID;
    @JsonProperty("Status")
    private String Status;
    @JsonProperty("TransactionStatus")
    private String TransactionStatus;
    private final static long serialVersionUID = -1093672458007076523L;

    public String getOriginTransactionID() {
        return OriginTransactionID;
    }

    public void setOriginTransactionID(String originTransactionID) {
        OriginTransactionID = originTransactionID;
    }

    public String getTransactionID() {
        return TransactionID;
    }

    public void setTransactionID(String transactionID) {
        TransactionID = transactionID;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String status) {
        Status = status;
    }

    public String getTransactionStatus() {
        return TransactionStatus;
    }

    public void setTransactionStatus(String transactionStatus) {
        TransactionStatus = transactionStatus;
    }

    @Override
    public String toString() {
        return "BrokerServiceFinalResponse{" +
                "OriginTransactionID='" + OriginTransactionID + '\'' +
                ", TransactionID='" + TransactionID + '\'' +
                ", Status='" + Status + '\'' +
                ", TransactionStatus='" + TransactionStatus + '\'' +
                '}';
    }
}
