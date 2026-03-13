/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.controller.business;

import com.equitybankgroup.payments.b2c.dto.airtel.AirtelDTO;
import com.equitybankgroup.payments.b2c.dto.airtel.contants.TPGConstants;
import com.equitybankgroup.payments.b2c.dto.input.EazInqRequest;
import com.equitybankgroup.payments.b2c.dto.input.Eazzycashres;
import com.equitybankgroup.payments.b2c.dto.input.InqResponse;
import com.equitybankgroup.payments.b2c.enums.RequestTypes;
import com.equitybankgroup.payments.b2c.model.StatusDetails;
import com.equitybankgroup.payments.b2c.model.TransactionDetails;
import com.equitybankgroup.payments.b2c.repository.StatusDetailsRepository;
import com.equitybankgroup.payments.b2c.repository.TransactionDetailsRepository;
import com.equitybankgroup.payments.b2c.service.business.allocation.OpenAPIAirtelAllocationService;
import com.equitybankgroup.payments.b2c.service.util.MiscUtil;
import java.util.Optional;
import java.util.concurrent.Executor;
import jakarta.xml.bind.JAXBException;
import javax.xml.parsers.ParserConfigurationException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.xml.sax.SAXException;

/**
 *
 * @author ronaldcheruiyot
 */
@RestController
@RequestMapping("/api/v1")
@Slf4j
public class AirtelBuyFloatController {
    
    @Autowired
    OpenAPIAirtelAllocationService buyFloatService;
    
    @Autowired
    TransactionDetailsRepository transactionDetailsRepository;
    
    @Autowired
    StatusDetailsRepository statusDetailsRepository;
    
    @Autowired
    Executor taskExecutor;
    
    @GetMapping("/buyfloat/status")
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
    
    @PostMapping("/buyfloat")
    public ResponseEntity postTransaction(@RequestBody String request)
    {   
        System.out.println("##### INCOMMING TRANSACTION REQUEST: " + request);
        EazInqRequest inqRequest = null;
        try {
            inqRequest = (EazInqRequest) MiscUtil.strToObject(request, EazInqRequest.class);
            InqResponse rs = new InqResponse();
            Eazzycashres eazzycashres = new Eazzycashres();
            rs.setEazzycashres(eazzycashres);
            String msgId = (inqRequest.getMsgId() > 0) ? String.valueOf(inqRequest.getMsgId()) : null;
            String rrn = inqRequest.getEazzycash().getRrn();
            if(buyFloatService.isLocal)
            {
                Optional<TransactionDetails> details = transactionDetailsRepository.findByRrnAndOperationType(inqRequest.getEazzycash().getRrn(), RequestTypes.BUY_FLOAT);
                if(details.isPresent())
                {
                    String response = writeServletErrorMsg(msgId, "-7", "-7", "Duplicate", rrn);
                    return new ResponseEntity(response, HttpStatus.OK);
                }
            }
            
            AirtelDTO airtDto = null;
            
            if(!MiscUtil.isNullOrEmpty(inqRequest.getEazzycash().getBankId()) && inqRequest.getEazzycash().getBankId().equalsIgnoreCase("43"))
            {
                airtDto = buyFloatService.sendTransaction(inqRequest, "CD", rs);
            } else if(!MiscUtil.isNullOrEmpty(inqRequest.getEazzycash().getBankId()) && inqRequest.getEazzycash().getBankId().equalsIgnoreCase("54")) {
                airtDto = buyFloatService.sendTransaction(inqRequest, "KE", rs);
            } else {
                String response = this.writeServletErrorMsg(msgId, "-1", "400", "Unknown institution code!!", rrn);
                return new ResponseEntity<>(response, getResponseHeaders(), HttpStatus.BAD_REQUEST);
            }


            
            int x = airtDto.getStatusCode();
            String telcoStatusCode = airtDto.getTelcoStatusCode();
            String statusMessage = airtDto.getTelcoStatusMessage();
            String tranId = airtDto.getTranId();
            if (x == -3) {
                String response = this.writeServletErrorMsg(msgId, "-3", telcoStatusCode, statusMessage, rrn);
                log.info("********* Response back to source: ");
                log.info(response);
                return new ResponseEntity(response, HttpStatus.OK);
            }
            if (x == -1) {
                String response = this.writeServletErrorMsg(msgId, "-1", telcoStatusCode, statusMessage, rrn);
                log.info("********* Response back to source: ");
                log.info(response);
                return new ResponseEntity(response, HttpStatus.OK);
            }
            if (x == 1) {
                String response = this.writeServletErrorMsg(msgId, "1", telcoStatusCode, statusMessage, rrn);
                log.info("********* Response back to source: ");
                log.info(response);
                return new ResponseEntity(response, HttpStatus.OK);
            }
            if (x == 0) {
                String response = writeServletSuccessMsg(msgId, telcoStatusCode, tranId, rrn);
                log.info("********* Response back to source: ");
                log.info(response);
                return new ResponseEntity(response, HttpStatus.OK);
            }
            
            String response = this.writeServletErrorMsg(msgId, String.valueOf(x), telcoStatusCode, statusMessage, rrn);
            log.info("********* Response back to source: ");
            log.info(response);
            return new ResponseEntity(response, HttpStatus.OK);
        } catch (JAXBException | ParserConfigurationException | SAXException ex) {
            ex.printStackTrace(System.out);
            String resp = getErrorResponse((inqRequest != null ? String.valueOf(inqRequest.getMsgId()) : "0000000"), "400", ex.getLocalizedMessage() != null ? ex.getLocalizedMessage() : TPGConstants.INVALID_XML_INPUT);
            return new ResponseEntity<>(resp, getResponseHeaders(), HttpStatus.BAD_REQUEST);
        }
//        return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
    }
    
