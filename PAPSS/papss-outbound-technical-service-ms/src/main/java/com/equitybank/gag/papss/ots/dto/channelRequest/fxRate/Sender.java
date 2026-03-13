
package com.equitybank.gag.papss.ots.dto.channelRequest.fxRate;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import jakarta.validation.constraints.*;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
        "countryCode",
        "currency",
        "amount",
        "isInvoice"
})
public class Sender implements Serializable {
    private final static long serialVersionUID = -2077720482669257279L;

    @NotBlank(message = "Country code is mandatory")
    @Size(min = 2, max = 2, message = "Country code must be 2 characters")
    @Pattern(regexp = "^[A-Z]+$", message = "Country code must be uppercase letters")
    @JsonProperty("countryCode")
    private String countryCode;

    @NotBlank(message = "Currency is mandatory")
    @Size(min = 3, max = 3, message = "Currency code must be 3 characters")
    @Pattern(regexp = "^[A-Z]+$", message = "Currency must be uppercase letters")
    @JsonProperty("currency")
    private String currency;

    @NotBlank(message = "Amount is mandatory")
    @DecimalMin(value = "0.01", message = "Amount must be greater than 0")
    @Digits(integer = 10, fraction = 2, message = "Amount must have up to 10 integer and 2 fraction digits")
    @JsonProperty("amount")
    private String amount;

    @NotBlank(message = "isInvoice is mandatory")
    @Pattern(regexp = "^(?i:true|false)$", message = "isInvoice must be either 'true' or 'false'")
    @JsonProperty("isInvoice")
    private String isInvoice;

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

    @JsonProperty("amount")
    public String getAmount() {
        return amount;
    }

    @JsonProperty("amount")
    public void setAmount(String amount) {
        this.amount = amount;
    }

    @JsonProperty("isInvoice")
    public String getIsInvoice() {
        return isInvoice;
    }

    @JsonProperty("isInvoice")
    public void setIsInvoice(String isInvoice) {
        this.isInvoice = isInvoice;
    }
}
