package com.equitybank.gag.telco_b2c.dto;

import java.io.Serializable;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;

//@XmlRootElement(name = "eazzycashres")
@XmlAccessorType(XmlAccessType.FIELD)
@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
        "status",
        "walletTranID",
        "responseCode",
        "responseDesc"
})
public class ChannelResponseDto implements Serializable {
    private static final long serialVersionUID = 7882287124336201304L;

    @JsonProperty("status")
    @XmlElement(name = "status")
    private String status;

    @JsonProperty("walletTranID")
    @XmlElement(name = "walletTranID")
    private String walletTranID;

    @JsonProperty("responseCode")
    @XmlElement(name = "responseCode")
    private String responseCode;

    @JsonProperty("responseDesc")
    @XmlElement(name = "responseDesc")
    private String responseDesc;

    // Getters and Setters
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getWalletTranID() {
        return walletTranID;
    }

    public void setWalletTranID(String walletTranID) {
        this.walletTranID = walletTranID;
    }

    public String getResponseCode() {
        return responseCode;
    }

    public void setResponseCode(String responseCode) {
        this.responseCode = responseCode;
    }

    public String getResponseDesc() {
        return responseDesc;
    }

    public void setResponseDesc(String responseDesc) {
        this.responseDesc = responseDesc;
    }
}