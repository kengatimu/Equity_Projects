/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.service.business;

/**
 *
 * @author ronaldcheruiyot To change this license header, choose License Headers
 * in Project Properties. To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import com.equitybankgroup.payments.b2c.dto.vodacom.Vodacomb2cResponse;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;

import com.equitybankgroup.payments.b2c.dto.vodacom.VodacomDTO;
import static com.equitybankgroup.payments.b2c.enums.TranStatus.SUCCESS;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.HashMap;
import java.util.concurrent.Executor;
import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import org.springframework.context.ApplicationContext;
import com.equitybankgroup.payments.b2c.enums.*;
import com.equitybankgroup.payments.b2c.dto.input.EazInqRequest;
import com.equitybankgroup.payments.b2c.dto.input.InqResponse;
import com.equitybankgroup.payments.b2c.dto.vodacom.constants.StatusCodes;
import com.equitybankgroup.payments.b2c.dto.vodacom.constants.TPGConstants;
import com.equitybankgroup.payments.b2c.dto.vodacom.constants.VodacomConstants;
import com.equitybankgroup.payments.b2c.model.StatusDetails;
import com.equitybankgroup.payments.b2c.model.TransactionDetails;
import com.equitybankgroup.payments.b2c.repository.TransactionDetailsRepository;
import com.equitybankgroup.payments.b2c.service.business.http.OutboundHttpAdapter;
import com.equitybankgroup.payments.b2c.service.cache.CacheService;
import com.equitybankgroup.payments.b2c.service.util.MiscUtil;
import com.huawei.cps.cpsinterface.common.ParameterType;
import com.huawei.cps.cpsinterface.request.Request;
import com.huawei.cps.cpsinterface.request.Request.Body.ReferenceData;
import java.math.BigDecimal;
import java.time.Duration;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.annotation.PostConstruct;
import java.math.BigInteger;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.env.Environment;
import com.huawei.cps.cpsinterface.api_requestmgr.*;
import com.huawei.cps.cpsinterface.response.Response;
import jakarta.xml.ws.BindingProvider;

/**
 *
 * @author ronaldcheruiyot
 */
@Service
@Slf4j
public class VodacomAirtimeService {

    @Value("${vodacom.cd.airtime.pOSDeviceIDKey}")
    String pOSDeviceIDKey;

    @Value("${vodacom.cd.airtime.pOSDeviceIDValue}")
    String pOSDeviceIDValue;

    @Value("${vodacom.cd.airtime.password}")
    String password;

    @Value("${vodacom.cd.airtime.resultURL}")
    String resultURL;

    @Value("${vodacom.cd.airtime.identifier}")
    String identifier;

    @Value("${vodacom.cd.airtime.shortCode}")
    String shortCode;

    @Value("${vodacom.cd.airtime.securityCredential}")
    String securityCredential;

    @Value("${vodacom.cd.airtime.receiverPartyIdentifier}")
    String receiverPartyIdentifier;

    @Value("${vodacom.cd.airtime.requestURL}")
    String requestURL;

    @Value("${vodacom.cd.airtime.thirdPartId}")
    String thirdPartId;

    @Value("${vodacom.cd.airtime.callbackWaitingTime}")
    String callbackWaitingTime;

    @Autowired
    private ApplicationContext applicationContext;

    @Autowired
    Executor taskExecutor;

    @Autowired
    OutboundHttpAdapter httpAdapter;

    @Autowired
    CacheService cacheService;

    @Autowired
    TransactionDetailsRepository tranRepository;

    private Map<String, Map<String, String>> props = new HashMap<>();

    public boolean isLocal = false;

    @PostConstruct
    public void init() {
        Environment env = this.applicationContext.getEnvironment();
        String[] activeProfiles = env.getActiveProfiles();
        for (String profile : activeProfiles) {
            if (profile.equalsIgnoreCase("local")) {
                isLocal = true;
            }
        }

    }

    public String getDisbursementURL(String countryCode) {
        Map<String, String> countryProps = props.get(countryCode);
        if (countryProps != null) {
            return countryProps.get("disbursementURL");
        }
        System.out.println("Props for country: " + countryCode + " not found!!");
        return null;
    }

    public String getPropertyValue(String countryCode, String propName) throws Exception {
        Map<String, String> countryProps = props.get(countryCode);
        if (countryProps != null) {
            String value = countryProps.get(propName);
            if (value != null && !value.isEmpty()) {
                return value;
            }

            String message = "Value for prop: " + propName + " for country: " + countryCode + " not cannot be null or empty!!";
            System.out.println(message);
        }
        String message = "Props for country: " + countryCode + " not found!!";
        System.out.println(message);
        throw new Exception(message);
    }

