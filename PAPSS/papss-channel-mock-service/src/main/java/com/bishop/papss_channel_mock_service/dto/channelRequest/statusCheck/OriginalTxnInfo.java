
package com.bishop.papss_channel_mock_service.dto.channelRequest.statusCheck;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

import java.io.Serializable;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "originalRrn"
})
public class OriginalTxnInfo implements Serializable {
    private final static long serialVersionUID = 5585929011730282847L;

    @NotBlank(message = "originalRrn is mandatory")
    @Size(min= 12, max = 12, message = "originalRrn must be 12 characters")
    @Pattern(regexp = "^[a-zA-Z0-9]+$", message = "RRN contains invalid characters")
    @JsonProperty("originalRrn")
    private String originalRrn;

    @JsonProperty("originalRrn")
    public String getOriginalRrn() {
        return originalRrn;
    }

    @JsonProperty("originalRrn")
    public void setOriginalRrn(String originalRrn) {
        this.originalRrn = originalRrn;
    }

}
