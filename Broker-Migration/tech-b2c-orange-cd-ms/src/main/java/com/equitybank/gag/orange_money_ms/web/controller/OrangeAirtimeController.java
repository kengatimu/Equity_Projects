/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybank.gag.orange_money_ms.web.controller;

/**
 *
 * @author ronaldcheruiyot
 */



import com.equitybank.gag.orange_money_ms.constants.TPGConstants;
import com.equitybank.gag.orange_money_ms.dto.airtime.AirtelDTO;
import com.equitybank.gag.orange_money_ms.entity.StatusDetails;
import com.equitybank.gag.orange_money_ms.repository.StatusDetailsRepository;
import com.equitybank.gag.orange_money_ms.repository.TransactionDetailsRepository;
import com.equitybank.gag.orange_money_ms.service.business.impl.AirtimeService;
import com.equitybank.gag.orange_money_ms.service.util.MiscUtil;
import java.math.BigDecimal;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import static com.equitybank.gag.orange_money_ms.constants.TPGConstants.AIRTIME_SERVICE_NOT_ACTIVATED;

@RestController
@RequestMapping("/api/AirTimeTopUpWSService")
@Slf4j
public class OrangeAirtimeController {
    
    @Autowired
    AirtimeService airtimeService;
    
    @Autowired
    StatusDetailsRepository statusDetailsRepository;
    
    @Autowired
    TransactionDetailsRepository transactionDetailsRepository;
    
    Set<String> whiteList;
    
    BigDecimal limitCDF;
    
    BigDecimal limitUSD;
    
    @GetMapping("/status")
    public ResponseEntity<?> getStats(@RequestParam String rrn) {
        log.info("Get stats request, rrn: " + rrn);
        try {
            Optional<StatusDetails> status = statusDetailsRepository.findByRrn(rrn);
            if(status.isEmpty())
            {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }
            return new ResponseEntity<>(status.get(), HttpStatus.OK);
 
        } catch (Exception ex) {
            ex.printStackTrace(System.out);
        }
        return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }
    
    
    
    @PostMapping("/AirTimeTopUp")
    public ResponseEntity buyAirtime(@RequestBody String request)
    {   
        System.out.println("##### INCOMMING AIRTIME TRANSACTION REQUEST: " + request);
        try {
            Map<String, String> map = MiscUtil.extractAllTagValues(request);
//            if(!airtimeService.isAirtimeActivated())
//            {
//                log.error(AIRTIME_SERVICE_NOT_ACTIVATED);
//                return new ResponseEntity(writeServletErrorMsg("503", AIRTIME_SERVICE_NOT_ACTIVATED + " for ORANGE"), HttpStatus.OK);
//            }
            AirtelDTO airtDto = airtimeService.buyAirtime(map);
            int x = airtDto.getStatusCode();
            String statusMessage = airtDto.getTelcoStatusMessage();
            String tranId = airtDto.getTranId();
            log.info("tranId: " + tranId);
            if (x == -3) {
                String response = this.writeServletErrorMsg("-3", statusMessage);
                return new ResponseEntity(response, HttpStatus.OK);
            }
            if (x == -1) {
                String response = this.writeServletErrorMsg("-1", statusMessage);
                return new ResponseEntity(response, HttpStatus.OK);
            }
            if (x == 1) {
                String response = this.writeServletErrorMsg("1", statusMessage);
                return new ResponseEntity(response, HttpStatus.OK);
            }
            if (x == 0) {
                String response = this.writeServletSuccessMsg(tranId);
                return new ResponseEntity(response, HttpStatus.OK);
            }
           
        } catch (Exception ex) {
            ex.printStackTrace(System.out);
            String resp = writeServletErrorMsg("400", ex.getLocalizedMessage() != null ? ex.getLocalizedMessage() : TPGConstants.INVALID_XML_INPUT);
            return new ResponseEntity<>(resp, HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
    }
    
    private String writeServletSuccessMsg(String tranID) {
        String response = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
"<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" +
"    <soap:Body>\n" +
"        <ns2:topupResponse xmlns:ns2=\"http://business.airtime.telcos.equitybank.com/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:type=\"ns2:topupResponse\">\n" +
"            <return>OK|" + tranID + "</return>\n" +
"        </ns2:topupResponse>\n" +
"    </soap:Body>\n" +
"</soap:Envelope>";
        return response;
    }
    
    private String writeServletErrorMsg(String errorCode, String errorDescription) {
        String response = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
"<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" +
"    <soap:Body>\n" +
"        <ns2:topupResponse xmlns:ns2=\"http://business.airtime.telcos.equitybank.com/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:type=\"ns2:topupResponse\">\n" +
"            <return>ERROR|" + errorCode + "</return>\n" +
"            <responseCode>" + errorCode + "</responseCode>\n" +
"            <responseDesc>" + errorDescription + "</responseDesc>\n" +
"        </ns2:topupResponse>\n" +
"    </soap:Body>\n" +
"</soap:Envelope>";
        return response;
    }
    
}
