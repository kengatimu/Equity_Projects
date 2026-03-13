/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.service.business.allocation;

/**
 *
 * @author ronaldcheruiyot  
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import com.equitybankgroup.payments.b2c.dto.airtel.StatusCodes;
import com.google.gson.Gson;
import java.util.Map;
import java.util.logging.Logger;
import org.springframework.http.HttpHeaders;
import org.springframework.web.client.RestClientException;
import com.equitybankgroup.payments.b2c.dto.airtel.AirtelDTO;
import com.equitybankgroup.payments.b2c.dto.airtel.CustomerData;
import com.equitybankgroup.payments.b2c.dto.airtel.allocation.common.*;
import com.equitybankgroup.payments.b2c.dto.airtel.allocation.statuscheck.*;
import com.equitybankgroup.payments.b2c.dto.input.EazInqRequest;
import com.equitybankgroup.payments.b2c.dto.input.InqResponse;
import com.equitybankgroup.payments.b2c.dto.input.InquireRequest;
import com.equitybankgroup.payments.b2c.dto.namecheck.MobileNumberInquireReq;
import com.equitybankgroup.payments.b2c.enums.RequestTypes;
import com.equitybankgroup.payments.b2c.enums.TranStatus;
import com.equitybankgroup.payments.b2c.enums.TransactionStatus;
import com.equitybankgroup.payments.b2c.model.StatusDetails;
import com.equitybankgroup.payments.b2c.model.TransactionDetails;
import com.equitybankgroup.payments.b2c.repository.TransactionDetailsRepository;
import com.equitybankgroup.payments.b2c.service.business.JDBCService;
import static com.equitybankgroup.payments.b2c.service.business.OpenAPIAirtelBankToWalletService.isNullOrEmpty;
import com.equitybankgroup.payments.b2c.service.business.http.OutboundHttpAdapter;
import com.equitybankgroup.payments.b2c.service.util.*;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.InetSocketAddress;
import java.net.MalformedURLException;
import java.net.Socket;
import java.net.URL;
import java.net.UnknownHostException;
import java.security.InvalidKeyException;
import java.security.KeyManagementException;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.HashMap;
import java.util.Properties;
import java.util.logging.Level;
import jakarta.annotation.PostConstruct;
import java.util.HashSet;
import java.util.Set;
import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.net.ssl.SSLContext;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.Header;
import org.apache.http.HttpResponse;
import org.apache.http.HttpVersion;
import org.apache.http.StatusLine;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.methods.HttpUriRequest;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLContexts;
import org.apache.http.conn.ssl.TrustAllStrategy;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.HttpParams;
import org.apache.http.params.HttpProtocolParamBean;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationContext;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

/**
 *
 * @author ronaldcheruiyot
 */

@Service
@Slf4j
public final class OpenAPIAirtelAllocationService {
    
    //CD PROPERTIES
    
    @Value("${airtel.cd.openapi.allocation.kycURL}")
    String kycURLCD;
    @Value("${airtel.cd.openapi.allocation.allocation.url}")
    String disbursementURLCD;
    @Value("${airtel.cd.openapi.allocation.token.url}")
    String tokenURLCD;
    @Value("${airtel.cd.openapi.allocation.statusCheckURL}")
    String statusCheckURLCD;
    @Value("${airtel.cd.openapi.allocation.encConsumerKey}")
    String encConsumerKeyCD;
    @Value("${airtel.cd.openapi.allocation.encConsumerSecret}")
    String encConsumerSecretCD;
    @Value("${airtel.cd.openapi.allocation.hostHeader}")
    String hostHeaderCD;
    
