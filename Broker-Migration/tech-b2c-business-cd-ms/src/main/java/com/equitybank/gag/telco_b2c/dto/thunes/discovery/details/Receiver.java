
package com.equitybank.gag.telco_b2c.dto.thunes.discovery.details;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;

import java.io.Serializable;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "payerId"
})
public class Receiver implements Serializable {
    private final static long serialVersionUID = 1L;

    @NotBlank(message = "PayerId code is mandatory")
    @Pattern(regexp = "^[0-9]+$", message = "PayerId code must contain numeric characters")
    @JsonProperty("payerId")
    private String payerId;

    @JsonProperty("payerId")
    public String getPayerId() {
        return payerId;
    }

    @JsonProperty("payerId")
    public void setPayerId(String payerId) {
        this.payerId = payerId;
    }
}
