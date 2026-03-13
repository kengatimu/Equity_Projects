/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybank.gag.orange_money_ms.dto.airtime;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 *
 * @author ronaldcheruiyot
 */
public class AllocationRequest {
    
    @JsonProperty("transaction")
    private Transaction transaction;

    public AllocationRequest(Transaction transaction) {
        this.transaction = transaction;
    }

    public Transaction getTransaction() {
        return transaction;
    }

    public void setTransaction(Transaction transaction) {
        this.transaction = transaction;
    }
    
    
    
    /**
     * {
 "transaction": {
    "id": "1701860883",
    "amount": "123",
    "payee": {
        "address_type": "MOBILE",
        "msisdn": "040633736"
        }
 },
 "note": "Allocation",
 "additional_info": {}
}
     */
    
    
}



