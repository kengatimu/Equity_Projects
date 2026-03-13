/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.controller.business;

import com.equitybankgroup.payments.b2c.dto.airtel.contants.AirtelConstants;
import com.equitybankgroup.payments.b2c.dto.input.Eazzycashres;
import com.equitybankgroup.payments.b2c.dto.input.InqResponse;
import com.equitybankgroup.payments.b2c.service.business.http.OutboundHttpAdapter;
import com.equitybankgroup.payments.b2c.service.util.MiscUtil;
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
import org.springframework.http.MediaType;
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
public class AirtelMockController {
    
    @Value("${airtel.cd.b2c.mock.scenario.login}")
    String loginScenario;
    
    @Value("${airtel.cd.b2c.mock.scenario.disbursement}")
    String disbursementScenario;
    
    @Value("${airtel.cd.airtime.mock.scenario.buy}")
    String buyAirtimeScenario;
    
    @Autowired
    OutboundHttpAdapter httpAdapter;
    
    @Autowired
    Executor taskExecutor;
    
    @PostMapping("/auth/oauth2/token")
    public ResponseEntity getToken(@RequestBody String loginRequest)
    {   
//        if(loginScenario.equalsIgnoreCase("success")) return new ResponseEntity(getSuccessLoginResponse(), HttpStatus.OK);
        
        return new ResponseEntity(getSuccessLoginResponse(), HttpStatus.OK);
        
//        return new ResponseEntity(HttpStatus.UNAUTHORIZED);
        
    }
    
    @PostMapping("/bank-to-wallet/v1/payments/")
    public ResponseEntity postTransaction(@RequestBody String disbursement)
    {   
        if(disbursementScenario.equalsIgnoreCase("success")) return new ResponseEntity(getSuccessDisbursementResponse(), HttpStatus.OK);

        return new ResponseEntity(getFailedDisbursementResponse(), HttpStatus.OK);
        
    }
    
    @GetMapping("/bank-to-wallet/v1/payments/{id}")
    public ResponseEntity getStatus(@PathVariable String id)
    {   
        if(disbursementScenario.equalsIgnoreCase("success")) return new ResponseEntity(getSuccessDisbursementResponse(), HttpStatus.OK);

        return new ResponseEntity(getFailedDisbursementResponse(), HttpStatus.OK);
        
    }
    
    /*
    @PostMapping("/airtime/buy")
    public ResponseEntity buyAirtime(@RequestBody String airtimeRequest) throws ParserConfigurationException, SAXException, IOException
    {  
        if(buyAirtimeScenario.equalsIgnoreCase("success")) return new ResponseEntity(getSuccessAirtimeResponse(airtimeRequest), HttpStatus.OK);
        
        return new ResponseEntity(getFailedAirtimeResponse(airtimeRequest), HttpStatus.OK);
    }
    */
    
    @PostMapping(value = "/airtime/buy", produces = "text/html")
public ResponseEntity<String> buyAirtime(@RequestBody String airtimeRequest) 
        throws ParserConfigurationException, SAXException, IOException {  
//    if (buyAirtimeScenario.equalsIgnoreCase("success")) {
//        return ResponseEntity.ok()
//                .contentType(MediaType.TEXT_HTML)
//                .body(getSuccessAirtimeResponse(airtimeRequest));
//    }

    return ResponseEntity.internalServerError()
            .contentType(MediaType.TEXT_HTML)
            .body(getFailedAirtimeResponse(airtimeRequest));
}
    /*
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
    */

    public String getFailedAirtimeResponse(String request) throws ParserConfigurationException, SAXException, IOException
    {   
       Map<String, String> reqMap = MiscUtil.extractAllTagValues(request);
       return "<html>\n" +
"<head>\n" +
"    <title>Airtime Purchase</title>\n" +
"</head>\n" +
"<body>\n" +
"    <h1>Airtime Purchase Status</h1>\n" +
"    <p>Your airtime purchase was Failed.</p>\n" +
"</body>\n" +
"</html>";
    }
    
    public String getSuccessAirtimeResponse(String request) throws ParserConfigurationException, SAXException, IOException
    {   
//       Map<String, String> reqMap = MiscUtil.extractAllTagValues(request);
       return "<?xml version=\"1.0\"?> <COMMAND>"
               + "<TYPE>EXRCTRFRESP</TYPE>"
               + "<TXNSTATUS>200</TXNSTATUS >"
               + "<DATE>" + MiscUtil.getCurrentTimestamp("dd/MM/yyyyHH:mm:ss") + "</DATE>"
               + "<EXTREFNUM>" + MiscUtil.generateRandomRRN(12) + "</EXTREFNUM>"
               + "<TXNID>" + MiscUtil.generateRandomRRN(12) + "</TXNID>"
               + "<MESSAGE>Successfully processed.</MESSAGE>"
               + "</COMMAND> ";
    }
    
