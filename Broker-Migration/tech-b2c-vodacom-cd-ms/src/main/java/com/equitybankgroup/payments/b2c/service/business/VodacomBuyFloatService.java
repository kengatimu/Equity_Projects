/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.service.business;

/**
 *
 * @author ronaldcheruiyot  
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
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
import com.equitybankgroup.payments.b2c.dto.vodacom.constants.VodacomConstants;
import com.equitybankgroup.payments.b2c.model.StatusDetails;
import com.equitybankgroup.payments.b2c.model.TransactionDetails;
import com.equitybankgroup.payments.b2c.repository.TransactionDetailsRepository;
import com.equitybankgroup.payments.b2c.service.business.http.OutboundHttpAdapter;
import com.equitybankgroup.payments.b2c.service.cache.CacheService;
import com.equitybankgroup.payments.b2c.service.util.MiscUtil;
import static com.equitybankgroup.payments.b2c.service.util.MiscUtil.getCurrentTimestamp;
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
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.env.Environment;

/**
 *
 * @author ronaldcheruiyot
 */
@Service
@Slf4j
public class VodacomBuyFloatService {

   
    @Value("${vodacom.cd.b2b.loginUsername}")
    String b2bLoginUsername;
    
    @Value("${vodacom.cd.b2b.loginPassword}")
    String b2bLoginPassword;
    
    @Value("${vodacom.cd.b2b.loginURL}")
    String b2bLoginURL;
    
    @Value("${vodacom.cd.b2b.disbursementURL}")
    String b2bDisbursementURL;
    
    @Value("${vodacom.cd.b2b.shortCode}")
    String b2bShortCode;
    
    @Value("${vodacom.cd.b2b.bankShortcode}")
    String b2bBankShortcode;
    
    @Value("${vodacom.cd.b2b.callBackDestination}")
    String b2bCallBackDestination;
    
    @Value("${vodacom.cd.b2b.callbackWaitingTime}")
    String b2bCallbackWaitingTime;
    
    
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
    public void init()
    {
        Environment env = this.applicationContext.getEnvironment();
        String[] activeProfiles = env.getActiveProfiles();
        for(String profile : activeProfiles)
        {
            if(profile.equalsIgnoreCase("local"))
            {
                isLocal = true;
            }
        }
        
    }

    public String getDisbursementURL(String countryCode) {
        Map<String, String> countryProps = props.get(countryCode);
        if(countryProps != null)
        {
            return countryProps.get("disbursementURL");
        }
        System.out.println("Props for country: " + countryCode + " not found!!");
        return null;
    }
    
    public String getPropertyValue(String countryCode, String propName) throws Exception
    {
        Map<String, String> countryProps = props.get(countryCode);
        if(countryProps != null)
        {
            String value = countryProps.get(propName);
            if(value != null && !value.isEmpty())
            {
                return value;
            }
            
            String message = "Value for prop: " + propName + " for country: " + countryCode + " not cannot be null or empty!!";
            System.out.println(message);
        }
        String message = "Props for country: " + countryCode + " not found!!";
        System.out.println(message);
        throw new Exception(message);
    }
    
    
    
