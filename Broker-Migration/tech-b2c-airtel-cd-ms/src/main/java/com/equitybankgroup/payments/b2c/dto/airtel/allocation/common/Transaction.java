/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.dto.airtel.allocation.common;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 *
 * @author ronaldcheruiyot
 */
public class Transaction
{   
    @JsonProperty("id")
    private String id;
    
    @JsonProperty("amount")
    private String amount;
    
    @JsonProperty("payee")
    private PayeeRequest payee;
    
    public Transaction(String id, String amount, PayeeRequest payee) {
        this.id = id;
        this.amount = amount;
        this.payee = payee;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public PayeeRequest getPayee() {
        return payee;
    }

    public void setPayee(PayeeRequest payee) {
        this.payee = payee;
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
