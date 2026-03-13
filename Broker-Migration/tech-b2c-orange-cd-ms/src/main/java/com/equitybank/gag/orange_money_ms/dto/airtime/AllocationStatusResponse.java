/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybank.gag.orange_money_ms.dto.airtime;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.google.gson.Gson;

/**
 *
 * @author ronaldcheruiyot
 */
public class AllocationStatusResponse {
    
    @JsonProperty("code")
    private String code;
    
    @JsonProperty("message")
    private String message;
    
    @JsonProperty("success")
    private boolean success;
    
    @JsonProperty("response_code")
    private String response_code;

    public AllocationStatusResponse() {
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getResponse_code() {
        return response_code;
    }

    public void setResponse_code(String response_code) {
        this.response_code = response_code;
    }
 

    

    public static void main(String[] args) {
        String resp = "{\n" +
"        \"response_code\": \"DP02050001001\",\n" +
"        \"code\": \"200\",\n" +
"        \"success\": true,\n" +
"        \"message\": \"SUCCESS\"\n" +
"    }";
        
        AllocationStatusResponse statusResp = (new Gson()).fromJson(resp, AllocationStatusResponse.class);
        System.out.println("response_code: " + statusResp.getResponse_code());
        System.out.println("code: " + statusResp.getCode());
        System.out.println("success: " + statusResp.isSuccess());
        System.out.println("message: " + statusResp.getMessage());
        
    }
    
    
}
