/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybank.gag.telco_b2c.dto.json;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 *
 * @author ronaldcheruiyot
 */
public class StatusRequest {
    @JsonProperty("OriginatingTransactionID")
    private String OriginatingTransactionID;

    public StatusRequest() {
    }

    public String getOriginatingTransactionID() {
        return OriginatingTransactionID;
    }

    public void setOriginatingTransactionID(String OriginatingTransactionID) {
        this.OriginatingTransactionID = OriginatingTransactionID;
    }

    
    
    
    
}