    public Vodacomb2cResponse postTransactionSOAP(Map<String, String> requestMap) {

        Vodacomb2cResponse response = new Vodacomb2cResponse();
        Map<String, Object> aditionalData = new HashMap<>();
        String rrn = requestMap.get(TPGConstants.AIRTIME_REQUEST_RRN);
        String amount = requestMap.get(TPGConstants.AIRTIME_REQUEST_AMOUNT);
        String msisdn = requestMap.get(TPGConstants.AIRTIME_REQUEST_MSISDNA);
        String currency = requestMap.get(TPGConstants.AIRTIME_REQUEST_CURRENCY);

        APIRequestMgrService apiRequestMgrService = new APIRequestMgrService();
        APIRequestMgrPortType port = apiRequestMgrService.getAPIRequestMgrServicePort();
        ((BindingProvider) port).getRequestContext().put(BindingProvider.ENDPOINT_ADDRESS_PROPERTY, this.requestURL);

        Request requestMsg = VodacomAirtimeService.getAirtimeSOAPRequest(msisdn, currency, amount,
                rrn, this.thirdPartId, this.password, this.resultURL, this.pOSDeviceIDKey, this.pOSDeviceIDValue,
                this.identifier, this.securityCredential, this.shortCode);
        Response responseMsg = port.apiRequest(requestMsg);

        String conversationId = responseMsg.getHeader().getConversationID();
        String responseDesc = responseMsg.getBody().getResponseDesc();
        String originatorConversationId = responseMsg.getHeader().getOriginatorConversationID();

        String responseCode = responseMsg.getBody().getResponseCode();
        BigInteger serviceStatus = responseMsg.getBody().getServiceStatus();

        log.info(rrn + "|conversationId: " + conversationId);
        log.info(rrn + "|responseDesc: " + responseDesc);
        log.info(rrn + "|originatorConversationId: " + originatorConversationId);
        log.info(rrn + "|responseCode: " + responseCode);
        log.info(rrn + "|serviceStatus: " + serviceStatus);

        aditionalData.put(VodacomConstants.AIRTIME_RESPONSE_ORIGINATOR_CONVERSATION_ID, originatorConversationId);
        aditionalData.put(VodacomConstants.AIRTIME_RESPONSE_CONVERSATION_ID, conversationId);
        aditionalData.put(VodacomConstants.AIRTIME_RESPONSE_DESC, responseDesc);

        if (MiscUtil.isNullOrEmpty(responseCode)) {
            response.setAditionalData(aditionalData);
            response.setStatus(TranStatus.TIMEOUT);
            response.setMessage("TXN status is null or empty!!");
            return response;
        }

        if (responseCode.equalsIgnoreCase("0") && !MiscUtil.isNullOrEmpty(originatorConversationId)) {
            System.out.println("Succesfully initiated");
            response.setStatus(TranStatus.SUCCESS);
            response.setMessage("Succesfully initiated");
            response.setAditionalData(aditionalData);
            return response;
        }

        if (MiscUtil.isNullOrEmpty(responseDesc)) {
            response.setStatus(TranStatus.FAILURE);
            log.info(rrn + "|Airtime purchase failed!");
            response.setAditionalData(aditionalData);
            response.setMessage("Airtime purchase failed!");
            return response;
        }

        response.setStatus(TranStatus.FAILURE);
        log.info(rrn + "|" + responseDesc);
        response.setAditionalData(aditionalData);
        response.setMessage(responseDesc);
        return response;
    }

    public VodacomDTO buyAirtime(Map<String, String> request) {
        JDBCService jdbcService = (JDBCService) this.applicationContext.getBean(JDBCService.class);
        String rrn = request.get(TPGConstants.AIRTIME_REQUEST_RRN);
        BigDecimal amount = new BigDecimal(request.get(TPGConstants.AIRTIME_REQUEST_AMOUNT));
        StatusDetails record = jdbcService.getB2cTransactionsByRrn(rrn);

        if (record == null) {
            if (!isLocal) {
                System.out.println(rrn + "|Airtime record record Not found!!");
                return new VodacomDTO(-1, null, null, rrn + "|B2C record Not found!!");
            }
            record = getStatusDetails(amount, rrn);
        }
        try {
            Vodacomb2cResponse response = postTransaction(request);
            String conversationId = (String) response.getAditionalData().get(VodacomConstants.AIRTIME_RESPONSE_CONVERSATION_ID);
            Map<String, String> map = new HashMap<>();
            map.put("statusCode", StatusCodes.INITIALIZED);
            System.out.println("conversationId: " + conversationId);
            if (MiscUtil.isNotNullAndNotEmpty(conversationId)) {
                cacheService.insretFromMainThread(conversationId, map);
            }
            //@TODO, what if insert fails?
            System.out.println("response.getStatus(): " + response.getStatus().name());
            String resultCode = (String) response.getAditionalData().get(VodacomConstants.AIRTIME_RESPONSE_RESPONSE_CODE);
            String telcoMessage = (String) response.getAditionalData().get(VodacomConstants.AIRTIME_RESPONSE_DESC);
            if (null == response.getStatus()) {
                return new VodacomDTO(-1, null, resultCode, !MiscUtil.isNullOrEmpty(telcoMessage) ? telcoMessage : "Failed");
            } else {
                switch (response.getStatus()) {
                    case SUCCESS:
                        System.out.println("in SUCCESS: ");
                        return checkStatus(rrn, record, jdbcService, conversationId);
                    case FAILURE:
                        record.setStatusCode(StatusCodes.FAILED);
                        record.setStatus(TransactionStatus.ERROR.name());
                        record.setStatusMessage(response.getMessage());
                        editTran(record, "-1", rrn, "-1", jdbcService);
                        return new VodacomDTO(-1, null, resultCode, !MiscUtil.isNullOrEmpty(telcoMessage) ? telcoMessage : "Failed");
                    case TIMEOUT:
                        record.setStatusCode(StatusCodes.TIMEOUT);
                        record.setStatus(TransactionStatus.TIMEOUT.name());
                        record.setStatusMessage(response.getMessage());
                        editTran(record, "-3", rrn, "-3", jdbcService);
                        return new VodacomDTO(-3, null, resultCode, !MiscUtil.isNullOrEmpty(telcoMessage) ? telcoMessage : "Timeout");
                    default:
                        editTran(record, "-1", rrn, "-1", jdbcService);
                        return new VodacomDTO(-1, null, resultCode, !MiscUtil.isNullOrEmpty(telcoMessage) ? telcoMessage : "Failed");
                }
            }

        } catch (Exception ex) {
            ex.printStackTrace(System.out);
            return new VodacomDTO(-1, null, null, "Failed");
        }
    }

