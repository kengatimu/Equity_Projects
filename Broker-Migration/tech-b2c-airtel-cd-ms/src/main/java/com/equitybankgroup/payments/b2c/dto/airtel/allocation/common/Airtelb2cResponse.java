/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.dto.airtel.allocation.common;

import com.equitybankgroup.payments.b2c.enums.TranStatus;
import java.util.Map;

/**
 *
 * @author ronaldcheruiyot
 */
public class Airtelb2cResponse {
    private TranStatus status;
    private String message;
    private Map<String, Object> aditionalData;

    public Airtelb2cResponse() {
    }

    public TranStatus getStatus() {
        return status;
    }

    public void setStatus(TranStatus status) {
        this.status = status;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Map<String, Object> getAditionalData() {
        return aditionalData;
    }

    public void setAditionalData(Map<String, Object> aditionalData) {
        this.aditionalData = aditionalData;
    }
    
    
    
}

