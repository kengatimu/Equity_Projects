/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybank.gag.telco_b2c.dto.json;

import com.google.gson.Gson;
import java.math.BigDecimal;

/**
 *
 * @author ronaldcheruiyot
 */
public class CashAllocationRequest {
    private String AgentNumber;
    private BigDecimal Amount;
    private String Currency;
    private String ProviderName;
    private String TransactionId;

    public CashAllocationRequest() {
    }

    public String getAgentNumber() {
        return AgentNumber;
    }

    public void setAgentNumber(String AgentNumber) {
        this.AgentNumber = AgentNumber;
    }

    public BigDecimal getAmount() {
        return Amount;
    }

    public void setAmount(BigDecimal Amount) {
        this.Amount = Amount;
    }

    public String getCurrency() {
        return Currency;
    }

    public void setCurrency(String Currency) {
        this.Currency = Currency;
    }

    public String getProviderName() {
        return ProviderName;
    }

    public void setProviderName(String ProviderName) {
        this.ProviderName = ProviderName;
    }

    public String getTransactionId() {
        return TransactionId;
    }

    public void setTransactionId(String TransactionId) {
        this.TransactionId = TransactionId;
    }
    
    public static void main(String[] args) {
        String req = "{\n" +
"    \"AgentNumber\": \"+2331327432232\",\n" +
"    \"Amount\": 1400.0,\n" +
"    \"Currency\": \"USD\",\n" +
"    \"ProviderName\": \"samplestring\",\n" +
"    \"TransactionId\": \"SampleString\"\n" +
"}";
        CashAllocationRequest request = (new Gson()).fromJson(req, CashAllocationRequest.class);
        System.out.println("AgentNumber: " + request.getAgentNumber());
        System.out.println("Amount: " + request.getAmount());
        System.out.println("Currency: " + request.getCurrency());
        System.out.println("ProviderName: " + request.getProviderName());
        System.out.println("TransactionId: " + request.getTransactionId());
    }
    
    
}



/**
 * {
    "AgentNumber": "+2331327432232",
    "Amount": 1400.0,
    "Currency": "USD",
    "ProviderName": "samplestring",
    "TransactionId": "SampleString"
}
 */