/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.vas.hostemulator.emulator.response;

import com.equitybankgroup.vas.hostemulator.emulator.util.MiscUtil;

/**
 *
 * @author ronaldcheruiyot
 */
public class WalletResponse {
    
    public static String getWalletSuccessResp(String MsgId)
    {
        String response = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>\n" +
"<response>\n" +
"    <MsgId>" + MsgId + "</MsgId>\n" +
"    <eazzycashres>\n" +
"        <status>OK</status>\n" +
"        <tranID>" + MiscUtil.generateRandomRRN(10)+ "</tranID>\n" +
"    </eazzycashres>\n" +
"</response>";
        
        return response;
        
    }
    
    public static String getWalletValidationSuccessResp(String rrn)
    {
    
        String response = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>\n" +
    "<response>\n" +
    "    <MsgId>" + rrn + "</MsgId>\n" +
    "    <eazzycashres>\n" +
    "        <status>OK</status>\n" +
    "    </eazzycashres>\n" +
    "</response>";
        
        return response;
    
    }
}