    //KE PROPERTIES
    @Value("${airtel.ke.openapi.allocation.kycURL}")
    String kycURLKE;
    @Value("${airtel.ke.openapi.allocation.allocation.url}")
    String disbursementURLKE;
    @Value("${airtel.ke.openapi.allocation.token.url}")
    String tokenURLKE;
    @Value("${airtel.ke.openapi.allocation.statusCheckURL}")
    String statusCheckURLKE;
    @Value("${airtel.ke.openapi.allocation.encConsumerKey}")
    String encConsumerKeyKE;
    @Value("${airtel.ke.openapi.allocation.encConsumerSecret}")
    String encConsumerSecretKE;
    @Value("${airtel.ke.openapi.allocation.hostHeader}")
    String hostHeaderKE;
    @Value("${airtel.ke.openapi.encryption.key}")
    String encryptionKey;
    
    
    @Autowired
    OutboundHttpAdapter httpAdapter;
    
    @Autowired
    private ApplicationContext applicationContext;
    
    public boolean isLocal = false;
    
    private Properties properties;
    
    Set<String> profiles = new HashSet<>();
    
    @Autowired
    TransactionDetailsRepository tranRepository;
    
    
    private Map<String, Map<String, String>> props = new HashMap<>();

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
    
    
    @PostConstruct
    public void init() throws Exception
    {   
        
        Environment env = this.applicationContext.getEnvironment();
        String[] activeProfiles = env.getActiveProfiles();
        for(String profile : activeProfiles)
        {
            profiles.add(profile);
            if(profile.equalsIgnoreCase("local"))
            {
                isLocal = true;
            }
        }
        
        
        if(profiles.contains("prod"))
        {   
            encryptionKey = StringEncryptor.jasyptDecrypt(applicationContext, encryptionKey);
            System.out.println("[KE]encryptionKey decrypted successfully!");
            encConsumerKeyKE = StringEncryptor.decrypt(encConsumerKeyKE.trim(), encryptionKey);
            System.out.println("[KE]encConsumerKeyKE decrypted successfully!");
            encConsumerSecretKE = StringEncryptor.decrypt(encConsumerSecretKE.trim(), encryptionKey);
            System.out.println("[KE]encConsumerSecretKE decrypted successfully!");
        }
        
        //CD
        Map<String, String> cdProps = new HashMap<>();
        cdProps.put("consumerKey", encConsumerKeyCD.trim());
        cdProps.put("consumerSecret", encConsumerSecretCD.trim());
        cdProps.put("disbursementURL", disbursementURLCD);
        cdProps.put("statusCheckURL", statusCheckURLCD);
        cdProps.put("currency", "CDF");
        cdProps.put("hostHeader", hostHeaderCD);
        cdProps.put("kycURL", kycURLCD);
        cdProps.put("tokenURL", tokenURLCD);
        props.put("CD", cdProps);
        
        //KE
        Map<String, String> keProps = new HashMap<>();
        keProps.put("consumerKey", encConsumerKeyKE.trim());
        keProps.put("consumerSecret", encConsumerSecretKE.trim());
        keProps.put("disbursementURL", disbursementURLKE);
        keProps.put("statusCheckURL", statusCheckURLKE);
        keProps.put("currency", "KES");
        keProps.put("hostHeader", hostHeaderKE);
        keProps.put("kycURL", kycURLKE);
        keProps.put("tokenURL", tokenURLKE);
        props.put("KE", keProps);
        
        
    }
    