    public VodacomDTO buyAirtimeSync(Map<String, String> request) {
        JDBCService jdbcService = (JDBCService) this.applicationContext.getBean(JDBCService.class);
        String rrn = request.get(TPGConstants.AIRTIME_REQUEST_RRN);
        BigDecimal amount = new BigDecimal(request.get(TPGConstants.AIRTIME_REQUEST_AMOUNT));
        StatusDetails record = jdbcService.getB2cTransactionsByRrn(rrn);

        if (record == null) {
            if (!isLocal) {
                System.out.println(rrn + "|Airtime record record Not found!!");
                return new VodacomDTO(-1, null, null, rrn + "|B2C record Not found!!");
            }
            record = getStatusDetails(amount, rrn);
        }
        try {
            Vodacomb2cResponse response = postTransactionSync(request);

            String originatorConversationId = (String) response.getAditionalData().get(VodacomConstants.AIRTIME_RESPONSE_ORIGINATOR_CONVERSATION_ID);
            String responseDesc = (String) response.getAditionalData().get(VodacomConstants.AIRTIME_RESPONSE_DESC);
            String resultDesc = (String) response.getAditionalData().get(VodacomConstants.AIRTIME_RESPONSE_DESC);
            String resultCode = (String) response.getAditionalData().get(VodacomConstants.AIRTIME_RESPONSE_RESPONSE_CODE);
            String transactionId = (String) response.getAditionalData().get("transactionId");
            
            
            if (null == response.getStatus()) {
                return new VodacomDTO(-1, null, resultCode, !MiscUtil.isNullOrEmpty(resultDesc) ? resultDesc : "Failed");
            } else {
                switch (response.getStatus()) {
                    case SUCCESS:
                        System.out.println("in SUCCESS: ");
                        System.out.println("Success registered");
                        record.setStatusCode(StatusCodes.SUCCESS);
                        record.setStatus(TransactionStatus.OK.name());
                        record.setStatusMessage((responseDesc != null) ? responseDesc : TransactionStatus.OK.getDescription());
                        record.setTranId(transactionId);
                        editTran(record, "1", rrn, "0", jdbcService);
                        return new VodacomDTO(0, transactionId,
                                resultCode, !MiscUtil.isNullOrEmpty(resultDesc) ? resultDesc : "Successfully processed");
                    case FAILURE:
                        record.setStatusCode(StatusCodes.FAILED);
                        record.setStatus(TransactionStatus.ERROR.name());
                        record.setStatusMessage(response.getMessage());
                        editTran(record, "-1", rrn, "-1", jdbcService);
                        return new VodacomDTO(-1, null, resultCode, !MiscUtil.isNullOrEmpty(resultDesc) ? resultDesc : "Failed");
                    case TIMEOUT:
                        record.setStatusCode(StatusCodes.TIMEOUT);
                        record.setStatus(TransactionStatus.TIMEOUT.name());
                        record.setStatusMessage(response.getMessage());
                        editTran(record, "-3", rrn, "-3", jdbcService);
                        return new VodacomDTO(-3, null, resultCode, !MiscUtil.isNullOrEmpty(resultDesc) ? resultDesc : "Timeout");
                    default:
                        editTran(record, "-1", rrn, "-1", jdbcService);
                        return new VodacomDTO(-1, null, resultCode, !MiscUtil.isNullOrEmpty(resultDesc) ? resultDesc : "Failed");
                }
            }

        } catch (Exception ex) {
            ex.printStackTrace(System.out);
            return new VodacomDTO(-1, null, null, "Failed");
        }
    }

