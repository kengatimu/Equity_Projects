
package com.bishop.papss_channel_mock_service.dto.channelRequest.transaction;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

import java.io.Serializable;

@JsonPropertyOrder({
    "institutionId",
    "bic",
    "countryCode",
    "currency",
    "accountNumber",
    "accountName",
    "emailAddress"
})
public class Receiver implements Serializable {
    private final static long serialVersionUID = -5394437748572380806L;

    @NotBlank(message = "Institution ID is mandatory")
    @Pattern(regexp = "^[a-zA-Z0-9_-]+$", message = "Institution ID contains invalid characters")
    @JsonProperty("institutionId")
    private String institutionId;

    @NotBlank(message = "BIC is mandatory")
    @Pattern(regexp = "^[a-zA-Z0-9]+$", message = "BIC contains invalid characters")
    @JsonProperty("bic")
    private String bic;

    @NotBlank(message = "Country code is mandatory")
    @Size(min = 2, max = 3, message = "Country code must be 2 or 3 characters")
    @Pattern(regexp = "^[A-Z]+$", message = "Country code must be uppercase letters")
    @JsonProperty("countryCode")
    private String countryCode;

    @NotBlank(message = "Currency is mandatory")
    @Size(min = 3, max = 3, message = "Currency code must be 3 characters")
    @Pattern(regexp = "^[A-Z]+$", message = "Currency must be uppercase letters")
    @JsonProperty("currency")
    private String currency;

    @NotBlank(message = "Account number is mandatory")
    @Pattern(regexp = "^[a-zA-Z0-9]+$", message = "Account number contains invalid characters")
    @JsonProperty("accountNumber")
    private String accountNumber;

    @NotBlank(message = "Account name is mandatory")
    @Pattern(regexp = "^[a-zA-Z0-9\\s\\-._]+$", message = "Account name contains invalid characters")
    @JsonProperty("accountName")
    private String accountName;

    @NotBlank(message = "Email address is mandatory")
    @Email(message = "Email should be valid")
    @JsonProperty("emailAddress")
    private String emailAddress;

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

    public String getCountryCode() {
        return countryCode;
    }

    public void setCountryCode(String countryCode) {
        this.countryCode = countryCode;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    public String getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    public String getEmailAddress() {
        return emailAddress;
    }

    public void setEmailAddress(String emailAddress) {
        this.emailAddress = emailAddress;
    }
}
