/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybank.gag.telco_b2c.dto.json;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.google.gson.Gson;
import jakarta.validation.constraints.*;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 *
 * @author ronaldcheruiyot
 */
public class AirtimeRequest implements Serializable {
    
    private final static long serialVersionUID = 1804800645276607876L;
    
    final String REGEX_0 = "[^'&´+`~<>/=:;!@#$%^*?]*";
    final String REGEX_1 = "[^<>?=:;@#]*";
    final String REGEX_2 = "[^<>?=;@#]*";
    final String REGEX_3 = "[^/<>?=]*";
    
    @DecimalMin(value = "0.0", inclusive = false, message = "Amount must be greater than zero")
    @NotNull(message = "Amount Must Be Provided")
    @JsonProperty("Amount")
    private BigDecimal Amount;
    
    @Pattern(
        regexp = "^[+0-9]*$", 
        message = "Invalid input in BeneficiaryPhoneNumber field"
    )
    @NotBlank(message = "BeneficiaryPhoneNumber Must Be Provided")
    @Size(min = 9, message = "BeneficiaryPhoneNumber is Too small")
    @Size(max = 30, message = "BeneficiaryPhoneNumber Is Too Large")
    @JsonProperty("BeneficiaryPhoneNumber")
    private String BeneficiaryPhoneNumber;
    
    @Pattern(regexp = REGEX_0, message = "Special characters is not allowed in TransactionReference field")
    @NotBlank(message = "TransactionReference Must Be Provided")
    @Size(min = 1, message = "TransactionReference Must Not Be Empty")
    @Size(max = 20, message = "TransactionReference Is Too Large")
    @JsonProperty("TransactionReference")
    private String TransactionReference;
    
    @Pattern(regexp = REGEX_0, message = "Special characters is not allowed in ProviderName field")
    @NotBlank(message = "ProviderName Must Be Provided")
    @Size(min = 1, message = "ProviderName Must Be Provided")
    @Size(max = 20, message = "ProviderName Is Too Large")
    @JsonProperty("ProviderName")
    private String ProviderName;
    
    @Pattern(regexp = REGEX_0, message = "Special characters is not allowed in Currency field")
    @Pattern(regexp = "^(USD|CDF)$", message = "Currency must be either 'USD' or 'CDF'")
    @NotBlank(message = "Currency Must Be Provided")
    @Size(min = 1, message = "Currency Must Be Provided")
    @Size(max = 20, message = "Currency Is Too Large")
    @JsonProperty("Currency")
    private String Currency;

    public AirtimeRequest() {
    }

    public BigDecimal getAmount() {
        return Amount;
    }

    public void setAmount(BigDecimal Amount) {
        this.Amount = Amount;
    }

    public String getBeneficiaryPhoneNumber() {
        return BeneficiaryPhoneNumber;
    }

    public void setBeneficiaryPhoneNumber(String BeneficiaryPhoneNumber) {
        this.BeneficiaryPhoneNumber = BeneficiaryPhoneNumber;
    }

    public String getTransactionReference() {
        return TransactionReference;
    }

    public void setTransactionReference(String TransactionReference) {
        this.TransactionReference = TransactionReference;
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
    
    
    
    public static void main(String[] args) {
        String req = "{\n" +
"    \"Amount\": 3.0,\n" +
"    \"BeneficiaryPhoneNumber\": \"sample string 4\",\n" +
"    \"TransactionReference\": \"sample string 5\",\n" +
"    \"ProviderName\": \"sample string 6\"\n" +
"}";
        System.out.println(req);
        AirtimeRequest request = (new Gson()).fromJson(req, AirtimeRequest.class);
        System.out.println("Amount: " + request.getAmount());
        System.out.println("BeneficiaryPhoneNumber: " + request.getBeneficiaryPhoneNumber());
        System.out.println("TransactionReference: " + request.getTransactionReference());
        System.out.println("ProviderName: " + request.getProviderName());
    }
}

/**
 * {
 "Amount": 3.0,
 "BeneficiaryPhoneNumber": "sample string 4",
 "TransactionReference": "sample string 5",
 "ProviderName": "sample string 6"
}
 */