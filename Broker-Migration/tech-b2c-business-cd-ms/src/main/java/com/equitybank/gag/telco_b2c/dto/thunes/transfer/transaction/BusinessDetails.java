package com.equitybank.gag.telco_b2c.dto.thunes.transfer.transaction;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
        "registeredName",
        "tradingName",
        "registrationNumber",
        "taxId",
        "dateOfIncorporation",
        "countryCode"
})
public class BusinessDetails implements Serializable {

    private static final long serialVersionUID = 5278150367335114314L;

    @NotBlank(message = "businessDetails.registeredName is mandatory")
    @Size(max = 150, message = "businessDetails.registeredName must not exceed 150 characters")
    @JsonProperty("registeredName")
    private String registeredName;

    @Size(max = 150, message = "businessDetails.tradingName must not exceed 150 characters")
    @JsonProperty("tradingName")
    private String tradingName;

    @NotBlank(message = "businessDetails.registrationNumber is mandatory")
    @Size(max = 100, message = "businessDetails.registrationNumber must not exceed 100 characters")
    @JsonProperty("registrationNumber")
    private String registrationNumber;

    @Size(max = 100, message = "businessDetails.taxId must not exceed 100 characters")
    @JsonProperty("taxId")
    private String taxId;

    @Pattern(regexp = "\\d{4}-\\d{2}-\\d{2}", message = "businessDetails.dateOfIncorporation must be in yyyy-MM-dd format")
    @JsonProperty("dateOfIncorporation")
    private String dateOfIncorporation;

    @NotBlank(message = "businessDetails.countryCode is mandatory")
    @Pattern(regexp = "[A-Z]{3}", message = "businessDetails.countryCode must be ISO-3166 alpha-3")
    @JsonProperty("countryCode")
    private String countryCode;


    @JsonProperty("registeredName")
    public String getRegisteredName() {
        return registeredName;
    }

    public void setRegisteredName(String registeredName) {
        this.registeredName = registeredName;
    }

    @JsonProperty("tradingName")
    public String getTradingName() {
        return tradingName;
    }

    public void setTradingName(String tradingName) {
        this.tradingName = tradingName;
    }

    @JsonProperty("registrationNumber")
    public String getRegistrationNumber() {
        return registrationNumber;
    }

    public void setRegistrationNumber(String registrationNumber) {
        this.registrationNumber = registrationNumber;
    }

    @JsonProperty("taxId")
    public String getTaxId() {
        return taxId;
    }

    public void setTaxId(String taxId) {
        this.taxId = taxId;
    }

    @JsonProperty("dateOfIncorporation")
    public String getDateOfIncorporation() {
        return dateOfIncorporation;
    }

    public void setDateOfIncorporation(String dateOfIncorporation) {
        this.dateOfIncorporation = dateOfIncorporation;
    }

    @JsonProperty("countryCode")
    public String getCountryCode() {
        return countryCode;
    }

    public void setCountryCode(String countryCode) {
        this.countryCode = countryCode;
    }
}
