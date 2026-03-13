/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.service.business;

import com.equitybankgroup.payments.b2c.dto.airtel.AirtelDTO;
import com.equitybankgroup.payments.b2c.dto.airtel.Airtelb2cResponse;
import com.equitybankgroup.payments.b2c.dto.airtel.StatusCodes;
import com.equitybankgroup.payments.b2c.dto.airtel.airtime.request.AirtimeRequestDTO;
import com.equitybankgroup.payments.b2c.dto.airtel.contants.AirtelConstants;
import com.equitybankgroup.payments.b2c.dto.airtel.contants.TPGConstants;
import com.equitybankgroup.payments.b2c.enums.RequestTypes;
import com.equitybankgroup.payments.b2c.enums.TranStatus;
import com.equitybankgroup.payments.b2c.enums.TransactionStatus;
import com.equitybankgroup.payments.b2c.model.StatusDetails;
import com.equitybankgroup.payments.b2c.model.TransactionDetails;
import com.equitybankgroup.payments.b2c.repository.TransactionDetailsRepository;

import static com.equitybankgroup.payments.b2c.service.business.OpenAPIAirtelBankToWalletService.isNullOrEmpty;

import com.equitybankgroup.payments.b2c.service.business.http.OutboundHttpAdapter;
import com.equitybankgroup.payments.b2c.service.util.MiscUtil;

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
 * @author ronaldcheruiyot
 */
@Service
@Slf4j
public class AirtimeService {

    @Value("${airtel.cd.airtime.pin}")
    private String pin;

    @Value("${airtel.cd.airtime.channelMsisdn}")
    private String channelMsisdn;

    @Value("${airtel.cd.airtime.password}")
    private String password;

    @Value("${airtel.cd.airtime.extCode}")
    private String extCode;

    @Value("${airtel.cd.airtime.requestURL}")
    private String airtimeBaseURL;

    @Value("${airtel.cd.airtime.LOGIN}")
    private String LOGIN;

    @Value("${airtel.cd.airtime.PASSWORD}")
    private String PASSWORD;

    @Value("${airtel.cd.airtime.REQUEST_GATEWAY_CODE}")
    private String REQUEST_GATEWAY_CODE;

    @Value("${airtel.cd.airtime.REQUEST_GATEWAY_TYPE}")
    private String REQUEST_GATEWAY_TYPE;

    @Value("${airtel.cd.airtime.SOURCE_TYPE}")
    private String SOURCE_TYPE;

    @Value("${airtel.cd.airtime.SERVICE_PORT}")
    private String SERVICE_PORT;

    @Value("${airtel.cd.airtime.loginId}")
    private String loginId;

    @Value("$(service.activation.airtime)")
    private String airtimeActivationStr;

    private boolean airtimeActivated;

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

    private String requestURL = null;


    public boolean isAirtimeActivated() {
        return airtimeActivated;
    }

    @PostConstruct
    public void init() throws Exception {
        Environment env = this.applicationContext.getEnvironment();
        String[] activeProfiles = env.getActiveProfiles();
        this.requestURL = this.buildURL();
        this.airtimeActivated = Boolean.valueOf(airtimeActivationStr);

        if (MiscUtil.isNullOrEmpty(this.requestURL))
            throw new IllegalArgumentException("requestURL cannot be null or empty!!");

        for (String profile : activeProfiles) {
            if (profile.equalsIgnoreCase("local")) {
                isLocal = true;
            }
            if (profile.equalsIgnoreCase("prod") && this.airtimeActivated) {
                boolean isHostAvailable = MiscUtil.isHostAvailable(this.requestURL);

                if (!isHostAvailable) {
                    throw new IllegalStateException("Comunication link failure, no connection to URL: " + this.requestURL + "!!");
                }
            }
        }

    }

