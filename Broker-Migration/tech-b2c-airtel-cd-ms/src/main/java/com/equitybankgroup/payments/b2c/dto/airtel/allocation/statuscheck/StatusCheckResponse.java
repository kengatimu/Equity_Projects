/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.dto.airtel.allocation.statuscheck;

/**
 *
 * @author ronaldcheruiyot
 */
public class StatusCheckResponse {
    
    private StatusCheckDataResponse data;
    private StatusCheckStatus status;

    public StatusCheckResponse() {
    }

    public StatusCheckDataResponse getData() {
        return data;
    }

    public void setData(StatusCheckDataResponse data) {
        this.data = data;
    }

    public StatusCheckStatus getStatus() {
        return status;
    }

    public void setStatus(StatusCheckStatus status) {
        this.status = status;
    }
    
    
    
    
}

/**
{
    "data": {
        "transaction": {
            "id": "AB***41",
            "message": "Your Request is submitted Successfully.",
            "status": "TS"
        }
    },
    "status": {
        "code": "200",
        "message": "SUCCESS",
        "result_code": "ESB000010",
        "response_code": "DP00900001001",
        "success": true
    }
    * 
    * {
    "data": {
        "transaction": {
            "id": "9945456784",
            "message": "Transaction Failed",
            "status": "TF"
        }
    },
    "status": {
        "response_code": "DP00900001013",
        "code": "200",
        "success": true,
        "result_code": "ESB000010",
        "message": "SUCCESS"
    }
}{
    "data": {
        "transaction": {
            "id": "9945456785",
            "message": "Transaction Failed",
            "status": "TF"
        }
    },
    "status": {
        "code": "200",
        "message": "SUCCESS",
        "success": true
    }
}
* 
* 
    * **/
