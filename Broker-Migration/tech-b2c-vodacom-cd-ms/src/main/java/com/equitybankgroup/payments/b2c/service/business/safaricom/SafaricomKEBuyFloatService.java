/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.service.business.safaricom;

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
import com.equitybankgroup.payments.b2c.dto.vodacom.constants.SafaricomB2BConstants;
import com.equitybankgroup.payments.b2c.dto.vodacom.constants.StatusCodes;
import com.equitybankgroup.payments.b2c.model.StatusDetails;
import com.equitybankgroup.payments.b2c.model.TransactionDetails;
import com.equitybankgroup.payments.b2c.repository.TransactionDetailsRepository;
import com.equitybankgroup.payments.b2c.service.business.JDBCService;
import com.equitybankgroup.payments.b2c.service.business.http.OutboundHttpAdapter;
import com.equitybankgroup.payments.b2c.service.cache.CacheService;
import com.equitybankgroup.payments.b2c.service.util.MiscUtil;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.annotation.PostConstruct;
import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.security.KeyFactory;
import java.security.MessageDigest;
import java.security.PublicKey;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;
import java.util.concurrent.ExecutionException;
import javax.crypto.Cipher;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.env.Environment;

/**
 *
 * @author ronaldcheruiyot
 */
@Service
@Slf4j
public class SafaricomKEBuyFloatService {

    @Value("${safaricom.ke.b2b.checkSum}")
    String checkSum;
    @Value("${safaricom.ke.b2b.shortCode}")
    String shortCode;
    @Value("${safaricom.ke.b2b.password}")
    String password;
    @Value("${safaricom.ke.b2b.queueTimeoutURL}")
    String queueTimeoutURL;
    @Value("${safaricom.ke.b2b.resultURL}")
    String resultURL;
    @Value("${safaricom.ke.b2b.securityCredentialPublicKey}")
    String securityCredentialPublicKey;
    @Value("${safaricom.ke.b2b.serviceId}")
    String serviceId;
    @Value("${safaricom.ke.b2b.spId}")
    String spId;
    @Value("${safaricom.ke.b2b.spPassword}")
    String spPassword;
    @Value("${safaricom.ke.b2b.thirdPartyID}")
    String thirdPartyID;
    @Value("${safaricom.ke.b2b.username}")
    String username;
    @Value("${safaricom.ke.b2b.debitPartyShortCode}")
    String debitPartyShortCode;

    @Value("${safaricom.ke.b2b.requestURL}")
    String requestURL;

    @Value("${safaricom.ke.b2b.callbackWaitingTime}")
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

