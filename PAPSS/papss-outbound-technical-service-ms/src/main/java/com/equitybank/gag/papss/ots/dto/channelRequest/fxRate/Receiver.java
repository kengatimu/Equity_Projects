
package com.equitybank.gag.papss.ots.dto.channelRequest.fxRate;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
        "institutionId",
        "countryCode",
        "currency"
})
public class Receiver implements Serializable {
    private final static long serialVersionUID = -6839675990096869038L;

    @NotBlank(message = "Receiver Institution ID is mandatory")
    @Pattern(regexp = "^[a-zA-Z0-9_-]+$", message = "Receiver Institution ID contains invalid characters")
    @JsonProperty("institutionId")
    private String institutionId;

    @NotBlank(message = "Receiver Country code is mandatory")
    @Size(min = 2, max = 2, message = "Receiver Country code must be 2 characters")
    @Pattern(regexp = "^[A-Z]+$", message = "Receiver Country code must be uppercase letters")
    @JsonProperty("countryCode")
    private String countryCode;

    @NotBlank(message = "Receiver Currency is mandatory")
    @Size(min = 3, max = 3, message = "Receiver Currency code must be 3 characters")
    @Pattern(regexp = "^[A-Z]+$", message = "Receiver Currency must be uppercase letters")
    @JsonProperty("currency")
    private String currency;

    @JsonProperty("institutionId")
    public String getInstitutionId() {
        return institutionId;
    }

    @JsonProperty("institutionId")
    public void setInstitutionId(String institutionId) {
        this.institutionId = institutionId;
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
