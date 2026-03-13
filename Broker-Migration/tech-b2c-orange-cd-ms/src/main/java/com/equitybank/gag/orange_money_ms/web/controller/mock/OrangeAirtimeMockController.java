/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybank.gag.orange_money_ms.web.controller.mock;


import com.equitybank.gag.orange_money_ms.constants.AirtelConstants;
import com.equitybank.gag.orange_money_ms.service.business.impl.OutboundHttpAdapter;
import com.equitybank.gag.orange_money_ms.service.util.MiscUtil;
import java.io.StringWriter;
import java.util.Map;
import java.util.concurrent.Executor;
import jakarta.xml.bind.JAXBContext;
import jakarta.xml.bind.JAXBException;
import jakarta.xml.bind.Marshaller;
import java.io.IOException;
import javax.xml.parsers.ParserConfigurationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.xml.sax.SAXException;

/**
 *
 * @author ronaldcheruiyot
 */
@RestController
public class OrangeAirtimeMockController {
    
    @Value("${orange.cd.airtime.mock.scenario.buy}")
    String buyAirtimeScenario;
    
    @Autowired
    OutboundHttpAdapter httpAdapter;
    
    @Autowired
    Executor taskExecutor;
    
    @PostMapping("/auth/oauth2/token")
    public ResponseEntity getToken(@RequestBody String loginRequest)
    {           
        return new ResponseEntity(getSuccessLoginResponse(), HttpStatus.OK);
        
        
    }
  
    
    @PostMapping("/pretups/C2SReceiver")
    public ResponseEntity buyAirtime(@RequestBody String airtimeRequest) throws ParserConfigurationException, SAXException, IOException
    {  
        if(buyAirtimeScenario.equalsIgnoreCase("success")) return new ResponseEntity(getSuccessAirtimeResponse(airtimeRequest), HttpStatus.OK);
        
        return new ResponseEntity(getFailedAirtimeResponse(airtimeRequest), HttpStatus.OK);
    }
    
    public String getFailedAirtimeResponse(String request) throws ParserConfigurationException, SAXException, IOException
    {   
       Map<String, String> reqMap = MiscUtil.extractAllTagValues(request);
       return "<?xml version=\"1.0\"?> <COMMAND>"
               + "<TYPE>EXRCTRFRESP</TYPE>"
               + "<TXNSTATUS>500</TXNSTATUS >"
               + "<DATE>" + MiscUtil.getCurrentTimestamp("dd/MM/yyyyHH:mm:ss") + "</DATE>"
               + "<EXTREFNUM>" + reqMap.get(AirtelConstants.AIRTIME_REQUEST_EXTREFNUM) + "</EXTREFNUM>"
               + "<MESSAGE>Failed.</MESSAGE>"
               + "</COMMAND> ";
    }
    
    public String getSuccessAirtimeResponse(String request) throws ParserConfigurationException, SAXException, IOException
    {   
       Map<String, String> reqMap = MiscUtil.extractAllTagValues(request);
       return "<?xml version=\"1.0\"?> <COMMAND>"
               + "<TYPE>EXRCTRFRESP</TYPE>"
               + "<TXNSTATUS>200</TXNSTATUS >"
               + "<DATE>" + MiscUtil.getCurrentTimestamp("dd/MM/yyyyHH:mm:ss") + "</DATE>"
               + "<EXTREFNUM>" + reqMap.get(AirtelConstants.AIRTIME_REQUEST_EXTREFNUM) + "</EXTREFNUM>"
               + "<TXNID>" + MiscUtil.generateRandomRRN(12) + "</TXNID>"
               + "<MESSAGE>Successfully processed.</MESSAGE>"
               + "</COMMAND> ";
    }
    
    
    
    public String getSuccessLoginResponse()
    {
        return "{\n" +
"    \"token_type\": \"bearer\",\n" +
"    \"access_token\": \"" + MiscUtil.generateRandomRRN(20) + "\",\n" +
"    \"expires_in\": 180\n" +
"}";
    }
   
    
    
}