    public VodacomDTO sendTransaction(EazInqRequest inqRequest, String countryCode, InqResponse rs) {
        JDBCService jdbcService = (JDBCService) this.applicationContext.getBean(JDBCService.class);
        StatusDetails record = jdbcService.getB2cTransactionsByRrn(inqRequest.getEazzycash().getRrn());
        String rrn = inqRequest.getEazzycash().getRrn();
        Long amount = inqRequest.getEazzycash().getAmount();
        if (record == null) {
            if (!isLocal) {
                System.out.println("B2C record Not found!!");
                return new VodacomDTO(-1, null, null, "B2C record Not found!!");
            }
            record = getStatusDetails(amount, rrn);
        }
        String originatorConversationID = getOriginatorConversationID(this.shortCode, rrn);
        Map<String, String> map = new HashMap<>();
        map.put("statusCode", StatusCodes.INITIALIZED);
        cacheService.insretFromMainThread(originatorConversationID, map);
        //@TODO, what if insert fails?

        try {
            Vodacomb2cResponse response = postTransaction(inqRequest, countryCode, rs, originatorConversationID);
            System.out.println("response.getStatus(): " + response.getStatus().name());
            String resultCode = (String) response.getAditionalData().get(SafaricomB2BConstants.B2B_DISBURSEMENT_RESPONSE_CODE);
            String telcoMessage = (String) response.getAditionalData().get(SafaricomB2BConstants.B2B_DISBURSEMENT_RESPONSE_DESC);
            if (MiscUtil.isNullOrEmpty(telcoMessage)) {
                telcoMessage = response.getMessage();
            }
            if (null == response.getStatus()) {
                return new VodacomDTO(-1, null, resultCode, !MiscUtil.isNullOrEmpty(telcoMessage) ? telcoMessage : "Failed");
            } else {
                switch (response.getStatus()) {
                    case SUCCESS: {
                        System.out.println("in SUCCESS: ");
                        return checkStatus(originatorConversationID, record, jdbcService, response);
                    }
                    case FAILURE: {
                        record.setStatusCode(StatusCodes.FAILED);
                        record.setStatus(TransactionStatus.ERROR.name());
                        record.setStatusMessage(response.getMessage());
                        editTran(record, "-1", rrn, "-1", jdbcService);
                        return new VodacomDTO(-1, null, resultCode, !MiscUtil.isNullOrEmpty(telcoMessage) ? telcoMessage : "Failed");
                    }
                    case TIMEOUT: {
                        record.setStatusCode(StatusCodes.TIMEOUT);
                        record.setStatus(TransactionStatus.TIMEOUT.name());
                        record.setStatusMessage(response.getMessage());
                        editTran(record, "-3", rrn, "-3", jdbcService);
                        return new VodacomDTO(-3, null, resultCode, !MiscUtil.isNullOrEmpty(telcoMessage) ? telcoMessage : "Timeout");
                    }
                    default: {
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

    public VodacomDTO checkStatus(String originatorConversationID, StatusDetails record, JDBCService jdbcService, Vodacomb2cResponse response) {
        String rrn = extractRRN(originatorConversationID);
        try {
            cacheService.waitForUpdate(originatorConversationID, Long.parseLong(b2bCallbackWaitingTime), TimeUnit.SECONDS);
            Map<String, String> map = cacheService.retrieveObject(originatorConversationID);

            if (map == null) {
                System.out.println("Cache miss on fetching result.");
                return new VodacomDTO(-1, null, StatusCodes.PENDING, "Pending");
            }

            
            String statusCode = map.get("statusCode");
            String statusDesc = map.get("statusDesc");
            String tranId = map.get("tranId");
            log.info(rrn + "|statusCode from cache: " + statusCode);
            log.info(rrn + "|tranId: " + tranId);
            log.info(rrn + "|statusCode from cache: " + statusCode);
            log.info(rrn + "|tranId: " + tranId);
            if (statusCode == null) {
                System.out.println(rrn + "|B2B record Not found!!");
                return new VodacomDTO(-1, null, null, "B2B record Not found!!");
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
                record.setStatusMessage(response.getMessage());
                editTran(record, "-1", rrn, "-1", jdbcService);
                return new VodacomDTO(-1, null, statusCode, !MiscUtil.isNullOrEmpty(statusDesc) ? statusDesc : "Failed");
            }

        } catch (InterruptedException | ExecutionException ex) {
            Logger.getLogger(SafaricomKEBuyFloatService.class.getName()).log(Level.SEVERE, null, ex);
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

    public Vodacomb2cResponse postTransaction(EazInqRequest inqRequest, String countryCode, InqResponse rs, String originatorConversationID) throws Exception {

        Vodacomb2cResponse response = new Vodacomb2cResponse();

        final String rrn = inqRequest.getEazzycash().getRrn();

        String tillNumber = inqRequest.getEazzycash().getNumber();

        String amount = String.valueOf(inqRequest.getEazzycash().getAmount());

        String storeNumber = inqRequest.getEazzycash().getStoreNumber();

        if (MiscUtil.isNullOrEmpty(tillNumber)) {
            response.setStatus(TranStatus.TIMEOUT);
            response.setMessage("INVALID TILL NUMBER!!");
            return response;
        }

        String requestStr = getB2BSoapRequest(amount, storeNumber, tillNumber, originatorConversationID, originatorConversationID);

        HttpHeaders headers = new HttpHeaders();

        headers.add("Content-Type", "text/xml");

        String responseStr = httpAdapter.httpPost(this.requestURL, headers, requestStr);

        if (MiscUtil.isNullOrEmpty(responseStr)) {
            response.setAditionalData(new HashMap<>());
            response.setStatus(TranStatus.TIMEOUT);
            response.setMessage("Partner returned null or empty response!!");
            return response;
        }

        responseStr = MiscUtil.extractCDATAContents(responseStr);

        Map<String, String> disbValues = MiscUtil.extractAllTagValues(responseStr);

        String serviceStatus = disbValues.get(SafaricomB2BConstants.B2B_DISBURSEMENT_RESPONSE_SERVICE_STATUS);
        String responseCode = disbValues.get(SafaricomB2BConstants.B2B_DISBURSEMENT_RESPONSE_CODE);
        String responseDesc = disbValues.get(SafaricomB2BConstants.B2B_DISBURSEMENT_RESPONSE_DESC);

        System.out.println(rrn + "|serviceStatus: " + serviceStatus);
        System.out.println(rrn + "|responseCode: " + responseCode);
        System.out.println(rrn + "|responseDesc: " + responseDesc);

        Map<String, Object> aditionalData = new HashMap<>();

        if (MiscUtil.isNotNullAndNotEmpty(responseCode)) {
            aditionalData.put(SafaricomB2BConstants.B2B_DISBURSEMENT_RESPONSE_CODE, responseCode);
        }

        if (MiscUtil.isNotNullAndNotEmpty(responseDesc)) {
            aditionalData.put(SafaricomB2BConstants.B2B_DISBURSEMENT_RESPONSE_DESC, responseDesc);
        }

        if (serviceStatus.equalsIgnoreCase("0")) {
            System.out.println("Succesfully initiated");
            response.setTranId(originatorConversationID);
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

    private String getB2BSoapRequest(String amount, String storeNumber, String tillNumber, String originatorConversationID, String conversationID) throws NoSuchAlgorithmException, InvalidKeyException, NoSuchPaddingException, UnsupportedEncodingException, InvalidKeySpecException, IllegalBlockSizeException, BadPaddingException {
        B2BRequest b2bRequest
                = B2BRequest.builder().amount(amount)
                        .checkSum(this.checkSum)
                        .originatorConversationID(originatorConversationID)
                        .conversationID(conversationID)
                        .password(this.password)
                        .queueTimeoutURL(this.queueTimeoutURL)
                        .resultURL(this.resultURL)
                        .securityCredential(getSecurityCredential(this.securityCredentialPublicKey, this.password))
                        .serviceId(this.serviceId)
                        .shortCode(storeNumber)
                        .spId(this.spId)
                        .spPassword(this.spPassword)
                        .thirdPartyID(this.thirdPartyID)
                        .username(this.username)
                        .debitPartyShortCode(this.debitPartyShortCode)
                        .receiverPartyShortCode(tillNumber)
                        .build();
        return b2bRequest.getSoapRequest();
    }

    private static String getOriginatorConversationID(String shortCode, String rrn) {
        return shortCode + "_" + "EQTOrg_" + MiscUtil.generateRandomRRN(12);
    }

    private static String extractRRN(String originatorConversationID) {
        int lastUnderscore = originatorConversationID.lastIndexOf('_');
        if (lastUnderscore != -1) {
            return originatorConversationID.substring(lastUnderscore + 1);
        }
        return originatorConversationID;
    }

    private static String getSecurityCredential(String securityCredentialPublicKey, String password) throws InvalidKeyException, NoSuchAlgorithmException, NoSuchPaddingException, UnsupportedEncodingException, InvalidKeySpecException, IllegalBlockSizeException, BadPaddingException {
        // Step 1: Decode base64 public key
        securityCredentialPublicKey = securityCredentialPublicKey.replaceAll("-----BEGIN PUBLIC KEY-----", "");
        securityCredentialPublicKey = securityCredentialPublicKey.replaceAll("-----END PUBLIC KEY-----", "");
        byte[] keyBytes = Base64.getDecoder().decode(securityCredentialPublicKey);
        X509EncodedKeySpec keySpec = new X509EncodedKeySpec(keyBytes);

        // Step 2: Generate RSA public key
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
        PublicKey publicKey = keyFactory.generatePublic(keySpec);

        // Step 3: Encrypt password using RSA with PKCS#1.5 padding
        Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding"); // Not OAEP
        cipher.init(Cipher.ENCRYPT_MODE, publicKey);
        byte[] encryptedBytes = cipher.doFinal(password.getBytes("UTF-8"));

        // Step 4: Encode to Base64 and return
        return Base64.getEncoder().encodeToString(encryptedBytes);
    }

    private StatusDetails getStatusDetails(Long amount, String rrn) {
        TransactionDetails details = new TransactionDetails();
        details.setAmount(BigDecimal.valueOf(amount));
        details.setBankId("54");
        details.setChannel("OMNI");
        details.setClientType("Customer");
        details.setRrn(rrn);
        details.setTelcoName("SAFARICOM-KE");
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

    public static void main(String[] args) throws NoSuchAlgorithmException, InvalidKeySpecException, InvalidKeyException, NoSuchPaddingException, IllegalBlockSizeException, BadPaddingException, UnsupportedEncodingException {
        B2BRequest b2bRequest
                = B2BRequest.builder().amount("100")
                        .checkSum("CheckSum0")
                        .originatorConversationID("459xxxxxxxxxxxxxxxxxxxxxxxxxxxx6")
                        .password("Password0")
                        .queueTimeoutURL("http://10.66.49.789:7888/new")
                        .resultURL("ResultURL0")
                        .securityCredential("SecurityCredential0xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx==")
                        .serviceId("35000001000009")
                        .shortCode("100003")
                        .spId("35000011")
                        .spPassword("Safaricom123!")
                        .thirdPartyID("broker_4")
                        .username("username")
                        .debitPartyShortCode("100001")
                        .receiverPartyShortCode("100002")
                        .build();
        System.out.println(b2bRequest.getSoapRequest());

        String publicKey = "-----BEGIN PUBLIC KEY-----MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA8rM5lxew7fQsdEsQWhwI0iwE45YioA/2BGvURO2+I5sB/q7EYrBWypmkmuX/dkx5yKh2m6sLDIDV/4LH7IHzGpKDiNxyA2Y2hRNsYtYYNiVmMZdyDd89r4fY+MuwLs5UK4o0Cd7nInMgUlCXSMTiEGtGYOTGW81gH6ZVWTL83HKu/F3VKHLSG1qcVGuXQiBlm1s4JxWkaSrN8DOPs2HnlcOJP37VE+2Evb1ewRaO4/qEbrYaV+6B0CySNwkYoRnnfDjOosQD+ewVik3aBqVnwVqX+0MrPhlRoa3VNGWSYreuM2xpQagpqol5EJB23GIIXG7QQbwQVHrt5J4u9S3Z7wIDAQAB-----END PUBLIC KEY-----";

        System.out.println(getSecurityCredential(publicKey, "1234567"));
    }

}
