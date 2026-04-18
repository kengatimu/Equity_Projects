package com.equitybank.payments.imt.b2c.drcbroker.service.model.response;

import java.io.Serializable;
import javax.annotation.Generated;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
        "requestId",
        "endToEndId",
        "channelId",
        "sourceSystemId",
        "receiverAccount",
        "receiverInstitutionCode",
        "receiverName",
        "status",
        "statusCode",
        "statusDesc",
        "statusMessage"
})
@Generated("jsonschema2pojo")
public class GenericBusinessServiceResModel implements Serializable
{
    @JsonProperty("requestId")
    private String requestId;
    @JsonProperty("endToEndId")
    private String endToEndId;
    @JsonProperty("channelId")
    private String channelId;
    @JsonProperty("sourceSystemId")
    private String sourceSystemId;
    @JsonProperty("receiverAccount")
    private String receiverAccount;
    @JsonProperty("receiverInstitutionCode")
    private String receiverInstitutionCode;
    @JsonProperty("receiverName")
    private String receiverName;
    @JsonProperty("status")
    private String status;
    @JsonProperty("statusCode")
    private String statusCode;
    @JsonProperty("statusDesc")
    private String statusDesc;
    @JsonProperty("statusMessage")
    private String statusMessage;
    private final static long serialVersionUID = 1288750473040030623L;

    @JsonProperty("requestId")
    public String getRequestId() {
        return requestId;
    }

    @JsonProperty("requestId")
    public void setRequestId(String requestId) {
        this.requestId = requestId;
    }

    @JsonProperty("endToEndId")
    public String getEndToEndId() {
        return endToEndId;
    }

    @JsonProperty("endToEndId")
    public void setEndToEndId(String endToEndId) {
        this.endToEndId = endToEndId;
    }

    @JsonProperty("channelId")
    public String getChannelId() {
        return channelId;
    }

    @JsonProperty("channelId")
    public void setChannelId(String channelId) {
        this.channelId = channelId;
    }

    @JsonProperty("sourceSystemId")
    public String getSourceSystemId() {
        return sourceSystemId;
    }

    @JsonProperty("sourceSystemId")
    public void setSourceSystemId(String sourceSystemId) {
        this.sourceSystemId = sourceSystemId;
    }

    @JsonProperty("receiverAccount")
    public String getReceiverAccount() {
        return receiverAccount;
    }

    @JsonProperty("receiverAccount")
    public void setReceiverAccount(String receiverAccount) {
        this.receiverAccount = receiverAccount;
    }

    @JsonProperty("receiverInstitutionCode")
    public String getReceiverInstitutionCode() {
        return receiverInstitutionCode;
    }

    @JsonProperty("receiverInstitutionCode")
    public void setReceiverInstitutionCode(String receiverInstitutionCode) {
        this.receiverInstitutionCode = receiverInstitutionCode;
    }

    @JsonProperty("receiverName")
    public String getReceiverName() {
        return receiverName;
    }

    @JsonProperty("receiverName")
    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    @JsonProperty("status")
    public String getStatus() {
        return status;
    }

    @JsonProperty("status")
    public void setStatus(String status) {
        this.status = status;
    }

    @JsonProperty("statusCode")
    public String getStatusCode() {
        return statusCode;
    }

    @JsonProperty("statusCode")
    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
    }

    @JsonProperty("statusDesc")
    public String getStatusDesc() {
        return statusDesc;
    }

    @JsonProperty("statusDesc")
    public void setStatusDesc(String statusDesc) {
        this.statusDesc = statusDesc;
    }

    @JsonProperty("statusMessage")
    public String getStatusMessage() {
        return statusMessage;
    }

    @JsonProperty("statusMessage")
    public void setStatusMessage(String statusMessage) {
        this.statusMessage = statusMessage;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(GenericBusinessServiceResModel.class.getName()).append('@').append(Integer.toHexString(System.identityHashCode(this))).append('[');
        sb.append("requestId");
        sb.append('=');
        sb.append(((this.requestId == null)?"<null>":this.requestId));
        sb.append(',');
        sb.append("endToEndId");
        sb.append('=');
        sb.append(((this.endToEndId == null)?"<null>":this.endToEndId));
        sb.append(',');
        sb.append("channelId");
        sb.append('=');
        sb.append(((this.channelId == null)?"<null>":this.channelId));
        sb.append(',');
        sb.append("sourceSystemId");
        sb.append('=');
        sb.append(((this.sourceSystemId == null)?"<null>":this.sourceSystemId));
        sb.append(',');
        sb.append("receiverAccount");
        sb.append('=');
        sb.append(((this.receiverAccount == null)?"<null>":this.receiverAccount));
        sb.append(',');
        sb.append("receiverInstitutionCode");
        sb.append('=');
        sb.append(((this.receiverInstitutionCode == null)?"<null>":this.receiverInstitutionCode));
        sb.append(',');
        sb.append("receiverName");
        sb.append('=');
        sb.append(((this.receiverName == null)?"<null>":this.receiverName));
        sb.append(',');
        sb.append("status");
        sb.append('=');
        sb.append(((this.status == null)?"<null>":this.status));
        sb.append(',');
        sb.append("statusCode");
        sb.append('=');
        sb.append(((this.statusCode == null)?"<null>":this.statusCode));
        sb.append(',');
        sb.append("statusDesc");
        sb.append('=');
        sb.append(((this.statusDesc == null)?"<null>":this.statusDesc));
        sb.append(',');
        sb.append("statusMessage");
        sb.append('=');
        sb.append(((this.statusMessage == null)?"<null>":this.statusMessage));
        sb.append(',');
        if (sb.charAt((sb.length()- 1)) == ',') {
            sb.setCharAt((sb.length()- 1), ']');
        } else {
            sb.append(']');
        }
        return sb.toString();
    }
}
