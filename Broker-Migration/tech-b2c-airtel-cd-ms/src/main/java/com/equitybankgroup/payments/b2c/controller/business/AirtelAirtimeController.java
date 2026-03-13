/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.controller.business;

/**
 *
 * @author ronaldcheruiyot
 */


import com.equitybankgroup.payments.b2c.dto.airtel.AirtelDTO;
import com.equitybankgroup.payments.b2c.dto.airtel.airtime.request.RequestEnvelope;
import com.equitybankgroup.payments.b2c.dto.airtel.contants.TPGConstants;
import com.equitybankgroup.payments.b2c.dto.input.Eazzycashres;
import com.equitybankgroup.payments.b2c.dto.input.InqResponse;
import com.equitybankgroup.payments.b2c.dto.namecheck.MobileNumberInquireReq;
import com.equitybankgroup.payments.b2c.dto.namecheck.MobileNumberInquireRes;
import com.equitybankgroup.payments.b2c.enums.RequestTypes;
import com.equitybankgroup.payments.b2c.model.StatusDetails;
import com.equitybankgroup.payments.b2c.model.TransactionDetails;
import com.equitybankgroup.payments.b2c.repository.StatusDetailsRepository;
import com.equitybankgroup.payments.b2c.repository.TransactionDetailsRepository;
import com.equitybankgroup.payments.b2c.service.business.AirtimeService;
import com.equitybankgroup.payments.b2c.service.util.MiscUtil;
import com.google.gson.Gson;
import java.math.BigDecimal;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import jakarta.annotation.PostConstruct;
import java.io.IOException;
import javax.xml.parsers.ParserConfigurationException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.xml.sax.SAXException;

@RestController
@RequestMapping("/api/AirTimeTopUpWSService")
@Slf4j
public class AirtelAirtimeController {
    
    @Value("${airtel.cd.airtime.whiteList}")
    String whiteListNumbers;
    
    @Value("${airtel.cd.airtime.limit.CDF}")
    String limitStrCDF;
    
    @Value("${airtel.cd.airtime.limit.USD}")
    String limitStrUSD;
    
    @Autowired
    AirtimeService airtimeService;
    
    @Autowired
    StatusDetailsRepository statusDetailsRepository;
    
    @Autowired
    TransactionDetailsRepository transactionDetailsRepository;
    
    Set<String> whiteList;
    
    BigDecimal limitCDF;
    
    BigDecimal limitUSD;
    
    @PostConstruct
    public void init()
    {
        whiteList = MiscUtil.stringToSet(this.whiteListNumbers, ",");
        limitCDF = new BigDecimal(limitStrCDF);
        limitUSD = new BigDecimal(limitStrUSD);
    }
    
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
            /*
            if(!this.whiteList.contains(map.get(TPGConstants.AIRTIME_REQUEST_MSISDNA)))
            {   
                String errorDescription = "Number: " + map.get(TPGConstants.AIRTIME_REQUEST_MSISDNA) + " not in whitelist";
                log.info(errorDescription);
                String response = writeServletErrorMsg("-8", errorDescription);
                return new ResponseEntity(response, HttpStatus.OK);
            }
            String currencyFromMap = map.get(TPGConstants.AIRTIME_REQUEST_CURRENCY);
            String currency = MiscUtil.isNotNullAndNotEmpty(currencyFromMap) ? currencyFromMap : "CDF";
            log.info("Currency: " + currency);
            BigDecimal amount = new BigDecimal(map.get(TPGConstants.AIRTIME_REQUEST_AMOUNT));
            if(currency.equalsIgnoreCase("CDF"))
            {
                if(amount.subtract(limitCDF).signum() > 0)
                {
                    String errorDescription = "Limit violation, amount: " + amount + " is greater than the limit: " + limitCDF;
                    log.info(errorDescription);
                    String response = writeServletErrorMsg("-9", errorDescription);
                    return new ResponseEntity(response, HttpStatus.OK);
                }
            }
            if(currency.equalsIgnoreCase("USD"))
            {
                if(amount.subtract(limitUSD).signum() > 0)
                {
                    String errorDescription = "Limit violation, amount: " + amount + " is greater than the limit: " + limitUSD;
                    log.info(errorDescription);
                    String response = writeServletErrorMsg("-9", errorDescription);
                    return new ResponseEntity(response, HttpStatus.OK);
                }
            }
            String rrn = map.get(TPGConstants.AIRTIME_REQUEST_RRN);
            if(airtimeService.isLocal)
            {
                Optional<TransactionDetails> details = transactionDetailsRepository.findByRrnAndOperationType(rrn, RequestTypes.AIRTIME);
                if(details.isPresent())
                {   
                    String errorDescription = "Duplicate request for RRN: " + rrn;
                    String response = writeServletErrorMsg("-7", errorDescription);
                    return new ResponseEntity(response, HttpStatus.OK);
                }
            }
*/

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
           
        } catch (IOException | ParserConfigurationException | SAXException ex) {
            ex.printStackTrace(System.out);
            String resp = writeServletErrorMsg("400", TPGConstants.INVALID_XML_INPUT);
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
