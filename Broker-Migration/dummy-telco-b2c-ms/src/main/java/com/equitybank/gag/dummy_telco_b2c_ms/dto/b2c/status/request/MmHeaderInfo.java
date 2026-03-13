
package com.equitybank.gag.dummy_telco_b2c_ms.dto.b2c.status.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import java.io.Serializable;

@XmlAccessorType(XmlAccessType.FIELD)
@JsonPropertyOrder({
    "operatorCode",
    "requestId",
    "requestToken",
    "requestType",
    "affiliateCode"
})
public class MmHeaderInfo implements Serializable {
    private final static long serialVersionUID = 1867246758833980285L;

    @XmlElement(name = "operatorCode")
    @JsonProperty("operatorCode")
    private String operatorCode;

    @XmlElement(name = "requestId")
    @JsonProperty("requestId")
    private String requestId;

    @XmlElement(name = "requestToken")
    @JsonProperty("requestToken")
    private String requestToken;

    @XmlElement(name = "requestType")
    @JsonProperty("requestType")
    private String requestType;

    @XmlElement(name = "affiliateCode")
    @JsonProperty("affiliateCode")
    private String affiliateCode;

    @JsonProperty("operatorCode")
    public String getOperatorCode() {
        return operatorCode;
    }

    @JsonProperty("operatorCode")
    public void setOperatorCode(String operatorCode) {
        this.operatorCode = operatorCode;
    }

    @JsonProperty("requestId")
    public String getRequestId() {
        return requestId;
    }

    @JsonProperty("requestId")
    public void setRequestId(String requestId) {
        this.requestId = requestId;
    }

    @JsonProperty("requestToken")
    public String getRequestToken() {
        return requestToken;
    }

    @JsonProperty("requestToken")
    public void setRequestToken(String requestToken) {
        this.requestToken = requestToken;
    }

    @JsonProperty("requestType")
    public String getRequestType() {
        return requestType;
    }

    @JsonProperty("requestType")
    public void setRequestType(String requestType) {
        this.requestType = requestType;
    }

    @JsonProperty("affiliateCode")
    public String getAffiliateCode() {
        return affiliateCode;
    }

    @JsonProperty("affiliateCode")
    public void setAffiliateCode(String affiliateCode) {
        this.affiliateCode = affiliateCode;
    }

}
