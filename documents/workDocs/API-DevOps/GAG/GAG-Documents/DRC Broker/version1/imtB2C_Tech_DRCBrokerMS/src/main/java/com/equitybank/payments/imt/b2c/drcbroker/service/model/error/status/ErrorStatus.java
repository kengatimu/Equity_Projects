
package com.equitybank.payments.imt.b2c.drcbroker.service.model.error.status;

import java.io.Serializable;
import javax.annotation.Generated;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "status",
    "statusCode",
    "statusDesc",
    "statusMessage",
    "httpStatusCode",
    "httpStatusDesc"
})
@Generated("jsonschema2pojo")
public class ErrorStatus implements Serializable
{

    @JsonProperty("status")
    private String status;
    @JsonProperty("statusCode")
    private String statusCode;
    @JsonProperty("statusDesc")
    private String statusDesc;
    @JsonProperty("statusMessage")
    private String statusMessage;
    @JsonProperty("httpStatusCode")
    private int httpStatusCode;
    @JsonProperty("httpStatusDesc")
    private String httpStatusDesc;
    private final static long serialVersionUID = 2760266988065747247L;

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

    @JsonProperty("httpStatusCode")
    public int getHttpStatusCode() {
        return httpStatusCode;
    }

    @JsonProperty("httpStatusCode")
    public void setHttpStatusCode(int httpStatusCode) {
        this.httpStatusCode = httpStatusCode;
    }

    @JsonProperty("httpStatusDesc")
    public String getHttpStatusDesc() {
        return httpStatusDesc;
    }

    @JsonProperty("httpStatusDesc")
    public void setHttpStatusDesc(String httpStatusDesc) {
        this.httpStatusDesc = httpStatusDesc;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(ErrorStatus.class.getName()).append('@').append(Integer.toHexString(System.identityHashCode(this))).append('[');
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
        sb.append("httpStatusCode");
        sb.append('=');
        sb.append(((this.httpStatusCode == 0)?"<null>":this.httpStatusCode));
        sb.append(',');
        sb.append("httpStatusDesc");
        sb.append('=');
        sb.append(((this.httpStatusDesc == null)?"<null>":this.httpStatusDesc));
        sb.append(',');
        if (sb.charAt((sb.length()- 1)) == ',') {
            sb.setCharAt((sb.length()- 1), ']');
        } else {
            sb.append(']');
        }
        return sb.toString();
    }

}
