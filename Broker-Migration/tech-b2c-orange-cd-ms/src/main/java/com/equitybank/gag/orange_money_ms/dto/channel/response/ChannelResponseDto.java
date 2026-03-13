package com.equitybank.gag.orange_money_ms.dto.channel.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;

import java.io.Serializable;

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