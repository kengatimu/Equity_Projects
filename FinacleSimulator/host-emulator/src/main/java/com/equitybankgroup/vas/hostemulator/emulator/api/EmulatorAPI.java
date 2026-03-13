/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.vas.hostemulator.emulator.api;

import com.equitybankgroup.vas.hostemulator.emulator.dto.CreditTransferBusinessServiceReqModel;
import com.equitybankgroup.vas.hostemulator.emulator.response.PesalinkResponse;
import com.equitybankgroup.vas.hostemulator.emulator.response.RTGSResponse;
import com.equitybankgroup.vas.hostemulator.emulator.response.WalletResponse;
import com.equitybankgroup.vas.hostemulator.emulator.util.MiscUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author ronaldcheruiyot
 */
@RestController
//@Slf4j
public class EmulatorAPI {
    private static final Logger log = LoggerFactory.getLogger(EmulatorAPI.class);
    
    @PostMapping(
        path = "/FISERVLET/fihttp",
        consumes = { MediaType.APPLICATION_XML_VALUE },
        produces = { MediaType.APPLICATION_XML_VALUE }
    )
    public ResponseEntity<?> fihttp(@RequestBody String request) {
        log.info("INCOMMING FI REQUEST::...");
        System.out.println(request);
        
        String RequestUUID = MiscUtil.extractTagValue(request, "RequestUUID");
        String MessageDateTime = MiscUtil.extractTagValue(request, "MessageDateTime");
        String BankId = MiscUtil.extractTagValue(request, "BankId");

        log.info("RequestUUID: " + RequestUUID);
        log.info("MessageDateTime: " + MessageDateTime);
        log.info("BankId: " + BankId);
        
        if(request.contains("RTGS"))
        {
            
            
            String response = RTGSResponse.getRTGSSuccessMessage(RequestUUID, MessageDateTime, BankId);
            
            log.info("OUTGOING SUCCESS FI RTGS RESPONSE::...");
            
            log.info(response);
            
            return new ResponseEntity(response, HttpStatus.OK);
            
        }
        
        String response = RTGSResponse.getRTGSSuccessMessage(RequestUUID, MessageDateTime, BankId);
        
        log.info("OUTGOING SUCCESS FI RTGS RESPONSE::...");
        
        log.info(response);
        
        return new ResponseEntity(response, HttpStatus.OK);
    
    }
    
    @PostMapping(
        path = "/pesalink/api/v1/credit-transfer",
        consumes = { MediaType.APPLICATION_JSON_VALUE },
        produces = { MediaType.APPLICATION_JSON_VALUE }
    )
    public ResponseEntity<?> pesalinkCreditTrasfer(@RequestBody CreditTransferBusinessServiceReqModel request) {
        log.info("INCOMMING PESALINK CREDIT TRANSFER REQUEST::...");
        System.out.println(request);
        
        String response = PesalinkResponse.getPesalinkCTSuccessResponse(request);
        
        log.info("OUTGOING SUCCESS PESALINK CREDIT TRANSFER RESPONSE::...");
        
        log.info(response);
        
        return new ResponseEntity(response, HttpStatus.OK);
    
    }
    
    @PostMapping(
        path = "/b2c/way4handler/",
        consumes = { MediaType.APPLICATION_XML_VALUE },
        produces = { MediaType.APPLICATION_XML_VALUE }
    )
    public ResponseEntity<?> walletTransfer(@RequestBody String request) {
        log.info("INCOMMING WALLET TRANSFER REQUEST::...");
        System.out.println(request);
        
        String msgId = MiscUtil.extractTagValue(request, "msgId");

        log.info("msgId: " + msgId);
        
        String response = WalletResponse.getWalletSuccessResp(msgId);
        
        log.info("OUTGOING SUCCESS WALLET TRANSFER RESPONSE::...");
        
        log.info(response);
        
        return new ResponseEntity(response, HttpStatus.OK);
    
    }
    
    @PostMapping(
        path = "/b2c/imthandler/",
        consumes = { MediaType.APPLICATION_XML_VALUE },
        produces = { MediaType.APPLICATION_XML_VALUE }
    )
    public ResponseEntity<?> walletAccountValidation(@RequestBody String request) {
        log.info("INCOMMING WALLET VALIDATION REQUEST::...");
        System.out.println(request);
        
        String rrn = MiscUtil.extractTagValue(request, "rrn");

        log.info("rrn: " + rrn);
        
        String response = WalletResponse.getWalletValidationSuccessResp(rrn);
        
        log.info("OUTGOING SUCCESS WALLET VALIDATION RESPONSE::...");
        
        log.info(response);
        
        return new ResponseEntity(response, HttpStatus.OK);
    
    }
    
    
}
