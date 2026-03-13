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
import com.equitybankgroup.payments.b2c.airtel.adapters.LocalDateTimeAdapter;
import com.google.gson.Gson;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClientException;

import com.equitybankgroup.payments.b2c.dto.airtel.AirtelDTO;
import static com.equitybankgroup.payments.b2c.enums.TranStatus.SUCCESS;
import java.util.HashMap;
import java.util.concurrent.Executor;
import jakarta.annotation.PostConstruct;
import org.springframework.context.ApplicationContext;
import com.equitybankgroup.payments.b2c.enums.*;
import com.equitybankgroup.payments.b2c.dto.airtel.*;
import com.equitybankgroup.payments.b2c.dto.input.EazInqRequest;
import com.equitybankgroup.payments.b2c.dto.input.InqResponse;
import com.equitybankgroup.payments.b2c.dto.input.InquireRequest;
import com.equitybankgroup.payments.b2c.dto.namecheck.MobileNumberInquireReq;
import com.equitybankgroup.payments.b2c.model.StatusDetails;
import com.equitybankgroup.payments.b2c.model.TransactionDetails;
import com.equitybankgroup.payments.b2c.repository.TransactionDetailsRepository;
import com.equitybankgroup.payments.b2c.service.business.http.OutboundHttpAdapter;
import com.equitybankgroup.payments.b2c.service.util.MiscUtil;
import com.equitybankgroup.payments.b2c.service.util.StringEncryptor;
import com.google.gson.GsonBuilder;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.env.Environment;

/**
 *
 * @author ronaldcheruiyot
 */
@Service
@Slf4j
public class OpenAPIAirtelBankToWalletService {

    //CD PROPERTIES
    @Value("${airtel.cd.openapi.token.url}")
    String tokenURL;
    @Value("${airtel.cd.openapi.kyc.url}")
    String kycURLcd;
    @Value("${airtel.cd.openapi.disbursement.url}")
    String disbursementURLcd;
    @Value("${airtel.cd.openapi.statusCheck.url}")
    String statusCheckURLcd;
    @Value("${airtel.cd.openapi.token.consumerKey}")
    String encConsumerKeycd;
    @Value("${airtel.cd.openapi.token.consumerSecret}")
    String encConsumerSecretcd;
    @Value("${airtel.cd.openapi.hostHeader}")
    String hostHeadercd;
    @Value("${airtel.cd.openapi.encryption.key}")
    String encryptionKey;

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

    Set<String> profiles = new HashSet<>();

