package com.equitybank.gag.telco_b2c.dto.thunes.transfer.quotation;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;

import java.io.Serializable;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
        "transactionType"
})
public class TransactionDetails implements Serializable {

    private static final long serialVersionUID = -8617250549188179195L;

    @NotBlank(message = "Transaction type is mandatory")
    @Pattern(regexp = "^(C2C|B2C|C2B|B2B)$", message = "Transaction type must be one of: C2C, B2C, C2B, or B2B")
    @JsonProperty("transactionType")
    private String transactionType;

    @JsonProperty("transactionType")
    public String getTransactionType() {
        return transactionType;
    }

    @JsonProperty("transactionType")
    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
    }
}
