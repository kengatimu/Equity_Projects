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
public class PayeeRequest
{
    @JsonProperty("msisdn")
    private String msisdn;
    
    @JsonProperty("address_type")
    private String address_type = "MOBILE";

    public PayeeRequest(String msisdn) {
        this.msisdn = msisdn;
    }
    
    

    
    
}
