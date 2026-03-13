package com.equitybank.gag.telco_b2c.dto.airtime.request;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;

import java.math.BigDecimal;

@XmlAccessorType(XmlAccessType.FIELD)
@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
        "msisdnA",
        "amount",
        "currency",
        "telcom",
        "country",
        "channel",
        "signature",
        "rrn"
})
public class TopUp {
    @JsonProperty("msisdnA")
    @XmlElement(name = "msisdnA")
    @NotBlank(message = "msisdnA field cannot be blank/null")
    private String msisdnA;

    @JsonProperty("amount")
    @XmlElement(name = "amount")
    @NotNull(message = "Amount field cannot be null")
    @DecimalMin(value = "0.0", inclusive = false, message = "Amount must be greater than zero")
    private BigDecimal amount;

    @JsonProperty("currency")
    @XmlElement(name = "currency")
    @NotBlank(message = "Currency field cannot be blank/null")
    private String currency;

    @JsonProperty("telcom")
    @XmlElement(name = "telcom")
    @NotBlank(message = "telcom field cannot be blank/null")
    private String telcom;

    @JsonProperty("country")
    @XmlElement(name = "country")
    @NotBlank(message = "country field cannot be blank/null")
    private String country;

    @JsonProperty("channel")
    @XmlElement(name = "channel")
    @NotBlank(message = "channel field cannot be blank/null")
    private String channel;

    @JsonProperty("signature")
    @XmlElement(name = "signature")
    @NotBlank(message = "signature field cannot be blank/null")
    private String signature;

    @JsonProperty("rrn")
    @XmlElement(name = "rrn")
    @NotBlank(message = "rrn field cannot be blank/null")
    @Size(min = 12, max = 20, message = "RRN must be between 12 and 20 characters")
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

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
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