    public VodacomDTO buyAirtimeSOAP(Map<String, String> request) {
        JDBCService jdbcService = (JDBCService) this.applicationContext.getBean(JDBCService.class);
        String rrn = request.get(TPGConstants.AIRTIME_REQUEST_RRN);
        BigDecimal amount = new BigDecimal(request.get(TPGConstants.AIRTIME_REQUEST_AMOUNT));
        StatusDetails record = jdbcService.getB2cTransactionsByRrn(rrn);

        if (record == null) {
            if (!isLocal) {
                System.out.println(rrn + "|Airtime record record Not found!!");
                return new VodacomDTO(-1, null, null, rrn + "|B2C record Not found!!");
            }
            record = getStatusDetails(amount, rrn);
        }
        try {
            Vodacomb2cResponse response = postTransactionSOAP(request);
            String conversationId = (String) response.getAditionalData().get(VodacomConstants.AIRTIME_RESPONSE_CONVERSATION_ID);
            Map<String, String> map = new HashMap<>();
            map.put("statusCode", StatusCodes.INITIALIZED);
            System.out.println("conversationId: " + conversationId);
            if (MiscUtil.isNotNullAndNotEmpty(conversationId)) {
                cacheService.insretFromMainThread(conversationId, map);
            }
            //@TODO, what if insert fails?
            System.out.println("response.getStatus(): " + response.getStatus().name());
            String resultCode = (String) response.getAditionalData().get(VodacomConstants.AIRTIME_RESPONSE_RESPONSE_CODE);
            String telcoMessage = (String) response.getAditionalData().get(VodacomConstants.AIRTIME_RESPONSE_DESC);
            if (null == response.getStatus()) {
                return new VodacomDTO(-1, null, resultCode, !MiscUtil.isNullOrEmpty(telcoMessage) ? telcoMessage : "Failed");
            } else {
                switch (response.getStatus()) {
                    case SUCCESS:
                        System.out.println("in SUCCESS: ");
                        return checkStatus(rrn, record, jdbcService, conversationId);
                    case FAILURE:
                        record.setStatusCode(StatusCodes.FAILED);
                        record.setStatus(TransactionStatus.ERROR.name());
                        record.setStatusMessage(response.getMessage());
                        editTran(record, "-1", rrn, "-1", jdbcService);
                        return new VodacomDTO(-1, null, resultCode, !MiscUtil.isNullOrEmpty(telcoMessage) ? telcoMessage : "Failed");
                    case TIMEOUT:
                        record.setStatusCode(StatusCodes.TIMEOUT);
                        record.setStatus(TransactionStatus.TIMEOUT.name());
                        record.setStatusMessage(response.getMessage());
                        editTran(record, "-3", rrn, "-3", jdbcService);
                        return new VodacomDTO(-3, null, resultCode, !MiscUtil.isNullOrEmpty(telcoMessage) ? telcoMessage : "Timeout");
                    default:
                        editTran(record, "-1", rrn, "-1", jdbcService);
                        return new VodacomDTO(-1, null, resultCode, !MiscUtil.isNullOrEmpty(telcoMessage) ? telcoMessage : "Failed");
                }
            }

        } catch (Exception ex) {
            ex.printStackTrace(System.out);
            return new VodacomDTO(-1, null, null, "Failed");
        }
    }

    public VodacomDTO checkStatus(String rrn, StatusDetails record, JDBCService jdbcService, String conversationId) {
        try {

            cacheService.waitForUpdate(conversationId, Long.valueOf(callbackWaitingTime), TimeUnit.SECONDS);
            Map<String, String> map = cacheService.retrieveObject(conversationId);
            String statusCode = map.get("statusCode");
            String tranId = map.get("tranId");
            String statusDesc = map.get("statusDesc");
            log.info(rrn + "|statusCode from cache: " + statusCode);
            log.info(rrn + "|conversationId: " + conversationId);
            if (statusCode == null) {
                System.out.println(rrn + "|B2C record Not found!!");
                return new VodacomDTO(-1, null, null, "B2C record Not found!!");
            }

            if (statusCode.equalsIgnoreCase(StatusCodes.SUCCESS)) {
                System.out.println("Success registered");
                record.setStatusCode(StatusCodes.SUCCESS);
                record.setStatus(TransactionStatus.OK.name());
                record.setStatusMessage(TransactionStatus.OK.getDescription());
                record.setTranId(tranId);
                editTran(record, "1", rrn, "0", jdbcService);
                return new VodacomDTO(0, tranId,
                        statusCode, !MiscUtil.isNullOrEmpty(statusDesc) ? statusDesc : "Successfully processed");
            }

            if (statusCode.equalsIgnoreCase(StatusCodes.FAILED)) {
                System.out.println("Failure registered");
                record.setStatusCode(StatusCodes.FAILED);
                record.setStatus(TransactionStatus.ERROR.name());
                record.setStatusMessage(statusDesc);
                editTran(record, "-1", rrn, "-1", jdbcService);
                return new VodacomDTO(-1, null, statusCode, !MiscUtil.isNullOrEmpty(statusDesc) ? statusDesc : "Failed");
            }

        } catch (InterruptedException | ExecutionException ex) {
            Logger.getLogger(VodacomAirtimeService.class.getName()).log(Level.SEVERE, null, ex);
        }

        editTran(record, "-3", rrn, "-3", jdbcService);
        return new VodacomDTO(-3, null, null, "Timeout");

    }

    public void editTran(StatusDetails record, String status1, String rrn, String status2, JDBCService jdbcService) {
        try {
            if (record != null) {
                jdbcService.editB2cTransactions(record);
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.out);
        }
    }

