/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.dto.airtel.allocation.common;

/**
 *
 * @author ronaldcheruiyot
 */
public class AirtelDTO {
    
    private int statusCode;
    private String telcoStatusCode;
    private String tranId;
    private String statusMessage;

    public AirtelDTO(int statusCode, String telcoStatusCode, String tranId, String statusMessage) {
        this.statusCode = statusCode;
        this.telcoStatusCode = telcoStatusCode;
        this.tranId = tranId;
        this.statusMessage = statusMessage;
    }

    

    public int getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(int statusCode) {
        this.statusCode = statusCode;
    }

    public String getTelcoStatusCode() {
        return telcoStatusCode;
    }

    public void setTelcoStatusCode(String telcoStatusCode) {
        this.telcoStatusCode = telcoStatusCode;
    }

    public String getTranId() {
        return tranId;
    }

    public void setTranId(String tranId) {
        this.tranId = tranId;
    }

    public String getStatusMessage() {
        return statusMessage;
    }

    public void setStatusMessage(String statusMessage) {
        this.statusMessage = statusMessage;
    }

    
    
    
    
}
