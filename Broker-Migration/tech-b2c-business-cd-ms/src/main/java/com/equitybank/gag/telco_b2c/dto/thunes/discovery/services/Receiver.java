
package com.equitybank.gag.telco_b2c.dto.thunes.discovery.services;

import java.io.Serializable;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "countryCode"
})
public class Receiver implements Serializable {
    private final static long serialVersionUID = -8617250549088179195L;

    @NotBlank(message = "Country code is mandatory")
    @Size(min = 3, max = 3, message = "Country code must 3 characters")
    @Pattern(regexp = "^[a-zA-Z]+$", message = "Country code contains invalid characters")
    @JsonProperty("countryCode")
    private String countryCode;

    @JsonProperty("countryCode")
    public String getCountryCode() {
        return countryCode;
    }

    @JsonProperty("countryCode")
    public void setCountryCode(String countryCode) {
        this.countryCode = countryCode;
    }

}
