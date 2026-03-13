/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybank.gag.telco_b2c.dto.json;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.google.gson.Gson;

/**
 *
 * @author ronaldcheruiyot
 */
public class StatusResponse {
    @JsonProperty("TransactionID")
//    @JsonInclude(JsonInclude.Include.NON_NULL)
    private String transactionID;
    
    @JsonProperty("OriginatingTransactionID")
//    @JsonInclude(JsonInclude.Include.NON_NULL)
    private String originatingTransactionID;
    
    @JsonProperty("Status")
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private String status;
    
    @JsonProperty("TransactionStatus")
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private String transactionStatus;

    public StatusResponse() {
    }

    public String getTransactionID() {
        return transactionID;
    }

    public void setTransactionID(String transactionID) {
        this.transactionID = transactionID;
    }

    public String getOriginatingTransactionID() {
        return originatingTransactionID;
    }

    public void setOriginatingTransactionID(String originatingTransactionID) {
        this.originatingTransactionID = originatingTransactionID;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getTransactionStatus() {
        return transactionStatus;
    }

    public void setTransactionStatus(String transactionStatus) {
        this.transactionStatus = transactionStatus;
    }

    
    
}

/**
 * {
    "TransactionID": "Sample String",
    "OriginatingTransactionID": "Sample String",
    "Status": "OK"
}
 */