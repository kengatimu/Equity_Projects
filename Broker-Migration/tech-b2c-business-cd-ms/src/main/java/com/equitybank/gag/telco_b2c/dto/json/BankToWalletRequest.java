/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybank.gag.telco_b2c.dto.json;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.google.gson.Gson;
import java.math.BigDecimal;

/**
 *
 * @author ronaldcheruiyot
 */
public class BankToWalletRequest {
    
    @JsonProperty("BeneficiaryPhoneNumber")
    private String BeneficiaryPhoneNumber;
    
    @JsonProperty("Amount")
    private BigDecimal Amount;
    
    @JsonProperty("ProviderName")
    private String ProviderName;
    
    @JsonProperty("Currency")
    private String Currency;
    
    @JsonProperty("TransactionID")
    private String TransactionID;

    public BankToWalletRequest() {
    }

    public String getBeneficiaryPhoneNumber() {
        return BeneficiaryPhoneNumber;
    }

    public void setBeneficiaryPhoneNumber(String BeneficiaryPhoneNumber) {
        this.BeneficiaryPhoneNumber = BeneficiaryPhoneNumber;
    }

    public BigDecimal getAmount() {
        return Amount;
    }

    public void setAmount(BigDecimal Amount) {
        this.Amount = Amount;
    }

    public String getProviderName() {
        return ProviderName;
    }

    public void setProviderName(String ProviderName) {
        this.ProviderName = ProviderName;
    }

    public String getCurrency() {
        return Currency;
    }

    public void setCurrency(String Currency) {
        this.Currency = Currency;
    }

    public String getTransactionID() {
        return TransactionID;
    }

    public void setTransactionID(String TransactionID) {
        this.TransactionID = TransactionID;
    }

    
    
    public static void main(String[] args) {
        String req = "{\n" +
"    \"BeneficiaryPhoneNumber\": \"sample string 2\",\n" +
"    \"Amount\": 3.0,\n" +
"    \"ProviderName\": \"sample string 3\",\n" +
"    \"Currency\": \"CDF\",\n" +
"    \"TransactionID\": \"sample string 4\"\n" +
"}";
        System.out.println(req);
        BankToWalletRequest request = (new Gson()).fromJson(req, BankToWalletRequest.class);
        System.out.println("BeneficiaryPhoneNumber: " + request.getBeneficiaryPhoneNumber());
        System.out.println("Amount: " + request.getAmount());
        System.out.println("ProviderName: " + request.getProviderName());
        System.out.println("Currency: " + request.getCurrency());
        System.out.println("TransactionID: " + request.getTransactionID());
    }
    
}
/**
 * {
 "BeneficiaryPhoneNumber": "sample string 2",
 "Amount": 3.0,
 "ProviderName": “sample string 3”,
 "Currency": "CDF",
 "TransactionID": "sample string 4"
}
 */