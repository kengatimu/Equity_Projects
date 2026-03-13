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
        "firstname",
        "lastname",
        "idType",
        "idCountryCode",
        "idNumber"
})
public class Representative implements Serializable {

    private static final long serialVersionUID = 5424059293220863754L;

    @NotBlank(message = "representative.firstname is mandatory")
    @Size(max = 100, message = "representative.firstname must not exceed 100 characters")
    @JsonProperty("firstname")
    private String firstname;

    @NotBlank(message = "representative.lastname is mandatory")
    @Size(max = 100, message = "representative.lastname must not exceed 100 characters")
    @JsonProperty("lastname")
    private String lastname;

    @Size(max = 50, message = "representative.idType must not exceed 50 characters")
    @JsonProperty("idType")
    private String idType;

    @Pattern(regexp = "[A-Z]{3}", message = "representative.idCountryCode must be ISO-3166 alpha-3")
    @JsonProperty("idCountryCode")
    private String idCountryCode;

    @Size(max = 100, message = "representative.idNumber must not exceed 100 characters")
    @JsonProperty("idNumber")
    private String idNumber;


    @JsonProperty("firstname")
    public String getFirstname() {
        return firstname;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    @JsonProperty("lastname")
    public String getLastname() {
        return lastname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    @JsonProperty("idType")
    public String getIdType() {
        return idType;
    }

    public void setIdType(String idType) {
        this.idType = idType;
    }

    @JsonProperty("idCountryCode")
    public String getIdCountryCode() {
        return idCountryCode;
    }

    public void setIdCountryCode(String idCountryCode) {
        this.idCountryCode = idCountryCode;
    }

    @JsonProperty("idNumber")
    public String getIdNumber() {
        return idNumber;
    }

    public void setIdNumber(String idNumber) {
        this.idNumber = idNumber;
    }
}
