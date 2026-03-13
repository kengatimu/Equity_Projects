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
import com.equitybankgroup.payments.b2c.dto.vodacom.constants.SafaricomB2BConstants;
import com.equitybankgroup.payments.b2c.dto.vodacom.constants.VodacomConstants;
import com.equitybankgroup.payments.b2c.service.business.VodacomBankToWalletService;
import com.equitybankgroup.payments.b2c.service.business.http.OutboundHttpAdapter;
import com.equitybankgroup.payments.b2c.service.util.MiscUtil;
import static com.equitybankgroup.payments.b2c.service.util.MiscUtil.extractCDATAContents;
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
public class SafaricomMockController {

    @Value("${safaricom.ke.b2b.mock.scenario.disbursement}")
    String disbursementScenario;

    @Autowired
    OutboundHttpAdapter httpAdapter;

    @Autowired
    Executor taskExecutor;

    @PostMapping("/mminterface/request")
    public ResponseEntity postTransactionB2B(@RequestBody String disbursement) {
        disbursement = MiscUtil.extractCDATAContents(disbursement);
        Map<String, String> values = MiscUtil.extractAllTagValues(disbursement);
        String originatorConversationID = values.get(SafaricomB2BConstants.B2B_DISBURSEMENT_REQUEST_ORIGINATOR_CONV_ID);
        String conversationID = values.get(SafaricomB2BConstants.B2B_DISBURSEMENT_REQUEST_CONV_ID);
        String callbackEndpoint = values.get(SafaricomB2BConstants.B2B_DISBURSEMENT_REQUEST_RESULT_URL);
        try {

            if (disbursementScenario.equalsIgnoreCase("success")) {
                return new ResponseEntity(getSuccessB2BDisbursementResponse(conversationID, originatorConversationID), HttpStatus.OK);
            }

            return new ResponseEntity(getFailedB2BDisbursementResponse(conversationID, originatorConversationID), HttpStatus.OK);
        } finally {
            final String originatorConversationID1 = originatorConversationID;
            final String conversationID1 = conversationID;
            final String callbackEndpoint1 = callbackEndpoint;
            taskExecutor.execute(() -> {
                sendB2BCallback(originatorConversationID1, conversationID1, callbackEndpoint1);
            });
        }

    }

