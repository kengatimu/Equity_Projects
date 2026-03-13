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
public class VodacomBankToWalletService {

   //MOCK
    @Value("${vodacom.cd.b2b.mock.loginURL}")
    String mockLoginURL;
    
    @Value("${vodacom.cd.b2b.mock.disbursementURL}")
    String mockDisbursementURL;
    
    @Value("${vodacom.cd.b2b.mock.callBackDestination}")
    String mockCallBackDestination;
    
    @Value("${vodacom.cd.b2b.mock.testNumber}")
    String mockTestNumber;
        
    @Value("${vodacom.cd.b2c.loginUsername}")
    String loginUserName;
    
    @Value("${vodacom.cd.b2c.loginPassword}")
    String loginPassword;
    
    @Value("${vodacom.cd.b2c.loginURL}")
    String loginURL;
    
    @Value("${vodacom.cd.b2c.disbursementURL}")
    String disbursementURL;
    
    @Value("${vodacom.cd.b2c.serviceProviderName}")
    String serviceProviderName;
    
    @Value("${vodacom.cd.b2c.shortCode}")
    String shortCode;
    
    @Value("${vodacom.cd.b2c.callBackDestination}")
    String callBackDestination;
    
    @Value("${vodacom.cd.b2c.callbackWaitingTime}")
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
        map.put("statusCode", StatusCodes.PENDING);
        record.setStatusCode(StatusCodes.PENDING);
        record.setStatus(TransactionStatus.PENDING.name());
        record.setStatusMessage("Transaction sent to telco, waiting for result.");
        editTran(record, jdbcService);
        cacheService.insretFromMainThread(inqRequest.getEazzycash().getRrn(), map);
        //@TODO, what if insert fails?

        try {
            Vodacomb2cResponse response = postTransaction(inqRequest, countryCode, rs);
            System.out.println("response.getStatus(): " + response.getStatus().name());
            String resultCode = (String) response.getAditionalData().get(VodacomConstants.DISBURSEMENT_RESPONSE_EVENTCODE);
            String telcoMessage = (String) response.getAditionalData().get(VodacomConstants.DISBURSEMENT_RESPONSE_DESCRIPTION);
            if(MiscUtil.isNullOrEmpty(telcoMessage))
            {
                telcoMessage = response.getMessage();
            }
            if(null == response.getStatus()) {
                return new VodacomDTO(-1, null, resultCode, !MiscUtil.isNullOrEmpty(telcoMessage) ? telcoMessage : "Failed"); 
            } else {
                switch (response.getStatus()) {
                    case SUCCESS:
                        System.out.println("in SYNC SUCCESS: ");
                        return checkStatus(rrn, record, jdbcService, response);
                    case FAILURE:
                        record.setStatusCode(StatusCodes.FAILED);
                        record.setStatus(TransactionStatus.ERROR.name());
                        record.setStatusMessage(response.getMessage());
                        editTran(record, jdbcService);
                        return new VodacomDTO(-1, null, resultCode, !MiscUtil.isNullOrEmpty(telcoMessage) ? telcoMessage : "Failed"); 
                    case TIMEOUT:
                        record.setStatusCode(StatusCodes.TIMEOUT);
                        record.setStatus(TransactionStatus.TIMEOUT.name());
                        record.setStatusMessage(response.getMessage());
                        editTran(record, jdbcService);
                        return new VodacomDTO(-3, null, resultCode, !MiscUtil.isNullOrEmpty(telcoMessage) ? telcoMessage : "Timeout");  
                    default:
                        editTran(record, jdbcService);
                        return new VodacomDTO(-1, null, resultCode, !MiscUtil.isNullOrEmpty(telcoMessage) ? telcoMessage : "Failed");
                }
            }

        } catch (Exception ex) {
            ex.printStackTrace(System.out);
            return new VodacomDTO(-1, null, null, "Failed"); 
        }
    }
    
    
    public VodacomDTO checkStatus(String rrn, StatusDetails record, JDBCService jdbcService,
            Vodacomb2cResponse response)
    {
        try {
            String tranId = (String)
                    response.getAditionalData().get(VodacomConstants.DISBURSEMENT_RESPONSE_INSIGHT_TXN_ID);
            record.setTranId(tranId);
            editTran(record, jdbcService);
            cacheService.waitForUpdate(rrn, Long.parseLong(callbackWaitingTime), TimeUnit.SECONDS);
            Map<String, String> map = cacheService.retrieveObject(rrn);
            
            if(map == null) {
               System.out.println("Cache miss on fetching result.");
               return new VodacomDTO(-1, null, StatusCodes.PENDING, "Pending");
            }
 

            String statusCode = map.get("statusCode");
            String statusDesc = (String) response.getAditionalData().get(VodacomConstants.DISBURSEMENT_RESPONSE_DESCRIPTION);
            log.info(rrn +"|statusCode from cache: " + statusCode);
            log.info(rrn +"|tranId: " + tranId);
            
            if(statusCode.equalsIgnoreCase(StatusCodes.PENDING)) {
               System.out.println("Pending status registered");
               return new VodacomDTO(-11, null, statusCode, !MiscUtil.isNullOrEmpty(statusDesc) ? statusDesc : "Pending");
            }
 
            if(statusCode.equalsIgnoreCase(StatusCodes.SUCCESS))
            {
                System.out.println("Success status registered");
                
                return new VodacomDTO(0, tranId,
                        statusCode, !MiscUtil.isNullOrEmpty(statusDesc) ? statusDesc : "Successfully processed");
            }
            
            if(statusCode.equalsIgnoreCase(StatusCodes.FAILED))
            {
                System.out.println("Failure registered");
                return new VodacomDTO(-1, null, statusCode, !MiscUtil.isNullOrEmpty(statusDesc) ? statusDesc : "Failed");
            }
            
           
            
            
        } catch (InterruptedException | ExecutionException ex) {
            Logger.getLogger(VodacomBankToWalletService.class.getName()).log(Level.SEVERE, null, ex);
        }
        return new VodacomDTO(-3, null, null, "Timeout");
        
    }
    
    public void editTran(StatusDetails record, JDBCService jdbcService)
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
        
        Map<String, Object> additionalData = new HashMap<>();
        
        if(MiscUtil.isNullOrEmpty(msisdn)) {
            response.setAditionalData(additionalData);
            response.setStatus(TranStatus.TIMEOUT);
            response.setMessage("INVALID MSISDN!!");
            return response;
        }
                
