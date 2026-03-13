/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybank.gag.orange_money_ms.web.controller.mock;

import com.equitybank.gag.orange_money_ms.constants.OrangeConstants;
import com.equitybank.gag.orange_money_ms.service.util.MiscUtil;
import java.util.Map;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author ronaldcheruiyot
 */
@RestController
@RequestMapping(path = "/api/v1/bank")
public class OrangeMockController {
    
    @PostMapping("/transactions")
    public ResponseEntity<?> transactions(@RequestBody String request) {
        
        return new ResponseEntity(getSuccessB2CMockResponseStr(request), HttpStatus.OK);
    }
    
    @PostMapping("/transactions/status")
    public ResponseEntity<?> status(@RequestBody String request) {
        
        return new ResponseEntity(getSuccessB2CMockResponseStr(request), HttpStatus.OK);
    }
    
    
    
    private static String getSuccessB2CMockResponseStr(String request)
    {   
        Map<String, String> values = MiscUtil.extractAllTagValues(request);
        
        return "<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" +
"    <soap:Body>\n" +
"        <ns2:AccountToWalletTransferResponse xmlns:ns2=\"http://b2w.banktowallet.com/b2w\">\n" +
"            <return>\n" +
"                <mmHeaderInfo>\n" +
"                    <operatorCode>ORANGEMONEYML</operatorCode>\n" +
"                    <requestId>" + values.get(OrangeConstants.ORANGE_B2C_REQUEST_REQUEST_ID) + "</requestId>\n" +
"                    <affiliateCode>EML</affiliateCode>\n" +
"                    <responseCode>000</responseCode>\n" +
"                    <responseMessage>Success</responseMessage>\n" +
"                </mmHeaderInfo>\n" +
"                <CBAReferenceNo>" + MiscUtil.generateRandomRRN(15) + "</CBAReferenceNo>\n" +
"            </return>\n" +
"        </ns2:AccountToWalletTransferResponse>\n" +
"    </soap:Body>\n" +
"</soap:Envelope>";
    }
    
    private static String getSuccessB2CStatusMockResponseStr(String request)
    {
        Map<String, String> values = MiscUtil.extractAllTagValues(request);
        
        return "<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" +
"    <soap:Body>\n" +
"        <ns2:TransferStatusInquiryResponse xmlns:ns2=\"http://b2w.banktowallet.com/b2w\">\n" +
"            <return>\n" +
"                <mmHeaderInfo>\n" +
"                    <operatorCode>ORANGEMONEYML</operatorCode>\n" +
"                    <requestId>" + values.get(OrangeConstants.ORANGE_B2C_STATUS_REQUEST_REQUEST_ID) + "</requestId>\n" +
"                    <affiliateCode>EML</affiliateCode>\n" +
"                    <responseCode>000</responseCode>\n" +
"                    <responseMessage>Success</responseMessage>\n" +
"                </mmHeaderInfo>\n" +
"                <CBAReferenceNo>" + MiscUtil.generateRandomRRN(15) + "</CBAReferenceNo>\n" +
"            </return>\n" +
"        </ns2:TransferStatusInquiryResponse>\n" +
"    </soap:Body>\n" +
"</soap:Envelope>";
    }

    
}
