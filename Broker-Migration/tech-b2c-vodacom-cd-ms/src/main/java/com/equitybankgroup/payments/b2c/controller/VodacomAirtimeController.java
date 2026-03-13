/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.controller;

/**
 *
 * @author ronaldcheruiyot
 */


import com.equitybankgroup.payments.b2c.dto.vodacom.VodacomDTO;
import com.equitybankgroup.payments.b2c.dto.vodacom.constants.StatusCodes;
import com.equitybankgroup.payments.b2c.dto.vodacom.constants.TPGConstants;
import com.equitybankgroup.payments.b2c.dto.vodacom.constants.VodacomConstants;
import com.equitybankgroup.payments.b2c.enums.RequestTypes;
import com.equitybankgroup.payments.b2c.enums.TransactionStatus;
import com.equitybankgroup.payments.b2c.model.StatusDetails;
import com.equitybankgroup.payments.b2c.model.TransactionDetails;
import com.equitybankgroup.payments.b2c.repository.StatusDetailsRepository;
import com.equitybankgroup.payments.b2c.repository.TransactionDetailsRepository;
import com.equitybankgroup.payments.b2c.service.business.VodacomAirtimeService;
import com.equitybankgroup.payments.b2c.service.cache.CacheService;
import com.equitybankgroup.payments.b2c.service.util.MiscUtil;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.concurrent.Executor;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.annotation.PostConstruct;
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

@RestController
@Slf4j
public class VodacomAirtimeController {
    
    @Value("${vodacom.cd.airtime.whiteList}")
    String whiteListNumbers;
    
    @Value("${vodacom.cd.airtime.limit.CDF}")
    String limitStrCDF;
    
    @Value("${vodacom.cd.airtime.limit.USD}")
    String limitStrUSD;
    
    @Autowired
    VodacomAirtimeService airtimeService;
    
    @Autowired
    StatusDetailsRepository statusDetailsRepository;
    
    @Autowired
    TransactionDetailsRepository transactionDetailsRepository;
    
    @Autowired
    CacheService cacheService;
    
    @Autowired
    Executor taskExecutor;
    
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
    
    @GetMapping("/api/AirTimeTopUpWSService/status")
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
    
    @PostMapping("/api/AirTimeTopUpWSService/AirTimeTopUp")
    public ResponseEntity buyAirtime(@RequestBody String request)
    {   
        System.out.println("##### INCOMMING AIRTIME TRANSACTION REQUEST: " + request);
        try {
            Map<String, String> map = MiscUtil.extractAllTagValues(request);
//            if(!this.whiteList.contains(map.get(TPGConstants.AIRTIME_REQUEST_MSISDNA)))
//            {   
//                log.info("Number: " + map.get(TPGConstants.AIRTIME_REQUEST_MSISDNA) + " not in whitelist");
//                String response = writeServletErrorMsg("-8");
//                return new ResponseEntity(response, HttpStatus.OK);
//            }
            String currencyFromMap = map.get(TPGConstants.AIRTIME_REQUEST_CURRENCY);
            String currency = MiscUtil.isNotNullAndNotEmpty(currencyFromMap) ? currencyFromMap : "CDF";
            log.info("Currency: " + currency);
//            BigDecimal amount = new BigDecimal(map.get(TPGConstants.AIRTIME_REQUEST_AMOUNT));
//            if(currency.equalsIgnoreCase("CDF"))
//            {
//                if(amount.subtract(limitCDF).signum() > 0)
//                {
//
//                    log.info("Limit violation, amount: " + amount + " is greater than the limit: " + limitCDF);
//                    String response = writeServletErrorMsg("-9");
//                    return new ResponseEntity(response, HttpStatus.OK);
//                }
//            }
//            if(currency.equalsIgnoreCase("USD"))
//            {
//                if(amount.subtract(limitUSD).signum() > 0)
//                {
//
//                    log.info("Limit violation, amount: " + amount + " is greater than the limit: " + limitUSD);
//                    String response = writeServletErrorMsg("-9");
//                    return new ResponseEntity(response, HttpStatus.OK);
//                }
//            }
            String rrn = map.get(TPGConstants.AIRTIME_REQUEST_RRN);
//            if(airtimeService.isLocal)
//            {
//                Optional<TransactionDetails> details = transactionDetailsRepository.findByRrnAndOperationType(rrn, RequestTypes.AIRTIME);
//                if(details.isPresent())
//                {
//                    String response = writeServletErrorMsg("-7");
//                    return new ResponseEntity(response, HttpStatus.OK);
//                }
//            }
            VodacomDTO airtDto = airtimeService.buyAirtimeSync(map);
            int x = airtDto.getStatusCode();
            String tranId = airtDto.getTranId();
            System.out.println("tranId: " + tranId);
            if (x == -3) {
                String response = this.writeServletErrorMsg("-3");
                return new ResponseEntity(response, HttpStatus.OK);
            }
            if (x == -1) {
                String response = this.writeServletErrorMsg("-1");
                return new ResponseEntity(response, HttpStatus.OK);
            }
            if (x == 1) {
                String response = this.writeServletErrorMsg("1");
                return new ResponseEntity(response, HttpStatus.OK);
            }
            if (x == 0) {
                String response = this.writeServletSuccessMsg(tranId);
                return new ResponseEntity(response, HttpStatus.OK);
            }
           
        } catch (Exception ex) {
            ex.printStackTrace(System.out);
        }
        return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
    }
    