//        msisdn = msisdn.substring(Math.max(0, msisdn.length() - 9));
        
        String loginRequest = getLoginRequest();
        
        log.info("SENDING LOGIN REQUEST...");

        HttpHeaders headers = new HttpHeaders();

        headers.add("Content-Type", "text/xml");

        String loginResponse = httpAdapter.httpPost((!MiscUtil.isNullOrEmpty(this.mockTestNumber) && msisdn.equalsIgnoreCase(this.mockTestNumber)) ? this.mockLoginURL : this.loginURL, headers, loginRequest);
        
        if(MiscUtil.isNullOrEmpty(loginResponse)) {
            response.setAditionalData(new HashMap<>());
            response.setStatus(TranStatus.FAILURE);
            response.setMessage("Login failed!!");
            return response;
        }
        
        Map<String, String> values = MiscUtil.extractAllTagValues(loginResponse);
        
        String eventCode = values.get(VodacomConstants.LOGIN_RESPONSE_EVENTCODE);
        String transactionId = values.get(VodacomConstants.LOGIN_RESPONSE_TRANSACTIONID);
        String sessionId = values.get(VodacomConstants.LOGIN_RESPONSE_SESSIONID);
            
        log.info("event code: " + eventCode);
        log.info("transaction id: " + transactionId);
        log.info("session id: " + sessionId);
        
        if(MiscUtil.isNullOrEmpty(sessionId))
        {   
            response.setAditionalData(additionalData);
            response.setStatus(TranStatus.FAILURE);
            response.setMessage("Could not get token!!");
            return response;
        }
        
        String requestStr = getDisbursementRequest(sessionId, msisdn, inqRequest.getEazzycash().getCurrency(), amount, rrn);
        
