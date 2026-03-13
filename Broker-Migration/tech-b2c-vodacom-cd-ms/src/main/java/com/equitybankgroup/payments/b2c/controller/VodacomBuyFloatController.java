/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.controller;

import com.equitybankgroup.payments.b2c.dto.vodacom.VodacomDTO;
import com.equitybankgroup.payments.b2c.dto.input.EazInqRequest;
import com.equitybankgroup.payments.b2c.dto.input.Eazzycashres;
import com.equitybankgroup.payments.b2c.dto.input.InqResponse;
import com.equitybankgroup.payments.b2c.dto.vodacom.constants.SafaricomB2BConstants;
import com.equitybankgroup.payments.b2c.dto.vodacom.constants.StatusCodes;
import com.equitybankgroup.payments.b2c.dto.vodacom.constants.VodacomConstants;
import com.equitybankgroup.payments.b2c.enums.TransactionStatus;
import com.equitybankgroup.payments.b2c.model.StatusDetails;
import com.equitybankgroup.payments.b2c.repository.StatusDetailsRepository;
import com.equitybankgroup.payments.b2c.repository.TransactionDetailsRepository;
import com.equitybankgroup.payments.b2c.service.business.VodacomBuyFloatService;
import com.equitybankgroup.payments.b2c.service.business.safaricom.SafaricomKEBuyFloatService;
import com.equitybankgroup.payments.b2c.service.cache.CacheService;
import com.equitybankgroup.payments.b2c.service.util.MiscUtil;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.Executor;

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

/**
 * @author ronaldcheruiyot
 */
@RestController
@RequestMapping("/api/v1")
@Slf4j
public class VodacomBuyFloatController {

    @Autowired
    VodacomBuyFloatService vodacomBuyFloatService;
    
    @Autowired
    SafaricomKEBuyFloatService safaricomBuyFloatService;

    @Autowired
    TransactionDetailsRepository transactionDetailsRepository;

    @Autowired
    StatusDetailsRepository statusDetailsRepository;

    @Autowired
    CacheService cacheService;

    @Autowired
    Executor taskExecutor;

