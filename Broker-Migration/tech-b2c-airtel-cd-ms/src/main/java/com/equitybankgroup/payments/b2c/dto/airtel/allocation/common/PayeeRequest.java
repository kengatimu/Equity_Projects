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
public class PayeeRequest
{
    @JsonProperty("msisdn")
    private String msisdn;
    
    @JsonProperty("address_type")
    private String address_type = "MOBILE";
    
    public PayeeRequest() {
    }

    public PayeeRequest(String msisdn) {
        this.msisdn = msisdn;
    }
    
    
    
    public String getMsisdn() {
        return msisdn;
    }

    public void setMsisdn(String msisdn) {
        this.msisdn = msisdn;
    }

    public String getAddress_type() {
        return address_type;
    }

    public void setAddress_type(String address_type) {
        this.address_type = address_type;
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