    public Vodacomb2cResponse postTransaction(Map<String, String> requestMap) {
        Vodacomb2cResponse response = new Vodacomb2cResponse();
        Map<String, Object> aditionalData = new HashMap<>();
        String rrn = requestMap.get(TPGConstants.AIRTIME_REQUEST_RRN);
        String amount = requestMap.get(TPGConstants.AIRTIME_REQUEST_AMOUNT);
        String msisdn = requestMap.get(TPGConstants.AIRTIME_REQUEST_MSISDNA);
        String currency = requestMap.get(TPGConstants.AIRTIME_REQUEST_CURRENCY);

        String requestStr = this.getBrokerAirtimeRequest(msisdn, currency, amount, rrn);

        HttpHeaders headers = new HttpHeaders();

        headers.add("Content-Type", "text/xml");

        String responseStr = httpAdapter.httpPost(this.requestURL, headers, requestStr);

        if (MiscUtil.isNullOrEmpty(responseStr)) {
            response.setAditionalData(aditionalData);
            response.setStatus(TranStatus.TIMEOUT);
            response.setMessage("Partner returned null or empty response!!");
            return response;
        }

        Map<String, String> respMap = MiscUtil.extractAllTagValues(responseStr);

        String conversationId = respMap.get(VodacomConstants.AIRTIME_RESPONSE_CONVERSATION_ID);
        String responseDesc = respMap.get(VodacomConstants.AIRTIME_RESPONSE_DESC);
        String originatorConversationId = respMap.get(VodacomConstants.AIRTIME_RESPONSE_ORIGINATOR_CONVERSATION_ID);
        String responseCode = respMap.get(VodacomConstants.AIRTIME_RESPONSE_RESPONSE_CODE);
        String serviceStatus = respMap.get(VodacomConstants.AIRTIME_RESPONSE_SERVICE_STATUS);

        log.info(rrn + "|conversationId: " + conversationId);
        log.info(rrn + "|responseDesc: " + responseDesc);
        log.info(rrn + "|originatorConversationId: " + originatorConversationId);
        log.info(rrn + "|responseCode: " + responseCode);
        log.info(rrn + "|serviceStatus: " + serviceStatus);

        aditionalData.put(VodacomConstants.AIRTIME_RESPONSE_ORIGINATOR_CONVERSATION_ID, originatorConversationId);
        aditionalData.put(VodacomConstants.AIRTIME_RESPONSE_CONVERSATION_ID, conversationId);
        aditionalData.put(VodacomConstants.AIRTIME_RESPONSE_DESC, responseDesc);

        if (MiscUtil.isNullOrEmpty(responseCode)) {
            response.setAditionalData(aditionalData);
            response.setStatus(TranStatus.TIMEOUT);
            response.setMessage("TXN status is null or empty!!");
            return response;
        }

        if (responseCode.equalsIgnoreCase("0") && !MiscUtil.isNullOrEmpty(originatorConversationId)) {
            System.out.println("Succesfully initiated");
            response.setStatus(TranStatus.SUCCESS);
            response.setMessage("Succesfully initiated");
            response.setAditionalData(aditionalData);
            return response;
        }

        if (MiscUtil.isNullOrEmpty(responseDesc)) {
            response.setStatus(TranStatus.FAILURE);
            log.info(rrn + "|Airtime purchase failed!");
            response.setAditionalData(aditionalData);
            response.setMessage("Airtime purchase failed!");
            return response;
        }

        response.setStatus(TranStatus.FAILURE);
        log.info(rrn + "|" + responseDesc);
        response.setAditionalData(aditionalData);
        response.setMessage(responseDesc);
        return response;

    }