    public AirtelDTO sendTransaction(EazInqRequest inqRequest, String countryCode, InqResponse rs)
    {   
        JDBCService jdbcService = (JDBCService) this.applicationContext.getBean(JDBCService.class);
        StatusDetails record = jdbcService.getB2cTransactionsByRrn(inqRequest.getEazzycash().getRrn());
        String rrn = inqRequest.getEazzycash().getRrn();
        String amount = inqRequest.getEazzycash().getAmount();
        if (record == null) {
            if(!isLocal)
            {
                log.info(rrn + "|B2C record Not found!!");
                return new com.equitybankgroup.payments.b2c.dto.airtel.AirtelDTO(-1, null, "B2C record Not found!!", null);
            }
            record = getStatusDetails(amount, rrn);
        }
         try {
            Airtelb2cResponse response = postTransaction(inqRequest, countryCode);
            String resultCode = (String) response.getAditionalData().get(com.equitybankgroup.payments.b2c.dto.airtel.Airtelb2cOpenApiConstants.AIRTEL_RESPONSE_CODE);
            String telcoMessage = (String) response.getAditionalData().get(com.equitybankgroup.payments.b2c.dto.airtel.Airtelb2cOpenApiConstants.AIRTEL_RESPONSE_MESSAGE);
            if(null == response.getStatus())
                return new com.equitybankgroup.payments.b2c.dto.airtel.AirtelDTO(-1, resultCode, null, "Failed"); 
            else switch (response.getStatus()) {
                case SUCCESS:
                    String tranId = (String) response.getAditionalData().get(com.equitybankgroup.payments.b2c.dto.airtel.Airtelb2cOpenApiConstants.AIRTEL_MONEY_ID);
                    record.setTranId(tranId);
                    record.setStatus(TransactionStatus.OK.name());
                    record.setStatusCode(StatusCodes.SUCCESS);
                    record.setStatusMessage(MiscUtil.isNotNullAndNotEmpty(telcoMessage) ? telcoMessage : "Successfully processed.");
                    editTran(record, "1", rrn, "0", jdbcService);
                    return new com.equitybankgroup.payments.b2c.dto.airtel.AirtelDTO(0, tranId, resultCode, telcoMessage);
                case FAILURE:
                    record.setStatus(TransactionStatus.ERROR.name());
                    record.setStatusCode(StatusCodes.FAILED);
                    record.setStatusMessage(MiscUtil.isNotNullAndNotEmpty(telcoMessage) ? telcoMessage : "Transaction failed.");
                    editTran(record, "-1", rrn, "-1", jdbcService);
                    return new com.equitybankgroup.payments.b2c.dto.airtel.AirtelDTO(-1, null, resultCode, telcoMessage); 
                case TIMEOUT:
                    record.setStatus(TransactionStatus.TIMEOUT.name());
                    record.setStatusCode(StatusCodes.TIMEOUT);
                    record.setStatusMessage(MiscUtil.isNotNullAndNotEmpty(telcoMessage) ? telcoMessage : "Transaction timeout.");
                    editTran(record, "-3", rrn, "-3", jdbcService);
                    return new com.equitybankgroup.payments.b2c.dto.airtel.AirtelDTO(-3, null, null, "Timeout"); 
                default:
                    record.setStatus(TransactionStatus.ERROR.name());
                    record.setStatusCode(StatusCodes.FAILED);
                    record.setStatusMessage(MiscUtil.isNotNullAndNotEmpty(telcoMessage) ? telcoMessage : "Transaction failed.");
                    editTran(record, "-1", rrn, "-1", jdbcService);
                    return new com.equitybankgroup.payments.b2c.dto.airtel.AirtelDTO(-1, null, null, "Failed");
            }

        } catch (Exception ex) {
            ex.printStackTrace(System.out);
            return new com.equitybankgroup.payments.b2c.dto.airtel.AirtelDTO(-1, null, null, "Failed"); 
        }
    }
    
