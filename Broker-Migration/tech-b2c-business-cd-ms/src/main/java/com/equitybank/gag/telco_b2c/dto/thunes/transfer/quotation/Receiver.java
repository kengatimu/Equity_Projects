package com.equitybank.gag.telco_b2c.dto.thunes.transfer.quotation;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import jakarta.validation.constraints.*;

import java.io.Serializable;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
        "payerId",
        "currency"
})
public class Receiver implements Serializable {

    private static final long serialVersionUID = -8617250549088179195L;

    @NotBlank(message = "Payer ID is mandatory")
    @Size(min = 1, max = 50, message = "Payer ID must be between 1 and 50 characters")
    @Pattern(regexp = "^[A-Za-z0-9\\-_]+$", message = "Payer ID contains invalid characters")
    @JsonProperty("payerId")
    private String payerId;

    @NotBlank(message = "Currency is mandatory")
    @Size(min = 3, max = 3, message = "Currency must be a 3-letter ISO code")
    @JsonProperty("currency")
    private String currency;

    @JsonProperty("payerId")
    public String getPayerId() {
        return payerId;
    }

    @JsonProperty("payerId")
    public void setPayerId(String payerId) {
        this.payerId = payerId;
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