    public Vodacomb2cResponse postTransactionSync(Map<String, String> requestMap) {
        Vodacomb2cResponse response = new Vodacomb2cResponse();
        Map<String, Object> aditionalData = new HashMap<>();
        String rrn = requestMap.get(TPGConstants.AIRTIME_REQUEST_RRN);
        String amount = requestMap.get(TPGConstants.AIRTIME_REQUEST_AMOUNT);
        String msisdn = requestMap.get(TPGConstants.AIRTIME_REQUEST_MSISDNA);
        String currency = requestMap.get(TPGConstants.AIRTIME_REQUEST_CURRENCY);

        String requestStr = this.getAirtimeRequestSync(msisdn, currency, amount, rrn);

        HttpHeaders headers = new HttpHeaders();

        headers.add("Content-Type", "text/xml");

        String responseStr = httpAdapter.httpPost(this.requestURL, headers, requestStr);

        if (MiscUtil.isNullOrEmpty(responseStr)) {
            response.setAditionalData(aditionalData);
            response.setStatus(TranStatus.TIMEOUT);
            response.setMessage("Partner returned null or empty response!!");
            return response;
        }

        Map<String, String> values = MiscUtil.extractAllTagValues(responseStr);
        String resultCode = values.get(VodacomConstants.AIRTIME_CALLBACK_RESULT_CODE);
        String resultDesc = values.get(VodacomConstants.AIRTIME_CALLBACK_RESULT_DESC);
        String transactionId = values.get(VodacomConstants.AIRTIME_CALLBACK_TRANSACTION_ID);
        String conversationId = values.get(VodacomConstants.AIRTIME_CALLBACK_CONVERSATION_ID);
        String originatorConversationId = values.get(VodacomConstants.AIRTIME_CALLBACK_ORIGINATOR_CONVERSATION_ID);

        log.info(transactionId + "|On update after response, resultCode: " + resultCode);
        log.info(transactionId + "|On update after response, resultDesc: " + resultDesc);
        log.info(transactionId + "|On update after response, transactionId: " + transactionId);
        log.info(transactionId + "|On update after response, conversationId: " + conversationId);
        log.info(transactionId + "|On update after response, originatorConversationId: " + originatorConversationId);

        aditionalData.put(VodacomConstants.AIRTIME_RESPONSE_ORIGINATOR_CONVERSATION_ID, originatorConversationId);
        aditionalData.put(VodacomConstants.AIRTIME_RESPONSE_CONVERSATION_ID, conversationId);
        aditionalData.put(VodacomConstants.AIRTIME_RESPONSE_DESC, resultDesc);
        aditionalData.put(VodacomConstants.AIRTIME_RESPONSE_RESPONSE_CODE, resultCode);
        aditionalData.put("transactionId", transactionId);

        if (MiscUtil.isNullOrEmpty(resultCode)) {
            response.setAditionalData(aditionalData);
            response.setStatus(TranStatus.TIMEOUT);
            response.setMessage("TXN status is null or empty!!");
            return response;
        }

        if (resultCode.equalsIgnoreCase("0") && !MiscUtil.isNullOrEmpty(conversationId)) {
            System.out.println("Succesfully initiated");
            response.setStatus(TranStatus.SUCCESS);
            response.setMessage("Succesfully initiated");
            response.setAditionalData(aditionalData);
            return response;
        }

        if (MiscUtil.isNullOrEmpty(resultDesc)) {
            response.setStatus(TranStatus.FAILURE);
            log.info(rrn + "|Airtime purchase failed!");
            response.setAditionalData(aditionalData);
            response.setMessage("Airtime purchase failed!");
            return response;
        }

        response.setStatus(TranStatus.FAILURE);
        log.info(rrn + "|" + resultDesc);
        response.setAditionalData(aditionalData);
        response.setMessage(resultDesc);
        return response;

    }

    private String getAirtimeRequest(String msisdn, String currency, String amount, String rrn) {

        String loginRequest = "<soapenv:Envelope\n"
                + "xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/'\n"
                + "xmlns:api='http://cps.huawei.com/cpsinterface/api_requestmgr'\n"
                + "xmlns:req='http://cps.huawei.com/cpsinterface/request'\n"
                + "xmlns:com='http://cps.huawei.com/cpsinterface/common'>\n"
                + "    <soapenv:Header/>\n"
                + "    <soapenv:Body>\n"
                + "        <api:Request>\n"
                + "            <req:Header>\n"
                + "                <req:Version>1.0</req:Version>\n"
                + "                <req:CommandID>InitTrans_2108</req:CommandID>\n"
                + "                <req:Caller>\n"
                + "                    <req:CallerType>2</req:CallerType>\n"
                + "                    <req:ThirdPartyID>" + this.thirdPartId + "</req:ThirdPartyID>\n"
                + "                    <req:Password>" + this.password + "</req:Password>\n"
                + "                    <req:ResultURL>" + this.resultURL + "</req:ResultURL>\n"
                + "                </req:Caller>\n"
                + "                <req:KeyOwner>1</req:KeyOwner>\n"
                + "                <req:Timestamp>" + MiscUtil.getCurrentTimestamp("yyyyMMddHHmmss") + "</req:Timestamp>\n"
                + "            </req:Header>\n"
                + "            <req:Body>\n"
                + "                <req:Identity>\n"
                + "                    <req:Initiator>\n"
                + "                        <req:IdentifierType>11</req:IdentifierType>\n"
                + "                        <req:Identifier>" + this.identifier + "</req:Identifier>\n"
                + "                        <req:SecurityCredential>" + this.securityCredential + "</req:SecurityCredential>\n"
                + "                        <req:ShortCode>" + this.shortCode + "</req:ShortCode>\n"
                + "                    </req:Initiator>\n"
                + "                    <req:ReceiverParty>\n"
                + "                        <req:IdentifierType>4</req:IdentifierType>\n"
                + "                        <req:Identifier>" + this.receiverPartyIdentifier + "</req:Identifier>\n"
                + "                    </req:ReceiverParty>\n"
                + "                </req:Identity>\n"
                + "                <req:TransactionRequest>\n"
                + "                    <req:Parameters>\n"
                + "                        <req:Parameter>\n"
                + "                            <com:Key>RechargedMSISDN</com:Key>\n"
                + "                            <com:Value>" + msisdn + "</com:Value>\n"
                + "                        </req:Parameter>\n"
                + "                        <req:Amount>" + amount + "</req:Amount>\n"
                + "                        <req:Currency>" + currency + "</req:Currency>\n"
                + "                    </req:Parameters>\n"
                + "                </req:TransactionRequest>\n"
                + "                <req:Remark>" + rrn + "</req:Remark>\n"
                + "            </req:Body>\n"
                + "        </api:Request>\n"
                + "    </soapenv:Body>\n"
                + "</soapenv:Envelope>";
        return loginRequest;
    }

