
package com.equitybank.payments.imt.b2c.drcbroker.service.model.request;

import java.io.Serializable;
import javax.annotation.Generated;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "AccountNumber",
    "BeneficiaryPhoneNumber",
    "Amount",
    "Currency",
    "TransactionID"
})
@Generated("jsonschema2pojo")
public class AtmCodeRequest implements Serializable
{

    @JsonProperty("AccountNumber")
    private String AccountNumber;
    @JsonProperty("BeneficiaryPhoneNumber")
    private String BeneficiaryPhoneNumber;
    @JsonProperty("Amount")
    private String Amount;
    @JsonProperty("Currency")
    private String Currency;
    @JsonProperty("TransactionID")
    private String TransactionID;
    private final static long serialVersionUID = -7784150038365948344L;

    public String getAccountNumber() {
        return AccountNumber;
    }

    public void setAccountNumber(String accountNumber) {
        AccountNumber = accountNumber;
    }

    public String getBeneficiaryPhoneNumber() {
        return BeneficiaryPhoneNumber;
    }

    public void setBeneficiaryPhoneNumber(String beneficiaryPhoneNumber) {
        BeneficiaryPhoneNumber = beneficiaryPhoneNumber;
    }

    public String getAmount() {
        return Amount;
    }

    public void setAmount(String amount) {
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
        return "BrokerServiceAtmCodeRequest{" +
                "AccountNumber='" + AccountNumber + '\'' +
                ", BeneficiaryPhoneNumber='" + BeneficiaryPhoneNumber + '\'' +
                ", Amount='" + Amount + '\'' +
                ", Currency='" + Currency + '\'' +
                ", TransactionID='" + TransactionID + '\'' +
                '}';
    }
}
