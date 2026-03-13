package com.equitybank.gag.telco_b2c.dto.thunes.transfer.transaction;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import jakarta.validation.constraints.Pattern;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
        "partnerFee",
        "partnerFeeCurrency",
        "bankFee",
        "bankFeeCurrency"
})
public class Fees implements Serializable {

    private static final long serialVersionUID = -3729025614442400106L;

    @Pattern(regexp = "^\\d+(\\.\\d{1,8})?$", message = "fees.partnerFee must be a valid positive amount with up to 8 decimals")
    @JsonProperty("partnerFee")
    private String partnerFee;

    @Pattern(regexp = "[A-Z]{3}", message = "fees.partnerFeeCurrency must be ISO-4217 (e.g. USD, EUR)")
    @JsonProperty("partnerFeeCurrency")
    private String partnerFeeCurrency;

    @Pattern(regexp = "^\\d+(\\.\\d{1,8})?$", message = "fees.bankFee must be a valid positive amount with up to 8 decimals")
    @JsonProperty("bankFee")
    private String bankFee;

    @Pattern(regexp = "[A-Z]{3}", message = "fees.bankFeeCurrency must be ISO-4217 (e.g. USD, EUR)")
    @JsonProperty("bankFeeCurrency")
    private String bankFeeCurrency;

    @JsonProperty("partnerFee")
    public String getPartnerFee() {
        return partnerFee;
    }

    public void setPartnerFee(String partnerFee) {
        this.partnerFee = partnerFee;
    }

    @JsonProperty("partnerFeeCurrency")
    public String getPartnerFeeCurrency() {
        return partnerFeeCurrency;
    }

    public void setPartnerFeeCurrency(String partnerFeeCurrency) {
        this.partnerFeeCurrency = partnerFeeCurrency;
    }

    @JsonProperty("bankFee")
    public String getBankFee() {
        return bankFee;
    }

    public void setBankFee(String bankFee) {
        this.bankFee = bankFee;
    }

    @JsonProperty("bankFeeCurrency")
    public String getBankFeeCurrency() {
        return bankFeeCurrency;
    }

    public void setBankFeeCurrency(String bankFeeCurrency) {
        this.bankFeeCurrency = bankFeeCurrency;
    }
}