    private String getBrokerAirtimeRequest(String msisdn, String currency, String amount, String rrn) {
        String loginRequest = "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/'\n"
                + " xmlns:api='http://cps.huawei.com/cpsinterface/api_requestmgr'\n"
                + " xmlns:req='http://cps.huawei.com/cpsinterface/request'\n"
                + " xmlns:com='http://cps.huawei.com/cpsinterface/common'>\n"
                + "    <soapenv:Header/>\n"
                + "    <soapenv:Body>\n"
                + "        <api:Request>\n"
                + "            <req:Header>\n"
                + "                <req:Version>1.0</req:Version>\n"
                + "                <req:CommandID>InitTrans_2108</req:CommandID>\n"
                + "                <req:OriginatorConversationID>" + MiscUtil.generateRandomRRN(7) + "</req:OriginatorConversationID>\n"
                + "                <req:Caller>\n"
                + "                    <req:CallerType>2</req:CallerType>\n"
                + "                    <req:ThirdPartyID>" + this.thirdPartId + "</req:ThirdPartyID>\n"
                + "                    <req:Password>" + this.password + "</req:Password>\n"
                + "                    <req:ResultURL>" + this.resultURL + "</req:ResultURL>\n"
                + "                </req:Caller>\n"
                + "                <req:KeyOwner>1</req:KeyOwner>\n"
                + "                <req:Timestamp>" + MiscUtil.getCurrentTimestamp("yyyyMMddHHmmss") + "</req:Timestamp>\n"
                + "            </req:Header>\n"
                + "            <req:Body>\n"
                + "                <req:Identity>\n"
                + "                    <req:Initiator>\n"
                + "                        <req:IdentifierType>11</req:IdentifierType>\n"
                + "                        <req:Identifier>" + this.identifier + "</req:Identifier>\n"
                + "                        <req:SecurityCredential>" + this.securityCredential + "</req:SecurityCredential>\n"
                + "                        <req:ShortCode>" + this.shortCode + "</req:ShortCode>\n"
                + "                    </req:Initiator>\n"
                + "                </req:Identity>\n"
                + "                <req:TransactionRequest>\n"
                + "                    <req:Parameters>\n"
                + "                        <req:Parameter>\n"
                + "                            <com:Key>RechargedMSISDN</com:Key>\n"
                + "                            <com:Value>" + msisdn + "</com:Value>\n"
                + "                        </req:Parameter>\n"
                + "                        <req:Amount>" + amount + "</req:Amount>\n"
                + "                        <req:Currency>" + currency + "</req:Currency>\n"
                + "                    </req:Parameters>\n"
                + "                </req:TransactionRequest>\n"
                + "                <req:ReferenceData>\n"
                + "                    <req:ReferenceItem>\n"
                + "                        <com:Key>" + this.pOSDeviceIDKey + "</com:Key>\n"
                + "                        <com:Value>" + this.pOSDeviceIDValue + "</com:Value>\n"
                + "                    </req:ReferenceItem>\n"
                + "                </req:ReferenceData>\n"
                + "            </req:Body>\n"
                + "        </api:Request>\n"
                + "    </soapenv:Body>\n"
                + "</soapenv:Envelope>";
        return loginRequest;
    }

    public static Request getAirtimeSOAPRequest(String msisdn, String currency, String amount, String rrn,
            String thirdPartId,
            String password, String resultURL,
            String pOSDeviceIDKey, String pOSDeviceIDValue,
            String identifier, String securityCredential, String shortCode) {
        Request request = new Request();
        Request.Body body = new Request.Body();
        Request.Header header = new Request.Header();
        Request.Header.Caller caller = new Request.Header.Caller();
        Request.Body.Identity identity = new Request.Body.Identity();
        Request.Body.Identity.Initiator initiator = new Request.Body.Identity.Initiator();
        Request.Body.TransactionRequest transactionRequest = new Request.Body.TransactionRequest();
        Request.Body.TransactionRequest.Parameters parameters = new Request.Body.TransactionRequest.Parameters();
        ParameterType parameter = new ParameterType();
        ReferenceData peferenceData = new ReferenceData();
        ParameterType referenceItem = new ParameterType();

        caller.setCallerType(BigInteger.TWO);
        caller.setThirdPartyID(thirdPartId);
        caller.setPassword(password);
        caller.setResultURL(resultURL);
        header.setCaller(caller);
        header.setVersion("1.0");
        header.setCommandID("InitTrans_2108");
        header.setOriginatorConversationID(MiscUtil.generateRandomRRN(7));
        header.setKeyOwner(BigInteger.ONE);
        header.setTimestamp(MiscUtil.getCurrentTimestamp("yyyyMMddHHmmss"));

        referenceItem.setKey(pOSDeviceIDKey);
        referenceItem.setValue(pOSDeviceIDValue);
        peferenceData.getReferenceItem().add(referenceItem);
        body.setReferenceData(peferenceData);

        parameter.setKey("RechargedMSISDN");
        parameter.setValue(msisdn);
        parameters.getParameter().add(parameter);
        parameters.setAmount(amount);
        parameters.setCurrency(currency);
        transactionRequest.setParameters(parameters);
        body.setTransactionRequest(transactionRequest);

        initiator.setIdentifierType("11");
        initiator.setIdentifier(identifier);
        initiator.setSecurityCredential(securityCredential);
        initiator.setShortCode(shortCode);
        identity.setInitiator(initiator);
        body.setIdentity(identity);

        request.setHeader(header);
        request.setBody(body);

        return request;

    }

