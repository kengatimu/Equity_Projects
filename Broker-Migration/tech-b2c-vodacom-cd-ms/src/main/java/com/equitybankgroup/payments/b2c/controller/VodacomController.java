/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.controller;

import com.equitybankgroup.payments.b2c.dto.input.EazInqRequest;
import com.equitybankgroup.payments.b2c.dto.input.Eazzycashres;
import com.equitybankgroup.payments.b2c.dto.input.InqResponse;
import com.equitybankgroup.payments.b2c.dto.vodacom.VodacomDTO;
import com.equitybankgroup.payments.b2c.dto.vodacom.constants.StatusCodes;
import com.equitybankgroup.payments.b2c.dto.vodacom.constants.VodacomConstants;
import com.equitybankgroup.payments.b2c.enums.RequestTypes;
import com.equitybankgroup.payments.b2c.enums.TransactionStatus;
import com.equitybankgroup.payments.b2c.model.StatusDetails;
import com.equitybankgroup.payments.b2c.model.TransactionDetails;
import com.equitybankgroup.payments.b2c.repository.StatusDetailsRepository;
import com.equitybankgroup.payments.b2c.repository.TransactionDetailsRepository;
import com.equitybankgroup.payments.b2c.service.CallbackService;
import com.equitybankgroup.payments.b2c.service.business.JDBCService;
import com.equitybankgroup.payments.b2c.service.business.VodacomBankToWalletService;
import com.equitybankgroup.payments.b2c.service.cache.CacheService;
import com.equitybankgroup.payments.b2c.service.util.MiscUtil;
import jakarta.xml.bind.JAXBContext;
import jakarta.xml.bind.JAXBException;
import jakarta.xml.bind.Marshaller;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.task.TaskExecutor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.StringWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.Executor;

/**
 *
 * @author ronaldcheruiyot
 */
@RestController
@RequestMapping("/api/v1")
@Slf4j
public class VodacomController {

    @Autowired
    CallbackService callbackService;
    
    @Autowired
    VodacomBankToWalletService bankToWalletService;
    
    @Autowired
    TransactionDetailsRepository transactionDetailsRepository;
    
    @Autowired
    StatusDetailsRepository statusDetailsRepository;
    
    @Autowired
    CacheService cacheService;
    
    @Autowired
    Executor taskExecutor;
    
    @Autowired
    JDBCService jdbcService;

    @Autowired
    @Qualifier("taskExecutor") TaskExecutor executor;
    
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
    
