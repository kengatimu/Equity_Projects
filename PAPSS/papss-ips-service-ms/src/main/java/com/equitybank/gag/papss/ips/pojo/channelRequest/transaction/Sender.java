
package com.equitybank.gag.papss.ips.pojo.channelRequest.transaction;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
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
    "address"
})
public class Sender implements Serializable {
    private final static long serialVersionUID = -9085830674079127038L;

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

    @NotBlank(message = "Address is mandatory")
    @Pattern(regexp = "^[a-zA-Z0-9\\s\\-.,#@]+$", message = "Address contains invalid characters")
    @JsonProperty("address")
    private String address;

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

    @JsonProperty("accountNumber")
    public String getAccountNumber() {
        return accountNumber;
    }

    @JsonProperty("accountNumber")
    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }

    @JsonProperty("accountName")
    public String getAccountName() {
        return accountName;
    }

    @JsonProperty("accountName")
    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    @JsonProperty("address")
    public String getAddress() {
        return address;
    }

    @JsonProperty("address")
    public void setAddress(String address) {
        this.address = address;
    }

}