    public void sendB2BCallback(String conversationID, String originatorConversationID, String callbackEndpoint) {

        String request = (disbursementScenario.equalsIgnoreCase("success"))
                ? getSuccessB2BCallbackRequest(originatorConversationID, conversationID)
                : getFailedB2BCallbackRequest(originatorConversationID, conversationID);
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "text/xml");
        httpAdapter.httpPost(callbackEndpoint, headers, request);
    }

    private static String getSuccessB2BDisbursementResponse(String conversationID, String originatorConversationID) {
        String b2bResponse = "<response xmlns=\"http://api-v1.gen.mm.vodafone.com/mminterface/response\">\n"
                + "    <ResponseCode>ResponseCode0</ResponseCode>\n"
                + "    <ResponseDesc>ResponseDesc0</ResponseDesc>\n"
                + "    <ConversationID>" + conversationID + "</ConversationID>\n"
                + "    <OriginatorConversationID>" + originatorConversationID + "</OriginatorConversationID>\n"
                + "    <ServiceStatus>0</ServiceStatus>\n"
                + "</response>";
        return "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:req=\"http://api- v1.gen.mm.vodafone.com/mminterface/request\">\n"
                + "    <soapenv:Header/>\n"
                + "    <soapenv:Body>\n"
                + "        <req:ResponseMsg>\n"
                + "            <![CDATA[\n"
                + "               " + b2bResponse + "\n"
                + "            ]]>\n"
                + "        </req:ResponseMsg>\n"
                + "    </soapenv:Body>\n"
                + "</soapenv:Envelope>";
    }

    private String getFailedB2BDisbursementResponse(String conversationID, String originatorConversationID) {
        String b2bResponse = "<response xmlns=\"http://api-v1.gen.mm.vodafone.com/mminterface/response\">\n"
                + "    <ResponseCode>ResponseCode0</ResponseCode>\n"
                + "    <ResponseDesc>ResponseDesc0</ResponseDesc>\n"
                + "    <ConversationID>" + conversationID + "</ConversationID>\n"
                + "    <OriginatorConversationID>" + originatorConversationID + "</OriginatorConversationID>\n"
                + "    <ServiceStatus>7</ServiceStatus>\n"
                + "</response>";
        return "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:req=\"http://api- v1.gen.mm.vodafone.com/mminterface/request\">\n"
                + "    <soapenv:Header/>\n"
                + "    <soapenv:Body>\n"
                + "        <req:ResponseMsg>\n"
                + "            <![CDATA[\n"
                + "               " + b2bResponse + "\n"
                + "            ]]>\n"
                + "        </req:ResponseMsg>\n"
                + "    </soapenv:Body>\n"
                + "</soapenv:Envelope>";
    }

    private String getSuccessB2BCallbackRequest(String conversationID, String originatorConversationID) {
        String b2bCallbackRequest = "<result>\n"
                + "    <ResultType>0</ResultType>\n"
                + "    <ResultCode>0</ResultCode>\n"
                + "    <ResultDesc>The service request is processed successfully.</ResultDesc>\n"
                + "    <OriginatorConversationID>" + originatorConversationID + "</OriginatorConversationID>\n"
                + "    <ConversationID>" + conversationID + "</ConversationID>\n"
                + "    <TransactionID>" + MiscUtil.generateRandomRRN(10) + "</TransactionID>\n"
                + "    <ResultParameters>\n"
                + "        <ResultParameter>\n"
                + "            <Key>Currency</Key>\n"
                + "            <Value>KES</Value>\n"
                + "        </ResultParameter>\n"
                + "        <ResultParameter>\n"
                + "            <Key>DebitAccountCurrentBalance</Key>\n"
                + "            <Value>{Amount={BasicAmount=8995089.00,MinimumAmount=899508900,CurrencyCode=KES}}</Value>\n"
                + "        </ResultParameter>\n"
                + "    </ResultParameters>\n"
                + "    <ReferenceData>\n"
                + "        <ReferenceItem>\n"
                + "            <Key>QueueTimeoutURL</Key>\n"
                + "            <Value>http://10.66.49.789:7888/new</Value>\n"
                + "        </ReferenceItem>\n"
                + "    </ReferenceData>\n"
                + "</result>";

        return "<?xml version='1.0' encoding='UTF-8'?>\n"
                + "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                + "    <soapenv:Body>\n"
                + "        <res:ResultMsg xmlns:res=\"http://api-v1.gen.mm.vodafone.com/mminterface/result\">\n"
                + "            <![CDATA[" + b2bCallbackRequest + "]]>\n"
                + "        </res:ResultMsg>\n"
                + "    </soapenv:Body>\n"
                + "</soapenv:Envelope>";
    }

    private String getFailedB2BCallbackRequest(String conversationID, String originatorConversationID) {
        String b2bCallbackRequest = "<result>\n"
                + "    <ResultType>7</ResultType>\n"
                + "    <ResultCode>7</ResultCode>\n"
                + "    <ResultDesc>The service request failed.</ResultDesc>\n"
                + "    <OriginatorConversationID>" + originatorConversationID + "</OriginatorConversationID>\n"
                + "    <ConversationID>" + conversationID + "</ConversationID>\n"
                + "    <TransactionID>" + MiscUtil.generateRandomRRN(10) + "</TransactionID>\n"
                + "    <ReferenceData>\n"
                + "        <ReferenceItem>\n"
                + "            <Key>QueueTimeoutURL</Key>\n"
                + "            <Value>http://10.66.49.789:7888/new</Value>\n"
                + "        </ReferenceItem>\n"
                + "    </ReferenceData>\n"
                + "</result>";

        return "<?xml version='1.0' encoding='UTF-8'?>\n"
                + "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                + "    <soapenv:Body>\n"
                + "        <res:ResultMsg xmlns:res=\"http://api-v1.gen.mm.vodafone.com/mminterface/result\">\n"
                + "            <![CDATA[" + b2bCallbackRequest + "]]>\n"
                + "        </res:ResultMsg>\n"
                + "    </soapenv:Body>\n"
                + "</soapenv:Envelope>";
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
