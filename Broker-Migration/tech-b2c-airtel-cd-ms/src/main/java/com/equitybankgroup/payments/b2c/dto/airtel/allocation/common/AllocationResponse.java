/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.dto.airtel.allocation.common;

import com.google.gson.Gson;

/**
 *
 * @author ronaldcheruiyot
 */

public class AllocationResponse
{
    private AllocationDataResponse data;

    private AllocationStatusResponse status;

    public AllocationResponse() {
    }

    public AllocationDataResponse getData() {
        return data;
    }

    public void setData(AllocationDataResponse data) {
        this.data = data;
    }

    public AllocationStatusResponse getStatus() {
        return status;
    }

    public void setStatus(AllocationStatusResponse status) {
        this.status = status;
    }
    
    /**
     * {
    "status": {
        "code": "400",
        "message": "Initiator is invalid",
        "success": false,
        "result_code": "0000900"
    }
}
* 
* {
    "status": {
        "response_code": "DP00900001010",
        "code": "400",
        "success": false,
        "result_code": "0000900",
        "message": "Initiator is invalid"
    }
}
     */
    public static void main(String[] args) {
        String respStr = "{\n" +
"    \"data\": {\n" +
"        \"additional_info\": {\n" +
"            \"mq_txn_id\": \"LC231206.1213.C00003\"\n" +
"        },\n" +
"        \"transaction\": {\n" +
"            \"reference_id\": \"APCCG127001004419712\",\n" +
"            \"airtel_money_id\": \"ALLO-EJBWGEX000-1701861217\",\n" +
"            \"id\": \"1701861217\",\n" +
"            \"status\": \"TS\"\n" +
"        }\n" +
"    },\n" +
"    \"status\": {\n" +
"        \"response_code\": \"DP02050001001\",\n" +
"        \"code\": \"200\",\n" +
"        \"success\": true,\n" +
"        \"message\": \"SUCCESS\"\n" +
"    }\n" +
"}";
        AllocationResponse resp = (new Gson()).fromJson(respStr, AllocationResponse.class);
        System.out.println("response_code: " + resp.getStatus().getResponse_code());
        System.out.println("code: " + resp.getStatus().getCode());
        System.out.println("success: " + resp.getStatus().isSuccess());
        System.out.println("message: " + resp.getStatus().getMessage());
        
        System.out.println("mq_txn_id: " + resp.getData().getAdditional_info().getMq_txn_id());
        AllocationTransactionResponse respData = resp.getData().getTransaction();
        System.out.println("airtel_money_id: " + respData.getAirtel_money_id());
        System.out.println("reference_id: " + respData.getReference_id());
        System.out.println("id: " + respData.getId());
        System.out.println("status: " + respData.getStatus());
    }
    
}



