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
public class Additional_info {
    
    @JsonProperty("mq_txn_id")
    private String mq_txn_id;

    public Additional_info() {
    }

    public String getMq_txn_id() {
        return mq_txn_id;
    }

    public void setMq_txn_id(String mq_txn_id) {
        this.mq_txn_id = mq_txn_id;
    }
    
    
    
}
