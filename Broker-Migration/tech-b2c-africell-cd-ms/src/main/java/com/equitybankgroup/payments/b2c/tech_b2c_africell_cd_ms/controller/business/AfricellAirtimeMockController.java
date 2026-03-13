/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.controller.business;

import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.dto.africell.AirtimeTelcoRequestDTO;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.dto.africell.Transaction;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.service.util.MiscUtil;
import java.util.UUID;
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
@RequestMapping("/BundlesService.asmx")
public class AfricellAirtimeMockController {
    
    @PostMapping("/SubscriberCreditTransfer")
    public ResponseEntity<?> transaction(@RequestBody AirtimeTelcoRequestDTO airtimeTelcoRequestDTO)
    {
        return new ResponseEntity(getMockSuccessAirtimeResponse(airtimeTelcoRequestDTO), HttpStatus.OK);
    }
    
    private String getMockSuccessAirtimeResponse(AirtimeTelcoRequestDTO airtimeTelcoRequestDTO) 
    {
        return "{\n" +
"    \"Code\": \"0\",\n" +
"    \"Description\": \"Successful\",\n" +
"    \"MMTransactionID\": \"" + airtimeTelcoRequestDTO.getMMTransactionID() + "\",\n" +
"    \"AfrTransactionID\": \"" + MiscUtil.generateRandomRRN(10) + "\"\n" +
"}";
    }
    
}
