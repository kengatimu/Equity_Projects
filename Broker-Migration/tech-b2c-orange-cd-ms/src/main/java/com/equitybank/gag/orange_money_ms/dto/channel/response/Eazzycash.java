package com.equitybank.gag.orange_money_ms.dto.channel.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;

import java.math.BigDecimal;

@XmlAccessorType(XmlAccessType.FIELD)
@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
        "amount",
        "name",
        "number",
        "rrn",
        "sender",
        "signature",
        "telco",
        "channel",
        "tranID",
        "optIn"
})
public class Eazzycash {
    @JsonProperty("amount")
    @XmlElement(name = "amount")
    @NotNull(message = "Amount field cannot be null")
    @DecimalMin(value = "0.0", inclusive = false, message = "Amount must be greater than zero")
    private BigDecimal amount;

    @JsonProperty("name")
    @XmlElement(name = "name")
//    @NotBlank(message = "Name field cannot be blank/null")
    private String name;

    @JsonProperty("number")
    @XmlElement(name = "number")
    @NotBlank(message = "Number field cannot be blank/null")
    private String number;

    @JsonProperty("rrn")
    @XmlElement(name = "rrn")
    @NotBlank(message = "RRN field cannot be blank/null")
    private String rrn;

    @JsonProperty("sender")
    @XmlElement(name = "sender")
//    @NotBlank(message = "Sender field cannot be blank/null")
    private String sender;

    @JsonProperty("signature")
    @XmlElement(name = "signature")
    @NotBlank(message = "Signature field cannot be blank/null")
    private String signature;

    @JsonProperty("telco")
    @XmlElement(name = "telco")
    @NotBlank(message = "Telco field cannot be blank/null")
    private String telco;

    @JsonProperty("channel")
    @XmlElement(name = "channel")
//    @NotBlank(message = "channel field cannot be blank/null")
    private String channel;

    @JsonProperty("tranID")
    @XmlElement(name = "tranID")
//    @NotBlank(message = "tranID field cannot be blank/null")
    private String walletTranID;

    @JsonProperty("optIn")
    @XmlElement(name = "optIn")
//    @NotBlank(message = "optIn field cannot be blank/null")
    private String optIn;

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getRrn() {
        return rrn;
    }

    public void setRrn(String rrn) {
        this.rrn = rrn;
    }

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public String getSignature() {
        return signature;
    }

    public void setSignature(String signature) {
        this.signature = signature;
    }

    public String getTelco() {
        return telco;
    }

    public void setTelco(String telco) {
        this.telco = telco;
    }

    public String getChannel() {
        return channel;
    }

    public void setChannel(String channel) {
        this.channel = channel;
    }

    public String getWalletTranID() {
        return walletTranID;
    }

    public void setWalletTranID(String walletTranID) {
        this.walletTranID = walletTranID;
    }

    public String getOptIn() {
        return optIn;
    }

    public void setOptIn(String optIn) {
        this.optIn = optIn;
    }
}
