/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybank.gag.orange_money_ms.service.business.impl;


import com.equitybank.gag.orange_money_ms.constants.AirtelConstants;
import com.equitybank.gag.orange_money_ms.constants.TPGConstants;
import com.equitybank.gag.orange_money_ms.dto.airtime.AirtelDTO;
import com.equitybank.gag.orange_money_ms.dto.airtime.Airtelb2cResponse;
import com.equitybank.gag.orange_money_ms.dto.airtime.AirtimeRequestDTO;
import com.equitybank.gag.orange_money_ms.dto.airtime.StatusCodes;
import com.equitybank.gag.orange_money_ms.entity.StatusDetails;
import com.equitybank.gag.orange_money_ms.entity.TransactionDetails;
import com.equitybank.gag.orange_money_ms.enums.RequestTypes;
import com.equitybank.gag.orange_money_ms.enums.TranStatus;
import com.equitybank.gag.orange_money_ms.enums.TransactionStatus;
import com.equitybank.gag.orange_money_ms.repository.TransactionDetailsRepository;
import com.equitybank.gag.orange_money_ms.service.util.MiscUtil;
import static com.equitybank.gag.orange_money_ms.service.util.MiscUtil.isNullOrEmpty;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.Executor;
import jakarta.annotation.PostConstruct;
import java.io.IOException;
import javax.xml.parsers.ParserConfigurationException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationContext;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.xml.sax.SAXException;

/**
 *
 * @author ronaldcheruiyot
 */
@Service
@Slf4j
public class AirtimeService {
    
    @Value("${orange.cd.airtime.pin}")
    private String pin;
    
    @Value("${orange.cd.airtime.channelMsisdn}")
    private String channelMsisdn;
    
    @Value("${orange.cd.airtime.password}")
    private String password;
    
    @Value("${orange.cd.airtime.extCode}")
    private String extCode;
    
    @Value("${orange.cd.airtime.requestURL}")
    private String requestBaseURL;
    
    @Value("${orange.cd.airtime.loginId}")
    private String loginId;
    
    @Value("${orange.cd.airtime.request.REQUEST_GATEWAY_CODE}")
    private String REQUEST_GATEWAY_CODE;
    
    @Value("${orange.cd.airtime.request.SERVICE_PORT}")
    private String SERVICE_PORT;
    
    @Value("${orange.cd.airtime.request.REQUEST_GATEWAY_TYPE}")
    private String REQUEST_GATEWAY_TYPE;
    
    @Value("${orange.cd.airtime.request.LOGIN}")
    private String LOGIN;
    
    @Value("${orange.cd.airtime.request.SOURCE_TYPE}")
    private String SOURCE_TYPE;
    
    @Value("${orange.cd.airtime.request.PASSWORD}")
    private String PASSWORD;
    
    @Value("$(service.activation.airtime)")
    private String airtimeActivationStr;

    private boolean airtimeActivated;
    
    private String requestURL = null;
    
    @Autowired
    private ApplicationContext applicationContext;
    
    @Autowired
    Executor taskExecutor;
    
    @Autowired
    OutboundHttpAdapter httpAdapter;
    
    @Autowired
    TransactionDetailsRepository tranRepository;
    
    private Map<String, Map<String, String>> props = new HashMap<>();
    
    public boolean isLocal = false;

    public boolean isAirtimeActivated() {
        return airtimeActivated;
    }

    
    
    
    
    @PostConstruct
    public void init() throws IllegalArgumentException, IllegalStateException
    {  
        Environment env = this.applicationContext.getEnvironment();
        String[] activeProfiles = env.getActiveProfiles();
        this.requestURL = buildURL();
        this.airtimeActivated = Boolean.valueOf(airtimeActivationStr);
        
        if(MiscUtil.isNullOrEmpty(this.requestURL)) throw new IllegalArgumentException("requestURL cannot be null or empty!!");
        
        for(String profile : activeProfiles)
        {
            if(profile.equalsIgnoreCase("local"))
            {
                isLocal = true;
            }
            if(profile.equalsIgnoreCase("prod") && this.airtimeActivated)
            {
               boolean isHostAvailable = MiscUtil.isHostAvailable(this.requestURL);
               
               if(!isHostAvailable)
               {
                   throw new IllegalStateException("Comunication link failure, no connection to URL: " + this.requestURL + "!!");
               }
            }
        }
        
        
    }
    
