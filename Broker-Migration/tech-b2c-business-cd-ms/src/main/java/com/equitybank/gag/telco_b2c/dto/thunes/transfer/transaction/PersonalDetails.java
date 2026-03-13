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
        "dateOfBirth",
        "gender",
        "nationalityCountryCode",
        "countryOfBirthCode"
})
public class PersonalDetails implements Serializable {

    private static final long serialVersionUID = -3178070913700548247L;

    @NotBlank(message = "personalDetails.firstname is mandatory")
    @Size(max = 100, message = "personalDetails.firstname must not exceed 100 characters")
    @JsonProperty("firstname")
    private String firstname;

    @NotBlank(message = "personalDetails.lastname is mandatory")
    @Size(max = 100, message = "personalDetails.lastname must not exceed 100 characters")
    @JsonProperty("lastname")
    private String lastname;

    @NotBlank(message = "personalDetails.dateOfBirth is mandatory")
    @Pattern(regexp = "\\d{4}-\\d{2}-\\d{2}", message = "personalDetails.dateOfBirth must be in yyyy-MM-dd format")
    @JsonProperty("dateOfBirth")
    private String dateOfBirth;

    @NotBlank(message = "personalDetails.gender is mandatory")
    @Pattern(regexp = "MALE|FEMALE", message = "personalDetails.gender must be either MALE or FEMALE")
    @JsonProperty("gender")
    private String gender;

    @NotBlank(message = "personalDetails.nationalityCountryCode is mandatory")
    @Pattern(regexp = "[A-Z]{3}", message = "personalDetails.nationalityCountryCode must be ISO-3166 alpha-3")
    @JsonProperty("nationalityCountryCode")
    private String nationalityCountryCode;

    @NotBlank(message = "personalDetails.countryOfBirthCode is mandatory")
    @Pattern(regexp = "[A-Z]{3}", message = "personalDetails.countryOfBirthCode must be ISO-3166 alpha-3")
    @JsonProperty("countryOfBirthCode")
    private String countryOfBirthCode;


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

    @JsonProperty("dateOfBirth")
    public String getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(String dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    @JsonProperty("gender")
    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    @JsonProperty("nationalityCountryCode")
    public String getNationalityCountryCode() {
        return nationalityCountryCode;
    }

    public void setNationalityCountryCode(String nationalityCountryCode) {
        this.nationalityCountryCode = nationalityCountryCode;
    }

    @JsonProperty("countryOfBirthCode")
    public String getCountryOfBirthCode() {
        return countryOfBirthCode;
    }

    public void setCountryOfBirthCode(String countryOfBirthCode) {
        this.countryOfBirthCode = countryOfBirthCode;
    }
}