    public String getAirtimeRequestSync(String msisdn, String currency, String amount, String rrn) {
        String request = "<soapenv:Envelope \n"
                + "xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" \n"
                + "xmlns:api=\"http://cps.huawei.com/synccpsinterface/api_requestmgr\"\n"
                + "xmlns:req=\"http://cps.huawei.com/synccpsinterface/request\" \n"
                + "xmlns:com=\"http://cps.huawei.com/synccpsinterface/common\">   \n"
                + "<soapenv:Header/>\n"
                + "<soapenv:Body>\n"
                + "<api:Request>\n"
                + "<req:Header>\n"
                + "<req:Version>1.0</req:Version>\n"
                + "<req:CommandID>InitTrans_2108</req:CommandID>\n"
                + "<req:OriginatorConversationID>" + MiscUtil.generateRandomRRN(7) + "</req:OriginatorConversationID>\n"
                + "<req:Caller>\n"
                + "<req:CallerType>2</req:CallerType>\n"
                + "<req:ThirdPartyID>" + this.thirdPartId + "</req:ThirdPartyID>\n"
                + "<req:Password>" + this.password + "</req:Password> \n"
                + "</req:Caller>\n"
                + "<req:KeyOwner>1</req:KeyOwner>\n"
                + "<req:Timestamp>" + MiscUtil.getCurrentTimestamp("yyyyMMddHHmmss") + "</req:Timestamp>\n"
                + "</req:Header>\n"
                + "<req:Body>\n"
                + "<req:Identity>\n"
                + "<req:Initiator>\n"
                + "<req:IdentifierType>11</req:IdentifierType>\n"
                + "<req:Identifier>" + this.identifier + "</req:Identifier>\n"
                + "<req:SecurityCredential>" + this.securityCredential + "</req:SecurityCredential>\n"
                + "<req:ShortCode>" + this.shortCode + "</req:ShortCode>\n"
                + "</req:Initiator>\n"
                + "</req:Identity>\n"
                + "<req:TransactionRequest>\n"
                + "<req:Parameters>\n"
                + "<req:Parameter>\n"
                + "<com:Key>RechargedMSISDN</com:Key>\n"
                + "<com:Value>" + msisdn + "</com:Value>\n"
                + "</req:Parameter>\n"
                + "<req:Amount>" + amount + "</req:Amount>\n"
                + "<req:Currency>" + currency + "</req:Currency>\n"
                + "</req:Parameters>\n"
                + "</req:TransactionRequest>\n"
                + "<req:ReferenceData>\n"
                + "<req:ReferenceItem>\n"
                + "<com:Key>" + this.pOSDeviceIDKey + "</com:Key>\n"
                + "<com:Value>" + this.pOSDeviceIDValue + "</com:Value>\n"
                + "</req:ReferenceItem>\n"
                + "</req:ReferenceData>\n"
                + "</req:Body>\n"
                + "</api:Request>\n"
                + "</soapenv:Body>\n"
                + "</soapenv:Envelope>";
        return request;
    }

    private StatusDetails getStatusDetails(BigDecimal amount, String rrn) {
        TransactionDetails details = new TransactionDetails();
        details.setAmount(amount);
        details.setBankId("43");
        details.setChannel("OMNI");
        details.setClientType("Customer");
        details.setRrn(rrn);
        details.setOperationType(RequestTypes.AIRTIME);
        details.setTelcoName("AIRTELMONEY-CD");

        StatusDetails record = new StatusDetails();
        record.setRrn(rrn);
        record.setStatus(TransactionStatus.INITIALIZED.name());
        record.setStatusCode(StatusCodes.INITIALIZED);
        record.setStatusMessage(TransactionStatus.INITIALIZED.getDescription());
        details.setStatusDetails(record);
        tranRepository.save(details);
        return record;
    }

    public static void main(String[] args) throws NoSuchAlgorithmException, InvalidKeySpecException, InvalidKeyException, NoSuchPaddingException, IllegalBlockSizeException, BadPaddingException {
        Request request = getAirtimeSOAPRequest("243798567483", "USD", "10.00",
                "12345678906", "7776", "rryytttu", "https://localhost:8080/result", "POSDeviceID",
                "POS234789", "10086", "5768877", "66678");

        System.out.println(MiscUtil.objToStr(request, Request.class));
        /*
        public static Request getAirtimeSOAPRequest(String msisdn, String currency, String amount, String rrn,
            String thirdPartId, 
            String password, String resultURL, 
            String pOSDeviceIDKey, String pOSDeviceIDValue,
            String identifier, String securityCredential, String shortCode) 
         */
    }

}