    private MultiValueMap<String, String> getResponseHeaders()
    {
        MultiValueMap<String, String> headers = new LinkedMultiValueMap<>();
        headers.add("Content-Type", "application/xml");
        return headers;
    }
    
    
    private String writeServletSuccessMsg(String msgId, String telcoResponseCode, String tranID, String rrn) {
        return "<response>\n" +
               "    <msgId>" + (((msgId != null) && !msgId.isEmpty()) ? msgId : rrn) + "</msgId>\n" +
"    <eazzycashres>\n" +
"        <status>OK</status>\n" +
"        <responseCode>0</responseCode>\n" +
"        <tranID>" + tranID + "</tranID>\n" +
"        <telcoResponseCode>" + telcoResponseCode + "</telcoResponseCode>\n" +
"    </eazzycashres>\n" +
"</response>";
    }
    
    private static String getErrorResponse(String msgId, String responseCode, String responseDesc)
    {
        return "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>\n" +
"<response>\n" +
"    <msgId>" + msgId + "</msgId>\n" +
"    <eazzycashres>\n" +
"        <status>ERROR|" + responseCode + "</status>\n" +
"        <responseCode>" + responseCode + "</responseCode>\n" +
"        <responseDesc>" + responseDesc + "</responseDesc>\n" +
"    </eazzycashres>\n" +
"</response>";
    }
    
    
    private String writeServletErrorMsg(String msgId, String status, String telcoResponseCode, String telcoResponseDesc, String rrn)
    {
        return "<response>\n" +
               "    <msgId>" + (((msgId != null) && !msgId.isEmpty()) ? msgId : rrn) + "</msgId>\n" +
"    <eazzycashres>\n" +
"        <status>ERROR</status>\n" +
"        <responseCode>" + status + "</responseCode>\n" +
"        <telcoResponseCode>" + telcoResponseCode + "</telcoResponseCode>\n" +
"        <telcoResponseDesc>" + telcoResponseDesc + "</telcoResponseDesc>\n" +
"    </eazzycashres>\n" +
"</response>";
    }
    
    public static void main(String[] args) {
        String resp = "<response>\n" +
               "    <msgId>1234444</msgId>\n" +
"    <eazzycashres>\n" +
"        <status>OK</status>\n" +
"        <responseCode>0</responseCode>\n" +
"        <tranID>12333444</tranID>\n" +
"        <telcoResponseCode>0000000</telcoResponseCode>\n" +
"    </eazzycashres>\n" +
"</response>";
        
        System.out.println(resp);
        
    }
    
    
}/**
 * RESPONSES:
 * <response>
<eazzycashres>
 <msgId>324234245453</msgId>
<status>ERROR</status>
<responseCode>-10</responseCode>
</eazzycashres>
</response>
Accepted
<response>
<eazzycashres>
 <msgId>324234245453</msgId>
<status>OK</status>
<responseCode>0</responseCode>
</eazzycashres>
</response>
 */