    public  AirtelDTO buyAirtime(Map<String, String> request)
    {
        JDBCService jdbcService = (JDBCService) this.applicationContext.getBean(JDBCService.class);
        String rrn = request.get(TPGConstants.AIRTIME_REQUEST_RRN);
        BigDecimal amount = new BigDecimal(request.get(TPGConstants.AIRTIME_REQUEST_AMOUNT));
        StatusDetails record = jdbcService.getB2cTransactionsByRrn(rrn);
        
        if (record == null) {
            if(!isLocal)
            {
                System.out.println(rrn + "|Airtime record record Not found!!");
                return new AirtelDTO(-1, null, "-1", rrn + "|B2C record Not found!!");
            }
            record = getStatusDetails(amount, rrn);
        } 
        try {
            Airtelb2cResponse response = postTransaction(request);
            String resultCode = (String) response.getAditionalData().get(AirtelConstants.AIRTIME_RESPONSE_TXNSTATUS);
            String telcoMessage = (String) response.getAditionalData().get(AirtelConstants.AIRTIME_RESPONSE_MESSAGE);
            if(null == response.getStatus())
                return new AirtelDTO(-1, resultCode, null, "Failed with no status"); 
            else switch (response.getStatus()) {
                case SUCCESS:
                    String tranId = (String) response.getAditionalData().get(AirtelConstants.AIRTIME_REQUEST_TXNID);
                    editTran(record, "1", rrn, "0", jdbcService);
                    return new AirtelDTO(0, tranId, resultCode, telcoMessage);
                case FAILURE:
                    editTran(record, "-1", rrn, "-1", jdbcService);
                    return new AirtelDTO(-1, null, resultCode, telcoMessage); 
                case TIMEOUT:
                    editTran(record, "-3", rrn, "-3", jdbcService);
                    return new AirtelDTO(-3, null, null, "Timeout"); 
                default:
                    editTran(record, "-1", rrn, "-1", jdbcService);
                    return new AirtelDTO(-1, null, null, "Failed");
            }

        } catch (Exception ex) {
            ex.printStackTrace(System.out);
            return new AirtelDTO(-1, null, null, "Failed"); 
        }
        
    }
    
    public Airtelb2cResponse postTransaction(Map<String, String> requestMap) throws ParserConfigurationException, SAXException, IOException
    {   
        Airtelb2cResponse response = new Airtelb2cResponse();
        Map<String, Object> aditionalData = new HashMap<>();
        String rrn = requestMap.get(TPGConstants.AIRTIME_REQUEST_RRN);
        String amount = requestMap.get(TPGConstants.AIRTIME_REQUEST_AMOUNT);
        String msisdn = requestMap.get(TPGConstants.AIRTIME_REQUEST_MSISDNA);
        String currency = requestMap.get(TPGConstants.AIRTIME_REQUEST_CURRENCY);

        AirtimeRequestDTO request = AirtimeRequestDTO.builder()
                .amount(String.valueOf(amount))
                .currency(currency)
                .extCode(this.extCode)
                .extNWCode("DR")
                .extRefNum(rrn)
                .language1("1")
                .language2("1")
                .loginId(this.loginId)
                .msisdn(this.channelMsisdn)
                .msisdn2(msisdn)
                .password(this.password)
                .pin(this.pin)
                .selector("1")
                .build();
        String requestStr = request.getAirtimeXMLRequest();
        
        HttpHeaders headers = new HttpHeaders();
        
        headers.add("Content-Type", "application/json");
                
        String responseStr = httpAdapter.httpPost(this.requestURL, headers, requestStr);
        
        if(isNullOrEmpty(responseStr)) {
            response.setAditionalData(new HashMap<>());
            response.setStatus(TranStatus.TIMEOUT);
            response.setMessage("Partner returned null or empty response!!");
            return response;
        }
        
        Map<String, String> respMap = MiscUtil.extractAllTagValues(responseStr);
        
        String txnStatus = respMap.get(AirtelConstants.AIRTIME_RESPONSE_TXNSTATUS);
        String txnId = respMap.get(AirtelConstants.AIRTIME_RESPONSE_TXNID);
        String message = respMap.get(AirtelConstants.AIRTIME_RESPONSE_MESSAGE);
        
        log.info(rrn + "|txnStatus: " + txnStatus);
        log.info(rrn + "|txnId: " + txnId);
        log.info(rrn + "|message: " + message);
        
        aditionalData.put(AirtelConstants.AIRTIME_RESPONSE_MESSAGE, !isNullOrEmpty(message) ? message : "Unknown response message.");
        aditionalData.put(AirtelConstants.AIRTIME_RESPONSE_TXNID, txnId);
        
        if(isNullOrEmpty(txnStatus)) {
            response.setAditionalData(aditionalData);
            response.setStatus(TranStatus.TIMEOUT);
            response.setMessage("TXN status is null or empty!!");
            return response;
        }
        
        
        if(txnStatus.equalsIgnoreCase("200") && !MiscUtil.isNullOrEmpty(txnId)) {
            System.out.println("Succesfully initiated");
            response.setStatus(TranStatus.SUCCESS);
            response.setMessage("Succesfully initiated");
            response.setAditionalData(aditionalData);
            return response;
        }
        
        if(MiscUtil.isNullOrEmpty(message))
        {   
            aditionalData.put(AirtelConstants.AIRTIME_RESPONSE_MESSAGE, "Airtime purchase failed!");
            response.setAditionalData(aditionalData);
            response.setStatus(TranStatus.FAILURE);
            log.info(rrn + "|Airtime purchase failed!");
            response.setMessage("Airtime purchase failed!");
            return response;
        }
        
        response.setAditionalData(aditionalData);
        response.setStatus(TranStatus.FAILURE);
        log.info(rrn + "|" + message);
        response.setMessage(message);
        return response;
        
    }
    
