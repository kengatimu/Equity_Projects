
package com.bishop.papss_channel_mock_service.dto.channelRequest.statusCheck;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;

import java.io.Serializable;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "institutionId"
})
public class Receiver implements Serializable {
    private final static long serialVersionUID = -7766906343990368128L;

    @NotBlank(message = "Institution ID is mandatory")
    @Pattern(regexp = "^[a-zA-Z0-9_-]+$", message = "Institution ID contains invalid characters")
    @JsonProperty("institutionId")
    private String institutionId;

    @JsonProperty("institutionId")
    public String getInstitutionId() {
        return institutionId;
    }

    @JsonProperty("institutionId")
    public void setInstitutionId(String institutionId) {
        this.institutionId = institutionId;
    }

}
