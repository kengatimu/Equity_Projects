package com.equitybankgroup.payments.b2c.dto.airtel.airtime.request;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotNull;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;

import java.math.BigDecimal;

@XmlAccessorType(XmlAccessType.FIELD)
@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
        "msisdnA",
        "amount",
        "telcom",
        "country",
        "channel",
        "signature",
        "rrn"
})
public class TopUp {
    @JsonProperty("msisdnA")
    @XmlElement(name = "msisdnA")
    @NotNull(message = "msisdnA field cannot be null")
    private String msisdnA;

    @JsonProperty("amount")
    @XmlElement(name = "amount")
    @NotNull(message = "Amount field cannot be null")
    @DecimalMin(value = "0.0", inclusive = false, message = "Amount must be greater than zero")
    private BigDecimal amount;

    @JsonProperty("telcom")
    @XmlElement(name = "telcom")
    @NotNull(message = "telcom field cannot be null")
    private String telcom;

    @JsonProperty("country")
    @XmlElement(name = "country")
    @NotNull(message = "country field cannot be null")
    private String country;

    @JsonProperty("channel")
    @XmlElement(name = "channel")
    @NotNull(message = "channel field cannot be null")
    private String channel;

    @JsonProperty("signature")
    @XmlElement(name = "signature")
    @NotNull(message = "signature field cannot be null")
    private String signature;

    @JsonProperty("rrn")
    @XmlElement(name = "rrn")
    @NotNull(message = "rrn field cannot be null")
    private String rrn;

    public String getMsisdnA() {
        return msisdnA;
    }

    public void setMsisdnA(String msisdnA) {
        this.msisdnA = msisdnA;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getTelcom() {
        return telcom;
    }

    public void setTelcom(String telcom) {
        this.telcom = telcom;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getChannel() {
        return channel;
    }

    public void setChannel(String channel) {
        this.channel = channel;
    }

    public String getSignature() {
        return signature;
    }

    public void setSignature(String signature) {
        this.signature = signature;
    }

    public String getRrn() {
        return rrn;
    }

    public void setRrn(String rrn) {
        this.rrn = rrn;
    }

}
