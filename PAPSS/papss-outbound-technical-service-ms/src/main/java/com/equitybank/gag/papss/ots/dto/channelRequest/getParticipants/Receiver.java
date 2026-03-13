
package com.equitybank.gag.papss.ots.dto.channelRequest.getParticipants;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
        "countryCode",
        "bic"
})
public class Receiver implements Serializable {
    private final static long serialVersionUID = 2560118395304908323L;

    @Pattern(regexp = "^[A-Z]{2}$|^$", message = "Country code must be 2 uppercase letters or empty")
    @JsonProperty("countryCode")
    private String countryCode;

    @Pattern(regexp = "^[a-zA-Z0-9]+$|^$", message = "BIC must be alphanumeric or empty")
    @JsonProperty("bic")
    private String bic;

    @JsonProperty("countryCode")
    public String getCountryCode() {
        return countryCode;
    }

    @JsonProperty("countryCode")
    public void setCountryCode(String countryCode) {
        this.countryCode = countryCode;
    }

    @JsonProperty("bic")
    public String getBic() {
        return bic;
    }

    @JsonProperty("bic")
    public void setBic(String bic) {
        this.bic = bic;
    }

}
