package com.equitybank.gag.telco_b2c.dto.thunes.transfer.transaction;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
        "address",
        "postalCode",
        "city",
        "countryCode",
        "msisdn",
        "email"
})
public class ContactDetails implements Serializable {

    private static final long serialVersionUID = 4408313966432471705L;

    @NotBlank(message = "contactDetails.address is mandatory")
    @Size(max = 255, message = "contactDetails.address must not exceed 255 characters")
    @JsonProperty("address")
    private String address;

    @NotBlank(message = "contactDetails.postalCode is mandatory")
    @Size(max = 20, message = "contactDetails.postalCode must not exceed 20 characters")
    @JsonProperty("postalCode")
    private String postalCode;

    @NotBlank(message = "contactDetails.city is mandatory")
    @Size(max = 100, message = "contactDetails.city must not exceed 100 characters")
    @JsonProperty("city")
    private String city;

    @NotBlank(message = "contactDetails.countryCode is mandatory")
    @Pattern(regexp = "[A-Z]{3}", message = "contactDetails.countryCode must be ISO-3166 alpha-3")
    @JsonProperty("countryCode")
    private String countryCode;

    @NotBlank(message = "contactDetails.msisdn is mandatory")
    @Pattern(regexp = "\\+?[1-9]\\d{7,14}", message = "contactDetails.msisdn must be in international format, e.g. +254712345678")
    @JsonProperty("msisdn")
    private String msisdn;

    @NotBlank(message = "contactDetails.email is mandatory")
    @Email(message = "contactDetails.email must be a valid email address")
    @Size(max = 150, message = "contactDetails.email must not exceed 150 characters")
    @JsonProperty("email")
    private String email;

    @JsonProperty("address")
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @JsonProperty("postalCode")
    public String getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }

    @JsonProperty("city")
    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    @JsonProperty("countryCode")
    public String getCountryCode() {
        return countryCode;
    }

    public void setCountryCode(String countryCode) {
        this.countryCode = countryCode;
    }

    @JsonProperty("msisdn")
    public String getMsisdn() {
        return msisdn;
    }

    public void setMsisdn(String msisdn) {
        this.msisdn = msisdn;
    }

    @JsonProperty("email")
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
