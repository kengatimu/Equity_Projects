
package com.equitybank.payments.imt.b2c.drcbroker.service.model.response;

import java.io.Serializable;
import javax.annotation.Generated;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "requestID",
    "resultStatus",
    "benficiaryName",
    "walletTXCode"
})
@Generated("jsonschema2pojo")
public class BusinessServiceFinalResponse implements Serializable
{

    @JsonProperty("requestID")
    private String requestID;
    @JsonProperty("resultStatus")
    private String resultStatus;
    @JsonProperty("benficiaryName")
    private String benficiaryName;
    @JsonProperty("walletTXCode")
    private String walletTXCode;
    private final static long serialVersionUID = 4414714336476880137L;

    @JsonProperty("requestID")
    public String getRequestID() {
        return requestID;
    }

    @JsonProperty("requestID")
    public void setRequestID(String requestID) {
        this.requestID = requestID;
    }

    @JsonProperty("resultStatus")
    public String getResultStatus() {
        return resultStatus;
    }

    @JsonProperty("resultStatus")
    public void setResultStatus(String resultStatus) {
        this.resultStatus = resultStatus;
    }

    @JsonProperty("benficiaryName")
    public String getBenficiaryName() {
        return benficiaryName;
    }

    @JsonProperty("benficiaryName")
    public void setBenficiaryName(String benficiaryName) {
        this.benficiaryName = benficiaryName;
    }

    @JsonProperty("walletTXCode")
    public String getWalletTXCode() {
        return walletTXCode;
    }

    @JsonProperty("walletTXCode")
    public void setWalletTXCode(String walletTXCode) {
        this.walletTXCode = walletTXCode;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(BusinessServiceFinalResponse.class.getName()).append('@').append(Integer.toHexString(System.identityHashCode(this))).append('[');
        sb.append("requestID");
        sb.append('=');
        sb.append(((this.requestID == null)?"<null>":this.requestID));
        sb.append(',');
        sb.append("resultStatus");
        sb.append('=');
        sb.append(((this.resultStatus == null)?"<null>":this.resultStatus));
        sb.append(',');
        sb.append("benficiaryName");
        sb.append('=');
        sb.append(((this.benficiaryName == null)?"<null>":this.benficiaryName));
        sb.append(',');
        sb.append("walletTXCode");
        sb.append('=');
        sb.append(((this.walletTXCode == null)?"<null>":this.walletTXCode));
        sb.append(',');
        if (sb.charAt((sb.length()- 1)) == ',') {
            sb.setCharAt((sb.length()- 1), ']');
        } else {
            sb.append(']');
        }
        return sb.toString();
    }

}
