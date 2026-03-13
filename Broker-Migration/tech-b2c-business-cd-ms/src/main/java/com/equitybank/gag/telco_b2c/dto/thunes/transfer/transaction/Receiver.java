package com.equitybank.gag.telco_b2c.dto.thunes.transfer.transaction;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
        "partyType",
        "personalDetails",
        "contactDetails",
        "identification",
        "occupation",
        "representative",
        "businessDetails"
})
public class Receiver implements Serializable {

    private static final long serialVersionUID = 7244567820565289561L;

    @NotBlank(message = "receiver.partyType is mandatory")
    @Pattern(regexp = "PERSON|BUSINESS", message = "receiver.partyType must be either PERSON or BUSINESS")
    @JsonProperty("partyType")
    private String partyType;

    @Valid
    @JsonProperty("personalDetails")
    private PersonalDetails personalDetails;

    @Valid
    @NotNull(message = "receiver.contactDetails is mandatory")
    @JsonProperty("contactDetails")
    private ContactDetails contactDetails;

    @Valid
    @JsonProperty("identification")
    private Identification identification;

    @JsonProperty("occupation")
    private String occupation;

    @Valid
    @JsonProperty("representative")
    private Representative representative;

    @Valid
    @JsonProperty("businessDetails")
    private BusinessDetails businessDetails;


    @JsonProperty("partyType")
    public String getPartyType() {
        return partyType;
    }

    public void setPartyType(String partyType) {
        this.partyType = partyType;
    }

    @JsonProperty("personalDetails")
    public PersonalDetails getPersonalDetails() {
        return personalDetails;
    }

    public void setPersonalDetails(PersonalDetails personalDetails) {
        this.personalDetails = personalDetails;
    }

    @JsonProperty("contactDetails")
    public ContactDetails getContactDetails() {
        return contactDetails;
    }

    public void setContactDetails(ContactDetails contactDetails) {
        this.contactDetails = contactDetails;
    }

    @JsonProperty("identification")
    public Identification getIdentification() {
        return identification;
    }

    public void setIdentification(Identification identification) {
        this.identification = identification;
    }

    @JsonProperty("occupation")
    public String getOccupation() {
        return occupation;
    }

    public void setOccupation(String occupation) {
        this.occupation = occupation;
    }

    @JsonProperty("representative")
    public Representative getRepresentative() {
        return representative;
    }

    public void setRepresentative(Representative representative) {
        this.representative = representative;
    }

    @JsonProperty("businessDetails")
    public BusinessDetails getBusinessDetails() {
        return businessDetails;
    }

    public void setBusinessDetails(BusinessDetails businessDetails) {
        this.businessDetails = businessDetails;
    }
}
