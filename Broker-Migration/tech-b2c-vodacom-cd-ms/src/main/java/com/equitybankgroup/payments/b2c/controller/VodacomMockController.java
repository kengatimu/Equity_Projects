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
import com.equitybankgroup.payments.b2c.dto.vodacom.constants.VodacomConstants;
import com.equitybankgroup.payments.b2c.service.business.VodacomBankToWalletService;
import com.equitybankgroup.payments.b2c.service.business.http.OutboundHttpAdapter;
import com.equitybankgroup.payments.b2c.service.util.MiscUtil;
import java.io.IOException;
import java.io.StringWriter;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.Executor;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletResponse;
import jakarta.xml.bind.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author ronaldcheruiyot
 */
@RestController
public class VodacomMockController {
    
    @Value("${vodacom.cd.b2c.mock.scenario.login}")
    String loginScenario;
    
    @Value("${vodacom.cd.b2c.mock.scenario.disbursement}")
    String disbursementScenario;
    
    @Value("${vodacom.cd.airtime.mock.scenario.buy}")
    String buyAirtimeScenario;
    
    @Autowired
    OutboundHttpAdapter httpAdapter;
    
    @Autowired
    Executor taskExecutor;///insight/B2BLogin
    
    @PostMapping("/insight/SOAPIn")
    public ResponseEntity loginB2C(@RequestBody String loginRequest)
    {   
        if(loginScenario.equalsIgnoreCase("success")) return new ResponseEntity(getSuccessLoginResponse(), HttpStatus.OK);
        
        return new ResponseEntity(getFailedLoginResponse(), HttpStatus.OK);
        
    }
    
    @PostMapping("/insight/B2BLogin")
    public ResponseEntity loginB2B(@RequestBody String loginRequest)
    {   
        if(loginScenario.equalsIgnoreCase("success")) return new ResponseEntity(getSuccessB2BLoginResponse(), HttpStatus.OK);
        
        return new ResponseEntity(getFailedB2BLoginResponse(), HttpStatus.OK);
        
    }
    
    @PostMapping("/iPG/B2C")
    public ResponseEntity postTransaction(@RequestBody String disbursement)
    {   
        try
        {
            if(disbursementScenario.equalsIgnoreCase("success")) return new ResponseEntity(getSuccessDisbursementResponse(), HttpStatus.OK);

            return new ResponseEntity(getFailedDisbursementResponse(), HttpStatus.OK);
        } finally {
            taskExecutor.execute(() -> {
                sendCallback(disbursement);
            });
        }
        
    }
    
    @PostMapping("/insight/B2B")
    public ResponseEntity postB2BTransaction(@RequestBody String disbursement)
    {   
        String insightIxnId = MiscUtil.generateRandomRRN(19);
        try
        {   
            
            if(disbursementScenario.equalsIgnoreCase("success")) return new ResponseEntity(getSuccessB2BDisbursementResponse(disbursement, insightIxnId), HttpStatus.OK);

            return new ResponseEntity(getFailedB2BDisbursementResponse(disbursement, insightIxnId), HttpStatus.OK);
        } finally {
            taskExecutor.execute(() -> {
                sendB2BCallback(disbursement, insightIxnId);
            });
        }
        
    }
    
    @PostMapping("/external/airtime/buy")
    public ResponseEntity buyAirtime(@RequestBody String airtimeRequest)
    {  
        Map<String, String> values = MiscUtil.extractAllTagValues(airtimeRequest);
        String originatorConversationID = values.get(VodacomConstants.AIRTIME_REQUEST_ORIGINATOR_CONVERSATION_ID);
        String conversationID = MiscUtil.generateRandomRRN(15);
            
        taskExecutor.execute(() -> {
            try {
                Thread.sleep(5000);
            } catch (InterruptedException ex) {
                Logger.getLogger(VodacomMockController.class.getName()).log(Level.SEVERE, null, ex);
            }
            sendAirtimeCallback(originatorConversationID, conversationID, airtimeRequest);
        });
        if(buyAirtimeScenario.equalsIgnoreCase("success")) return new ResponseEntity(getSuccessAirtimeResponse(originatorConversationID, conversationID), HttpStatus.OK);
            return new ResponseEntity(getFailedAirtimeResponse(originatorConversationID, conversationID), HttpStatus.OK);
        }
    
