package com.equitybank.gag.telco_b2c.dto.thunes.transfer.transaction;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
        "purpose",
        "documentReference",
        "reference"
})
public class Remittance implements Serializable {

    private static final long serialVersionUID = 4526306722340065693L;

    @NotBlank(message = "remittance.purpose is mandatory")
    @Size(max = 100, message = "remittance.purpose must not exceed 100 characters")
    @JsonProperty("purpose")
    private String purpose;

    @Size(max = 100, message = "remittance.documentReference must not exceed 100 characters")
    @JsonProperty("documentReference")
    private String documentReference;

    @Size(max = 140, message = "remittance.reference must not exceed 140 characters")
    @JsonProperty("reference")
    private String reference;

    @JsonProperty("purpose")
    public String getPurpose() {
        return purpose;
    }

    public void setPurpose(String purpose) {
        this.purpose = purpose;
    }

    @JsonProperty("documentReference")
    public String getDocumentReference() {
        return documentReference;
    }

    public void setDocumentReference(String documentReference) {
        this.documentReference = documentReference;
    }

    @JsonProperty("reference")
    public String getReference() {
        return reference;
    }

    public void setReference(String reference) {
        this.reference = reference;
    }
}