    @PostMapping("/transaction")
    public ResponseEntity<?> postTransaction(@RequestBody String request)
    {   
        System.out.println("##### INCOMMING TRANSACTION REQUEST: " + request);
        try {
            EazInqRequest inqRequest = (EazInqRequest) MiscUtil.strToObject(request, EazInqRequest.class);
            InqResponse rs = new InqResponse();
            Eazzycashres eazzycashres = new Eazzycashres();
            rs.setEazzycashres(eazzycashres);
        
            if(bankToWalletService.isLocal)
            {
                Optional<TransactionDetails> details = transactionDetailsRepository.findByRrnAndOperationType(inqRequest.getEazzycash().getRrn(), RequestTypes.B2C);
                if(details.isPresent())
                {
                    String response = writeServletErrorMsg("Duplicate transaction", rs, "-7", null, inqRequest);
                    return new ResponseEntity<>(response, HttpStatus.OK);
                }
            }

            VodacomDTO airtDto = bankToWalletService.sendTransaction(inqRequest, "CD", rs);
            int x = airtDto.getStatusCode();
            String telcoStatusCode = airtDto.getTelcoStatusCode();
            String statusMessage = airtDto.getTelcoStatusMessage();
            String tranId = airtDto.getTranId();
            if (x == -3) {
                String response = this.writeServletErrorMsg((MiscUtil.isNotNullAndNotEmpty(statusMessage))  ? statusMessage : "Transaction failed!! Timeout", rs, "-3", telcoStatusCode, inqRequest);
                return new ResponseEntity<>(response, HttpStatus.OK);
            }
            if (x == -1) {
                String response = this.writeServletErrorMsg((MiscUtil.isNotNullAndNotEmpty(statusMessage))  ? statusMessage : "Transaction failed", rs, "400", telcoStatusCode, inqRequest);
                return new ResponseEntity<>(response, HttpStatus.OK);
            }
            if (x == 1) {
                String response = this.writeServletErrorMsg((MiscUtil.isNotNullAndNotEmpty(statusMessage))  ? statusMessage : "Transaction failed!", rs, "400", telcoStatusCode, inqRequest);
                return new ResponseEntity<>(response, HttpStatus.OK);
            }
            if (x == -11) {
                String response = writeServletPendingMsg("Pending!", inqRequest.getEazzycash().getRrn(), tranId, inqRequest, telcoStatusCode);
                return new ResponseEntity<>(response, HttpStatus.OK);
            }
            if (x == 0) {
                String response = writeServletSuccessMsg("Transaction Posted Successful!", inqRequest.getEazzycash().getRrn(), tranId, inqRequest, telcoStatusCode);
                return new ResponseEntity<>(response, HttpStatus.OK);
            }
            
            String response = this.writeServletErrorMsg((MiscUtil.isNotNullAndNotEmpty(statusMessage))  ? statusMessage : "Transaction failed!", rs, String.valueOf(x), telcoStatusCode, inqRequest);
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (JAXBException ex) {
            ex.printStackTrace(System.out);
        }
        return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

//    @PostMapping("/vodacom/b2c/callback")
//    public ResponseEntity<?> callback(@RequestBody String telcoCallbackString) {
//        log.info("Received Callback From Telco : " + telcoCallbackString);
//
//        sendCallbackToBusinessService(telcoCallbackString);
//        return new ResponseEntity<>(composeTelcoCallbackResponse(), HttpStatus.OK);
//    }

    private void sendCallbackToBusinessService(String telcoCallbackString) {
        executor.execute(() -> callbackService.sendCallbackToBusinessService(telcoCallbackString));
    }



    @PostMapping("/vodacom/b2c/callback")
    public ResponseEntity<?> callback(@RequestBody String callback)
    {   
        log.info("RECEIVED CALLBACK REQUEST: " + callback);
        taskExecutor.execute(() -> {
            Map<String, String> values = MiscUtil.extractAllTagValues(callback);
            String resultCode = values.get(VodacomConstants.CALLBACK_RESULT_CODE);
            String resultDesc = values.get(VodacomConstants.CALLBACK_RESULT_DESC);
            String thirdPartyReference = values.get(VodacomConstants.DISBURSEMENT_REQUEST_TP_REFERENCE);
            String statusCode = StatusCodes.TIMEOUT;
            String statusDesc = "Timeout; could not process callback!";
            String status = TransactionStatus.TIMEOUT.name();

            if(!MiscUtil.isNullOrEmpty(resultCode) && !MiscUtil.isNullOrEmpty(thirdPartyReference))
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
            log.info(thirdPartyReference +"|On update after callback, statusCode" + statusCode);
            Map<String, String> map = new HashMap<>();
            map.put("statusCode", statusCode);
            map.put("statusDesc", statusDesc);
            cacheService.updateCacheFromApiCall(thirdPartyReference, map);
            StatusDetails record = jdbcService.getB2cTransactionsByRrn(thirdPartyReference);
            if(record != null) {
                System.out.println("Status: " + status);
                record.setStatusCode(statusCode);
                record.setStatus(status);
                record.setStatusMessage(statusDesc);
                editTran(record); 
            }
            sendCallbackToBusinessService(callback);
        });
        return new ResponseEntity<>(HttpStatus.ACCEPTED);
    }

     
        
    private String writeServletPendingMsg(String msg, String rrn, String tranID, EazInqRequest inqRequest, String statusCode) {
        try {
            InqResponse rs = new InqResponse();
            Eazzycashres eazzycashres = new Eazzycashres();
            eazzycashres.status = "PENDING|" + tranID;
            eazzycashres.responseCode = statusCode;
            eazzycashres.walletTranID = tranID;
            if((msg != null) && !(msg.isEmpty()))
            {
                eazzycashres.responseDesc = msg;
            }
            if(!MiscUtil.isNullOrEmpty(inqRequest.getMsgId())) {
                rs.setMsgId(inqRequest.getMsgId());
            } else {
                rs.setMsgId(rrn);
            }
            
            rs.setEazzycashres(eazzycashres);
            JAXBContext jaxbContext = JAXBContext.newInstance(InqResponse.class);
            Marshaller jaxbMarshaller = jaxbContext.createMarshaller();
            jaxbMarshaller.setProperty("jaxb.formatted.output", Boolean.TRUE);
            StringWriter jaxwriter = new StringWriter();
            jaxbMarshaller.marshal(rs, jaxwriter);
            StringBuffer jaxrespBfr = jaxwriter.getBuffer();
            String response = jaxrespBfr.toString();
            System.out.println(msg + response);
            System.out.println(msg);
            System.out.println(msg + jaxrespBfr);
            return response;
        } catch (JAXBException ex) {
            ex.printStackTrace(System.out);
        }
        return null;
    }
    
    private String writeServletSuccessMsg(String msg, String rrn, String tranID, EazInqRequest inqRequest, String statusCode) {
        try {
            InqResponse rs = new InqResponse();
            Eazzycashres eazzycashres = new Eazzycashres();
            eazzycashres.status = "OK|" + tranID;
            eazzycashres.responseCode = statusCode;
            eazzycashres.walletTranID = tranID;
            if((msg != null) && !(msg.isEmpty()))
            {
                eazzycashres.responseDesc = msg;
            }
            if(!MiscUtil.isNullOrEmpty(inqRequest.getMsgId())) {
                rs.setMsgId(inqRequest.getMsgId());
            } else {
                rs.setMsgId(rrn);
            }
            
            rs.setEazzycashres(eazzycashres);
            JAXBContext jaxbContext = JAXBContext.newInstance(InqResponse.class);
            Marshaller jaxbMarshaller = jaxbContext.createMarshaller();
            jaxbMarshaller.setProperty("jaxb.formatted.output", Boolean.TRUE);
            StringWriter jaxwriter = new StringWriter();
            jaxbMarshaller.marshal(rs, jaxwriter);
            StringBuffer jaxrespBfr = jaxwriter.getBuffer();
            String response = jaxrespBfr.toString();
            System.out.println(msg + response);
            System.out.println(msg);
            System.out.println(msg + jaxrespBfr);
            return response;
        } catch (JAXBException ex) {
            ex.printStackTrace(System.out);
        }
        return null;
    }
    
    
    private String writeServletErrorMsg(String msg, InqResponse rs, String status, String telcoStatusCode, EazInqRequest inqRequest)
    {
        try {
            if((status != null) && !(status.isEmpty())) 
            {
                (rs.getEazzycashres()).status = "ERROR|" + status;
            } else {
                (rs.getEazzycashres()).status = "ERROR";
            }
            
            if((msg != null) && !(msg.isEmpty()))
            {
                (rs.getEazzycashres()).responseDesc = msg;
            }
            
            if((telcoStatusCode != null) && !(telcoStatusCode.isEmpty()))
            {
                (rs.getEazzycashres()).responseCode = telcoStatusCode;
            }
            if(!MiscUtil.isNullOrEmpty(inqRequest.getMsgId())) {
                rs.setMsgId(inqRequest.getMsgId());
            } else {
                rs.setMsgId(inqRequest.getEazzycash().getRrn());
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
        } catch (JAXBException ex) {
            ex.printStackTrace(System.out);
        }
        return null;
    }
    
    public void editTran(StatusDetails record)
    {
        try
        {   
            if(record != null)
            {
                jdbcService.editB2cTransactions(record);
            }
        } catch(Exception ex)
        {
            ex.printStackTrace(System.out);
        }
    }

    private String composeTelcoCallbackResponse() {
        return "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>\n" +
                "<response>\n" +
                "    <dataItem>\n" +
                "        <name>ResponseCode</name>\n" +
                "        <type>String</type>\n" +
                "        <value>200</value>\n" +
                "    </dataItem>\n" +
                "    <dataItem>\n" +
                "        <name>RESULT_CODE</name>\n" +
                "        <type>String</type>\n" +
                "        <value>Received</value>\n" +
                "    </dataItem>\n" +
                "</response>";
    }
    
}