    public String getFailedAirtimeResponse(String originatorConversationID, String conversationID)
    {   
       return "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" +
"    <soapenv:Body>\n" +
"        <api:Response xmlns:api=\"http://cps.huawei.com/cpsinterface/api_requestmgr\" xmlns:res=\"http://cps.huawei.com/cpsinterface/response\">\n" +
"            <res:Header>\n" +
"                <res:Version>1.0</res:Version>\n" +
"                <res:OriginatorConversationID>" + originatorConversationID  + "</res:OriginatorConversationID>\n" +
"                <res:ConversationID>" + conversationID + "</res:ConversationID>\n" +
"            </res:Header>\n" +
"            <res:Body>\n" +
"                <res:ResponseCode>1</res:ResponseCode>\n" +
"                <res:ResponseDesc>Request Failed</res:ResponseDesc>\n" +
"                <res:ServiceStatus>1</res:ServiceStatus>\n" +
"            </res:Body>\n" +
"        </api:Response>\n" +
"    </soapenv:Body>\n" +
"</soapenv:Envelope>";
    }
    
    public String getSuccessAirtimeResponse(String originatorConversationID, String conversationID)
    {   
       return "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" +
"    <soapenv:Body>\n" +
"        <api:Response xmlns:api=\"http://cps.huawei.com/cpsinterface/api_requestmgr\" xmlns:res=\"http://cps.huawei.com/cpsinterface/response\">\n" +
"            <res:Header>\n" +
"                <res:Version>1.0</res:Version>\n" +
"                <res:OriginatorConversationID>S_X" + originatorConversationID  + "</res:OriginatorConversationID>\n" +
"                <res:ConversationID>" + conversationID + "</res:ConversationID>\n" +
"            </res:Header>\n" +
"            <res:Body>\n" +
"                <res:ResponseCode>0</res:ResponseCode>\n" +
"                <res:ResponseDesc>Accept the service request successfully.</res:ResponseDesc>\n" +
"                <res:ServiceStatus>0</res:ServiceStatus>\n" +
"            </res:Body>\n" +
"        </api:Response>\n" +
"    </soapenv:Body>\n" +
"</soapenv:Envelope>";
    }
    
