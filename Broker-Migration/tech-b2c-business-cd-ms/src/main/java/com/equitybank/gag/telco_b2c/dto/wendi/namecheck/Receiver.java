package com.equitybank.gag.telco_b2c.dto.wendi.namecheck;

import java.io.Serializable;
import javax.annotation.processing.Generated;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import jakarta.validation.constraints.Size;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
        "msisdn"
})
@Generated("jsonschema2pojo")
public class Receiver implements Serializable {
    private static final long serialVersionUID = -2448579210744920594L;

    @JsonProperty("msisdn")

    @NotBlank(message = "msisdn must not be blank")
    @Size(min = 5, max = 20, message = "msisdn length is invalid")
    @Pattern(regexp = "^\\+?[0-9]+$", message = "msisdn contains invalid characters")
    private String msisdn;

    @JsonProperty("msisdn")
    public String getMsisdn() {
        return msisdn;
    }

    @JsonProperty("msisdn")
    public void setMsisdn(String msisdn) {
        this.msisdn = msisdn;
    }
}