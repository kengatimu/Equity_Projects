
package com.equitybank.payments.imt.b2c.response.service.model.request;

import java.io.Serializable;
import javax.annotation.Generated;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "BeneficiaryPhoneNumber",
    "ProviderName",
    "Amount",
    "Currency",
    "TransactionID"
})
@Generated("jsonschema2pojo")
public class BrokerServiceRequest implements Serializable
{

    @JsonProperty("BeneficiaryPhoneNumber")
    private String beneficiaryPhoneNumber;
    @JsonProperty("ProviderName")
    private String providerName;
    @JsonProperty("Amount")
    private Integer amount;
    @JsonProperty("Currency")
    private String currency;
    @JsonProperty("TransactionID")
    private String transactionID;
    private final static long serialVersionUID = 2908319721018812409L;

    @JsonProperty("BeneficiaryPhoneNumber")
    public String getBeneficiaryPhoneNumber() {
        return beneficiaryPhoneNumber;
    }

    @JsonProperty("BeneficiaryPhoneNumber")
    public void setBeneficiaryPhoneNumber(String beneficiaryPhoneNumber) {
        this.beneficiaryPhoneNumber = beneficiaryPhoneNumber;
    }

    @JsonProperty("ProviderName")
    public String getProviderName() {
        return providerName;
    }

    @JsonProperty("ProviderName")
    public void setProviderName(String providerName) {
        this.providerName = providerName;
    }

    @JsonProperty("Amount")
    public Integer getAmount() {
        return amount;
    }

    @JsonProperty("Amount")
    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    @JsonProperty("Currency")
    public String getCurrency() {
        return currency;
    }

    @JsonProperty("Currency")
    public void setCurrency(String currency) {
        this.currency = currency;
    }

    @JsonProperty("TransactionID")
    public String getTransactionID() {
        return transactionID;
    }

    @JsonProperty("TransactionID")
    public void setTransactionID(String transactionID) {
        this.transactionID = transactionID;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(BrokerServiceRequest.class.getName()).append('@').append(Integer.toHexString(System.identityHashCode(this))).append('[');
        sb.append("beneficiaryPhoneNumber");
        sb.append('=');
        sb.append(((this.beneficiaryPhoneNumber == null)?"<null>":this.beneficiaryPhoneNumber));
        sb.append(',');
        sb.append("providerName");
        sb.append('=');
        sb.append(((this.providerName == null)?"<null>":this.providerName));
        sb.append(',');
        sb.append("amount");
        sb.append('=');
        sb.append(((this.amount == null)?"<null>":this.amount));
        sb.append(',');
        sb.append("currency");
        sb.append('=');
        sb.append(((this.currency == null)?"<null>":this.currency));
        sb.append(',');
        sb.append("transactionID");
        sb.append('=');
        sb.append(((this.transactionID == null)?"<null>":this.transactionID));
        sb.append(',');
        if (sb.charAt((sb.length()- 1)) == ',') {
            sb.setCharAt((sb.length()- 1), ']');
        } else {
            sb.append(']');
        }
        return sb.toString();
    }

}
