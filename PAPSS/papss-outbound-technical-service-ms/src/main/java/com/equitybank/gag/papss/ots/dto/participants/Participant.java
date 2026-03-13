package com.equitybank.gag.papss.ots.dto.participants;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlElementWrapper;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;

import java.util.List;

@JsonInclude(JsonInclude.Include.NON_NULL)
public class Participant {

    @JacksonXmlProperty(isAttribute = true)
    private String papssId;

    @JacksonXmlProperty(localName = "bic")
    private String bic;

    @JacksonXmlProperty(localName = "name")
    private String name;

    @JacksonXmlProperty(localName = "countryCode")
    private String countryCode;

    @JacksonXmlProperty(localName = "status")
    private String status;

    @JacksonXmlElementWrapper(localName = "paymentschemas")
    @JacksonXmlProperty(localName = "paymentschema")
    private List<String> paymentSchemas;

    @JacksonXmlElementWrapper(localName = "currencies")
    @JacksonXmlProperty(localName = "currency")
    private List<String> currencies;

    @JacksonXmlProperty(localName = "online")
    private boolean online;

    @JacksonXmlProperty(localName = "nonInstant")
    private boolean nonInstant;

    // Getters and setters

    public String getPapssId() {
        return papssId;
    }

    public void setPapssId(String papssId) {
        this.papssId = papssId;
    }

    public String getBic() {
        return bic;
    }

    public void setBic(String bic) {
        this.bic = bic;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCountryCode() {
        return countryCode;
    }

    public void setCountryCode(String countryCode) {
        this.countryCode = countryCode;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List<String> getPaymentSchemas() {
        return paymentSchemas;
    }

    public void setPaymentSchemas(List<String> paymentSchemas) {
        this.paymentSchemas = paymentSchemas;
    }

    public List<String> getCurrencies() {
        return currencies;
    }

    public void setCurrencies(List<String> currencies) {
        this.currencies = currencies;
    }

    public boolean isOnline() {
        return online;
    }

    public void setOnline(boolean online) {
        this.online = online;
    }

    public boolean isNonInstant() {
        return nonInstant;
    }

    public void setNonInstant(boolean nonInstant) {
        this.nonInstant = nonInstant;
    }
}
