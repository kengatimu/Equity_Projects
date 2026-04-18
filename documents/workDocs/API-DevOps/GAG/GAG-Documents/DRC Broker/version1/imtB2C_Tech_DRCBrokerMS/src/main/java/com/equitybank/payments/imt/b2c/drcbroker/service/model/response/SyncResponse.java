
package com.equitybank.payments.imt.b2c.drcbroker.service.model.response;

import java.io.Serializable;
import javax.annotation.Generated;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "OriginatingTransactionID",
    "TransactionID",
    "Status",
    "TransactionStatus"
})
@Generated("jsonschema2pojo")
public class SyncResponse implements Serializable
{

    @JsonProperty("OriginatingTransactionID")
    private String OriginatingTransactionID;
    @JsonProperty("TransactionID")
    private String TransactionID;
    @JsonProperty("Status")
    private String Status;
    @JsonProperty("TransactionStatus")
    private Integer TransactionStatus;
    private final static long serialVersionUID = 7220618919280840552L;

    public String getOriginatingTransactionID() {
        return OriginatingTransactionID;
    }

    public void setOriginatingTransactionID(String originatingTransactionID) {
        OriginatingTransactionID = originatingTransactionID;
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

    public Integer getTransactionStatus() {
        return TransactionStatus;
    }

    public void setTransactionStatus(Integer transactionStatus) {
        TransactionStatus = transactionStatus;
    }

    @Override
    public String toString() {
        return "BrokerSyncResponseModel{" +
                "OriginatingTransactionID=" + OriginatingTransactionID +
                ", TransactionID=" + TransactionID +
                ", Status=" + Status +
                ", TransactionStatus=" + TransactionStatus +
                '}';
    }
}
