package com.equitybank.gag.telco_b2c.dto.thunes.transfer.transaction;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
        "quotationId",
        "externalId"
})
public class Quotation implements Serializable {

    private static final long serialVersionUID = -6241922366331855909L;

    @NotBlank(message = "quotation.quotationId is mandatory")
    @Size(max = 100, message = "quotation.quotationId must not exceed 100 characters")
    @JsonProperty("quotationId")
    private String quotationId;

    @Size(max = 100, message = "quotation.externalId must not exceed 100 characters")
    @JsonProperty("externalId")
    private String externalId;

    @JsonProperty("quotationId")
    public String getQuotationId() {
        return quotationId;
    }

    public void setQuotationId(String quotationId) {
        this.quotationId = quotationId;
    }

    @JsonProperty("externalId")
    public String getExternalId() {
        return externalId;
    }

    public void setExternalId(String externalId) {
        this.externalId = externalId;
    }
}