    public String getDisbursementURL(String countryCode) {
        Map<String, String> countryProps = props.get(countryCode);
        if (countryProps != null) {
            return countryProps.get("disbursementURL");
        }
        log.info("Props for country: " + countryCode + " not found!!");
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

    @PostConstruct
    public void init() throws Exception {
        Environment env = this.applicationContext.getEnvironment();
        String[] activeProfiles = env.getActiveProfiles();
        for (String profile : activeProfiles) {
            profiles.add(profile);
            if (profile.equalsIgnoreCase("local")) {
                isLocal = true;
            }
        }

        if (profiles.contains("prod")) {
            encryptionKey = StringEncryptor.jasyptDecrypt(applicationContext, encryptionKey);
            System.out.println("[CD]encryptionKey decrypted successfully!");
            encConsumerKeycd = StringEncryptor.decrypt(encConsumerKeycd, encryptionKey);
            System.out.println("[CD]encConsumerKeycd decrypted successfully!");
            encConsumerSecretcd = StringEncryptor.decrypt(encConsumerSecretcd, encryptionKey);
            System.out.println("[CD]encConsumerSecretcd decrypted successfully!");
        }

        //CD
        Map<String, String> cdProps = new HashMap<>();
        cdProps.put("consumerKey", encConsumerKeycd);
        cdProps.put("consumerSecret", encConsumerSecretcd.trim());
        cdProps.put("disbursementURL", disbursementURLcd);
        cdProps.put("statusCheckURL", statusCheckURLcd);
        cdProps.put("currency", "CDF");
        cdProps.put("hostHeader", hostHeadercd);
        cdProps.put("kycURL", kycURLcd);
        props.put("CD", cdProps);

    }

    public AirtelDTO sendTransaction(EazInqRequest inqRequest, String countryCode, InqResponse rs) {
        JDBCService jdbcService = (JDBCService) this.applicationContext.getBean(JDBCService.class);
        StatusDetails record = jdbcService.getB2cTransactionsByRrn(inqRequest.getEazzycash().getRrn());
        String rrn = inqRequest.getEazzycash().getRrn();
        String amount = inqRequest.getEazzycash().getAmount();
        if (record == null) {
            if (!isLocal) {
                log.info(rrn + "|B2C record Not found!!");
                return new AirtelDTO(-1, null, "B2C record Not found!!", null);
            }
            record = getStatusDetails(amount, rrn);
        }
        try {
            Airtelb2cResponse response = postTransaction(inqRequest, countryCode, rs);
            String resultCode = (String) response.getAditionalData().get(Airtelb2cOpenApiConstants.AIRTEL_RESPONSE_CODE);
            String telcoMessage = (String) response.getAditionalData().get(Airtelb2cOpenApiConstants.AIRTEL_RESPONSE_MESSAGE);
            if (null == response.getStatus()) {
                return new AirtelDTO(-1, resultCode, null, "Failed");
            } else {
                switch (response.getStatus()) {
                    case SUCCESS:
                        String tranId = (String) response.getAditionalData().get(Airtelb2cOpenApiConstants.AIRTEL_MONEY_ID);
                        record.setTranId(tranId);
                        record.setStatus(TransactionStatus.OK.name());
                        record.setStatusCode(StatusCodes.SUCCESS);
                        record.setStatusMessage(MiscUtil.isNotNullAndNotEmpty(telcoMessage) ? telcoMessage : "Successfully processed.");
                        editTran(record, "1", rrn, "0", jdbcService);
                        return new AirtelDTO(0, tranId, resultCode, telcoMessage);
                    case FAILURE:
                        record.setStatus(TransactionStatus.ERROR.name());
                        record.setStatusCode(MiscUtil.isNotNullAndNotEmpty(resultCode) ? resultCode : StatusCodes.FAILED);
                        record.setStatusMessage(MiscUtil.isNotNullAndNotEmpty(telcoMessage) ? telcoMessage : "Transaction failed.");
                        editTran(record, "-1", rrn, "-1", jdbcService);
                        return new AirtelDTO(-1, null, resultCode, telcoMessage);
                    case TIMEOUT:
                        record.setStatus(TransactionStatus.TIMEOUT.name());
                        record.setStatusCode(StatusCodes.TIMEOUT);
                        record.setStatusMessage(MiscUtil.isNotNullAndNotEmpty(telcoMessage) ? telcoMessage : "Transaction timeout.");
                        editTran(record, "-3", rrn, "-3", jdbcService);
                        return new AirtelDTO(-3, null, null, "Timeout");
                    default:
                        record.setStatus(TransactionStatus.ERROR.name());
                        record.setStatusCode(MiscUtil.isNotNullAndNotEmpty(resultCode) ? resultCode : StatusCodes.FAILED);
                        record.setStatusMessage(MiscUtil.isNotNullAndNotEmpty(telcoMessage) ? telcoMessage : "Transaction failed.");
                        editTran(record, "-1", rrn, "-1", jdbcService);
                        return new AirtelDTO(-1, null, null, "Failed");
                }
            }

        } catch (Exception ex) {
            ex.printStackTrace(System.out);
            return new AirtelDTO(-1, null, null, "Failed");
        }
    }

    public AirtelDTO checkTransactionStatus(InquireRequest inqRequest, String countryCode) {
        JDBCService jdbcService = (JDBCService) this.applicationContext.getBean(JDBCService.class);
        TransactionDetails record = jdbcService.getB2cTransactionDeatilsByRrn(inqRequest.getEazzycash().getRrn(), RequestTypes.B2C);
        StatusDetails statusDetails = jdbcService.getB2cTransactionsByRrn(inqRequest.getEazzycash().getRrn());
        if (record == null) {
            log.info(inqRequest.getEazzycash().getRrn() + "|B2C record Not found!!");
            return new AirtelDTO(-1, null, "B2C record Not found!!", null);
        }
        if (statusDetails == null) {
            log.info(inqRequest.getEazzycash().getRrn() + "|B2C status details record Not found!!");
            return new AirtelDTO(-1, null, "B2C status details Not found!!", null);
        }
        String rrn = inqRequest.getEazzycash().getRrn();
        try {
            Airtelb2cResponse response = statusCheck(rrn, countryCode, record.getSenderCurrency());
            String resultCode = (String) response.getAditionalData().get(Airtelb2cOpenApiConstants.AIRTEL_RESPONSE_CODE);
            String telcoMessage = (String) response.getAditionalData().get(Airtelb2cOpenApiConstants.AIRTEL_RESPONSE_MESSAGE);
            if (null == response.getStatus()) {
                return new AirtelDTO(-1, resultCode, null, "Failed");
            } else {
                switch (response.getStatus()) {
                    case SUCCESS:
                        String tranId = (String) response.getAditionalData().get(Airtelb2cOpenApiConstants.AIRTEL_MONEY_ID);
                        statusDetails.setTranId(tranId);
                        statusDetails.setStatus(TransactionStatus.OK.name());
                        statusDetails.setStatusCode(StatusCodes.SUCCESS);
                        statusDetails.setStatusMessage(MiscUtil.isNotNullAndNotEmpty(telcoMessage) ? telcoMessage : "Successfully processed.");
                        editTran(statusDetails, "1", rrn, "0", jdbcService);
                        return new AirtelDTO(0, tranId, resultCode, telcoMessage);
                    case FAILURE:
                        statusDetails.setStatus(TransactionStatus.ERROR.name());
                        statusDetails.setStatusCode(MiscUtil.isNotNullAndNotEmpty(resultCode) ? resultCode : StatusCodes.FAILED);
                        statusDetails.setStatusMessage(MiscUtil.isNotNullAndNotEmpty(telcoMessage) ? telcoMessage : "Transaction failed.");
                        editTran(statusDetails, "-1", rrn, "-1", jdbcService);
                        return new AirtelDTO(-1, null, resultCode, telcoMessage);
                    case TIMEOUT:
                        statusDetails.setStatus(TransactionStatus.TIMEOUT.name());
                        statusDetails.setStatusCode(StatusCodes.TIMEOUT);
                        statusDetails.setStatusMessage(MiscUtil.isNotNullAndNotEmpty(telcoMessage) ? telcoMessage : "Transaction timeout.");
                        editTran(statusDetails, "-3", rrn, "-3", jdbcService);
                        return new AirtelDTO(-3, null, null, "Timeout");
                    default:
                        statusDetails.setStatus(TransactionStatus.ERROR.name());
                        statusDetails.setStatusCode(MiscUtil.isNotNullAndNotEmpty(resultCode) ? resultCode : StatusCodes.FAILED);
                        statusDetails.setStatusMessage(MiscUtil.isNotNullAndNotEmpty(telcoMessage) ? telcoMessage : "Transaction failed.");
                        editTran(statusDetails, "-1", rrn, "-1", jdbcService);
                        return new AirtelDTO(-1, null, null, "Failed");
                }
            }

        } catch (Exception ex) {
            ex.printStackTrace(System.out);
            return new AirtelDTO(-1, null, null, "Failed");
        }
    }

    public void editTran(StatusDetails record, String status1, String rrn, String status2, JDBCService jdbcService) {
        try {
            if (record != null) {
//                System.out.println("***** On save status details:");
//                Gson gson = new GsonBuilder()
//                        .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
//                        .create();
//                System.out.println(gson.toJson(record));
                jdbcService.editB2cTransactions(record, status1, rrn, status2);
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.out);
        }
    }

    public Airtelb2cResponse nameCheck(MobileNumberInquireReq inqRequest, String countryCode, String currency) throws Exception {

        if (isNullOrEmpty(inqRequest)) {
            throw new IllegalArgumentException("INVALID REQUEST!!");
        }

        Airtelb2cResponse response = new Airtelb2cResponse();
        String msisdn = inqRequest.getMobileNumber();
        msisdn = msisdn.substring(Math.max(0, msisdn.length() - 9));
        if (isNullOrEmpty(msisdn)) {
            throw new IllegalArgumentException("MSISDN cannot be null or empty");
        }
        String kycURL = this.getPropertyValue(countryCode, "kycURL");

        String responseStr = httpAdapter.httpGet(kycURL + "/" + msisdn, getGenericHeaders(countryCode, currency));
        if (isNullOrEmpty(responseStr)) {
            log.error("Partner returned null or empty response!!");
            response.setStatus(TranStatus.FAILURE);
            response.setMessage("Partner returned null or empty response!!");
            return response;
        }

        NameCheckResponse ncResponse = (new Gson()).fromJson(responseStr, NameCheckResponse.class);
        if (isNullOrEmpty(ncResponse)) {
            log.error("Could not deserialize partner response!!");
            response.setStatus(TranStatus.FAILURE);
            response.setMessage("Could not deserialize partner response!!");
            return response;
        }

        Status status = ncResponse.getStatus();
        CustomerData data = ncResponse.getData();
        String code = status.getCode();
        String message = status.getMessage();
        String resultCode = status.getResult_code();
        boolean success = status.isSuccess();

        if (isNullOrEmpty(status) || isNullOrEmpty(code) || isNullOrEmpty(message) || isNullOrEmpty(resultCode) || isNullOrEmpty(data)) {
            log.error("One or more response code parameters is missing!!");
            response.setStatus(TranStatus.FAILURE);
            response.setMessage("One or more response code parameters is missing!!");
            return response;
        }

        if (code.equalsIgnoreCase("200") && message.equalsIgnoreCase("SUCCESS") && resultCode.equalsIgnoreCase("ESB000010") && success) {
            response.setStatus(TranStatus.SUCCESS);
            response.setMessage("Succesfully processed");
            log.info("Succesfully processed");
            Map<String, Object> aditionalData = new HashMap<>();
            aditionalData.put(Airtelb2cOpenApiConstants.CUSTOMER_FIRST_NAME, data.getFirst_name());
            aditionalData.put(Airtelb2cOpenApiConstants.CUSTOMER_LAST_NAME, data.getLast_name());
            aditionalData.put(Airtelb2cOpenApiConstants.AIRTEL_MONEY_IS_BARRED, data.getIs_barred());
            aditionalData.put(Airtelb2cOpenApiConstants.AIRTEL_MONEY_IS_PIN_RESET, data.getIs_pin_set());
            aditionalData.put(Airtelb2cOpenApiConstants.AIRTEL_MONEY_GRADE, data.getGrade());
            response.setAditionalData(aditionalData);
            return response;
        }
        log.error("Namecheck failed!");
        response.setStatus(TranStatus.FAILURE);
        response.setMessage("Namecheck failed!");
        return response;

    }

    public Airtelb2cResponse postTransaction(EazInqRequest inqRequest, String countryCode, InqResponse rs) throws Exception {

        Airtelb2cResponse response = new Airtelb2cResponse();

        final String rrn = inqRequest.getEazzycash().getRrn();

        String msisdn = inqRequest.getEazzycash().getNumber();

        if (isNullOrEmpty(msisdn)) {
            response.setStatus(TranStatus.TIMEOUT);
            response.setMessage("INVALID MSISDN!!");
            return response;
        }

        msisdn = msisdn.substring(Math.max(0, msisdn.length() - 9));

        PayeeRequest payee = new PayeeRequest(msisdn);

        Transaction transaction = new Transaction(inqRequest.getEazzycash().getRrn(), String.valueOf(inqRequest.getEazzycash().getAmount()), payee);

        Bank2WalletRequest disbursementRequest = new Bank2WalletRequest(transaction, "Bank initiated bank to wallet transfer");

        String requestStr = (new Gson()).toJson(disbursementRequest);

        HttpHeaders headers = getGenericHeaders(countryCode, inqRequest.getEazzycash().getCurrency());

        headers.add("Content-Type", "application/json");

        String disbursementURL = this.getPropertyValue(countryCode, "disbursementURL");
        MiscUtil.printHeaders(headers, "CD", "transaction");
        String responseStr = httpAdapter.httpPost(disbursementURL, headers, requestStr);

        if (isNullOrEmpty(responseStr)) {
            response.setAditionalData(new HashMap<>());
            response.setStatus(TranStatus.TIMEOUT);
            response.setMessage("Partner returned null or empty response!!");
            return response;
        }

        AllocationResponse dsResponse = (new Gson()).fromJson(responseStr, AllocationResponse.class);

        log.info(rrn + "|Deserialized dsResponse: " + (new Gson()).toJson(dsResponse));

        if (isNullOrEmpty(dsResponse)) {
            log.info(rrn + "|Could not deserialize partner response!!");
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

        if (MiscUtil.isNotNullAndNotEmpty(responseCode)) {
            aditionalData.put(Airtelb2cOpenApiConstants.AIRTEL_RESPONSE_CODE, responseCode);
        }

        if (MiscUtil.isNotNullAndNotEmpty(message)) {
            aditionalData.put(Airtelb2cOpenApiConstants.AIRTEL_RESPONSE_MESSAGE, message);
        }

        String tranMessage = null;

        if ((data != null) && (data.getTransaction() != null)) {
            tranMessage = data.getTransaction().getMessage();
        }

        if (MiscUtil.isNotNullAndNotEmpty(tranMessage)) {
            aditionalData.put(Airtelb2cOpenApiConstants.AIRTEL_RESPONSE_MESSAGE, tranMessage);
        }

        boolean success = status.isSuccess();

        log.info(rrn + "|CODE: " + code);
        log.info(rrn + "|MESSAGE: " + message);
        log.info(rrn + "|RESPONSE MESSAGE: " + tranMessage);
        log.info(rrn + "|RESPONSE_CODE: " + responseCode);
        log.info(rrn + "|SUCCESS: " + success);

//        taskExecutor.execute(() -> {
//            try {
//                statusCheck(rrn, countryCode);
//            } catch (Exception ex) {
//                ex.printStackTrace(System.out);
//            }
//        });
        if (isNullOrEmpty(status) || isNullOrEmpty(code) || isNullOrEmpty(message) || isNullOrEmpty(responseCode) || (isNullOrEmpty(data))) {
            log.info(rrn + "|One or more response code parameters is missing!!");
            response.setAditionalData(aditionalData);
            response.setStatus(TranStatus.FAILURE);
            response.setMessage((MiscUtil.isNotNullAndNotEmpty(message)) ? message : "One or more response code parameters is missing!!");
            return response;
        }

        String referenceId = data.getTransaction().getReference_id();
        log.info(rrn + "|AIRTEL REFERENCE: " + referenceId);

        if (code.equalsIgnoreCase("200") && responseCode.equalsIgnoreCase("DP02100001000") && success && MiscUtil.isNotNullAndNotEmpty(message) && message.toUpperCase().contains("AMBIGUOUS")) {
            log.info(rrn + "|AMBIGUOUS Response!!");
            response.setAditionalData(aditionalData);
            response.setStatus(TranStatus.TIMEOUT);
            response.setMessage("AMBIGUOUS Response!!");
            return response;
        }

        if (code.equalsIgnoreCase("200") && responseCode.equalsIgnoreCase("DP02100001001") && success) {
            log.info(rrn + "|Succesfully processed");
            response.setStatus(TranStatus.SUCCESS);
            response.setMessage("Succesfully processed");
            aditionalData.put(Airtelb2cOpenApiConstants.REFERENCE_ID, referenceId);
            aditionalData.put(Airtelb2cOpenApiConstants.AIRTEL_MONEY_ID, referenceId);
            response.setAditionalData(aditionalData);
            return response;
        }

        response.setAditionalData(aditionalData);
        response.setStatus(TranStatus.FAILURE);
        log.info(rrn + "|Allocation failed!");
        response.setMessage((MiscUtil.isNotNullAndNotEmpty(message)) ? message : "Allocation failed!");
        return response;

    }

    public Airtelb2cResponse statusCheck(String id, String countryCode, String currency) throws Exception {
        String rrn = id;
        Airtelb2cResponse response = new Airtelb2cResponse();
        HttpHeaders headers = getGenericHeaders(countryCode, currency);
        String statusCheckURL = this.getPropertyValue(countryCode, "statusCheckURL");
        String responseStr = httpAdapter.httpGet(statusCheckURL + "/" + id, headers);

        if (isNullOrEmpty(responseStr)) {
            response.setAditionalData(new HashMap<>());
            response.setStatus(TranStatus.TIMEOUT);
            response.setMessage("Partner returned null or empty response!!");
            return response;
        }

        AllocationResponse dsResponse = (new Gson()).fromJson(responseStr, AllocationResponse.class);

        log.info(rrn + "|Deserialized dsResponse: " + (new Gson()).toJson(dsResponse));

        if (isNullOrEmpty(dsResponse)) {
            log.info(rrn + "|Could not deserialize partner response!!");
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

        if (MiscUtil.isNotNullAndNotEmpty(responseCode)) {
            aditionalData.put(Airtelb2cOpenApiConstants.AIRTEL_RESPONSE_CODE, responseCode);
        }

        if (MiscUtil.isNotNullAndNotEmpty(message)) {
            aditionalData.put(Airtelb2cOpenApiConstants.AIRTEL_RESPONSE_MESSAGE, message);
        }

        boolean success = status.isSuccess();

        log.info(rrn + "|CODE: " + code);
        log.info(rrn + "|MESSAGE: " + message);
        log.info(rrn + "|RESPONSE_CODE: " + responseCode);
        log.info(rrn + "|SUCCESS: " + success);

        if (isNullOrEmpty(status) || isNullOrEmpty(code) || isNullOrEmpty(message) || isNullOrEmpty(responseCode) || (isNullOrEmpty(data))) {
            log.info(rrn + "|One or more response code parameters is missing!!");
            response.setAditionalData(aditionalData);
            response.setStatus(TranStatus.FAILURE);
            response.setMessage((MiscUtil.isNotNullAndNotEmpty(message)) ? message : "One or more response code parameters is missing!!");
            return response;
        }

        String referenceId = data.getTransaction().getReference_id();
        log.info(rrn + "|AIRTEL REFERENCE: " + referenceId);

        if (code.equalsIgnoreCase("200") && responseCode.equalsIgnoreCase("DP02100001000") && success && MiscUtil.isNotNullAndNotEmpty(message) && message.toUpperCase().contains("AMBIGUOUS")) {
            log.info(rrn + "|AMBIGUOUS Response!!");
            response.setAditionalData(aditionalData);
            response.setStatus(TranStatus.TIMEOUT);
            response.setMessage("AMBIGUOUS Response!!");
            return response;
        }

        if (code.equalsIgnoreCase("200") && responseCode.equalsIgnoreCase("DP02100001001") && success) {
            log.info(rrn + "|Succesfully processed");
            response.setStatus(TranStatus.SUCCESS);
            response.setMessage("Succesfully processed");
            aditionalData.put(Airtelb2cOpenApiConstants.REFERENCE_ID, referenceId);
            aditionalData.put(Airtelb2cOpenApiConstants.AIRTEL_MONEY_ID, referenceId);
            response.setAditionalData(aditionalData);
            return response;
        }

        response.setAditionalData(aditionalData);
        response.setStatus(TranStatus.FAILURE);
        log.info(rrn + "|Transaction failed!");
        response.setMessage((MiscUtil.isNotNullAndNotEmpty(message)) ? message : "Transaction failed!");
        return response;

    }

    private HttpHeaders getGenericHeaders(String countryCode, String currency) throws Exception {
        String token = generateToken(countryCode);

        if (isNullOrEmpty(token)) {
            throw new Exception("Could not generate token!!");
        }

        if (isNullOrEmpty(currency)) {
            throw new Exception("Currency cannot be null or empty!!");
        }

        if (!currency.equalsIgnoreCase("CDF") && !currency.equalsIgnoreCase("USD")) {
            throw new Exception("Invalid currency!!");
        }

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

    public static boolean isNullOrEmpty(String value) {
        return ((value == null) || value.isEmpty());
    }

    public static boolean isNullOrEmpty(Object value) {
        return (value == null);
    }

    private String generateToken(String countryCode) throws Exception {
        String consumerKey = this.getPropertyValue(countryCode, "consumerKey");
        String consumerSecret = this.getPropertyValue(countryCode, "consumerSecret");
        String hostHeader = this.getPropertyValue(countryCode, "hostHeader");

        String reqStr = "{\n"
                + "      \"client_id\": \"" + consumerKey + "\",\n"
                + "      \"client_secret\": \"" + consumerSecret + "\",\n"
                + "      \"grant_type\": \"client_credentials\"\n"
                + "}\n"
                + "  ";
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/json");
        headers.add("Accept", "*/*");
        HttpEntity<String> entity = new HttpEntity<>(reqStr, headers);
        try {
            log.info("AIRTEL UG TOKEN URL: " + tokenURL);
            log.info("Request String: " + reqStr);
            ResponseEntity responseEntity = httpAdapter.httpPost(tokenURL, entity, TokenResp.class);
            if (responseEntity != null) {
                log.info("Resp for : " + tokenURL + " Resp dump: \n" + (new Gson()).toJson(responseEntity.getBody()));
                TokenResp token = (TokenResp) responseEntity.getBody();
                return token.getAccess_token();
            } else {
                log.info("NULL Resp from " + tokenURL);
            }
        } catch (RestClientException e) {
            log.info("RestClientException: " + e.getMessage());
            e.printStackTrace(System.out);
        }
        return null;
    }

    private StatusDetails getStatusDetails(String amount, String rrn) {
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

    /**
     * {
     * "data": { "transaction": { "reference_id": "18*****3354",
     * "airtel_money_id": "partner-AB***41", "id": "AB***41", "status": "TS" }
     * }, "status": { "code": "200", "message": "Trans.ID : CI2***02. You have
     * sent ***** to 99****39, B****MA . Your available balance is ** 5**.21.",
     * "result_code": "ESB000010", "response_code": "DP00900001001", "success":
     * true } }
     *
     * {
     * "data": { "transaction": { "id": "AB***41", "message": "Your Request is
     * submitted Successfully.", "status": "TS" } }, "status": { "code": "200",
     * "message": "SUCCESS", "result_code": "ESB000010", "response_code":
     * "DP00900001001", "success": true } }
     */
}
