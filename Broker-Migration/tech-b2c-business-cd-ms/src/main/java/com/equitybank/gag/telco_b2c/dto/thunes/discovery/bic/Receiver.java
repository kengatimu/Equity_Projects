
package com.equitybank.gag.telco_b2c.dto.thunes.discovery.bic;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

import java.io.Serializable;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "bic"
})
public class Receiver implements Serializable {
    private final static long serialVersionUID = -8617250549088179195L;

    @NotBlank(message = "BIC is mandatory")
    @Pattern(regexp = "^[a-zA-Z0-9]+$", message = "BIC contains invalid characters")
    @JsonProperty("bic")
    private String bic;

    @JsonProperty("bic")
    public String getBic() {
        return bic;
    }

    @JsonProperty("bic")
    public void setBic(String bic) {
        this.bic = bic;
    }

}