    public void sendAirtimeCallback(String originatorConversationID, String conversationID, String airtimeRequest)
    {   
        System.out.println("START System.out.println(airtimeRequest);");
        System.out.println(airtimeRequest);
        System.out.println("START System.out.println(airtimeRequest);");
        Map<String, String> values = MiscUtil.extractAllTagValues(airtimeRequest);
        String callbackEndpoint = values.get(VodacomConstants.AIRTIME_REQUEST_CALLBACK_DEST);
        String request = (buyAirtimeScenario.equalsIgnoreCase("success")) ? getAirtimeSuccessCallbackRequest(originatorConversationID, conversationID) : getAirtimeFailedCallbackRequest(originatorConversationID, conversationID);
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "text/xml");
        httpAdapter.httpPost(callbackEndpoint, headers, request);
    }
    
    public void sendCallback(String disbursement)
    {
        Map<String, String> values = MiscUtil.extractAllTagValues(disbursement);
        String thirdPartyReference = values.get(VodacomConstants.DISBURSEMENT_REQUEST_TP_REFERENCE);
        String callbackEndpoint = values.get(VodacomConstants.DISBURSEMENT_REQUEST_CALLBACK_DEST);
        String request = (disbursementScenario.equalsIgnoreCase("success")) ? getSuccessCallbackRequest(thirdPartyReference) : getFailedCallbackRequest(thirdPartyReference);
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "text/xml");
        httpAdapter.httpPost(callbackEndpoint, headers, request);
    }
    
    public void sendB2BCallback(String disbursement, String insightReference)
    {
        Map<String, String> values = MiscUtil.extractAllTagValues(disbursement);
        String callbackEndpoint = values.get(VodacomConstants.B2B_DISBURSEMENT_REQUEST_CALLBACK_DESTINATION);
        String transactionId = values.get(VodacomConstants.B2B_DISBURSEMENT_REQUEST_TRANSACTION_ID);
        String amount = values.get(VodacomConstants.B2B_DISBURSEMENT_REQUEST_AMOUNT);
        String thirdPartyReference = values.get(VodacomConstants.B2B_DISBURSEMENT_REQUEST_THIRD_PARTY_REFERENCE);
        String request = (disbursementScenario.equalsIgnoreCase("success")) ? 
                getSuccessB2BCallbackRequest(transactionId, amount, thirdPartyReference, insightReference) : 
                getFailedB2BCallbackRequest(transactionId, amount, thirdPartyReference, insightReference);
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "text/xml");
        httpAdapter.httpPost(callbackEndpoint, headers, request);
    }
    
    public String getAirtimeSuccessCallbackRequest(String originatorConversationID, String conversationID)
    {
        return "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:api=\"http://cps.huawei.com/cpsinterface/api_resultmgr\" xmlns:res=\"http://cps.huawei.com/cpsinterface/result\" xmlns:com=\"http://cps.huawei.com/cpsinterface/common\">\n" +
"    <soapenv:Header/>\n" +
"    <soapenv:Body>\n" +
"        <api:Result>\n" +
"            <res:Header>\n" +
"                <res:Version>1.0</res:Version>\n" +
"                <res:OriginatorConversationID>" + originatorConversationID + "</res:OriginatorConversationID>\n" +
"                <res:ConversationID>" + conversationID + "</res:ConversationID>\n" +
"            </res:Header>\n" +
"            <res:Body>\n" +
"                <res:ResultType>0</res:ResultType>\n" +
"                <res:ResultCode>0</res:ResultCode>\n" +
"                <res:ResultDesc>Process service request successfully.</res:ResultDesc>\n" +
"                <res:TransactionResult>\n" +
"                    <res:TransactionID>XD" + MiscUtil.generateRandomRRN(16) + "</res:TransactionID>\n" +
"                </res:TransactionResult>\n" +
"            </res:Body>\n" +
"        </api:Result>\n" +
"    </soapenv:Body>\n" +
"</soapenv:Envelope>";
    }
    
    public String getAirtimeFailedCallbackRequest(String originatorConversationID, String conversationID)
    {
        return "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:api=\"http://cps.huawei.com/cpsinterface/api_resultmgr\" xmlns:res=\"http://cps.huawei.com/cpsinterface/result\" xmlns:com=\"http://cps.huawei.com/cpsinterface/common\">\n" +
"    <soapenv:Header/>\n" +
"    <soapenv:Body>\n" +
"        <api:Result>\n" +
"            <res:Header>\n" +
"                <res:Version>1.0</res:Version>\n" +
"                <res:OriginatorConversationID>" + originatorConversationID + "</res:OriginatorConversationID>\n" +
"                <res:ConversationID>" + conversationID + "</res:ConversationID>\n" +
"            </res:Header>\n" +
"            <res:Body>\n" +
"                <res:ResultType>1</res:ResultType>\n" +
"                <res:ResultCode>1</res:ResultCode>\n" +
"                <res:ResultDesc>Request failed.</res:ResultDesc>\n" +
"            </res:Body>\n" +
"        </api:Result>\n" +
"    </soapenv:Body>\n" +
"</soapenv:Envelope>";
    }
    
    public String getSuccessB2BCallbackRequest(String transactionId, String amount, 
            String thirdPartyReference, String insightReference)
    {
        return "<Result>\n" +
"    <TransactionID>" + transactionId + "</TransactionID>\n" +
"    <Amount>" + amount + "</Amount>\n" +
"    <TransactionTime>" + MiscUtil.getCurrentTimestamp("yyyyMMddHHmmss") + "</TransactionTime>\n" +
"    <ThirdPartyReference>" + thirdPartyReference + "</ThirdPartyReference>\n" +
"    <InsightReference>" + insightReference + "</InsightReference>\n" +
"    <ResultCode>0</ResultCode>\n" +
"    <ResultDesc>Process service request successfully.</ResultDesc>\n" +
"</Result>";
    }
    
     public String getFailedB2BCallbackRequest(String transactionId, String amount, 
            String thirdPartyReference, String insightReference)
    {
        return "<Result>\n" +
"    <TransactionID>" + transactionId + "</TransactionID>\n" +
"    <Amount>" + amount + "</Amount>\n" +
"    <TransactionTime>" + MiscUtil.getCurrentTimestamp("yyyyMMddHHmmss") + "</TransactionTime>\n" +
"    <ThirdPartyReference>" + thirdPartyReference + "</ThirdPartyReference>\n" +
"    <InsightReference>" + insightReference + "</InsightReference>\n" +
"    <ResultCode>-3</ResultCode>\n" +
"    <ResultDesc>Transaction failed/Invalid MSISDN.</ResultDesc>\n" +
"</Result>";
    }
    
    public String getSuccessCallbackRequest(String thirdPartyReference)
    {
        return "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n" +
"<soapenv:Envelope\n" +
" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n" +
" xmlns:soap=\"http://www.4cgroup.co.za/soapauth\"\n" +
" xmlns:gen=\"http://www.4cgroup.co.za/genericsoap\">\n" +
" <soapenv:Header>\n" +
" <soap:EventID>1</soap:EventID>\n" +
" </soapenv:Header>\n" +
" <soapenv:Body>\n" +
" <gen:getGenericResult>\n" +
" <Request>\n" +
" <dataItem>\n" +
" <name>ResultType</name>\n" +
" <value>0</value>\n" +
" <type>String</type>\n" +
" </dataItem>\n" +
" <dataItem>\n" +
" <name>ResultCode</name>\n" +
" <value>0</value>\n" +
" <type>String</type>\n" +
" </dataItem>\n" +
" <dataItem>\n" +
" <name>ResultDesc</name>\n" +
" <value> Process service request successfully.</value>\n" +
" <type>String</type>\n" +
" </dataItem>\n" +
" <dataItem>\n" +
" <name>OriginatorConversationId</name>\n" +
" <value>" + (UUID.randomUUID()).toString() + "</value>\n" +
" <type>String</type>\n" +
" </dataItem>\n" +
" <dataItem>\n" +
" <name>ConversationId</name>\n" +
" <value>" + (UUID.randomUUID()).toString() + "</value>\n" +
" <type>String</type>\n" +
" </dataItem>\n" +
" <dataItem>\n" +
" <name>TransactionID</name>\n" +
" <value>X-BS" + MiscUtil.generateRandomRRN(System.currentTimeMillis(), 3) + "</value>\n" +
" <type>String</type>\n" +
" </dataItem>\n" +
" <dataItem>\n" +
" <name>Amount</name>\n" +
" <value>200</value>\n" +
" <type>String</type>\n" +
" </dataItem>\n" +
" <dataItem>\n" +
" <name>TransactionTime</name>\n" +
" <value>20170301T22:59:01</value>\n" +
" <type>String</type>\n" +
" </dataItem>\n" +
" <dataItem>\n" +
" <name>ThirdPartyReference</name>\n" +
" <value>" + thirdPartyReference + "</value>\n" +
" <type>String</type>\n" +
" </dataItem>\n" +
" <dataItem>\n" +
" <name>InsightReference</name>\n" +
" <value>4655768799898</value>\n" +
" <type>String</type>\n" +
" </dataItem>\n" +
" </Request>\n" +
" </gen:getGenericResult>\n" +
" </soapenv:Body>\n" +
"</soapenv:Envelope>";
    }
    
    public String getFailedCallbackRequest(String thirdPartyReference)
    {
        return "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n" +
"<soapenv:Envelope\n" +
" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\"\n" +
" xmlns:soap=\"http://www.4cgroup.co.za/soapauth\"\n" +
" xmlns:gen=\"http://www.4cgroup.co.za/genericsoap\">\n" +
" <soapenv:Header>\n" +
" <soap:EventID>1</soap:EventID>\n" +
" </soapenv:Header>\n" +
" <soapenv:Body>\n" +
" <gen:getGenericResult>\n" +
" <Request>\n" +
" <dataItem>\n" +
" <name>ResultType</name>\n" +
" <value>-1</value>\n" +
" <type>String</type>\n" +
" </dataItem>\n" +
" <dataItem>\n" +
" <name>ResultCode</name>\n" +
" <value>-1</value>\n" +
" <type>String</type>\n" +
" </dataItem>\n" +
" <dataItem>\n" +
" <name>ResultDesc</name>\n" +
" <value>Error</value>\n" +
" <type>String</type>\n" +
" </dataItem>\n" +
" <dataItem>\n" +
" <name>OriginatorConversationId</name>\n" +
" <value>" + (UUID.randomUUID()).toString() + "</value>\n" +
" <type>String</type>\n" +
" </dataItem>\n" +
" <dataItem>\n" +
" <name>ConversationId</name>\n" +
" <value>" + (UUID.randomUUID()).toString() + "</value>\n" +
" <type>String</type>\n" +
" </dataItem>\n" +
" <dataItem>\n" +
" <name>TransactionID</name>\n" +
" <value>X-BS" + MiscUtil.generateRandomRRN(System.currentTimeMillis(), 3) + "</value>\n" +
" <type>String</type>\n" +
" </dataItem>\n" +
" <dataItem>\n" +
" <name>Amount</name>\n" +
" <value>200</value>\n" +
" <type>String</type>\n" +
" </dataItem>\n" +
" <dataItem>\n" +
" <name>TransactionTime</name>\n" +
" <value>20170301T22:59:01</value>\n" +
" <type>String</type>\n" +
" </dataItem>\n" +
" <dataItem>\n" +
" <name>ThirdPartyReference</name>\n" +
" <value>" + thirdPartyReference + "</value>\n" +
" <type>String</type>\n" +
" </dataItem>\n" +
" <dataItem>\n" +
" <name>InsightReference</name>\n" +
" <value>4655768799898</value>\n" +
" <type>String</type>\n" +
" </dataItem>\n" +
" </Request>\n" +
" </gen:getGenericResult>\n" +
" </soapenv:Body>\n" +
"</soapenv:Envelope>";
    }
    
    public String getFailedDisbursementResponse()
    {
       return "<?xml version='1.0' encoding='UTF-8'?>\n" +
"<S:Envelope\n" +
"xmlns:S=\"http://schemas.xmlsoap.org/soap/envelope/\"\n" +
"xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" +
"    <S:Header>\n" +
"        <ns3:eventid\n" +
"xmlns:ns2=\"http://www.4cgroup.co.za/genericsoap\"\n" +
"xmlns:ns3=\"http://www.4cgroup.co.za/soapauth\">12001\n" +
"</ns3:eventid>\n" +
"    </S:Header>\n" +
"    <S:Body>\n" +
"        <ns2:getGenericResultResponse\n" +
"xmlns:ns2=\"http://www.4cgroup.co.za/genericsoap\"\n" +
"xmlns:ns3=\"http://www.4cgroup.co.za/soapauth\">\n" +
"            <SOAPAPIResult>\n" +
"                <eventInfo>\n" +
"                    <code>4</code>\n" +
"                    <description>Failed</description>\n" +
"                    <detail>Processed</detail>\n" +
"                    <transactionID>74b2f36481524d1e9bf907edbc86291d</transactionID>\n" +
"                </eventInfo>\n" +
"                <request>\n" +
"                    <dataItem>\n" +
"                        <name>ServiceProviderName</name>\n" +
"                        <type>String</type>\n" +
"                        <value>ONE4ALL</value>\n" +
"                    </dataItem>\n" +
"                    <dataItem>\n" +
"                        <name>CustomerMSISDN</name>\n" +
"                        <type>String</type>\n" +
"                        <value>243811835361</value>\n" +
"                    </dataItem>\n" +
"                    <dataItem>\n" +
"                        <name>Currency</name>\n" +
"                        <type>String</type>\n" +
"                        <value>USD</value>\n" +
"                    </dataItem>\n" +
"                    <dataItem>\n" +
"                        <name>Amount</name>\n" +
"                        <type>String</type>\n" +
"                        <value>1</value>\n" +
"                    </dataItem>\n" +
"                    <dataItem>\n" +
"                        <name>TransactionDateTime</name>\n" +
"                        <type>Date</type>\n" +
"                        <value>20180601123700</value>\n" +
"                    </dataItem>\n" +
"                    <dataItem>\n" +
"                        <name>Shortcode</name>\n" +
"                        <type>String</type>\n" +
"                        <value>15058</value>\n" +
"                    </dataItem>\n" +
"                    <dataItem>\n" +
"                        <name>Language</name>\n" +
"                        <type>String</type>\n" +
"                        <value>EN</value>\n" +
"                    </dataItem>\n" +
"                    <dataItem>\n" +
"                        <name>ThirdPartyReference</name>\n" +
"                        <type>String</type>\n" +
"                        <value>Christian-Test1</value>\n" +
"                    </dataItem>\n" +
"                    <dataItem>\n" +
"                        <name>CallBackChannel</name>\n" +
"                        <type>String</type>\n" +
"                        <value>2</value>\n" +
"                    </dataItem>\n" +
"                    <dataItem>\n" +
"                        <name>CallBackDestination</name>\n" +
"                        <type>String</type>\n" +
"                        <value>https://callbackurl</value>\n" +
"                    </dataItem>\n" +
"                    <dataItem>\n" +
"                        <name>CommandID</name>\n" +
"                        <type>String</type>\n" +
"                        <value>InitTrans_one4allb2c</value>\n" +
"                    </dataItem>\n" +
"                </request>\n" +
"                <response>\n" +
"                    <dataItem>\n" +
"                        <name>Insight_txid</name>\n" +
"                        <type>String</type>\n" +
"                        <value>lurzsmmaxquh9l1svold6e3hx7x7jp9t</value>\n" +
"                    </dataItem>\n" +
"                    <dataItem>\n" +
"                        <name>ResponseCode</name>\n" +
"                        <type>String</type>\n" +
"                        <value>0</value>\n" +
"                    </dataItem>\n" +
"                </response>\n" +
"            </SOAPAPIResult>\n" +
"        </ns2:getGenericResultResponse>\n" +
"    </S:Body>\n" +
"</S:Envelope>"; 
    }
    
    public String getSuccessDisbursementResponse()
    {
       return "<?xml version='1.0' encoding='UTF-8'?>\n" +
"<S:Envelope\n" +
"xmlns:S=\"http://schemas.xmlsoap.org/soap/envelope/\"\n" +
"xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" +
"    <S:Header>\n" +
"        <ns3:eventid\n" +
"xmlns:ns2=\"http://www.4cgroup.co.za/genericsoap\"\n" +
"xmlns:ns3=\"http://www.4cgroup.co.za/soapauth\">12001\n" +
"</ns3:eventid>\n" +
"    </S:Header>\n" +
"    <S:Body>\n" +
"        <ns2:getGenericResultResponse\n" +
"xmlns:ns2=\"http://www.4cgroup.co.za/genericsoap\"\n" +
"xmlns:ns3=\"http://www.4cgroup.co.za/soapauth\">\n" +
"            <SOAPAPIResult>\n" +
"                <eventInfo>\n" +
"                    <code>3</code>\n" +
"                    <description>Processed</description>\n" +
"                    <detail>Processed</detail>\n" +
"                    <transactionID>" + (UUID.randomUUID()).toString() + "</transactionID>\n" +
"                </eventInfo>\n" +
"                <request>\n" +
"                    <dataItem>\n" +
"                        <name>ServiceProviderName</name>\n" +
"                        <type>String</type>\n" +
"                        <value>ONE4ALL</value>\n" +
"                    </dataItem>\n" +
"                    <dataItem>\n" +
"                        <name>CustomerMSISDN</name>\n" +
"                        <type>String</type>\n" +
"                        <value>243811835361</value>\n" +
"                    </dataItem>\n" +
"                    <dataItem>\n" +
"                        <name>Currency</name>\n" +
"                        <type>String</type>\n" +
"                        <value>USD</value>\n" +
"                    </dataItem>\n" +
"                    <dataItem>\n" +
"                        <name>Amount</name>\n" +
"                        <type>String</type>\n" +
"                        <value>1</value>\n" +
"                    </dataItem>\n" +
"                    <dataItem>\n" +
"                        <name>TransactionDateTime</name>\n" +
"                        <type>Date</type>\n" +
"                        <value>20180601123700</value>\n" +
"                    </dataItem>\n" +
"                    <dataItem>\n" +
"                        <name>Shortcode</name>\n" +
"                        <type>String</type>\n" +
"                        <value>15058</value>\n" +
"                    </dataItem>\n" +
"                    <dataItem>\n" +
"                        <name>Language</name>\n" +
"                        <type>String</type>\n" +
"                        <value>EN</value>\n" +
"                    </dataItem>\n" +
"                    <dataItem>\n" +
"                        <name>ThirdPartyReference</name>\n" +
"                        <type>String</type>\n" +
"                        <value>Christian-Test1</value>\n" +
"                    </dataItem>\n" +
"                    <dataItem>\n" +
"                        <name>CallBackChannel</name>\n" +
"                        <type>String</type>\n" +
"                        <value>2</value>\n" +
"                    </dataItem>\n" +
"                    <dataItem>\n" +
"                        <name>CallBackDestination</name>\n" +
"                        <type>String</type>\n" +
"                        <value>https://callbackurl</value>\n" +
"                    </dataItem>\n" +
"                    <dataItem>\n" +
"                        <name>CommandID</name>\n" +
"                        <type>String</type>\n" +
"                        <value>InitTrans_one4allb2c</value>\n" +
"                    </dataItem>\n" +
"                </request>\n" +
"                <response>\n" +
"                    <dataItem>\n" +
"                        <name>Insight_txid</name>\n" +
"                        <type>String</type>\n" +
"                        <value>lurzsmmaxquh9l1svold6e3hx7x7jp9t</value>\n" +
"                    </dataItem>\n" +
"                    <dataItem>\n" +
"                        <name>ResponseCode</name>\n" +
"                        <type>String</type>\n" +
"                        <value>0</value>\n" +
"                    </dataItem>\n" +
"                </response>\n" +
"            </SOAPAPIResult>\n" +
"        </ns2:getGenericResultResponse>\n" +
"    </S:Body>\n" +
"</S:Envelope>"; 
    }
    
    public String getSuccessB2BDisbursementResponse(String request, String insightTxnId)
    {   
        Map<String, String> values = MiscUtil.extractAllTagValues(request);
        return "<Response>\n" +
"    <ThirdPartyReference>" + values.get(VodacomConstants.B2B_DISBURSEMENT_REQUEST_THIRD_PARTY_REFERENCE) + "</ThirdPartyReference>\n" +
"    <InsightTxID>" + insightTxnId + "</InsightTxID>\n" +
"    <TransactionDateTime>" + MiscUtil.getCurrentTimestamp("yyyyMMddHHmmss") + "</TransactionDateTime>\n" +
"    <ResponseCode>0</ResponseCode>\n" +
"    <ResponseDesc>Success</ResponseDesc>\n" +
"</Response>";
    }
    
    public String getFailedB2BDisbursementResponse(String request, String insightTxnId)
    {   
        Map<String, String> values = MiscUtil.extractAllTagValues(request);
        return "<Response>\n" +
"    <ThirdPartyReference>" + values.get(VodacomConstants.B2B_DISBURSEMENT_REQUEST_THIRD_PARTY_REFERENCE) + "</ThirdPartyReference>\n" +
"    <InsightTxID>" + insightTxnId + "</InsightTxID>\n" +
"    <TransactionDateTime>" + MiscUtil.getCurrentTimestamp("yyyyMMddHHmmss") + "</TransactionDateTime>\n" +
"    <ResponseCode>-2</ResponseCode>\n" +
"    <ResponseDesc>Duplicate Transaction</ResponseDesc>\n" +
"</Response>";
    }
    
    public String getSuccessLoginResponse()
    {
        return "<?xml version='1.0' encoding='UTF-8'?>\n" +
"<S:Envelope\n" +
"xmlns:S=\"http://schemas.xmlsoap.org/soap/envelope/\"\n" +
"xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" +
"<S:Header>\n" +
"<ns3:eventid\n" +
"xmlns:ns2=\"http://www.4cgroup.co.za/genericsoap\"\n" +
"xmlns:ns3=\"http://www.4cgroup.co.za/soapauth\">2500\n" +
"</ns3:eventid>\n" +
"</S:Header>\n" +
"<S:Body>\n" +
"<ns2:getGenericResultResponse\n" +
"xmlns:ns2=\"http://www.4cgroup.co.za/genericsoap\"\n" +
"xmlns:ns3=\"http://www.4cgroup.co.za/soapauth\">\n" +
"<SOAPAPIResult>\n" +
"<eventInfo>\n" +
"<code>3</code>\n" +
"<description>Processed</description>\n" +
"<detail>Processed</detail>\n" +
"<transactionID>" + (UUID.randomUUID()).toString() + "</transactionID>\n" +
"</eventInfo>\n" +
"<request>\n" +
"<dataItem>\n" +
"<name>Username</name>\n" +
"<type>String</type>\n" +
"<value>thirdpartyc2bw</value>\n" +
"</dataItem>\n" +
"<dataItem>\n" +
"<name>Password</name>\n" +
"<type>String</type>\n" +
"<value>thirdpartyc2bw</value>\n" +
"</dataItem>\n" +
"</request>\n" +
"<response>\n" +
"<dataItem>\n" +
"<name>SessionID</name>\n" +
"<type>String</type>\n" +
"<value>" + (UUID.randomUUID()).toString() + "</value>\n" +
"</dataItem>\n" +
"</response>\n" +
"</SOAPAPIResult>\n" +
"</ns2:getGenericResultResponse>\n" +
"</S:Body>\n" +
"</S:Envelope>";
    }
    
    public String getSuccessB2BLoginResponse()
    {
        return "<Response>\n" +
"    <SessionID>" + MiscUtil.getRandomUUID() + "</SessionID>\n" +
"    <ResultCode>0</ResultCode>\n" +
"    <ResultDesc>Success</ResultDesc>\n" +
"</Response>";
    }
    
    public String getFailedB2BLoginResponse()
    {
        return "<Response>\n" +
"<ResultCode>-1</ResultCode>\n" +
"<ResultDesc>Invalid Credentials</ResultDesc>\n" +
"</Response> ";
    }
    
    public String getFailedLoginResponse()
    {
        return "<?xml version='1.0' encoding='UTF-8'?>\n" +
"<S:Envelope\n" +
"xmlns:S=\"http://schemas.xmlsoap.org/soap/envelope/\"\n" +
"xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" +
"<S:Header>\n" +
"<ns3:eventid\n" +
"xmlns:ns2=\"http://www.4cgroup.co.za/genericsoap\"\n" +
"xmlns:ns3=\"http://www.4cgroup.co.za/soapauth\">2500\n" +
"</ns3:eventid>\n" +
"</S:Header>\n" +
"<S:Body>\n" +
"<ns2:getGenericResultResponse\n" +
"xmlns:ns2=\"http://www.4cgroup.co.za/genericsoap\"\n" +
"xmlns:ns3=\"http://www.4cgroup.co.za/soapauth\">\n" +
"<SOAPAPIResult>\n" +
"<eventInfo>\n" +
"<code>4</code>\n" +
"<description>Failed</description>\n" +
"<detail>Processed</detail>\n" +
"</eventInfo>\n" +
"<request>\n" +
"<dataItem>\n" +
"<name>Username</name>\n" +
"<type>String</type>\n" +
"<value>thirdpartyc2bw</value>\n" +
"</dataItem>\n" +
"<dataItem>\n" +
"<name>Password</name>\n" +
"<type>String</type>\n" +
"<value>thirdpartyc2bw</value>\n" +
"</dataItem>\n" +
"</request>\n" +
"<response>\n" +
"<dataItem>\n" +
"<name>SessionID</name>\n" +
"<type>String</type>\n" +
"<value>dbcb63a40afd4191a990d66ed9cb62f7</value>\n" +
"</dataItem>\n" +
"</response>\n" +
"</SOAPAPIResult>\n" +
"</ns2:getGenericResultResponse>\n" +
"</S:Body>\n" +
"</S:Envelope>";
    }
    
    private String writeServletSuccessMsg(String msg, String rrn, String tranID) {
        try {
            InqResponse rs = new InqResponse();
            Eazzycashres eazzycashres = new Eazzycashres();
            eazzycashres.status = "OK";
            eazzycashres.responseCode = "00";
            eazzycashres.walletTranID = tranID;
            rs.setMsgId(rrn);
            rs.setEazzycashres(eazzycashres);
            JAXBContext jaxbContext = JAXBContext.newInstance(InqResponse.class);
            Marshaller jaxbMarshaller = jaxbContext.createMarshaller();

            jaxbMarshaller.setProperty("jaxb.formatted.output", Boolean.valueOf(true));


            StringWriter jaxwriter = new StringWriter();
            jaxbMarshaller.marshal(rs, jaxwriter);
            StringBuffer jaxrespBfr = jaxwriter.getBuffer();;
            String response = jaxrespBfr.toString();
            System.out.println(msg + response);
            return response;
        } catch (JAXBException e) {
            e.printStackTrace(System.out);
        }
        return null;
    }
    
    private String writeServletErrorMsg(String msg, InqResponse rs) {
        try {
            if (msg.contains("Timeout")) {
                (rs.getEazzycashres()).status = "ERROR|-3";
            } else {
                (rs.getEazzycashres()).status = "ERROR";
            }

            JAXBContext jaxbContext = JAXBContext.newInstance(InqResponse.class);
            Marshaller jaxbMarshaller = jaxbContext.createMarshaller();
            jaxbMarshaller.setProperty("jaxb.formatted.output", Boolean.valueOf(true));
            StringWriter jaxwriter = new StringWriter();
            jaxbMarshaller.marshal(rs, jaxwriter);
            StringBuffer jaxrespBfr = jaxwriter.getBuffer();
            String response = jaxrespBfr.toString();
            System.out.println(msg + response);
            System.out.println(msg);
            System.out.println(msg + jaxrespBfr.toString());
            return response;
        } catch (JAXBException e) {
            e.printStackTrace(System.out);
        }
        return null;
    }
    
}
