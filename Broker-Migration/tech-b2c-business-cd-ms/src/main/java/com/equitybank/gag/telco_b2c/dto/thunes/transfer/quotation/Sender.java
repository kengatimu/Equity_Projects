package com.equitybank.gag.telco_b2c.dto.thunes.transfer.quotation;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import jakarta.validation.constraints.*;

import java.io.Serializable;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
        "amount",
        "countryCode",
        "currency"
})
public class Sender implements Serializable {

    private static final long serialVersionUID = -8617250549188179195L;

    @NotBlank(message = "Amount is mandatory")
    @Pattern(regexp = "^[0-9]+(\\.[0-9]{1,2})?$", message = "Amount must be a valid number with up to 2 decimals")
    @JsonProperty("amount")
    private String amount;

    @NotBlank(message = "Country code is mandatory")
    @Size(min = 3, max = 3, message = "Country code must be 3 letters")
    @JsonProperty("countryCode")
    private String countryCode;

    @NotBlank(message = "Currency is mandatory")
    @Size(min = 3, max = 3, message = "Currency must be a 3-letter ISO code")
    @JsonProperty("currency")
    private String currency;

    @JsonProperty("amount")
    public String getAmount() {
        return amount;
    }

    @JsonProperty("amount")
    public void setAmount(String amount) {
        this.amount = amount;
    }

    @JsonProperty("countryCode")
    public String getCountryCode() {
        return countryCode;
    }

    @JsonProperty("countryCode")
    public void setCountryCode(String countryCode) {
        this.countryCode = countryCode;
    }

    @JsonProperty("currency")
    public String getCurrency() {
        return currency;
    }

    @JsonProperty("currency")
    public void setCurrency(String currency) {
        this.currency = currency;
    }
}