    public AirtelDTO buyAirtime(Map<String, String> request) {
        JDBCService jdbcService = (JDBCService) this.applicationContext.getBean(JDBCService.class);
        String rrn = request.get(TPGConstants.AIRTIME_REQUEST_RRN);
        BigDecimal amount = new BigDecimal(request.get(TPGConstants.AIRTIME_REQUEST_AMOUNT));
        StatusDetails record = jdbcService.getB2cTransactionsByRrn(rrn);

        if (record == null) {
            if (!isLocal) {
                System.out.println(rrn + "|Airtime record record Not found!!");
                return new AirtelDTO(-1, null, "-1", rrn + "|B2C record Not found!!");
            }
            record = getStatusDetails(amount, rrn);
        }
        try {
            Airtelb2cResponse response = postTransaction(request);
            String resultCode = (String) response.getAditionalData().get(AirtelConstants.AIRTIME_RESPONSE_TXNSTATUS);
            String telcoMessage = (String) response.getAditionalData().get(AirtelConstants.AIRTIME_RESPONSE_MESSAGE);
            if (null == response.getStatus()) {
                return new AirtelDTO(-1, resultCode, null, "Failed with no status");
            } else {
                switch (response.getStatus()) {
                    case SUCCESS:
                        String tranId = (String) response.getAditionalData().get(AirtelConstants.AIRTIME_REQUEST_TXNID);
                        record.setStatusCode(StatusCodes.SUCCESS);
                        record.setStatus(TransactionStatus.OK.name());
                        record.setStatusMessage(telcoMessage);
                        record.setTranId(tranId);
                        editTran(record, "1", rrn, "0", jdbcService);
                        return new AirtelDTO(0, tranId, resultCode, telcoMessage);
                    case FAILURE:
                        record.setStatusCode(StatusCodes.FAILED);
                        record.setStatus(TransactionStatus.ERROR.name());
                        record.setStatusMessage(telcoMessage);
                        editTran(record, "-1", rrn, "-1", jdbcService);
                        return new AirtelDTO(-1, null, resultCode, telcoMessage);
                    case TIMEOUT:
                        editTran(record, "-3", rrn, "-3", jdbcService);
                        return new AirtelDTO(-3, null, null, "Timeout");
                    default:
                        record.setStatusCode(StatusCodes.FAILED);
                        record.setStatus(TransactionStatus.ERROR.name());
                        record.setStatusMessage("Failed.");
                        editTran(record, "-1", rrn, "-1", jdbcService);
                        return new AirtelDTO(-1, null, null, "Failed!");
                }
            }

        } catch (Exception ex) {
            ex.printStackTrace(System.out);
            return new AirtelDTO(-1, null, null, "Failed");
        }

    }