    @PostMapping("/api/vodacom/airtimetopupcallback")
    public ResponseEntity airtimeCallback(@RequestBody String callback)
    {   
        log.info("RECEIVED CALLBACK REQUEST: " + callback);
        taskExecutor.execute(() -> {
            Map<String, String> values = MiscUtil.extractAllTagValues(callback);
            String resultCode = values.get(VodacomConstants.AIRTIME_CALLBACK_RESULT_CODE);
            String resultDesc = values.get(VodacomConstants.AIRTIME_CALLBACK_RESULT_DESC);
            String transactionId = values.get(VodacomConstants.AIRTIME_CALLBACK_TRANSACTION_ID);
            String conversationId = values.get(VodacomConstants.AIRTIME_CALLBACK_CONVERSATION_ID);
            String statusCode = StatusCodes.TIMEOUT;
            String statusDesc = "Timeout; could not process callback!";
            String status = TransactionStatus.TIMEOUT.name();

            if(!MiscUtil.isNullOrEmpty(resultCode) && !MiscUtil.isNullOrEmpty(transactionId))
            {
                if(resultCode.equalsIgnoreCase("0"))
                {
                    statusCode = StatusCodes.SUCCESS;
                    status = TransactionStatus.OK.name();
                } else {
                    statusCode = StatusCodes.FAILED;
                    status = TransactionStatus.ERROR.name();
                }

            }

            if(!MiscUtil.isNullOrEmpty(resultDesc))
            {
                statusDesc = resultDesc;
            }
            log.info(transactionId +"|On update after callback, statusCode: " + statusCode);
            log.info(transactionId +"|On update after callback, conversationId: " + conversationId);
            log.info(transactionId +"|On update after callback, resultCode: " + resultCode);
            log.info(transactionId +"|On update after callback, resultDesc: " + resultDesc);
            Map<String, String> map = new HashMap<>();
            map.put("statusCode", statusCode);
            map.put("statusDesc", statusDesc);
            map.put("tranId", transactionId);
            try {
                Thread.sleep(3000);
            } catch (InterruptedException ex) {
                Logger.getLogger(VodacomController.class.getName()).log(Level.SEVERE, null, ex);
            }
            cacheService.updateCacheFromApiCall(conversationId, map);
        });
        return new ResponseEntity(HttpStatus.ACCEPTED);
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
    
    private String writeServletErrorMsg(String errorCode) {
        String response = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
"<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" +
"    <soap:Body>\n" +
"        <ns2:topupResponse xmlns:ns2=\"http://business.airtime.telcos.equitybank.com/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:type=\"ns2:topupResponse\">\n" +
"            <return>ERROR|" + errorCode + "</return>\n" +
"        </ns2:topupResponse>\n" +
"    </soap:Body>\n" +
"</soap:Envelope>";
        return response;
    }
    
}