    public AirtelDTO checkTransactionStatus(InquireRequest inqRequest, String countryCode)
    {   
        JDBCService jdbcService = (JDBCService) this.applicationContext.getBean(JDBCService.class);
        StatusDetails record = jdbcService.getB2cTransactionsByRrn(inqRequest.getEazzycash().getRrn());
        
        String rrn = inqRequest.getEazzycash().getRrn();
        try {
            String currency = this.getPropertyValue(countryCode, "currency");
            Airtelb2cResponse response = statusCheck(rrn, countryCode, currency);
            String resultCode = (String) response.getAditionalData().get(com.equitybankgroup.payments.b2c.dto.airtel.Airtelb2cOpenApiConstants.AIRTEL_RESPONSE_CODE);
            String telcoMessage = (String) response.getAditionalData().get(com.equitybankgroup.payments.b2c.dto.airtel.Airtelb2cOpenApiConstants.AIRTEL_RESPONSE_MESSAGE);
            if(null == response.getStatus())
                return new AirtelDTO(-1, resultCode, null, "Failed"); 
            else switch (response.getStatus()) {
                case SUCCESS:
                    String tranId = (String) response.getAditionalData().get(com.equitybankgroup.payments.b2c.dto.airtel.Airtelb2cOpenApiConstants.AIRTEL_MONEY_ID);
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

    public com.equitybankgroup.payments.b2c.dto.airtel.Airtelb2cResponse nameCheck(MobileNumberInquireReq inqRequest, String countryCode, String currency) throws Exception {
        
        if(isNullOrEmpty(inqRequest)) throw new IllegalArgumentException("INVALID REQUEST!!");
        
        com.equitybankgroup.payments.b2c.dto.airtel.Airtelb2cResponse response = new com.equitybankgroup.payments.b2c.dto.airtel.Airtelb2cResponse();
        String msisdn = inqRequest.getMobileNumber();
        msisdn = msisdn.substring(Math.max(0, msisdn.length() - 9));
        if(isNullOrEmpty(msisdn)) throw new IllegalArgumentException("MSISDN cannot be null or empty");
        String kycURL = this.getPropertyValue(countryCode, "kycURL");
        
        HttpHeaders headers = getGenericHeaders(countryCode, currency);
        
        MiscUtil.printHeaders(headers, countryCode, "namecheck-float");
        
        String responseStr = httpAdapter.httpGet(kycURL + "/" + msisdn, headers);
        if(isNullOrEmpty(responseStr)) {
            log.error("Partner returned null or empty response!!");
            response.setStatus(TranStatus.FAILURE);
            response.setMessage("Partner returned null or empty response!!");
            return response;
        }
        
        com.equitybankgroup.payments.b2c.dto.airtel.NameCheckResponse ncResponse = (new Gson()).fromJson(responseStr, com.equitybankgroup.payments.b2c.dto.airtel.NameCheckResponse.class);
        if(isNullOrEmpty(ncResponse)) {
            log.error("Could not deserialize partner response!!");
            response.setStatus(TranStatus.FAILURE);
            response.setMessage("Could not deserialize partner response!!");
            return response;
        }
        
        com.equitybankgroup.payments.b2c.dto.airtel.Status status = ncResponse.getStatus();
        CustomerData data = ncResponse.getData();
        String code = status.getCode();
        String message = status.getMessage();
        String resultCode = status.getResult_code();
        boolean success = status.isSuccess();
        
        if(isNullOrEmpty(status) || isNullOrEmpty(code) || isNullOrEmpty(message)|| isNullOrEmpty(resultCode) || isNullOrEmpty(data)) {
            log.error("One or more response code parameters is missing!!");
            response.setStatus(TranStatus.FAILURE);
            response.setMessage("One or more response code parameters is missing!!");
            return response;
        }
        
        
        if(code.equalsIgnoreCase("200") && message.equalsIgnoreCase("SUCCESS") && resultCode.equalsIgnoreCase("ESB000010") && success) {
            response.setStatus(TranStatus.SUCCESS);
            response.setMessage("Succesfully processed");
            log.info("Succesfully processed");
            Map<String, Object> aditionalData = new HashMap<>();
            aditionalData.put(com.equitybankgroup.payments.b2c.dto.airtel.Airtelb2cOpenApiConstants.CUSTOMER_FIRST_NAME, data.getFirst_name());
            aditionalData.put(com.equitybankgroup.payments.b2c.dto.airtel.Airtelb2cOpenApiConstants.CUSTOMER_LAST_NAME, data.getLast_name());
            aditionalData.put(com.equitybankgroup.payments.b2c.dto.airtel.Airtelb2cOpenApiConstants.AIRTEL_MONEY_IS_BARRED, data.getIs_barred());
            aditionalData.put(com.equitybankgroup.payments.b2c.dto.airtel.Airtelb2cOpenApiConstants.AIRTEL_MONEY_IS_PIN_RESET, data.getIs_pin_set());
            aditionalData.put(com.equitybankgroup.payments.b2c.dto.airtel.Airtelb2cOpenApiConstants.AIRTEL_MONEY_GRADE, data.getGrade());
            response.setAditionalData(aditionalData);
            return response;
        }
        log.error("Namecheck failed!");
        response.setStatus(TranStatus.FAILURE);
        response.setMessage("Namecheck failed!");
        return response;
        
    }
    
    public Airtelb2cResponse postTransaction(EazInqRequest inqRequest, String countryCode) throws Exception{
        
        Airtelb2cResponse response = new Airtelb2cResponse();
        final String rrn = inqRequest.getEazzycash().getRrn();
        
        
        String msisdn = inqRequest.getEazzycash().getNumber();
        
        if(isNullOrEmpty(msisdn)) {
            response.setAditionalData(new HashMap<>());
            response.setStatus(TranStatus.TIMEOUT);
            response.setMessage("INVALID MSISDN!!");
            return response;
        }
                
        msisdn = msisdn.substring(Math.max(0, msisdn.length() - 9));
        
        PayeeRequest payee = new PayeeRequest(msisdn);
        
        Transaction transaction = new Transaction(rrn, String.valueOf(inqRequest.getEazzycash().getAmount()), payee);
        
        
        AllocationRequest allocationRequest = new AllocationRequest(transaction);
        
        
        String requestStr = (new Gson()).toJson(allocationRequest);
        
        HttpHeaders headers = getGenericHeaders(countryCode, inqRequest.getEazzycash().getCurrency());
        
        MiscUtil.printHeaders(headers, countryCode, "floatPurchase");
        
        headers.add("Content-Type", "application/json");
        
        String disbursementURL = this.getPropertyValue(countryCode, "disbursementURL");
        
        String responseStr = httpAdapter.httpPost(disbursementURL, headers, requestStr);
        
        if(isNullOrEmpty(responseStr)) {
            response.setAditionalData(new HashMap<>());
            response.setStatus(TranStatus.TIMEOUT);
            response.setMessage("Partner returned null or empty response!!");
            return response;
        }
        
        AllocationResponse dsResponse = (new Gson()).fromJson(responseStr, AllocationResponse.class);
        
        System.out.println("Deserialized dsResponse: " + (new Gson()).toJson(dsResponse));

        
        if(isNullOrEmpty(dsResponse)) {
            System.out.println("Could not deserialize partner response!!");
            response.setAditionalData(new HashMap<>());
            response.setStatus(TranStatus.TIMEOUT);
            response.setMessage("Could not deserialize partner response!!");
            return response;
        }
        
        AllocationStatusResponse status = dsResponse.getStatus();
        AllocationDataResponse data = dsResponse.getData();
        
        String code = status.getCode();
        String message = status.getMessage();
        String responseCode = status.getResponse_code();
        
        Map<String, Object> aditionalData = new HashMap<>();
        
        if(MiscUtil.isNotNullAndNotEmpty(responseCode))
        {
            aditionalData.put(Airtelb2cOpenApiConstants.AIRTEL_RESPONSE_CODE, responseCode);
        }
        
        if(MiscUtil.isNotNullAndNotEmpty(message))
        {
            aditionalData.put(Airtelb2cOpenApiConstants.AIRTEL_RESPONSE_MESSAGE, message);
        }
        
        boolean success = status.isSuccess();
        
        System.out.println("CODE: " + code);
        System.out.println("MESSAGE: " + message);
        System.out.println("RESPONSE_CODE: " + responseCode);
        System.out.println("SUCCESS: " + success);
        
        
        
//        taskExecutor.execute(() -> {
//            try {
//                statusCheck(rrn, countryCode);
//            } catch (Exception ex) {
//                ex.printStackTrace(System.out);
//            }
//        });
        
        
        if(isNullOrEmpty(status) || isNullOrEmpty(code) || isNullOrEmpty(message)|| isNullOrEmpty(responseCode) || (isNullOrEmpty(data))) {
            System.out.println("One or more response code parameters is missing!!");
            response.setAditionalData(aditionalData);
            response.setStatus(TranStatus.FAILURE);
            response.setMessage((MiscUtil.isNotNullAndNotEmpty(message)) ? message : "One or more response code parameters is missing!!");
            return response;
        }

        String referenceId = data.getTransaction().getReference_id();
        System.out.println("AIRTEL REFERENCE: " + referenceId);
        
        if(code.equalsIgnoreCase("200") && responseCode.equalsIgnoreCase("DP02050001000") && success && MiscUtil.isNotNullAndNotEmpty(message) && message.toUpperCase().contains("AMBIGUOUS")) {
            System.out.println("AMBIGUOUS Response!!");
            response.setAditionalData(aditionalData);
            response.setStatus(TranStatus.TIMEOUT);
            response.setMessage("AMBIGUOUS Response!!");
            return response;
        }
        
        if(code.equalsIgnoreCase("200") && responseCode.equalsIgnoreCase("DP02050001001") && success) {
            System.out.println("Succesfully processed");
            response.setStatus(TranStatus.SUCCESS);
            response.setMessage("Succesfully processed");
            aditionalData.put(Airtelb2cOpenApiConstants.REFERENCE_ID, referenceId);
            aditionalData.put(Airtelb2cOpenApiConstants.AIRTEL_MONEY_ID, referenceId);
            response.setAditionalData(aditionalData);
            return response;
        }
                
        response.setAditionalData(aditionalData);
        response.setStatus(TranStatus.FAILURE);
        System.out.println("Allocation failed!");
        response.setMessage((MiscUtil.isNotNullAndNotEmpty(message)) ? message :"Allocation failed!");
        return response;
        
    }

    public Airtelb2cResponse statusCheck(String id, String countryCode, String currency) throws Exception {
        Airtelb2cResponse response = new Airtelb2cResponse();
        HttpHeaders headers = getGenericHeaders(countryCode, currency);
        String statusCheckURL = this.getPropertyValue(countryCode, "statusCheckURL");
        String responseStr = httpAdapter.httpGet(statusCheckURL + "/" + id, headers); 
        if(isNullOrEmpty(responseStr)) {
            response.setStatus(TranStatus.TIMEOUT);
            response.setMessage("Partner returned null or empty response!!");
            return response;
        }
        
        StatusCheckResponse statusCheckResp = (new Gson()).fromJson(responseStr, StatusCheckResponse.class);
                
        if(isNullOrEmpty(statusCheckResp)) {
            System.out.println("Could not deserialize partner response!!");
            response.setStatus(TranStatus.FAILURE);
            response.setMessage("Could not deserialize partner response!!");
            return response;
        }
        
        if(isNullOrEmpty(statusCheckResp.getStatus()) || isNullOrEmpty(statusCheckResp.getData())) {
            System.out.println("One or more response code parameters(status or data) is missing!!");
            response.setStatus(TranStatus.FAILURE);
            response.setMessage("One or more response code parameters(status or data) is missing!!");
            return response;
        }
        
        String code = statusCheckResp.getStatus().getCode();
        String message = statusCheckResp.getStatus().getMessage();
        String resultCode = statusCheckResp.getStatus().getResult_code();
        String responseCode = statusCheckResp.getStatus().getResponse_code();
        boolean success = statusCheckResp.getStatus().isSuccess();
        String status = statusCheckResp.getData().getTransaction().getStatus();
        
        if(isNullOrEmpty(code) || isNullOrEmpty(resultCode)) {
            System.out.println("One or more response code parameters(code or resultCode) is missing!!");
            response.setStatus(TranStatus.FAILURE);
            response.setMessage("One or more response code parameters(code or resultCode) is missing!!");
            return response;
        }
        
        if(code.equalsIgnoreCase("200") && resultCode.equalsIgnoreCase("ESB000010") && (status.equalsIgnoreCase("TS")) && (responseCode.equalsIgnoreCase("DP00900001001")) && success) {
            System.out.println("Succesfully processed");
            response.setStatus(TranStatus.SUCCESS);
            response.setMessage("Succesfully processed");
            return response;
        }
        
        Map<String, Object> aditionalData = new HashMap<>();
        
        if(MiscUtil.isNotNullAndNotEmpty(resultCode))
        {
            aditionalData.put(Airtelb2cOpenApiConstants.AIRTEL_RESULT_CODE, resultCode);
        }
        
        if(MiscUtil.isNotNullAndNotEmpty(message))
        {
            aditionalData.put(Airtelb2cOpenApiConstants.AIRTEL_RESPONSE_MESSAGE, message);
        }
        response.setAditionalData(aditionalData);
        response.setStatus(TranStatus.FAILURE);
        System.out.println("disbursement failed!");
        response.setMessage("disbursement failed!");
        return response;
        
    }
    
    private StatusDetails getStatusDetails(String amount, String rrn)
    {
        TransactionDetails details = new TransactionDetails();
        details.setAmount(new BigDecimal(amount));
        details.setBankId("43");
        details.setChannel("OMNI");
        details.setClientType("Customer");
        details.setRrn(rrn);
        details.setOperationType(RequestTypes.B2C);
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
    
    
    private HttpHeaders getGenericHeaders(String countryCode, String currency) throws Exception
    {   
        String token = generateToken(countryCode);
        
        if(isNullOrEmpty(token)) throw new Exception("Could not generate token!!");
        
        if(isNullOrEmpty(currency)) throw new Exception("Currency cannot be null or empty!!");
        
        if(!currency.equalsIgnoreCase("CDF") && !currency.equalsIgnoreCase("USD") && !currency.equalsIgnoreCase("KES")) throw new Exception("Invalid currency!!");
        
        log.info("Token: " + token);
                
        String hostHeader = this.getPropertyValue(countryCode, "hostHeader");
        
        HttpHeaders headers = new HttpHeaders();
        headers.add("Accept", "*/*");
        headers.add("X-Country", countryCode);
        headers.add("X-Currency", currency);
        headers.add("Authorization", "Bearer " + token);
        headers.add("host", hostHeader);
        
        return headers;
    }
    
    
    public static boolean isNullOrEmpty(String value)
    {
        return ((value == null) || value.isEmpty());
    }
    
    public static boolean isNullOrEmpty(Object value)
    {
        return (value == null);
    }
    
    private String generateToken(String countryCode) throws Exception {
        String consumerKey = this.getPropertyValue(countryCode, "consumerKey");
        String consumerSecret = this.getPropertyValue(countryCode, "consumerSecret");
        String tokenURL = this.getPropertyValue(countryCode, "tokenURL");
        
        String reqStr = "{\n" +
                "      \"client_id\": \"" + consumerKey + "\",\n" +
                "      \"client_secret\": \"" + consumerSecret + "\",\n" +
                "      \"grant_type\": \"client_credentials\"\n" +
                "}\n" +
                "  ";
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json");
        headers.add("Accept", "*/*");
        HttpEntity<String> entity = new HttpEntity<>(reqStr, headers);
        try {
            log.info("AIRTEL TOKEN URL: " + tokenURL);
            log.info("Request String: " + reqStr);
            ResponseEntity<String> responseEntity = httpAdapter.httpPost(tokenURL, entity, String.class);
            if (responseEntity != null) {
                String responseBody = responseEntity.getBody();
                log.info("Resp for : " + tokenURL + " Resp dump: \n"  + responseBody);
                com.equitybankgroup.payments.b2c.dto.airtel.TokenResp token = (new Gson()).fromJson(responseBody, com.equitybankgroup.payments.b2c.dto.airtel.TokenResp.class);
                return token.getAccess_token();
            } else {
                log.error("NULL Resp from " + tokenURL);
            }
        } catch (RestClientException e) {
            log.error("RestClientException: " + e.getMessage());
            e.printStackTrace(System.out);
        }
        return null;
    }
    
    
    
   
   private static boolean isHostAvailable(String hostName, int port) {
     try {
       Socket socket = new Socket();
       InetSocketAddress socketAddress = new InetSocketAddress(hostName, port);
       socket.connect(socketAddress, 3000);
       socket.close();
       return true;
     } catch (UnknownHostException unknownHost) {
       System.out.println("isHostAvailable UnknownHostException: " + unknownHost.getMessage());
       return false;
     } catch (IOException e) {
       System.out.println("isHostAvailable IOException: " + e.getMessage());
       e.printStackTrace();
       return false;
     }
   }
   
   public static void printPostHeaders(HttpPost httprequest)
   {
       Header[] headers = httprequest.getAllHeaders();
       System.out.println("########### START PRINT POST REQUEST HEADERS ###########");
       for(Header header : headers)
       {
           System.out.println(header.getName() + " : " + header.getValue());
       }
       System.out.println("########### END PRINT POST REQUEST HEADERS ###########");
   }
   
   public static void printGetHeaders(HttpGet httprequest)
   {
       Header[] headers = httprequest.getAllHeaders();
       System.out.println("########### START PRINT GET REQUEST HEADERS ###########");
       for(Header header : headers)
       {
           System.out.println(header.getName() + " : " + header.getValue());
       }
       System.out.println("########### END PRINT GET REQUEST HEADERS ###########");
   }
   
   public static void printResponseHeaders(HttpResponse httpResponse)
   {
       Header[] headers = httpResponse.getAllHeaders();
       System.out.println("########### START PRINT RESPONSE HEADERS ###########");
       for(Header header : headers)
       {
           System.out.println(header.getName() + " : " + header.getValue());
       }
       System.out.println("########### END PRINT RESPONSE HEADERS ###########");
   }
   
    
    public static String GenerateEncryptedPinFromBase64Key(String publicKeyString, String plainText) throws NoSuchAlgorithmException, InvalidKeySpecException, InvalidKeyException, NoSuchPaddingException, IllegalBlockSizeException, BadPaddingException
    {   
        String encryptedString = RSAUtil.encrypt(plainText, publicKeyString);
        
        System.out.println("Encrypted value: " + encryptedString);

       
        return encryptedString;

    }
    
    public static void main(String[] args) throws NoSuchAlgorithmException, InvalidKeySpecException, InvalidKeyException, NoSuchPaddingException, IllegalBlockSizeException, BadPaddingException {
        System.out.println("FINAL: " + GenerateEncryptedPinFromBase64Key("MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCkq3XbDI1s8Lu7SpUBP+bqOs/MC6PKWz6n/0UkqTiOZqKqaoZClI3BUDTrSIJsrN1Qx7ivBzsaAYfsB0CygSSWay4iyUcnMVEDrNVOJwtWvHxpyWJC5RfKBrweW9b8klFa/CfKRtkK730apy0Kxjg+7fF0tB4O3Ic9Gxuv4pFkbQIDAQAB"
, "1234"));
    }
    
    /**
     * {
    "data": {
        "transaction": {
            "reference_id": "18*****3354",
            "airtel_money_id": "partner-AB***41",
            "id": "AB***41",
            "status": "TS"
        }
    },
    "status": {
        "code": "200",
        "message": "Trans.ID :  CI2***02. You have sent ***** to 99****39, B****MA . Your available balance is ** 5**.21.",
        "result_code": "ESB000010",
        "response_code": "DP00900001001",
        "success": true
    }
}
* 
* {
    "data": {
        "transaction": {
            "id": "AB***41",
            "message": "Your Request is submitted Successfully.",
            "status": "TS"
        }
    },
    "status": {
        "code": "200",
        "message": "SUCCESS",
        "result_code": "ESB000010",
        "response_code": "DP00900001001",
        "success": true
    }
}
     */
    
}

