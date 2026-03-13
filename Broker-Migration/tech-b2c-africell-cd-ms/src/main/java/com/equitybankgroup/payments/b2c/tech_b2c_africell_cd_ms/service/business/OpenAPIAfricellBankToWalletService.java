/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.service.business;

import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.constants.TPGConstants;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.dto.africell.*;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.dto.input.*;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.enums.TransactionStatus;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.model.TransactionDetails;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.service.business.http.OutboundHttpAdapter;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.service.util.MiscUtil;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.service.util.RSAUtil;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.service.util.XMLStringifier;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.google.gson.Gson;
import jakarta.annotation.PostConstruct;
import jakarta.xml.bind.DatatypeConverter;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.StatusLine;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.NoopHostnameVerifier;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.ssl.SSLContextBuilder;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationContext;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.net.ssl.SSLContext;
import java.security.InvalidKeyException;
import java.security.KeyManagementException;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.security.spec.InvalidKeySpecException;
import java.util.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class OpenAPIAfricellBankToWalletService {

    private static final Logger logger = LoggerFactory.getLogger(OpenAPIAfricellBankToWalletService.class);
    
    private final RegistrationService registrationService;
    
    private final OutboundHttpAdapter httpAdapter;
    
    private final ApplicationContext applicationContext;
    
    private final AfricellUtil africellUtil;
    
    @Value("${africell.cd.token.url}")
    private String africellTokenURL;

    @Value("${africell.cd.mock.token}")
    private boolean isMock;
    @Value("${africell.cd.token.url}")
    String tokenURL;

    @Value("${africell.cd.disbursement.url}")
    String disbursementURLcd;

    @Value("${africell.cd.token.url}")
    String tokenURLcd;
    
    @Value("${africell.cd.b2c.bankAccounNumber}")
    String bankAccounNumber;
    
    @Value("${africell.cd.b2c.registrationEnabled}")
    String registrationEnabled;
    
    
    @Value("${africell.cd.airtime.url}")
    private String airtimeURL;

    @Value("${africell.cd.token.consumerKey}")
    private String consumerKey;
    @Value("${africell.cd.token.consumerSecret}")
    private String consumerSecret;
    @Value("${africell.cd.userID}")
    private String userId;
    @Value("${africell.cd.username}")
    private String username;
    @Value("${africell.cd.password}")
    private String password;
    @Value("${africell.cd.airtime.bankId}")
    private String airtimeBankId;
    @Value("${africell.cd.airtime.whiteList}")
    private String airtimeWhitelist;
    @Value("${africell.cd.airtime.useWhiteList}")
    private boolean useWhiteList;
    private final Map<String, Map<String, String>> props = new HashMap<>();
    private final XMLStringifier xmlStringifier = new XMLStringifier();

    public String getPropertyValue(String countryCode, String propName) throws Exception {
        Map<String, String> countryProps = props.get(countryCode.toLowerCase());
        if (countryProps != null) {
            String value = countryProps.get(propName);
            if (value != null && !value.isEmpty()) {
                return value;
            }

            String message = "Value for prop: " + propName + " for country: " + countryCode + " not cannot be null or empty!!";
            logger.info(message);
        }
        String message = "Props for country: " + countryCode + " not found!!";
        logger.info(message);
        throw new Exception(message);
    }

    @PostConstruct
    public void init() throws Exception {
        //CD
        Map<String, String> cdProps = new HashMap<>();
        System.out.println("[cd]consumerKey decrypted successfully!");
        System.out.println("[cd]consumerSecret decrypted successfully!");
//        cdProps.put("consumerSecret", consumerSecretcd);
        cdProps.put("disbursementURL", disbursementURLcd);
//        cdProps.put("statusCheckURL", statusCheckURLcd);
        cdProps.put("currency", "cdF");
        props.put("cd", cdProps);

    }

    public String sendTransaction(EazInqRequest inqRequest, String countryCode, WalletResponse rs) throws JsonProcessingException {
        JDBCService jdbcService = this.applicationContext.getBean(JDBCService.class);
        TransactionDetails record = jdbcService.getB2cTransactionsByRrn(inqRequest.getEazzycash().getRrn());
        String rrn = inqRequest.getEazzycash().getRrn();
        
        if (record == null) {
            logger.error("B2C record Not found!!");

            Eazzycashres eazzycashres = new Eazzycashres();
            eazzycashres.setStatus("ERROR|99");
            eazzycashres.setResponseCode("99");
            eazzycashres.setResponseDesc("Not Found");
            rs.setEazzycashres(eazzycashres);
            String res = xmlStringifier.stringify(rs).replaceAll("WalletResponse", "response");
            String req = xmlStringifier.stringify(inqRequest);
            updateLogDetails(req, res, null, null, TransactionStatus.ERROR.name(), rrn, StatusCodes.FAILED, TransactionStatus.ERROR.getDescription(), null, jdbcService);

            return res;
        }

        try {
            if(Boolean.valueOf(registrationEnabled)) {
                InquireResponse inqResp = registrationService.register(inqRequest);
                if(!inqResp.getEazzycashres().status.startsWith("OK|"))
                {
                    return MiscUtil.objectToStr(inqResp, InquireResponse.class);
                }
            }
            
            AfricellB2CResponse response = postTransaction(inqRequest, countryCode, jdbcService);
            if (response.getStatus() != null && response.getStatus().equals("SUCCEEDED")) {
                rs.setMsgId(rrn);
                Eazzycashres eazzycashres = new Eazzycashres();
                eazzycashres.setWalletTranID(response.getTransactionId());
                eazzycashres.setStatus("OK|" + response.getTransactionId());
                eazzycashres.setResponseCode("00");
                eazzycashres.setResponseDesc(response.getMessage());
                rs.setEazzycashres(eazzycashres);
                String res = xmlStringifier.stringify(rs).replaceAll("WalletResponse", "response");
                String req = xmlStringifier.stringify(inqRequest);
                updateLogDetails(req, res, null, null, TransactionStatus.OK.name(), rrn, StatusCodes.SUCCESS, TransactionStatus.OK.getDescription(), response.getTransactionId(), jdbcService);

                return res;

            }

            rs.setMsgId(rrn);
            Eazzycashres eazzycashres = new Eazzycashres();
            eazzycashres.setStatus("ERROR|-1");
            eazzycashres.setResponseCode("-1");
            rs.setEazzycashres(eazzycashres);
            String res = xmlStringifier.stringify(rs).replaceAll("WalletResponse", "response");
            String req = xmlStringifier.stringify(inqRequest);

            String tranId = null;
            if (response.getTransactionId() != null) {
                tranId = response.getTransactionId();
            }
            updateLogDetails(req, res, null, null, TransactionStatus.ERROR.name(), rrn, StatusCodes.FAILED, TransactionStatus.ERROR.getDescription(), tranId, jdbcService);

            return res;
        } catch (Exception ex) {
            rs.setMsgId(rrn);
            Eazzycashres eazzycashres = new Eazzycashres();
            eazzycashres.setResponseCode("-1");
            eazzycashres.setStatus("ERROR|-1");
            eazzycashres.setResponseDesc(ex.getLocalizedMessage());
            rs.setEazzycashres(eazzycashres);
            String res = xmlStringifier.stringify(rs).replaceAll("WalletResponse", "response");
            String req = xmlStringifier.stringify(inqRequest);
            updateLogDetails(req, res, null, null, TransactionStatus.TIMEOUT.name(), rrn, StatusCodes.TIMEOUT, TransactionStatus.TIMEOUT.getDescription(), null, jdbcService);
            logger.info(ex.getMessage());
            ex.printStackTrace(System.out);
            return res;
        }
    }

    public void updateLogDetails(String request, String response, String telcoReqStr, String telcoRespStr, String status1, String rrn, String status2, String msg, String tranId, JDBCService jdbcService) {
        try {
            jdbcService.updateLogDetails(request, response, telcoReqStr, telcoRespStr, status1, rrn, status2, msg, tranId);
        } catch (Exception ex) {
            logger.error(ex.getMessage());
        }
    }

    public String handleTopUp(Map<String, String> map) throws JsonProcessingException {
        String rrn = map.get(TPGConstants.AIRTIME_REQUEST_RRN);
        JDBCService jdbcService = this.applicationContext.getBean(JDBCService.class);
        AirtimeTelcoResponseDTO airtimeTelcoResponseDTO = handleAirtimeTopupRequest(map, jdbcService);
        AirtimeChannelResponse response = new AirtimeChannelResponse();
        AirtimeChannelResponse.Body body = new AirtimeChannelResponse.Body();
        AirtimeChannelResponse.Body.TopupResponse topupResponse = new AirtimeChannelResponse.Body.TopupResponse();
        String status1;
        String status2;
        String msg;

        if (Objects.isNull(airtimeTelcoResponseDTO)) {
            topupResponse.setReturned("ERROR|-3");
            body.setTopupResponse(topupResponse);
            response.setBody(body);
            status1 = TransactionStatus.TIMEOUT.name();
            msg = StatusCodes.TIMEOUT;
            status2 = TransactionStatus.TIMEOUT.getDescription();
        } else if (airtimeTelcoResponseDTO.getCode().equals("0")) {
            topupResponse.setReturned("OK|" + airtimeTelcoResponseDTO.getAfrTransactionID());
            body.setTopupResponse(topupResponse);
            response.setBody(body);
            status1 = TransactionStatus.OK.name();
            status2 = TransactionStatus.OK.getDescription();
            msg = StatusCodes.SUCCESS;
        } else {
            topupResponse.setReturned("ERROR|02");
            body.setTopupResponse(topupResponse);
            response.setBody(body);
            status1 = TransactionStatus.ERROR.name();
            status2 = TransactionStatus.ERROR.getDescription();
            msg = StatusCodes.FAILED;
        }

        String res = xmlStringifier.stringify(response)
                .replaceAll("Body", "soap:Body")
                .replaceAll("AirtimeChannelResponse", "soap:Envelope")
                .replaceAll("returned", "return");
        String req = map.get(TPGConstants.AIRTIME_ORIGINAL_REQUEST);

        updateLogDetails(req, res, null, null, status1, rrn, status2, msg, null, jdbcService);
        return res;
    }

    private AirtimeTelcoResponseDTO handleAirtimeTopupRequest(Map<String, String> map, JDBCService jdbcService) {
        String mockResponse = "{\"Code\":\"0\",\"Description\":\"Successful\",\"MMTransactionID\":\"1234\",\"AfrTransactionID\":\"1234\"}";
        String msisdnA = map.get(TPGConstants.AIRTIME_REQUEST_MSISDNA);
        String rrn = map.get(TPGConstants.AIRTIME_REQUEST_RRN);
        msisdnA = msisdnA.substring(Math.max(0, msisdnA.length() - 9));    
        msisdnA = "243" + msisdnA;
        AirtimeTelcoRequestDTO airtimeTelcoRequestDTO = AirtimeTelcoRequestDTO.builder()
                .UserID(userId)
                .targetDealerNumber(msisdnA)
                .creditAmount(map.get(TPGConstants.AIRTIME_REQUEST_AMOUNT))
                .SendSMSNotifications("true")
//                .SenderMSISDN(topup.getMsisdnA())              
                .MMTransactionID(map.get(TPGConstants.AIRTIME_REQUEST_RRN))
                .build();
        Gson gson = new Gson();

/*        
{
    "UserID": "*****",
    "targetDealerNumber": "243900590652",
    "creditAmount": "300.0000",
    "SendSMSNotifications": "true",
    "MMTransactionID": "8998471"
}
*/
        try {
            HttpHeaders headers = new HttpHeaders();

            headers.add("Content-Type", "application/json");
            headers.add("UserName", username);
            headers.add("Password", password);

            String requestStr = gson.toJson(airtimeTelcoRequestDTO);
            String responseStr;
            if (!isMock) {
//                if (useWhiteList && !airtimeWhitelist.contains(msisdnA)) {
//                    return AirtimeTelcoResponseDTO.builder()
//                            .Code("9")
//                            .Description("Receiver account cannot be topped up.")
//                            .build();
//                }

                responseStr = httpAdapter.httpPost(airtimeURL, headers, requestStr);
            } else {
                responseStr = mockResponse;
            }

            String req = map.get(TPGConstants.AIRTIME_ORIGINAL_REQUEST);
            AirtimeTelcoResponseDTO airtimeTelcoResponseDTO = gson.fromJson(responseStr, AirtimeTelcoResponseDTO.class);
            updateLogDetails(req, null, requestStr, responseStr, TransactionStatus.PENDING.name(), rrn, StatusCodes.SUCCESS, TransactionStatus.PENDING.getDescription(), airtimeTelcoResponseDTO.getAfrTransactionID(), jdbcService);
            return airtimeTelcoResponseDTO;

        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return null;
    }
    
    public static class HttpClientConfig {

        public static CloseableHttpClient createHttpClient_AcceptsUntrustedCerts() throws Exception {
            SSLContext sslContext = SSLContextBuilder.create()
                    .loadTrustMaterial((chain, authType) -> true)
                    .build();

            SSLConnectionSocketFactory connectionFactory = new SSLConnectionSocketFactory(sslContext, NoopHostnameVerifier.INSTANCE);

            return HttpClients.custom()
                    .setSSLSocketFactory(connectionFactory)
                    .build();
        }
    }

    

    public AfricellB2CResponse postTransaction(EazInqRequest inqRequest, String countryCode, JDBCService jdbcService) throws Exception {

        AfricellB2CResponse response = new AfricellB2CResponse();
        Gson gson = new Gson();
        
        String sourceAccountNumber = inqRequest.getEazzycash().getSourceAccount();

        String msisdn = inqRequest.getEazzycash().getNumber();

        if (isNullOrEmpty(msisdn)) {
            response.setStatus("ERROR");
            response.setMessage("INVALID MSISDN!!");
            return response;
        }

        msisdn = MiscUtil.formatAfricellNumber(msisdn);

        String currency = "102";
        String bankId = "BE cdf";
        if (inqRequest.getEazzycash().getCurrency().equals("USD")) {
            currency = "101";
            bankId = "BE usd";
        }
        /*
        {
    "serviceCode": "BIBWREQ",
    "bearerCode": "USSD",
    "transactionAmount": "1000",
    "currency": "101",
    "externalReferenceId": "405441",
    "remarks": null,
    "initiator": "transactor",
    "language": "en",
    "transactor": {
        "idType": "mobileNumber",
        "idValue": "0907720455",
        "bankId": "BE usd",
        "bankAccountNumber": "060107658120076"
    },
    "receiver": {
        "idType": "mobileNumber",
        "idValue": "0907720455",
        "productId": "12"
    }
}
}
        */

        Transaction transaction = Transaction.builder()
//                .serviceFlowId("")
                .serviceCode("BIBWREQ")
                .transactionAmount(String.valueOf(inqRequest.getEazzycash().getAmount()))
                .initiator("transactor")
                .currency(currency)
                .bearerCode("USSD")
                .language("en")
                .externalReferenceId(UUID.randomUUID().toString())
                .remarks(null)
//                .transactionMode("")
//                .requestedServiceCode("BIBWREQ")
//                .productOwnerCode("123456")
//                .productBrand("almadar")
//                .productCategory("voice")
                .transactor(Transaction.Transactor.builder()
                        .idType("mobileNumber")
                        .idValue(msisdn)
                        .bankId(bankId)
//                        .bankAccountNumber(inqRequest.getEazzycash().getSourceAccount())
                        .bankAccountNumber(sourceAccountNumber)
                        .build())
                .receiver(Transaction.Receiver.builder()
                        .idType("mobileNumber")
                        .idValue(msisdn)
                        .productId("12")
                        .build())
                .build();

        String requestStr = gson.toJson(transaction);

        HttpHeaders headers = getGenericHeaders("application/json");
        AfricellB2CResponse dsResponse;
        try {

            String disbursementURL = this.getPropertyValue(countryCode, "disbursementURL");
            headers.add("Authorization", "Bearer " + africellUtil.getAfricellToken());
            MiscUtil.printHeaders(headers, "transaction");
            String responseStr = httpAdapter.httpPost(disbursementURL, headers, requestStr);

            if (isNullOrEmpty(responseStr)) {
                response.setStatus("ERROR");
                response.setMessage("Partner returned null or empty response!!");
                return response;
            }

            dsResponse = gson.fromJson(responseStr, AfricellB2CResponse.class);
            String req = xmlStringifier.stringify(inqRequest);
            updateLogDetails(req, null, requestStr, responseStr, TransactionStatus.TELCO_STATUS_CHECK_COMPLETED.name(),
                    inqRequest.getEazzycash().getRrn(), StatusCodes.FAILED, TransactionStatus.TELCO_STATUS_CHECK_COMPLETED.getDescription(), null, jdbcService);

            if (isNullOrEmpty(dsResponse)) {
                logger.error("Could not deserialize partner response!!");
                response.setStatus("ERROR");
                response.setMessage("Could not deserialize partner response!!");
                return response;
            }

        } catch (Exception e) {
            dsResponse = new AfricellB2CResponse();
            dsResponse.setStatus("ERROR");
            dsResponse.setMessage("Request Timed out");
        }
        return dsResponse;

    }
    
    

    public CloseableHttpClient useTrustingTrustManager() {
        try {
            System.setProperty("sun.security.ssl.allowUnsafeRenegotiation", "true");
            // Trust strategy accepting all certificates
            org.apache.hc.core5.ssl.TrustStrategy acceptingTrustStrategy = new org.apache.hc.core5.ssl.TrustStrategy() {
                @Override
                public boolean isTrusted(X509Certificate[] chain, String authType) throws CertificateException {
                    return true;
                }
            };
            SSLContext sslContext = org.apache.hc.core5.ssl.SSLContexts.custom().loadTrustMaterial(null, acceptingTrustStrategy).build();

            SSLConnectionSocketFactory csf = new SSLConnectionSocketFactory(sslContext, NoopHostnameVerifier.INSTANCE);
            CloseableHttpClient httpClient = HttpClients.custom().setSSLSocketFactory(csf).build();

            return httpClient;
        } catch (KeyManagementException | KeyStoreException | NoSuchAlgorithmException t) {
            t.printStackTrace(System.out);

            return null;
        }

    }

    private HttpHeaders getGenericHeaders(String acceptContentType) throws Exception {
        Gson gson = new Gson();
        String token = africellUtil.getAfricellToken();
        if (isNullOrEmpty(token)) {
            throw new Exception("Could not generate token");
        }
        HttpHeaders headers = new HttpHeaders();
        if(acceptContentType != null)
        {
            headers.add("Accept", acceptContentType);
        }
        headers.add("Content-Type", "application/json");
        headers.add("Accept-Charset", "utf-8");
        headers.add("Authorization", "Bearer " + token);
        return headers;
    }

    public static boolean isNullOrEmpty(String value) {
        return ((value == null) || value.isEmpty());
    }

    public static boolean isNullOrEmpty(Object value) {
        return (value == null);
    }

    public static String GenerateEncryptedPinFromBase64Key(String publicKeyString, String plainText) throws NoSuchAlgorithmException, InvalidKeySpecException, InvalidKeyException, NoSuchPaddingException, IllegalBlockSizeException, BadPaddingException {
        String encryptedString = RSAUtil.encrypt(plainText, publicKeyString);

        System.out.println("Encrypted value: " + encryptedString);

        return encryptedString;

    }

}
