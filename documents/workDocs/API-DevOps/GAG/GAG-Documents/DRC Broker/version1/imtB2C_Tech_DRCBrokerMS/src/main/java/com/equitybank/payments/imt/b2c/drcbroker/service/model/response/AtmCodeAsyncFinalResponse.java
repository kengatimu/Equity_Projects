
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
        "ResultCode",
        "ResultDescription"
})
@Generated("jsonschema2pojo")
public class AtmCodeAsyncFinalResponse implements Serializable
{

    @JsonProperty("OriginatingTransactionID")
    private String OriginatingTransactionID;
    @JsonProperty("TransactionID")
    private String TransactionID;
    @JsonProperty("ResultCode")
    private String ResultCode;
    @JsonProperty("ResultDescription")
    private String ResultDescription;
    private final static long serialVersionUID = -2655749305618823803L;

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

    public String getResultCode() {
        return ResultCode;
    }

    public void setResultCode(String resultCode) {
        ResultCode = resultCode;
    }

    public String getResultDescription() {
        return ResultDescription;
    }

    public void setResultDescription(String resultDescription) {
        ResultDescription = resultDescription;
    }

    @Override
    public String toString() {
        return "BrokerAtmCodeAsyncFinalResponse{" +
                "OriginatingTransactionID='" + OriginatingTransactionID + '\'' +
                ", TransactionID='" + TransactionID + '\'' +
                ", ResultCode='" + ResultCode + '\'' +
                ", ResultDescription='" + ResultDescription + '\'' +
                '}';
    }
}