    @GetMapping("/buyfloat/status")
    public ResponseEntity<?> getStats(@RequestParam String rrn) {
        log.info("Get stats request, rrn: " + rrn);
        try {
            Optional<StatusDetails> status = statusDetailsRepository.findByRrn(rrn);
            if (status.isEmpty()) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }
            return new ResponseEntity<>(status.get(), HttpStatus.OK);

        } catch (Exception ex) {
            ex.printStackTrace(System.out);
        }
        return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PostMapping("/buyfloat")
    public ResponseEntity postTransaction(@RequestBody String request) {
        System.out.println("##### INCOMMING TRANSACTION REQUEST: " + request);
        try {
            EazInqRequest inqRequest = (EazInqRequest) MiscUtil.strToObject(request, EazInqRequest.class);
            InqResponse rs = new InqResponse();
            Eazzycashres eazzycashres = new Eazzycashres();
            rs.setEazzycashres(eazzycashres);
            String msgId = String.valueOf(inqRequest.getMsgId());
            String rrn = inqRequest.getEazzycash().getRrn();
//            if (vodacomBuyFloatService.isLocal) {
//                Optional<TransactionDetails> details = transactionDetailsRepository.findByRrnAndOperationType(inqRequest.getEazzycash().getRrn(), RequestTypes.BUY_FLOAT);
//                if (details.isPresent()) {
//                    String response = writeServletErrorMsg(msgId, "-7", "", "");
//                    return new ResponseEntity(response, HttpStatus.OK);
//                }
//            }


            VodacomDTO airtDto = null;
            
            if(!MiscUtil.isNullOrEmpty(inqRequest.getEazzycash().getBankId()) && inqRequest.getEazzycash().getBankId().equalsIgnoreCase("43"))
            {
                airtDto = vodacomBuyFloatService.sendTransaction(inqRequest, "CD", rs);
            } else if(!MiscUtil.isNullOrEmpty(inqRequest.getEazzycash().getBankId()) && inqRequest.getEazzycash().getBankId().equalsIgnoreCase("54")) {
                airtDto = safaricomBuyFloatService.sendTransaction(inqRequest, "KE", rs);
            } else {
                String response = this.writeServletErrorMsg(msgId, "-1", "400", "Unknown institution code!!");
                return new ResponseEntity<>(response, getResponseHeaders(), HttpStatus.BAD_REQUEST);
            }
            int x = airtDto.getStatusCode();
            String telcoStatusCode = airtDto.getTelcoStatusCode();
            String statusMessage = airtDto.getTelcoStatusMessage();
            if (x == -3) {
                String response = this.writeServletErrorMsg(msgId, "-3", telcoStatusCode, statusMessage);
                return new ResponseEntity(response, HttpStatus.OK);
            }
            if (x == -1) {
                String response = this.writeServletErrorMsg(msgId, "-1", telcoStatusCode, statusMessage);
                return new ResponseEntity(response, HttpStatus.OK);
            }
            if (x == 1) {
                String response = this.writeServletErrorMsg(msgId, "1", telcoStatusCode, statusMessage);
                return new ResponseEntity(response, HttpStatus.OK);
            }
            if (x == 0) {
                String tranId = airtDto.getTranId();
                String response = writeServletSuccessMsg(msgId, tranId);
                return new ResponseEntity(response, HttpStatus.OK);
            }

            String response = this.writeServletErrorMsg(msgId, String.valueOf(x), telcoStatusCode, statusMessage);
            return new ResponseEntity(response, HttpStatus.OK);
        } catch (jakarta.xml.bind.JAXBException ex) {
            ex.printStackTrace(System.out);
        }
        return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PostMapping("/vodacom/b2b/callback")
    public ResponseEntity vodacomCallback(@RequestBody String callback) {
        log.info("RECEIVED VODACOM B2B CALLBACK REQUEST: " + callback);
        taskExecutor.execute(() -> {
            Map<String, String> values = MiscUtil.extractAllTagValues(callback);
            String resultCode = values.get(VodacomConstants.B2B_CALLBACK_RESULT_CODE);
            String resultDesc = values.get(VodacomConstants.B2B_CALLBACK_RESULT_DESC);
            String thirdPartyReference = values.get(VodacomConstants.B2B_CALLBACK_RESULT_THIRD_PARTY_REFERENCE);
            String statusCode = StatusCodes.TIMEOUT;
            String statusDesc = "Timeout; could not process callback!";
            String status = TransactionStatus.TIMEOUT.name();

            if (!MiscUtil.isNullOrEmpty(resultCode) && !MiscUtil.isNullOrEmpty(thirdPartyReference)) {
                if (resultCode.equalsIgnoreCase("0")) {
                    statusCode = StatusCodes.SUCCESS;
                    status = TransactionStatus.OK.name();
                } else {
                    statusCode = StatusCodes.FAILED;
                    status = TransactionStatus.ERROR.name();
                }

            }

            if (!MiscUtil.isNullOrEmpty(resultDesc)) {
                statusDesc = resultDesc;
            }
            log.info(thirdPartyReference + "|On update after callback, statusCode" + statusCode);
            Map<String, String> map = new HashMap<>();
            map.put("statusCode", statusCode);
            map.put("statusDesc", statusDesc);
            cacheService.updateCacheFromApiCall(thirdPartyReference, map);
        });
        return new ResponseEntity(HttpStatus.ACCEPTED);
    }
    
    @PostMapping("/safaricom/b2b/callback")
    public ResponseEntity safaricomCallback(@RequestBody String callback1) {
        log.info("RECEIVED SAFARICOM B2B CALLBACK REQUEST: " + callback1);
        final String callback = MiscUtil.extractCDATAContents(callback1);
        taskExecutor.execute(() -> {
            
            Map<String, String> values = MiscUtil.extractAllTagValues(callback);
            String resultCode = values.get(SafaricomB2BConstants.B2B_DISBURSEMENT_RESULT_CODE);
            String resultDesc = values.get(SafaricomB2BConstants.B2B_DISBURSEMENT_RESULT_DESC);
            String tranId = values.get(SafaricomB2BConstants.B2B_DISBURSEMENT_RESULT_TRAN_ID);
            String originatorConversationID = values.get(SafaricomB2BConstants.B2B_DISBURSEMENT_RESULT_ORIGINATOR_CONV_ID);
            String statusCode = StatusCodes.TIMEOUT;
            String statusDesc = "Timeout; could not process callback!";
            String status = TransactionStatus.TIMEOUT.name();

            if (!MiscUtil.isNullOrEmpty(resultCode) && !MiscUtil.isNullOrEmpty(tranId)) {
                if (resultCode.equalsIgnoreCase("0")) {
                    statusCode = StatusCodes.SUCCESS;
                    status = TransactionStatus.OK.name();
                } else {
                    statusCode = StatusCodes.FAILED;
                    status = TransactionStatus.ERROR.name();
                }

            }

            if (!MiscUtil.isNullOrEmpty(resultDesc)) {
                statusDesc = resultDesc;
            }
            log.info(tranId + "|On update after callback, originatorConversationID" + originatorConversationID);
            log.info(tranId + "|On update after callback, statusCode" + statusCode);
            Map<String, String> map = new HashMap<>();
            map.put("statusCode", statusCode);
            map.put("statusDesc", statusDesc);
            map.put("tranId", tranId);
            cacheService.updateCacheFromApiCall(originatorConversationID, map);
        });
        return new ResponseEntity(HttpStatus.ACCEPTED);
    }

    private String writeServletSuccessMsg(String msgId, String tranId) {
        return "<response>\n" +
                "    <msgId>" + msgId + "</msgId>\n" +
                "    <eazzycashres>\n" +
                "        <status>OK</status>\n" +
                "        <responseCode>00</responseCode>\n" +
                "        <tranID>" + tranId + "</tranID>\n" +
                "        <telcoResponseCode>0</telcoResponseCode>\n" +
                "        <telcoResponseDesc>Success</telcoResponseDesc>\n" +
                "    </eazzycashres>\n" +
                "</response>";

    }

    
    private MultiValueMap<String, String> getResponseHeaders()
    {
        MultiValueMap<String, String> headers = new LinkedMultiValueMap<>();
        headers.add("Content-Type", "application/xml");
        return headers;
    }
    
    private String writeServletErrorMsg(String msgId, String status, String telcoStatusCode, String statusMessage) {
        return "<response>\n" +
                "    <msgId>" + msgId + "</msgId>\n" +
                "    <eazzycashres>\n" +
                "        <status>ERROR</status>\n" +
                "        <responseCode>" + status + "</responseCode>\n" +
                "        <telcoResponseCode>" + telcoStatusCode + "</telcoResponseCode>\n" +
                "        <telcoResponseDesc>" + statusMessage + "</telcoResponseDesc>\n" +
                "    </eazzycashres>\n" +
                "</response>";
    }
//        return "<response>\n" +
//"    <eazzycashres>\n" +
//"        <msgId>" + msgId + "</msgId>\n" +
//"        <status>ERROR</status>\n" +
//"        <responseCode>" + status + "</responseCode>\n" +
//"    </eazzycashres>\n" +
//"</response>";
//    }

}/**
 * RESPONSES:
 * <response>
 * <eazzycashres>
 * <msgId>324234245453</msgId>
 * <status>ERROR</status>
 * <responseCode>-10</responseCode>
 * </eazzycashres>
 * </response>
 * Accepted
 * <response>
 * <eazzycashres>
 * <msgId>324234245453</msgId>
 * <status>OK</status>
 * <responseCode>0</responseCode>
 * </eazzycashres>
 * </response>
 */
