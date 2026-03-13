/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.controller.business;

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
@RequestMapping("/BankInitBankToSVA")
public class AfricellMockController {
    
    @PostMapping("/1.0")
    public ResponseEntity<?> transaction(@RequestBody Transaction transaction)
    {
        return new ResponseEntity(getMockSuccessDisbursementResponse(transaction), HttpStatus.OK);
    }
    
    private String getMockSuccessDisbursementResponse(Transaction transaction) 
    {
        return "{\n" +
"    \"receiverLastName\": \"AUTWHS1109065902\",\n" +
"    \"senderMobileNumber\": \"" + transaction.getTransactor().getIdType() + "\",\n" +
"    \"txnStatus\": \"TS\",\n" +
"    \"serviceRequestId\": \"" + UUID.randomUUID().toString() + "\",\n" +
"    \"receiverMobileNumber\": \"7701536457\",\n" +
"    \"serviceFlow\": \"BIBWREQ\",\n" +
"    \"message\": \"Bank Initiated Bank to Wallet transaction of RUB 10 hasbeen successfully completed between the sender: 7701536457 and receiver: 7701536457. Txn ID: BW180802.0519.A00151\",\n" +
"    \"senderLastName\": \"AUTWHS1109065902\",\n" +
"    \"transactionId\": \"" + MiscUtil.generateRandomRRN(12) + "\",\n" +
"    \"status\": \"SUCCEEDED\"\n" +
"}";
    }
    
}
