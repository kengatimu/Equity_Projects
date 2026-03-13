/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.vas.hostemulator.emulator.response;

import com.equitybankgroup.vas.hostemulator.emulator.dto.CreditTransferBusinessServiceReqModel;

/**
 *
 * @author ronaldcheruiyot
 */
public class PesalinkResponse {
    
    public static String getPesalinkCTSuccessResponse(CreditTransferBusinessServiceReqModel request)
    {
    
        String response = "{\n" +
"    \"requestId\": \"" + request.getRequestId() + "\",\n" +
"    \"status\": \"SUCCESS\",\n" +
"    \"statusCode\": \"00\",\n" +
"    \"statusDesc\": \"Request accepted successfully\",\n" +
"    \"errorCode\": \"000\",\n" +
"    \"errorDesc\": \"Transaction Status Inquire Successful: Transaction Processed Successfully\"\n" +
"}";
        return response;
    }
    
}
