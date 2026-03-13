
package com.equitybank.gag.telco_b2c.dto.thunes.creditParties.creditPartyVerify;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;

import java.io.Serializable;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
        "serviceId",
        "msisdn",
        "bankAccountNumber",
        "businessRegisteredName",
        "payerId",
        "bic",
        "transactionType"
})
public class Receiver implements Serializable {
    private final static long serialVersionUID = 1L;

    @NotBlank(message = "Service ID is mandatory")
    @Pattern(regexp = "^[0-9]+$", message = "Payer ID contains invalid characters")
    @JsonProperty("serviceId")
    private String serviceId;

    @JsonProperty("msisdn")
    private String msisdn;

    @JsonProperty("bankAccountNumber")
    private String bankAccountNumber;

    @JsonProperty("businessRegisteredName")
    private String businessRegisteredName;

    @NotBlank(message = "Payer ID is mandatory")
    @Pattern(regexp = "^[a-zA-Z0-9]+$", message = "Payer ID contains invalid characters")
    @JsonProperty("payerId")
    private String payerId;

    @JsonProperty("bic")
    private String bic;

    @NotBlank(message = "Transaction Type is mandatory")
    @Pattern(regexp = "^[a-zA-Z0-9]+$", message = "Transaction Type contains invalid characters")
    @JsonProperty("transactionType")
    private String transactionType;

    @JsonProperty("serviceId")
    public String getServiceId() {
        return serviceId;
    }

    @JsonProperty("serviceId")
    public void setServiceId(String serviceId) {
        this.serviceId = serviceId;
    }

    @JsonProperty("msisdn")
    public String getMsisdn() {
        return msisdn;
    }

    @JsonProperty("msisdn")
    public void setMsisdn(String msisdn) {
        this.msisdn = msisdn;
    }

    @JsonProperty("bankAccountNumber")
    public String getBankAccountNumber() {
        return bankAccountNumber;
    }

    @JsonProperty("bankAccountNumber")
    public void setBankAccountNumber(String bankAccountNumber) {
        this.bankAccountNumber = bankAccountNumber;
    }

    @JsonProperty("businessRegisteredName")
    public String getBusinessRegisteredName() {
        return businessRegisteredName;
    }

    @JsonProperty("businessRegisteredName")
    public void setBusinessRegisteredName(String businessRegisteredName) {
        this.businessRegisteredName = businessRegisteredName;
    }

    @JsonProperty("payerId")
    public String getPayerId() {
        return payerId;
    }

    @JsonProperty("payerId")
    public void setPayerId(String payerId) {
        this.payerId = payerId;
    }

    @JsonProperty("bic")
    public String getBic() {
        return bic;
    }

    @JsonProperty("bic")
    public void setBic(String bic) {
        this.bic = bic;
    }

    @JsonProperty("transactionType")
    public String getTransactionType() {
        return transactionType;
    }

    @JsonProperty("transactionType")
    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
    }
}
