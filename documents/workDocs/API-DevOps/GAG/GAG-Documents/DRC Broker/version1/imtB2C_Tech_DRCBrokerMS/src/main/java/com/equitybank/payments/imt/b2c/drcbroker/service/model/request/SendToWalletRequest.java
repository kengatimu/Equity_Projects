
package com.equitybank.payments.imt.b2c.drcbroker.service.model.request;

import java.io.Serializable;
import java.math.BigDecimal;
import javax.annotation.Generated;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
        "BeneficiaryPhoneNumber",
        "PhoneNumber",
        "ProviderName",
        "Amount",
        "Currency",
        "TransactionID"
})
@Generated("jsonschema2pojo")
public class SendToWalletRequest implements Serializable {

    @JsonProperty("BeneficiaryPhoneNumber")
    private String BeneficiaryPhoneNumber;
//    @JsonProperty("PhoneNumber")
//    private String PhoneNumber;
    @JsonProperty("ProviderName")
    private String ProviderName;
    @JsonProperty("Amount")
    private BigDecimal Amount;
    @JsonProperty("Currency")
    private String Currency;
    @JsonProperty("TransactionID")
    private String TransactionID;
    private final static long serialVersionUID = 2908319721018812409L;

    public String getBeneficiaryPhoneNumber() {
        return BeneficiaryPhoneNumber;
    }

    public void setBeneficiaryPhoneNumber(String beneficiaryPhoneNumber) {
        BeneficiaryPhoneNumber = beneficiaryPhoneNumber;
    }

//    public String getPhoneNumber() {
//        return PhoneNumber;
//    }
//
//    public void setPhoneNumber(String phoneNumber) {
//        PhoneNumber = phoneNumber;
//    }

    public String getProviderName() {
        return ProviderName;
    }

    public void setProviderName(String providerName) {
        ProviderName = providerName;
    }

    public BigDecimal getAmount() {
        return Amount;
    }

    public void setAmount(BigDecimal amount) {
        Amount = amount;
    }

    public String getCurrency() {
        return Currency;
    }

    public void setCurrency(String currency) {
        Currency = currency;
    }

    public String getTransactionID() {
        return TransactionID;
    }

    public void setTransactionID(String transactionID) {
        TransactionID = transactionID;
    }

    @Override
    public String toString() {
        return "BrokerServiceRequest{" +
                "BeneficiaryPhoneNumber='" + BeneficiaryPhoneNumber + '\'' +
//                ", PhoneNumber='" + PhoneNumber + '\'' +
                ", ProviderName='" + ProviderName + '\'' +
                ", Amount=" + Amount +
                ", Currency='" + Currency + '\'' +
                ", TransactionID='" + TransactionID + '\'' +
                '}';
    }
}
