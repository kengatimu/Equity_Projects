
package com.equitybank.gag.papss.ots.dto.channelRequest.namecheck;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;

@JsonPropertyOrder({
    "institutionId",
    "bic",
    "accountNumber"
})
public class Receiver implements Serializable {
    private final static long serialVersionUID = -4810966544680563141L;

    @NotBlank(message = "Institution ID is mandatory")
    @Pattern(regexp = "^[a-zA-Z0-9_-]+$", message = "Institution ID contains invalid characters")
    @JsonProperty("institutionId")
    private String institutionId;

    @NotBlank(message = "BIC is mandatory")
    @Pattern(regexp = "^[a-zA-Z0-9]+$", message = "BIC contains invalid characters")
    @JsonProperty("bic")
    private String bic;

    @NotBlank(message = "Account number is mandatory")
    @Pattern(regexp = "^[a-zA-Z0-9]+$", message = "Account number contains invalid characters")
    @JsonProperty("accountNumber")
    private String accountNumber;

    public String getInstitutionId() {
        return institutionId;
    }

    public void setInstitutionId(String institutionId) {
        this.institutionId = institutionId;
    }

    public String getBic() {
        return bic;
    }

    public void setBic(String bic) {
        this.bic = bic;
    }

    public String getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(String accountNumber) {
        if (accountNumber == null) {
            this.accountNumber = null;
            return;
        }

        String trimmed = accountNumber.trim();

        // Explicitly reject internal whitespace
        if (trimmed.contains(" ")) {
            trimmed = trimmed.replace(" ", "");
        }

        this.accountNumber = trimmed;
    }

}
