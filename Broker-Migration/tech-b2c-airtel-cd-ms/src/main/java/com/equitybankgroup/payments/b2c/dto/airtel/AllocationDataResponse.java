/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.dto.airtel;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.google.gson.Gson;

/**
 *
 * @author ronaldcheruiyot
 */
public class AllocationDataResponse {
    
    @JsonProperty("Additional_info")
    private Additional_info additional_info;
    
    @JsonProperty("transaction")
    private AllocationTransactionResponse transaction;

    public AllocationDataResponse() {
    }

    public Additional_info getAdditional_info() {
        return additional_info;
    }

    public void setAdditional_info(Additional_info additional_info) {
        this.additional_info = additional_info;
    }

    

    public AllocationTransactionResponse getTransaction() {
        return transaction;
    }

    public void setTransaction(AllocationTransactionResponse transaction) {
        this.transaction = transaction;
    }

     public static void main(String[] args) {
        String resp = "{\n" +
"    \"additional_info\": {\n" +
"        \"mq_txn_id\": \"LC231206.1213.C00003\"\n" +
"    },\n" +
"    \"transaction\": {\n" +
"        \"reference_id\": \"APCCG127001004419712\",\n" +
"        \"airtel_money_id\": \"ALLO-EJBWGEX000-1701861217\",\n" +
"        \"id\": \"1701861217\",\n" +
"        \"status\": \"TS\"\n" +
"    }\n" +
"}";

        Gson g = new Gson();
        AllocationDataResponse respData = g.fromJson(resp, AllocationDataResponse.class);
        System.out.println("Airtel Money Id: " + respData.getTransaction().getAirtel_money_id());
        System.out.println("Reference Id: " + respData.getTransaction().getReference_id());
    }
    
    /**
     * {
 "data": {
 "additional_info": {
 "mq_txn_id": "LC231206.1213.C00003"
 },
 "transaction": {
 "reference_id": "APCCG127001004419712",
 "airtel_money_id": "ALLO-EJBWGEX000-1701861217",
 "id": "1701861217",
 "status": "TS"
 }
 },
 "status": {
 "response_code": "DP02050001001",
 "code": "200",
 "success": true,
 "message": "SUCCESS"
 }
}
     */
    
}