    public VodacomDTO sendTransaction(EazInqRequest inqRequest, String countryCode, InqResponse rs)
    {   
        JDBCService jdbcService = (JDBCService) this.applicationContext.getBean(JDBCService.class);
        StatusDetails record = jdbcService.getB2cTransactionsByRrn(inqRequest.getEazzycash().getRrn());
        String rrn = inqRequest.getEazzycash().getRrn();
        Long amount = inqRequest.getEazzycash().getAmount();
        if (record == null) {
            if(!isLocal)
            {
                System.out.println("B2C record Not found!!");
                return new VodacomDTO(-1, null, null, "B2C record Not found!!");
            }
            record = getStatusDetails(amount, rrn);
        }
        Map<String, String> map = new HashMap<>();
        map.put("statusCode", StatusCodes.INITIALIZED);
        cacheService.insretFromMainThread(inqRequest.getEazzycash().getRrn(), map);
        //@TODO, what if insert fails?
        
        
        try {
            Vodacomb2cResponse response = postTransaction(inqRequest, countryCode, rs);
            System.out.println("response.getStatus(): " + response.getStatus().name());
            String resultCode = (String) response.getAditionalData().get(VodacomConstants.B2B_DISBURSEMENT_RESPONSE_CODE);
            String telcoMessage = (String) response.getAditionalData().get(VodacomConstants.B2B_DISBURSEMENT_RESPONSE_DESC);
            if(MiscUtil.isNullOrEmpty(telcoMessage))
            {
                telcoMessage = response.getMessage();
            }
            if(null == response.getStatus()) {
                return new VodacomDTO(-1, null, resultCode, !MiscUtil.isNullOrEmpty(telcoMessage) ? telcoMessage : "Failed"); 
            } else {
                switch (response.getStatus()) {
                    case SUCCESS : {
                        System.out.println("in SUCCESS: ");
                        return checkStatus(rrn, record, jdbcService, response);
                    }
                    case FAILURE : {
                        record.setStatusCode(StatusCodes.FAILED);
                        record.setStatus(TransactionStatus.ERROR.name());
                        record.setStatusMessage(response.getMessage());
                        editTran(record, "-1", rrn, "-1", jdbcService);
                        return new VodacomDTO(-1, null, resultCode, !MiscUtil.isNullOrEmpty(telcoMessage) ? telcoMessage : "Failed");
                    }
                    case TIMEOUT : {
                        record.setStatusCode(StatusCodes.TIMEOUT);
                        record.setStatus(TransactionStatus.TIMEOUT.name());
                        record.setStatusMessage(response.getMessage());
                        editTran(record, "-3", rrn, "-3", jdbcService);
                        return new VodacomDTO(-3, null, resultCode, !MiscUtil.isNullOrEmpty(telcoMessage) ? telcoMessage : "Timeout");
                    }
                    default : {
                        editTran(record, "-1", rrn, "-1", jdbcService);
                        return new VodacomDTO(-1, null, resultCode, !MiscUtil.isNullOrEmpty(telcoMessage) ? telcoMessage : "Failed");
                    }
                }
            }

        } catch (Exception ex) {
            ex.printStackTrace(System.out);
            return new VodacomDTO(-1, "", "", "Failed");
        }
    }
    
    
    public VodacomDTO checkStatus(String rrn, StatusDetails record, JDBCService jdbcService, Vodacomb2cResponse response) {
        try {
//            String tranId = (String) response.getAdditionalData().get(VodacomConstants.B2B_DISBURSEMENT_RESPONSE_INSIGHT_TXN_ID);
            String tranId = response.getTranId();
            cacheService.waitForUpdate(rrn, Long.parseLong(b2bCallbackWaitingTime), TimeUnit.SECONDS);

            // Updated this part
            Map<String, String> map = new HashMap<>();
            map.put("statusCode", StatusCodes.SUCCESS);
            cacheService.update(rrn, map);
            // Upto here

//            Map<String, String> map = cacheService.retrieveObject(rrn);
            String statusCode = map.get("statusCode");
            String statusDesc = (String) response.getAditionalData().get(VodacomConstants.B2B_DISBURSEMENT_RESPONSE_DESC);
            log.info(rrn +"|statusCode from cache: " + statusCode);
            log.info(rrn +"|tranId: " + tranId);
            if(statusCode == null)
            {
                System.out.println(rrn +"|B2C record Not found!!");
                return new VodacomDTO(-1, null, null,"B2C record Not found!!");
            }
            
            if(statusCode.equalsIgnoreCase(StatusCodes.SUCCESS))
            {
                System.out.println("Success registered");
                record.setStatusCode(StatusCodes.SUCCESS);
                record.setStatus(TransactionStatus.OK.name());
                record.setStatusMessage(TransactionStatus.OK.getDescription());
                record.setTranId(tranId);
                editTran(record, "1", rrn, "0", jdbcService); 
                return new VodacomDTO(0, tranId,
                        statusCode, !MiscUtil.isNullOrEmpty(statusDesc) ? statusDesc : "Successfully processed");
            }
            
            if(statusCode.equalsIgnoreCase(StatusCodes.FAILED))
            {
                System.out.println("Failure registered");
                record.setStatusCode(StatusCodes.FAILED);
                record.setStatus(TransactionStatus.ERROR.name());
                record.setStatusMessage(response.getMessage());
                editTran(record, "-1", rrn, "-1", jdbcService);
                return new VodacomDTO(-1, null, statusCode, !MiscUtil.isNullOrEmpty(statusDesc) ? statusDesc : "Failed");
            }
            
            
        } catch (InterruptedException ex) {
            Logger.getLogger(VodacomBuyFloatService.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        editTran(record, "-3", rrn, "-3", jdbcService);
        return new VodacomDTO(-3, null, null, "Timeout");
        
    }
    
    public void editTran(StatusDetails record, String status1, String rrn, String status2, JDBCService jdbcService)
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

    
    public Vodacomb2cResponse postTransaction(EazInqRequest inqRequest, String countryCode, InqResponse rs) throws Exception{
        
        Vodacomb2cResponse response = new Vodacomb2cResponse();
        
        final String rrn = inqRequest.getEazzycash().getRrn();
        
        String msisdn = inqRequest.getEazzycash().getNumber();
        
        String amount = String.valueOf(inqRequest.getEazzycash().getAmount());
        
        if(MiscUtil.isNullOrEmpty(msisdn)) {
            response.setStatus(TranStatus.TIMEOUT);
            response.setMessage("INVALID MSISDN!!");
            return response;
        }
                
        msisdn = msisdn.substring(Math.max(0, msisdn.length() - 9));
        
        String loginRequest = getB2BLoginRequest();
        
        log.info("SENDING LOGIN REQUEST...");
        
        String loginResponse = httpAdapter.httpPost(this.b2bLoginURL, new HttpHeaders(), loginRequest);
        
        if(MiscUtil.isNullOrEmpty(loginResponse)) {
            response.setAditionalData(new HashMap<>());
            response.setStatus(TranStatus.FAILURE);
            response.setMessage("Login failed!!");
            return response;
        }
        
        Map<String, String> values = MiscUtil.extractAllTagValues(loginResponse);
        
        String resultCode = values.get(VodacomConstants.B2B_LOGIN_RESPONSE_RESULT_CODE);
        String resultDesc = values.get(VodacomConstants.B2B_LOGIN_RESPONSE_RESULT_DESC);
        String sessionId = values.get(VodacomConstants.B2B_LOGIN_RESPONSE_SESSION_ID);
            
        log.info("resultCode: " + resultCode);
        log.info("resultDesc: " + resultDesc);
        log.info("sessionId: " + sessionId);
        
        if(MiscUtil.isNullOrEmpty(sessionId) || MiscUtil.isNullOrEmpty(resultCode))
        {   
            response.setAditionalData(new HashMap<>());
            response.setStatus(TranStatus.FAILURE);
            response.setMessage("Login failed!!");
            return response;
        }
        
        if(!resultCode.equalsIgnoreCase("0"))
        {   
            response.setAditionalData(new HashMap<>());
            response.setStatus(TranStatus.FAILURE);
            response.setMessage("Login failed!!");
            return response;
        }
        
        String requestStr = getB2BDisbursementRequest(sessionId, msisdn, inqRequest.getEazzycash().getCurrency(), amount, rrn);
        
        HttpHeaders headers = new HttpHeaders();
        
        headers.add("Content-Type", "text/xml");
        
        String responseStr = httpAdapter.httpPost(this.b2bDisbursementURL, headers, requestStr);
 
        
        if(MiscUtil.isNullOrEmpty(responseStr)) {
            response.setAditionalData(new HashMap<>());
            response.setStatus(TranStatus.TIMEOUT);
            response.setMessage("Partner returned null or empty response!!");
            return response;
        }
        
        Map<String, String> disbValues = MiscUtil.extractAllTagValues(responseStr);
        
        String thirdPartyReference = disbValues.get(VodacomConstants.B2B_DISBURSEMENT_THIRD_PARTY_REFERENCE);
        String insightTxID = disbValues.get(VodacomConstants.B2B_DISBURSEMENT_RESPONSE_INSIGHT_TXN_ID);
        String transactionDateTime = disbValues.get(VodacomConstants.B2B_DISBURSEMENT_RESPONSE_TRANSACTION_DATETIME);
        String ResponseCode = disbValues.get(VodacomConstants.B2B_DISBURSEMENT_RESPONSE_CODE);
        String ResponseDesc = disbValues.get(VodacomConstants.B2B_DISBURSEMENT_RESPONSE_DESC);

        System.out.println(rrn + "|thirdPartyReference: " + thirdPartyReference);
        System.out.println(rrn + "|insightTxID: " + insightTxID);
        System.out.println(rrn + "|transactionDateTime: " + transactionDateTime);
        System.out.println(rrn + "|ResponseCode: " + ResponseCode);
        System.out.println(rrn + "|ResponseDesc: " + ResponseDesc);
        
        Map<String, Object> aditionalData = new HashMap<>();
        
        if(MiscUtil.isNotNullAndNotEmpty(ResponseCode))
        {
            aditionalData.put(VodacomConstants.B2B_DISBURSEMENT_RESPONSE_CODE, ResponseCode);
        }
        
        if(MiscUtil.isNotNullAndNotEmpty(ResponseDesc))
        {
            aditionalData.put(VodacomConstants.B2B_DISBURSEMENT_RESPONSE_DESC, ResponseDesc);
        }
        
        if(ResponseCode.equalsIgnoreCase("0") && !MiscUtil.isNullOrEmpty(insightTxID) && ResponseDesc.equalsIgnoreCase("sUCCESS")) {
            System.out.println("Succesfully initiated");
            response.setTranId(insightTxID);
            response.setStatus(TranStatus.SUCCESS);
            response.setMessage("Succesfully initiated");
            response.setAditionalData(aditionalData);
            return response;
        }
        response.setAditionalData(aditionalData);
        response.setStatus(TranStatus.FAILURE);
        System.out.println("disbursement failed!");
        response.setMessage("disbursement failed!");
        return response;
        
    }
    
    private String getB2BLoginRequest() 
    {   
        
        String loginRequest = "<Request>\n" +
"    <Username>" + this.b2bLoginUsername +"</Username>\n" +
"    <Password>" + this.b2bLoginPassword + "</Password>\n" +
"</Request>";
        return loginRequest;
    }
    
    private String getFromatedDate()
    {
        LocalDateTime now = LocalDateTime.now();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");

        String formattedDate = now.format(formatter);
        
        return formattedDate;
    }
    
    private String getB2BDisbursementRequest(String sessionId, String msisdn, String currency, String amount, String rrn) 
    {   
        
        String loginRequest = "<Request>\n" +
"    <Command>BankB2W</Command>\n" +
"    <SessionID>" + sessionId + "</SessionID>\n" +
"    <Shortcode>" + this.b2bShortCode + "</Shortcode>\n" +
"    <BankShortcode>" + this.b2bBankShortcode + "</BankShortcode>\n" +
"    <Currency>" + currency + "</Currency>\n" +
"    <Amount>" + amount + "</Amount>\n" +
"    <DateTime>" + MiscUtil.getCurrentTimestamp("yyyyMMdd HHmmss") + "</DateTime>\n" +
"    <ThirdPartyReference>" + rrn + "</ThirdPartyReference>\n" +
"    <TransactionID>" + rrn + "</TransactionID>\n" +
"    <CommandID>InitTrans_EmoneyCB2B</CommandID>\n" +
"    <TransactionType>VA</TransactionType>\n" +
"    <CallBackChannel>2</CallBackChannel>\n" +
"    <CallBackDestination>" + this.b2bCallBackDestination + "</CallBackDestination>\n" +
"</Request>";
        return loginRequest;
    }
    
    private StatusDetails getStatusDetails(Long amount, String rrn)
    {
        TransactionDetails details = new TransactionDetails();
        details.setAmount(BigDecimal.valueOf(amount));
        details.setBankId("43");
        details.setChannel("OMNI");
        details.setClientType("Customer");
        details.setRrn(rrn);
        details.setTelcoName("VODACOM-CD");
        details.setOperationType(RequestTypes.BUY_FLOAT);

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
        String response = 
"<?xml version='1.0' encoding='UTF-8'?>\n" +
"<S:Envelope xmlns:S=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" +
"    <S:Header>\n" +
"        <ns3:eventid xmlns:ns2=\"http://www.4cgroup.co.za/genericsoap\" xmlns:ns3=\"http://www.4cgroup.co.za/soapauth\">2500\n" +
"</ns3:eventid>\n" +
"    </S:Header>\n" +
"    <S:Body>\n" +
"        <ns2:getGenericResultResponse xmlns:ns2=\"http://www.4cgroup.co.za/genericsoap\" xmlns:ns3=\"http://www.4cgroup.co.za/soapauth\">\n" +
"            <SOAPAPIResult>\n" +
"                <eventInfo>\n" +
"                    <code>3</code>\n" +
"                    <description>Processed</description>\n" +
"                    <detail>Processed</detail>\n" +
"                    <transactionID>0c49ec4bbebe44b082aa24e5f548b514</transactionID>\n" +
"                </eventInfo>\n" +
"                <request>\n" +
"                    <dataItem>\n" +
"                        <name>Username</name>\n" +
"                        <type>String</type>\n" +
"                        <value>thirdpartyc2bw</value>\n" +
"                    </dataItem>\n" +
"                    <dataItem>\n" +
"                        <name>Password</name>\n" +
"                        <type>String</type>\n" +
"                        <value>thirdpartyc2bw</value>\n" +
"                    </dataItem>\n" +
"                </request>\n" +
"                <response>\n" +
"                    <dataItem>\n" +
"                        <name>SessionID</name>\n" +
"                        <type>String</type>\n" +
"                        <value>dbcb63a40afd4191a990d66ed9cb62f7</value>\n" +
"                    </dataItem>\n" +
"                </response>\n" +
"            </SOAPAPIResult>\n" +
"        </ns2:getGenericResultResponse>\n" +
"    </S:Body>\n" +
"</S:Envelope>";
            System.out.println(response);
            Map<String, String> values = MiscUtil.extractAllTagValues(response);
            System.out.println("event code: " + values.get(VodacomConstants.LOGIN_RESPONSE_EVENTCODE));
            System.out.println("transaction id: " + values.get(VodacomConstants.LOGIN_RESPONSE_TRANSACTIONID));
            System.out.println("sesion id: " + values.get(VodacomConstants.LOGIN_RESPONSE_SESSIONID));
    }
    
    
}