//        HttpHeaders headers = new HttpHeaders();
//
//        headers.add("Content-Type", "text/xml");
//
        String responseStr = httpAdapter.httpPost((!MiscUtil.isNullOrEmpty(this.mockTestNumber) && msisdn.equalsIgnoreCase(this.mockTestNumber)) ? this.mockDisbursementURL : this.disbursementURL, headers, requestStr);
 
        
        if(MiscUtil.isNullOrEmpty(responseStr)) {
            response.setAditionalData(additionalData);
            response.setStatus(TranStatus.TIMEOUT);
            response.setMessage("Partner returned null or empty response!!");
            return response;
        }
        
        Map<String, String> disbValues = MiscUtil.extractAllTagValues(responseStr);
        
        String disbEventCode = disbValues.get(VodacomConstants.DISBURSEMENT_RESPONSE_EVENTCODE);
        String disbInsightTransactionId = disbValues.get(VodacomConstants.DISBURSEMENT_RESPONSE_INSIGHT_TXN_ID);
        String disbDescription = disbValues.get(VodacomConstants.DISBURSEMENT_RESPONSE_DESCRIPTION);

        System.out.println("disbEventCode: " + disbEventCode);
        additionalData.put(VodacomConstants.DISBURSEMENT_RESPONSE_EVENTCODE, disbEventCode);
        additionalData.put(VodacomConstants.DISBURSEMENT_RESPONSE_DESCRIPTION, disbDescription);
        System.out.println("disbInsightTransactionId: " + disbInsightTransactionId);
        System.out.println("disbDescription: " + disbDescription);
        
        
        if(disbEventCode.equalsIgnoreCase("3") && !MiscUtil.isNullOrEmpty(disbInsightTransactionId) && disbDescription.equalsIgnoreCase("Processed")) {
            System.out.println("Succesfully initiated");
            response.setStatus(TranStatus.SUCCESS);
            response.setMessage("Succesfully initiated");
            additionalData.put(VodacomConstants.DISBURSEMENT_RESPONSE_INSIGHT_TXN_ID, disbInsightTransactionId);
            response.setAditionalData(additionalData);
            return response;
        }
        response.setAditionalData(additionalData);
        response.setStatus(TranStatus.FAILURE);
        System.out.println("disbursement failed!");
        response.setMessage("disbursement failed!");
        return response;
        
    }
    
    private String getLoginRequest() 
    {   
        
        String loginRequest = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
"<soapenv:Envelope\n" +
"xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n" +
"xmlns:soap=\"http://www.4cgroup.co.za/soapauth\"\n" +
"xmlns:gen=\"http://www.4cgroup.co.za/genericsoap\">\n" +
"<soapenv:Header>\n" +
"<soap:EventID>2500</soap:EventID>\n" +
"</soapenv:Header>\n" +
"<soapenv:Body>\n" +
"<gen:getGenericResult>\n" +
"<Request>\n" +
"<dataItem>\n" +
"<name>Username</name>\n" +
"<type>String</type>\n" +
"<value>" + this.loginUserName + "</value>\n" +
"</dataItem>\n" +
"<dataItem>\n" +
"<name>Password</name>\n" +
"<type>String</type>\n" +
"<value>" + this.loginPassword + "</value>\n" +
"</dataItem>\n" +
"</Request>\n" +
"</gen:getGenericResult>\n" +
"</soapenv:Body>\n" +
"</soapenv:Envelope>";
        return loginRequest;
    }
    
    private String getFromatedDate()
    {
        LocalDateTime now = LocalDateTime.now();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");

        String formattedDate = now.format(formatter);
        
        return formattedDate;
    }
    
    private String getDisbursementRequest(String tokenId, String msisdn, String currency, String amount, String rrn) 
    {   
        
        String loginRequest = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
"<soapenv:Envelope\n" +
"xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" +
"    <soapenv:Header>\n" +
"        <soap:EventID xmlns:soap=\"http://www.4cgroup.co.za/soapauth\">12001</soap:EventID>\n" +
"        <soap:Token xmlns:soap=\"http://www.4cgroup.co.za/soapauth\">" + tokenId + "</soap:Token>\n" +
"    </soapenv:Header>\n" +
"    <soapenv:Body>\n" +
"        <gen:getGenericResult\n" +
"xmlns:gen=\"http://www.4cgroup.co.za/genericsoap\">\n" +
"            <Request>\n" +
"                <dataItem>\n" +
"                    <name>ServiceProviderName</name>\n" +
"                    <type>String</type>\n" +
"                    <value>" + this.serviceProviderName + "</value>\n" +
"                </dataItem>\n" +
"                <dataItem>\n" +
"                    <name>CustomerMSISDN</name>\n" +
"                    <type>String</type>\n" +
"                    <value>" + msisdn + "</value>\n" +
"                </dataItem>\n" +
"                <dataItem>\n" +
"                    <name>Currency</name>\n" +
"                    <type>String</type>\n" +
"                    <value>" + currency + "</value>\n" +
"                </dataItem>\n" +
"                <dataItem>\n" +
"                    <name>Amount</name>\n" +
"                    <type>String</type>\n" +
"                    <value>" + amount + "</value>\n" +
"                </dataItem>\n" +
"                <dataItem>\n" +
"                    <name>TransactionDateTime</name>\n" +
"                    <type>Date</type>\n" +
"                    <value>" + getFromatedDate() + "</value>\n" +
"                </dataItem>\n" +
"                <dataItem>\n" +
"                    <name>Shortcode</name>\n" +
"                    <type>String</type>\n" +
"                    <value>" + this.shortCode + "</value>\n" +
"                </dataItem>\n" +
"                <dataItem>\n" +
"                    <name>Language</name>\n" +
"                    <type>String</type>\n" +
"                    <value>EN</value>\n" +
"                </dataItem>\n" +
"                <dataItem>\n" +
"                    <name>ThirdPartyReference</name>\n" +
"                    <type>String</type>\n" +
"                    <value>" + rrn + "</value>\n" +
"                </dataItem>\n" +
"                <dataItem>\n" +
"                    <name>CallBackChannel</name>\n" +
"                    <type>String</type>\n" +
"                    <value>2</value>\n" +
"                </dataItem>\n" +
"                <dataItem>\n" +
"                    <name>CallBackDestination</name>\n" +
"                    <type>String</type>\n" +
"                    <value>" + ((!MiscUtil.isNullOrEmpty(this.mockTestNumber) && msisdn.equalsIgnoreCase(this.mockTestNumber)) ? this.mockCallBackDestination : this.callBackDestination) + "</value>\n" +
"                </dataItem>\n" +
"                <dataItem>\n" +
"                    <name>CommandID</name>\n" +
"                    <type>String</type>\n" +
"                    <value>InitTrans_one4allb2c</value>\n" +
"                </dataItem>\n" +
"            </Request>\n" +
"        </gen:getGenericResult>\n" +
"    </soapenv:Body>\n" +
"</soapenv:Envelope>";
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