    private String buildURL()
    {
//        StringBuilder builder = new StringBuilder();
//        builder.append(this.requestBaseURL)
//                .append("?REQUEST_GATEWAY_CODE=")
//                .append(this.REQUEST_GATEWAY_CODE)
//                .append("&amp;SERVICE_PORT=")
//                .append(this.SERVICE_PORT)
//                .append("&amp;REQUEST_GATEWAY_TYPE=")
//                .append(this.REQUEST_GATEWAY_TYPE)
//                .append("&amp;LOGIN=")
//                .append(this.LOGIN)
//                .append("&amp;SOURCE_TYPE=")
//                .append(this.SOURCE_TYPE)
//                .append("&amp;PASSWORD=")
//                .append(this.PASSWORD);

        StringBuilder builder = new StringBuilder();
        builder.append(this.requestBaseURL)
                .append("?REQUEST_GATEWAY_CODE=")
                .append(this.REQUEST_GATEWAY_CODE)
                .append("&;SERVICE_PORT=")
                .append(this.SERVICE_PORT)
                .append("&;REQUEST_GATEWAY_TYPE=")
                .append(this.REQUEST_GATEWAY_TYPE)
                .append("&;LOGIN=")
                .append(this.LOGIN)
                .append("&;SOURCE_TYPE=")
                .append(this.SOURCE_TYPE)
                .append("&;PASSWORD=")
                .append(this.PASSWORD);
                
        String resultantURL = builder.toString();
        System.out.println("resultantURL: " + resultantURL);
        return resultantURL;
    }
 
    
    public void editTran(StatusDetails record, String status1, String rrn, String status2, JDBCService jdbcService)
    {
        try
        {   
            if(record != null)
            {
                jdbcService.editB2cTransactions(record, status1, rrn, status2);
            }
        } catch(Exception ex)
        {
            ex.printStackTrace(System.out);
        }
    }
    
    
    private StatusDetails getStatusDetails(BigDecimal amount, String rrn)
    {
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
    
    
    public static void main(String[] args) {
        AirtimeRequestDTO req = AirtimeRequestDTO.builder()
                .amount("50055")
                .extCode("123")
                .extNWCode("MO")
                .extRefNum(MiscUtil.generateRandomRRN(12))
                .language1("1")
                .language2("1")
                .loginId("TEST")
                .msisdn("243765345674")
                .msisdn2("243709876456")
                .password("TEST")
                .pin("123456")
                .selector("1")
                .build();
        System.out.println(req.getAirtimeXMLRequest());
                
    }
    
}