    public Airtelb2cResponse postTransaction(Map<String, String> requestMap) throws ParserConfigurationException, SAXException, IOException {
        Airtelb2cResponse response = new Airtelb2cResponse();
        Map<String, Object> aditionalData = new HashMap<>();
        String rrn = requestMap.get(TPGConstants.AIRTIME_REQUEST_RRN);
        String amount = requestMap.get(TPGConstants.AIRTIME_REQUEST_AMOUNT);
        String msisdn = formatMsisdn(requestMap);
        
//        Double doubleValue = Double.parseDouble(amount);

        // Convert to Long
//        Long longValue = doubleValue.longValue();

//        String requestStr = getAirtimeRequstStrTZ(rrn, longValue, msisdn, this.extCode, this.pin, this.password, this.channelMsisdn, this.loginId);
        String requestStr = getAirtimeRequstStrTZ(rrn, amount, msisdn, this.extCode, this.pin, this.password, this.channelMsisdn, this.loginId);

        /*
        public String getAirtimeRequestString(String rrn, Long amount, String msisdn,
            String extCode, String pin, String password, String channelMsisdn)
        */

        HttpHeaders headers = new HttpHeaders();

        headers.add("Content-Type", "text/xml");

        String responseStr = httpAdapter.customHttpPost(this.requestURL, headers, requestStr);

        if (isNullOrEmpty(responseStr)) {
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

        if (isNullOrEmpty(txnStatus)) {
            response.setAditionalData(aditionalData);
            response.setStatus(TranStatus.TIMEOUT);
            response.setMessage("TXN status is null or empty!!");
            return response;
        }


        if (txnStatus.equalsIgnoreCase("200") && !MiscUtil.isNullOrEmpty(txnId)) {
            System.out.println("Succesfully initiated");
            response.setStatus(TranStatus.SUCCESS);
            response.setMessage("Succesfully initiated");
            response.setAditionalData(aditionalData);
            return response;
        }

        if (MiscUtil.isNullOrEmpty(message)) {
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

    private String formatMsisdn(Map<String, String> requestMap) {
        String msisdn = requestMap.get(TPGConstants.AIRTIME_REQUEST_MSISDNA);
        if (msisdn == null || msisdn.isEmpty()) {
            return msisdn;
        }

        // Assuming 9+ digits means a country code is present
        if (msisdn.length() > 9) {
            msisdn = msisdn.replaceFirst("^\\d{1,3}", "");
        }

        return msisdn;
    }

    public void editTran(StatusDetails record, String status1, String rrn, String status2, JDBCService jdbcService) {
        try {
            if (record != null) {
                jdbcService.editB2cTransactions(record, status1, rrn, status2);
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.out);
        }
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

    private String buildURL() {
        StringBuilder builder = new StringBuilder();
        builder.append(this.airtimeBaseURL)
                .append("?REQUEST_GATEWAY_CODE=")
                .append("PRO")
                .append("&REQUEST_GATEWAY_TYPE=")
                .append(this.REQUEST_GATEWAY_TYPE)
                .append("&LOGIN=")
                .append(this.LOGIN)
                .append("&PASSWORD=")
                .append(this.PASSWORD)
                .append("&SOURCE_TYPE=")
                .append(this.SOURCE_TYPE)
                .append("&SERVICE_PORT=")
                .append(this.SERVICE_PORT);

        String resultantURL = builder.toString();
        System.out.println("resultantURL: " + resultantURL);
        return resultantURL;
    }
    
    public static String getAirtimeRequestString(String rrn, Long amount, String msisdn,
            String extCode, String pin, String password, String channelMsisdn)
    {
        return "<?xml version=\"1.0\"?><COMMAND>\n" +
"<TYPE>EXRCTRFREQ</TYPE>\n" +
"<DATE>" + MiscUtil.getCurrentTimestamp("dd/MM/yyyyHH:mm:ss") + "</DATE>\n" +
"<MSISDN> </MSISDN>\n" +
"<EXTNWCODE>CO</EXTNWCODE>\n" +
"<PIN>" + pin + "</PIN>\n" +
"<LOGINID> </LOGINID>\n" +
"<PASSWORD> </PASSWORD>\n" +
"<EXTCODE>" + extCode + "</EXTCODE>\n" +
"<EXTREFNUM>" + rrn + "</EXTREFNUM>\n" +
"<MSISDN2>" + msisdn + "</MSISDN2>\n" +
"<AMOUNT>" + amount + "</AMOUNT>\n" +
"<LANGUAGE1>1</LANGUAGE1>\n" +
"<LANGUAGE2>1</LANGUAGE2>\n" +
"<SELECTOR>1</SELECTOR>\n" +
"</COMMAND>";
    }
    
    public static String getAirtimeRequstStrTZ(String rrn, String amount, String msisdn,
            String extCode, String pin, String password, String channelMsisdn, String loginId)
    {
        return "<?xml version=\"1.0\"?><!DOCTYPE COMMAND PUBLIC \"-//Ocam//DTD XML Command1.0//EN\"\"xml/command.dtd\"><COMMAND>\n" +
"     <TYPE>EXRCTRFREQ</TYPE>\n" +
"     <DATE></DATE>\n" +
"     <EXTNWCODE>CO</EXTNWCODE>\n" +
"     <MSISDN>" + channelMsisdn +"</MSISDN>\n" +
"       <PIN>" + pin + "</PIN>\n" +
"     <LOGINID></LOGINID>\n" +
"     <PASSWORD></PASSWORD>\n" +
"     <EXTCODE>" + extCode + "</EXTCODE>\n" +
"     <EXTREFNUM>" + rrn + "</EXTREFNUM>\n" +
"     <MSISDN2>" + msisdn + "</MSISDN2>\n" +
"     <AMOUNT>" + amount + "</AMOUNT>\n" +
"     <LANGUAGE1>1</LANGUAGE1>\n" +
"     <LANGUAGE2>1</LANGUAGE2>\n" +
"     <SELECTOR>1</SELECTOR>\n" +
" </COMMAND>";
    }


    public static void main(String[] args) {
//        Double doubleValue = Double.parseDouble("100");
//
//        // Convert to Long
//        Long longValue = doubleValue.longValue();
//        String requestStr = getAirtimeRequstStrTZ("4465565775", longValue, "998158760", "131220", "1468", "557766768", "977857601", "pro_credit");
//
//        System.out.println(requestStr);

    }

}
