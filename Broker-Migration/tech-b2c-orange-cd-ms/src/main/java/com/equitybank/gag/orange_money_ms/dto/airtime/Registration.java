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
public class Registration {
    
    @JsonProperty("status")
    private String status;

    public Registration() {
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
    
}
