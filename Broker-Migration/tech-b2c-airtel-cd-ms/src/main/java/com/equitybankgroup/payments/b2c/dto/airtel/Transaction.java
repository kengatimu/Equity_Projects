/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.dto.airtel;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;

/**
 *
 * @author ronaldcheruiyot
 */

@Data
@AllArgsConstructor
public class Transaction
{   
    @JsonProperty("id")
    private String id;
    
    @JsonProperty("amount")
    private String amount;
    
    @JsonProperty("payee")
    private PayeeRequest payee;

    
    
    
    
}
