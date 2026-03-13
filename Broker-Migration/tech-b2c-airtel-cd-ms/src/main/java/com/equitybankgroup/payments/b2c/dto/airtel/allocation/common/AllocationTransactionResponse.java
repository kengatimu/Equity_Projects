/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.dto.airtel.allocation.common;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.google.gson.Gson;

/**
 *
 * @author ronaldcheruiyot
 */
public class AllocationTransactionResponse {
    
    
    @JsonProperty("reference_id")
    private String reference_id;
    @JsonProperty("airtel_money_id")
    private String airtel_money_id;
    @JsonProperty("id")
    private String id;
    @JsonProperty("status")
    private String status;

    public AllocationTransactionResponse() {
    }

    public String getReference_id() {
        return reference_id;
    }

    public void setReference_id(String reference_id) {
        this.reference_id = reference_id;
    }

    public String getAirtel_money_id() {
        return airtel_money_id;
    }

    public void setAirtel_money_id(String airtel_money_id) {
        this.airtel_money_id = airtel_money_id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    

    public static void main(String[] args) {
        String resp = "{\n" +
"            \"reference_id\": \"24521837122\",\n" +
"            \"airtel_money_id\": \"disbursement-L2XF3XE2T5-34556756688785\",\n" +
"            \"id\": \"34556756688785\",\n" +
"            \"status\": \"TS\"\n" +
"        }";

        Gson g = new Gson();
        AllocationTransactionResponse respData = g.fromJson(resp, AllocationTransactionResponse.class);
        System.out.println("airtel_money_id: " + respData.getAirtel_money_id());
        System.out.println("reference_id: " + respData.getReference_id());
        System.out.println("id: " + respData.getId());
        System.out.println("status: " + respData.getStatus());
    }
    
    /**
     * {
            "reference_id": "24521837122",
            "airtel_money_id": "disbursement-L2XF3XE2T5-34556756688785",
            "id": "34556756688785",
            "status": "TS"
        }
     */
    
}

