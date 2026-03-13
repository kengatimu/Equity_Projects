/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybank.gag.orange_money_ms.dto.airtime;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;

/**
 *
 * @author ronaldcheruiyot
 */
@Data
@AllArgsConstructor
public class Bank2WalletRequest {

    @JsonProperty("transaction")
    private Transaction transaction;
     
    @JsonProperty("note")
    private String note;
    
    @JsonProperty("additional_info")
    private final Additional_info additional_info = new Additional_info();
    
    
    
    
    
}



