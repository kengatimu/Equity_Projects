/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.dto.airtel.status;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 *
 * @author ronaldcheruiyot
 */
public class StatusCheckDataResponse {
    
    @JsonProperty("transaction")
    private StatusCheckTransaction transaction;

    public StatusCheckDataResponse() {
    }

    public StatusCheckTransaction getTransaction() {
        return transaction;
    }

    public void setTransaction(StatusCheckTransaction transaction) {
        this.transaction = transaction;
    }
    
    
    
}