    public String getSuccessDisbursementResponse()
    {   
       String tranId = MiscUtil.generateRandomRRN(12);
       return "{\n" +
"    \"data\": {\n" +
"        \"additional_info\": {\n" +
"            \"mq_txn_id\": \"BW24**4.0**3.G**015\"\n" +
"        },\n" +
"        \"transaction\": {\n" +
"            \"airtel_money_id\": \"product-partner-" + tranId +"\",\n" +
"            \"reference_id\": APC" + tranId + ",\n" +
"            \"id\": \"" + tranId + "\",\n" +
"            \"status\": \"TS\",\n" +
"            \"message\": \"Transaction Successful\"\n" +
"        }\n" +
"    },\n" +
"    \"status\": {\n" +
"        \"response_code\": \"DP02100001001\",\n" +
"        \"code\": \"200\",\n" +
"        \"success\": true,\n" +
"        \"message\": \"success\"\n" +
"    }\n" +
"}";
    }
    
    public String getSuccessLoginResponse()
    {
        return "{\n" +
"    \"token_type\": \"bearer\",\n" +
"    \"access_token\": \"" + MiscUtil.generateRandomRRN(20) + "\",\n" +
"    \"expires_in\": 180\n" +
"}";
    }
    
    public String getFailedDisbursementResponse()
    {   
        String tranId = MiscUtil.generateRandomRRN(12);
        return "{\n" +
"    \"data\": {\n" +
"        \"transaction\": {\n" +
"            \"reference_id\": \"APC" + tranId + "\",\n" +
"            \"id\": \"" + tranId + "\",\n" +
"            \"status\": \"TS\"\n" +
"        }\n" +
"    },\n" +
"    \"status\": {\n" +
"        \"code\": \"500\",\n" +
"        \"message\": \"Failed.\",\n" +
"        \"response_code\": \"DP00900001002\",\n" +
"        \"success\": true\n" +
"    }\n" +
"}"; 
    }
    
    private String writeServletSuccessMsg(String msg, String rrn, String tranID) {
        try {
            InqResponse rs = new InqResponse();
            Eazzycashres eazzycashres = new Eazzycashres();
            eazzycashres.status = "OK";
            eazzycashres.responseCode = "00";
            eazzycashres.walletTranID = tranID;
            rs.setMsgId(rrn);
            rs.setEazzycashres(eazzycashres);
            JAXBContext jaxbContext = JAXBContext.newInstance(InqResponse.class);
            Marshaller jaxbMarshaller = jaxbContext.createMarshaller();

            jaxbMarshaller.setProperty("jaxb.formatted.output", Boolean.valueOf(true));


            StringWriter jaxwriter = new StringWriter();
            jaxbMarshaller.marshal(rs, jaxwriter);
            StringBuffer jaxrespBfr = jaxwriter.getBuffer();;
            String response = jaxrespBfr.toString();
            System.out.println(msg + response);
            return response;
        } catch (JAXBException e) {
            e.printStackTrace(System.out);
        }
        return null;
    }
    
    private String writeServletErrorMsg(String msg, InqResponse rs) {
        try {
            if (msg.contains("Timeout")) {
                (rs.getEazzycashres()).status = "ERROR|-3";
            } else {
                (rs.getEazzycashres()).status = "ERROR";
            }

            JAXBContext jaxbContext = JAXBContext.newInstance(InqResponse.class);
            Marshaller jaxbMarshaller = jaxbContext.createMarshaller();
            jaxbMarshaller.setProperty("jaxb.formatted.output", Boolean.valueOf(true));
            StringWriter jaxwriter = new StringWriter();
            jaxbMarshaller.marshal(rs, jaxwriter);
            StringBuffer jaxrespBfr = jaxwriter.getBuffer();
            String response = jaxrespBfr.toString();
            System.out.println(msg + response);
            System.out.println(msg);
            System.out.println(msg + jaxrespBfr.toString());
            return response;
        } catch (JAXBException e) {
            e.printStackTrace(System.out);
        }
        return null;
    }
    
}
