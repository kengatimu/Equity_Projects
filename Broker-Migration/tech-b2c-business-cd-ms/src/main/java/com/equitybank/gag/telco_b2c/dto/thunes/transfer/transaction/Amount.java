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
        "senderAmount",
        "senderCurrency",
        "receiverAmount",
        "receiverCurrency"
})
public class Amount implements Serializable {

    private static final long serialVersionUID = -7238283874096079662L;

    @NotBlank(message = "amount.senderAmount is mandatory")
    @Pattern(regexp = "^\\d+(\\.\\d{1,2})?$", message = "amount.senderAmount must be a valid positive amount with up to 2 decimals")
    @JsonProperty("senderAmount")
    private String senderAmount;

    @NotBlank(message = "amount.senderCurrency is mandatory")
    @Pattern(regexp = "[A-Z]{3}", message = "amount.senderCurrency must be ISO-4217 (e.g. USD, EUR)")
    @JsonProperty("senderCurrency")
    private String senderCurrency;

    @Pattern(regexp = "^\\d+(\\.\\d{1,2})?$", message = "amount.receiverAmount must be a valid positive amount with up to 2 decimals")
    @JsonProperty("receiverAmount")
    private String receiverAmount;

    @Pattern(regexp = "[A-Z]{3}", message = "amount.receiverCurrency must be ISO-4217 (e.g. USD, EUR)")
    @JsonProperty("receiverCurrency")
    private String receiverCurrency;

    @JsonProperty("senderAmount")
    public String getSenderAmount() {
        return senderAmount;
    }

    public void setSenderAmount(String senderAmount) {
        this.senderAmount = senderAmount;
    }

    @JsonProperty("senderCurrency")
    public String getSenderCurrency() {
        return senderCurrency;
    }

    public void setSenderCurrency(String senderCurrency) {
        this.senderCurrency = senderCurrency;
    }

    @JsonProperty("receiverAmount")
    public String getReceiverAmount() {
        return receiverAmount;
    }

    public void setReceiverAmount(String receiverAmount) {
        this.receiverAmount = receiverAmount;
    }

    @JsonProperty("receiverCurrency")
    public String getReceiverCurrency() {
        return receiverCurrency;
    }

    public void setReceiverCurrency(String receiverCurrency) {
        this.receiverCurrency = receiverCurrency;
    }
}
