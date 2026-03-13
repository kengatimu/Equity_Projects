package com.equitybank.gag.telco_b2c.service.impl;

import com.equitybank.gag.telco_b2c.dto.Eazzycash;
import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.dto.thunes.creditParties.creditPartyInfo.CreditPartyInformation;
import com.equitybank.gag.telco_b2c.dto.thunes.creditParties.creditPartyVerify.CreditPartyVerify;
import com.equitybank.gag.telco_b2c.dto.thunes.transfer.quotation.CreateQuoteDto;
import com.equitybank.gag.telco_b2c.dto.thunes.transfer.transaction.TransactionRequestDto;
import com.equitybank.gag.telco_b2c.dto.wendi.namecheck.NamecheckRequest;
import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.enums.TransactionStatus;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.service.PayloadService;
import com.equitybank.gag.telco_b2c.service.TelcoAccountResolverService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.ByteArrayInputStream;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;

import static com.equitybank.gag.telco_b2c.config.ApplicationConstants.*;
import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.*;

@Service
public class PayloadServiceImpl implements PayloadService {
    private static final Logger log = LoggerFactory.getLogger(PayloadServiceImpl.class);

    private final String wendiClientId;
    private final TelcoAccountResolverService telcoAccountResolverService;

    public PayloadServiceImpl(@Value("${wendi.client_id}") String wendiClientId,
                              TelcoAccountResolverService telcoAccountResolverService) {
        this.wendiClientId = wendiClientId;
        this.telcoAccountResolverService = telcoAccountResolverService;
    }

    @Override
    public String transactionErrorResponseXml(String rrn, String errorCode, String errorDescription) {
        if (errorDescription.contains("timeout")
                || errorDescription.contains("time out")
                || errorDescription.contains("timed out")) {
            errorCode = TIMEOUT_STATUS_CODE;
        }

        return "<response>\n" +
                "    <msgId>" + rrn + "</msgId>\n" +
                "    <eazzycashres>\n" +
                "        <rrn>" + rrn + "</rrn>\n" +
                "        <status>ERROR|" + errorCode + "</status>\n" +
                "        <responseCode>" + errorCode + "</responseCode>\n" +
                "        <responseDesc>" + errorDescription + "</responseDesc>\n" +
                "    </eazzycashres>\n" +
                "</response>";
    }

    @Override
    public String composeStatusCheckResponse(TransactionDetails transactionDetails, String rrn) {
        String status;
        String responseCode;
        String tranId = transactionDetails.getStatusDetails().getTranId();
        String tranStatus = transactionDetails.getStatusDetails().getStatus();
        String statusCode = transactionDetails.getStatusDetails().getStatusCode();
        String statusMessage = transactionDetails.getStatusDetails().getStatusMessage();

        if ("OK".equalsIgnoreCase(tranStatus)) {
            status = "OK|" + tranId;
            responseCode = "000";
            statusMessage = "Success";
        } else {
            status = tranStatus + "|" + statusCode;
            responseCode = statusCode;
        }

        return "<eazzycashStatusRes>\n" +
                "    <msgId>" + rrn + "</msgId>\n" +
                "    <eazzycashres>\n" +
                "        <rrn>" + rrn + "</rrn>\n" +
                "        <status>" + status + "</status>\n" +
                "        <responseCode>" + responseCode + "</responseCode>\n" +
                "        <responseDesc>" + statusMessage + "</responseDesc>\n" +
                "    </eazzycashres>\n" +
                "</eazzycashStatusRes>";
    }

    @Override
    public String statusCheckErrorResponseXml(String rrn, String errorCode, String errorDescription) {
        if (errorDescription.contains("timeout")
                || errorDescription.contains("time out")
                || errorDescription.contains("timed out")) {
            errorCode = TIMEOUT_STATUS_CODE;
        }

        return "<eazzycashStatusRes>\n" +
                "    <msgId>" + rrn + "</msgId>\n" +
                "    <eazzycashres>\n" +
                "        <rrn>" + rrn + "</rrn>\n" +
                "        <status>ERROR|" + errorCode + "</status>\n" +
                "        <responseCode>" + errorCode + "</responseCode>\n" +
                "        <responseDesc>" + errorDescription + "</responseDesc>\n" +
                "    </eazzycashres>\n" +
                "</eazzycashStatusRes>";
    }

    @Override
    public String airtimeTopUpErrorResponseXml(String version, String errorCode, String errorDescription) {
        if (errorDescription.contains("timeout")
                || errorDescription.contains("time out")
                || errorDescription.contains("timed out")) {
            errorCode = TIMEOUT_STATUS_CODE;
        }

        if (version.equals("json")) {
            return "{\n" +
                    "    \"OriginTransactionID\": null,\n" +
                    "    \"TransactionID\": null,\n" +
                    "    \"Status\": \"" + errorCode + "\",\n" +
                    "    \"TransactionStatus\": \"0\"\n" +
                    "}";
        }

        return "<Envelope>\n" +
                "    <Body>\n" +
                "        <topupResponse>\n" +
                "            <return>ERROR|" + errorCode + "</return>\n" +
                "            <responseCode>" + errorCode + "</responseCode>\n" +
                "            <responseDesc>" + errorDescription + "</responseDesc>\n" +
                "            </topupResponse>\n" +
                "    </Body>\n" +
                "</Envelope>";
    }

    @Override
    public String imtDefaultErrorResponseXml(String rrn, String errorCode, String errorDescription, TransactionStatus tranStatus) {
        String status = tranStatus + "|";
        if (errorDescription.contains("timeout")
                || errorDescription.contains("time out")
                || errorDescription.contains("timed out")) {
            errorCode = TIMEOUT_STATUS_CODE;
            status = TransactionStatus.ERROR.toString();
        }

        return "<statusDetails>\n" +
                "    <rrn>" + rrn + "</rrn>\n" +
                "    <status>" + status + errorCode + "</status>\n" +
                "    <responseCode>" + errorCode + "</responseCode>\n" +
                "    <responseDesc>" + errorDescription + "</responseDesc>\n" +
                "</statusDetails>";
    }

    @Override
    public String imtPendingResponseXml(String rrn, String pendingStatusCode, String pendingStatusDescription, TransactionStatus tranStatus) {
        String status = tranStatus + "|";
        if (pendingStatusDescription.contains("timeout")
                || pendingStatusDescription.contains("time out")
                || pendingStatusDescription.contains("timed out")) {
            pendingStatusCode = TIMEOUT_STATUS_CODE;
            status = TransactionStatus.ERROR.toString();
        }

        return "<statusDetails>\n" +
                "    <rrn>" + rrn + "</rrn>\n" +
                "    <status>" + status + pendingStatusCode + "</status>\n" +
                "    <responseCode>" + pendingStatusCode + "</responseCode>\n" +
                "    <responseDesc>" + pendingStatusDescription + "</responseDesc>\n" +
                "</statusDetails>";
    }

    @Override
    public String imtFinalSuccessResponseXml(String rrn, Map<String, String> responseDetailsMap) {
//        String status = "OK" + "|";
        String status = "OK";
        String responseCode = "000";
        String responseDesc = "Transaction Was Processed Successfully.";

        return "<statusDetails>\n" +
                "    <rrn>" + rrn + "</rrn>\n" +
                "    <status>" + status + "</status>\n" +
                "    <responseCode>" + responseCode + "</responseCode>\n" +
                "    <responseDesc>" + responseDesc + "</responseDesc>\n" +
                "    <doCheckIn>" + responseDetailsMap.get("doCheckIn") + "</doCheckIn>\n" +
                "    <timeStamp>" + responseDetailsMap.get("timeStamp") + "</timeStamp>\n" +
                "    <flags>" + responseDetailsMap.get("flags") + "</flags>\n" +
                "    <referenceNumber>" + responseDetailsMap.get("referenceNumber") + "</referenceNumber>\n" +
                "    <expectedDateOfDelivery>" + responseDetailsMap.get("expectedDateOfDelivery") + "</expectedDateOfDelivery>\n" +
                "    <transactionDateTime>" + responseDetailsMap.get("transactionDateTime") + "</transactionDateTime>\n" +
                "</statusDetails>";
    }

    @Override
    public String technicalServiceCallBackResponse(String rrn) {
        String status = "OK|000";
        String statusCode = "000";
        String statusMessage = "Callback processed successfully.";
        return "<statusDetails>\n" +
                "    <rrn>" + rrn + "</rrn>\n" +
                "    <status>" + status + "</status>\n" +
                "    <responseCode>" + statusCode + "</responseCode>\n" +
                "    <responseDesc>" + statusMessage + "</responseDesc>\n" +
                "</statusDetails>";
    }

    @Override
    public String defaultTechnicalServiceErrorResponse(String errorCode, String errorDesc) {
        String faultCode = "soapenv:Client";
        return "<soapenv:Envelope " +
                "xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" " +
                "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" " +
                "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">\n" +
                "    <soapenv:Body>\n" +
                "        <soapenv:Fault>\n" +
                "            <faultcode>" + faultCode + "</faultcode>\n" +
                "            <faultstring>" + errorDesc + "</faultstring>\n" +
                "            <detail>\n" +
                "                <ac:errors xmlns:ac=\"http://www.moneygram.com/AgentConnect1512\">\n" +
                "                    <ac:error>\n" +
                "                        <ac:errorCode>" + errorCode + "</ac:errorCode>\n" +
                "                        <ac:errorString>" + errorDesc + "</ac:errorString>\n" +
                "                    </ac:error>\n" +
                "                </ac:errors>\n" +
                "                <ns1:exceptionName xmlns:ns1=\"http://xml.apache.org/axis/\">com.moneygram.agentconnect.soap.ACException</ns1:exceptionName>\n" +
                "            </detail>\n" +
                "        </soapenv:Fault>\n" +
                "    </soapenv:Body>\n" +
                "</soapenv:Envelope>";
    }

    @Override
    public String composeFloatPurchaseErrorResponse(String rrn, String errorCode, String errorDescription, Map<String, String> finFloatXmlTagsMap, String channel) {
        if (errorDescription.contains("timeout")
                || errorDescription.contains("time out")
                || errorDescription.contains("timed out")) {
            errorCode = TIMEOUT_STATUS_CODE;
        }

        // Build Finacle over the counter error response
        if (DEFAULT_FIN_CHANNEL.equalsIgnoreCase(channel)) {
            return "<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" +
                    "    <soap:Body>\n" +
                    "        <ns2:finRequestResponse xmlns:ns2=\"http://ws.equitybank/\">\n" +
                    "            <return>\n" +
                    "                <amount>" + finFloatXmlTagsMap.get("amount") + "</amount>\n" +
                    "                <branchName>" + finFloatXmlTagsMap.get("branchName") + "</branchName>\n" +
                    "                <dealerAccountNumber>" + finFloatXmlTagsMap.get("dealerAccountNumber") + "</dealerAccountNumber>\n" +
                    "                <dealerCode>" + finFloatXmlTagsMap.get("dealerCode") + "</dealerCode>\n" +
                    "                <dealerName>" + errorDescription + "</dealerName>\n" +
                    "                <finacleUserId>" + finFloatXmlTagsMap.get("finacleUserId") + "</finacleUserId>\n" +
                    "                <payMethod>" + finFloatXmlTagsMap.get("payMethod") + "</payMethod>\n" +
                    "                <payRef>" + finFloatXmlTagsMap.get("payRef") +"</payRef>\n" +
                    "                <respCode>" + FINACLE_DEFAULT_FAILURE_CODE + "</respCode>\n" +
                    "            </return>\n" +
                    "        </ns2:finRequestResponse>\n" +
                    "    </soap:Body>\n" +
                    "</soap:Envelope>";
        }

        return "<response>\n" +
                "    <msgId>" + rrn + "</msgId>\n" +
                "    <eazzycashres>\n" +
                "        <rrn>" + rrn + "</rrn>\n" +
                "        <status>ERROR|" + errorCode + "</status>\n" +
                "        <responseCode>" + errorCode + "</responseCode>\n" +
                "        <responseDesc>" + errorDescription + "</responseDesc>\n" +
                "    </eazzycashres>\n" +
                "</response>";
    }

    @Override
    public String composeNameCheckErrorResponse(String rrn, String telcom, String channel, String mobileNumber, String type, Map<String, String> finXmlTagsMap, String errorDescription) {
        // Build Finacle over the counter error response
        if (DEFAULT_FIN_CHANNEL.equalsIgnoreCase(channel)) {
            return "<soap:Envelope\n" +
                    "    xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" +
                    "    <soap:Body>\n" +
                    "        <ns2:authRequestResponse\n" +
                    "            xmlns:ns2=\"http://ws.equitybank/\">\n" +
                    "            <return>\n" +
                    "                <amount>" + finXmlTagsMap.get("amount") + "</amount>\n" +
                    "                <branchName>" + finXmlTagsMap.get("branchName") + "</branchName>\n" +
                    "                <dealerAccountNumber>" + finXmlTagsMap.get("dealerAccountNumber") + "</dealerAccountNumber>\n" +
                    "                <dealerCode>" + finXmlTagsMap.get("dealerCode") + "</dealerCode>\n" +
                    "                <dealerName>" + errorDescription + "</dealerName>\n" +
                    "                <payMethod>" + finXmlTagsMap.get("payMethod") + "</payMethod>\n" +
                    "                <payRef>" + finXmlTagsMap.get("payRef") +"</payRef>\n" +
                    "                <respCode>" + FINACLE_DEFAULT_FAILURE_CODE + "</respCode>\n" +
                    "            </return>\n" +
                    "        </ns2:authRequestResponse>\n" +
                    "    </soap:Body>\n" +
                    "</soap:Envelope>";
        }

        if ("float-purchase-namecheck".equals(type)) {
            return "<MobileNumberInquireRes>\n" +
                    "    <msgId>" + rrn + "</msgId>\n" +
                    "    <channel>" + channel + "</channel>\n" +
                    "    <telcom>" + telcom + "</telcom>\n" +
                    "    <mobileNumber>" + mobileNumber + "</mobileNumber>\n" +
                    "    <responseCode>01</responseCode>\n" +
                    "    <customerNames></customerNames>\n" +
                    "</MobileNumberInquireRes>";
        }

        return "<MobileNumberInquireRes>\n" +
                "    <msgId>" + rrn + "</msgId>\n" +
                "    <channel>" + channel + "</channel>\n" +
                "    <telcom>" + telcom + "</telcom>\n" +
                "    <mobileNumber>" + mobileNumber + "</mobileNumber>\n" +
                "    <responseCode>00</responseCode>\n" +
                "    <customerNames></customerNames>\n" +
                "</MobileNumberInquireRes>";
    }

    @Override
    public String composeFinacleGetRateXmlRequest() {
        String messageDateTime = composeMessageDateTime();
        String toCurrency = "USD";
        String fromCurrency = "CDF";
        String defaultAmount = "1";

        return "<FIXML\n" +
                "    xmlns=\"http://www.finacle.com/fixml\"\n" +
                "    xsi:schemaLocation=\"http://www.finacle.com/fixmlSBAcctAdd.xsd\"\n" +
                "    xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\n" +
                "    <Header>\n" +
                "        <RequestHeader>\n" +
                "            <MessageKey>\n" +
                "                <ServiceRequestVersion>10.2</ServiceRequestVersion>\n" +
                "                <RequestUUID>" + messageDateTime + "</RequestUUID>\n" +
                "                <ChannelId>" + FINACLE_RATE_CODE_CHANNEL_ID + "</ChannelId>\n" +
                "                <ServiceRequestId>getExchangeRateForRateCode</ServiceRequestId>\n" +
                "            </MessageKey>\n" +
                "            <RequestMessageInfo>\n" +
                "                <EntityId/>\n" +
                "                <EntityType/>\n" +
                "                <MessageDateTime>" + messageDateTime + "</MessageDateTime>\n" +
                "                <TimeZone/>\n" +
                "                <ArmCorrelationId/>\n" +
                "                <BankId>" + DEFAULT_BANK_ID + "</BankId>\n" +
                "            </RequestMessageInfo>\n" +
                "            <Security>\n" +
                "                <FICertToken/>\n" +
                "                <SSOTransferToken/>\n" +
                "                <Token>\n" +
                "                    <PasswordToken>\n" +
                "                        <UserId/>\n" +
                "                        <Password/>\n" +
                "                    </PasswordToken>\n" +
                "                </Token>\n" +
                "                <RealUserLoginSessionId/>\n" +
                "                <RealUser/>\n" +
                "                <RealUserPwd/>\n" +
                "            </Security>\n" +
                "        </RequestHeader>\n" +
                "    </Header>\n" +
                "    <Body>\n" +
                "        <getExchangeRateForRateCodeRequest>\n" +
                "            <getExchangeRateForRateCode_CustomData/>\n" +
                "            <ExchangeRateForRateCodeInputVO>\n" +
                "                <toCrncyCode>" + toCurrency + "</toCrncyCode>\n" +
                "                <fromCrncyCode>" + fromCurrency + "</fromCrncyCode>\n" +
                "                <rateCode>" + FINACLE_RATE_CODE + "</rateCode>\n" +
                "                <txnAmount>\n" +
                "                    <amountValue>" + defaultAmount + "</amountValue>\n" +
                "                </txnAmount>\n" +
                "            </ExchangeRateForRateCodeInputVO>\n" +
                "        </getExchangeRateForRateCodeRequest>\n" +
                "    </Body>\n" +
                "</FIXML>";
    }

    @Override
    public String composeDefaultErrorResponse(String errorCode, String errorDescription) {
        return "<response>\n" +
                "    <errorCode>" + errorCode + "</errorCode>\n" +
                "    <errorMessage>" + errorDescription + "</errorMessage>\n" +
                "</response>";
    }

    @Override
    public String getErrorResponse(request channelRequest, String responseCode, String responseDesc) {
        return "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>\n" +
                "<response>\n" +
                "    <msgId>" + channelRequest.getMsgId() + "</msgId>\n" +
                "    <eazzycashres>\n" +
                "        <rrn>" + channelRequest.getMsgId() + "</rrn>\n" +
                "        <status>ERROR|" + responseCode + "</status>\n" +
                "        <responseCode>" + responseCode + "</responseCode>\n" +
                "        <responseDesc>" + responseDesc + "</responseDesc>\n" +
                "    </eazzycashres>\n" +
                "</response>";
    }

    @Override
    public String composeChannelCallbackSuccessResponse(Map<String, String> xmlTagsMap, String rrn) {
        return "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
                "<mpesaResultCallBack>\n" +
                "    <rrn>" + xmlTagsMap.get("thirdPartyReference") + "</rrn>\n" +
                "    <responseCode>0</responseCode>\n" +
                "    <responseDesc>Success</responseDesc>\n" +
                "    <mpesaTranID>" + xmlTagsMap.get("transactionId") + "</mpesaTranID>\n" +
                "    <timeStamp></timeStamp>\n" +
                "    <receiverName ></receiverName>\n" +
                "    <receiverMsisdn ></receiverMsisdn>\n" +
                "</mpesaResultCallBack>";


    }

    @Override
    public String composeChannelCallbackFailureResponse(Map<String, String> xmlTagsMap, String rrn) {
        return "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
                "<mpesaResultCallBack>\n" +
                "    <rrn>" + xmlTagsMap.get("thirdPartyReference") + "</rrn>\n" +
                "    <responseCode>400</responseCode>\n" +
                "    <responseDesc>Failure: " + xmlTagsMap.get("resultDesc") + "</responseDesc>\n" +
                "    <mpesaTranID></mpesaTranID>\n" +
                "    <timeStamp></timeStamp>\n" +
                "    <receiverName ></receiverName>\n" +
                "    <receiverMsisdn ></receiverMsisdn>\n" +
                "</mpesaResultCallBack>";
    }

    @Override
    public Object composeCallbackResponse(Map<String, String> xmlTagsMap) {
        return "{\n" +
                "    \"reference\": \"" + xmlTagsMap.get("thirdPartyReference") + "\",\n" +
                "    \"responseCode\": \"00\",\n" +
                "    \"responseDescription\": \"Callback Received and Processed Successfully\"\n" +
                "}";
    }

    @Override
    public String finReqToFloatPurchaseNamecheckReq(Map<String, String> xmlTagsMap) throws CustomException {
        // Get the bankId, currency, and telco
        Map<String, String> dealerAccountInfoMap = telcoAccountResolverService.resolveTelcoNameForFinacleFloatPurchase(xmlTagsMap);

        return "<mobileNumberInquireReq\n" +
                "    xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"\n" +
                "    xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">\n" +
                "    <msgId>" + xmlTagsMap.get("payRef") + "</msgId>\n" +
                "    <bankId>" + dealerAccountInfoMap.get("bankId") + "</bankId>\n" +
                "    <channel>" + DEFAULT_FIN_CHANNEL + "</channel>\n" +
                "    <telcom>" + dealerAccountInfoMap.get("telco") + "</telcom>\n" +
                "    <mobileNumber>" + xmlTagsMap.get("dealerCode") + "</mobileNumber>\n" +
                "    <tillNumber>" + xmlTagsMap.get("dealerCode") + "</tillNumber>\n" +
                "    <timestamp></timestamp>\n" +
                "    <amount>0</amount>\n" +
                "    <signature>" + getDummySignature() + "</signature>\n" +
                "</mobileNumberInquireReq>";
    }

    @Override
    public request finReqToFloatPurchaseTranReq(Map<String, String> xmlTagsMap) throws CustomException {
        // Make sure the rrn is not less than 12 digits
        String payRef = xmlTagsMap.get("payRef");
        String paddedRrn = StringUtils.leftPad(payRef, 12, '0');

        // Get the bankId, currency, and telco
        Map<String, String> dealerAccountInfoMap = telcoAccountResolverService.resolveTelcoNameForFinacleFloatPurchase(xmlTagsMap);

        // Compose the request object
        Eazzycash eazzycash = new Eazzycash();
        eazzycash.setRrn(paddedRrn);
        eazzycash.setBankId(dealerAccountInfoMap.get("bankId"));
        eazzycash.setAmount(new BigDecimal(xmlTagsMap.get("amount")));
        eazzycash.setAmountCurrency(dealerAccountInfoMap.get("currency"));
        eazzycash.setSourceAccount("");
        eazzycash.setCurrency(dealerAccountInfoMap.get("currency"));
        eazzycash.setChargeAmount(BigDecimal.ZERO);
        eazzycash.setChargeCurrency(dealerAccountInfoMap.get("currency"));
        eazzycash.setName(xmlTagsMap.getOrDefault("dealerName", ""));
        eazzycash.setNumber(xmlTagsMap.get("dealerCode"));
        eazzycash.setTelco(dealerAccountInfoMap.get("telco"));
        eazzycash.setDestinationShortCode(xmlTagsMap.get("dealerCode"));
        eazzycash.setStoreNumber("");
        eazzycash.setChannel(DEFAULT_FIN_CHANNEL);
        eazzycash.setTranType("BUYFLOAT");
        eazzycash.setSource(DEFAULT_FIN_CHANNEL);
        eazzycash.setNarration("Float purchase");
        eazzycash.setChargeFlag("N");
        eazzycash.setSignature(getDummySignature());

        request request = new request();
        request.setMsgId(paddedRrn);
        request.setEazzycash(eazzycash);

        return request;
    }

    @Override
    public String generateFinNamecheckResponse(String responseXml, Map<String, String> finXmlTagsMap) throws CustomException {
        try {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document document = builder.parse(new ByteArrayInputStream(responseXml.getBytes()));

            document.getDocumentElement().normalize();

            String responseCode = getTagValue(document, "responseCode");
            String customerNames = getTagValue(document, "customerNames");

            if ("01".equals(responseCode)) {
                responseCode = FINACLE_DEFAULT_FAILURE_CODE;
                customerNames = "Request Failed";
            }

            // Build Finacle over the counter response
            return "<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" +
                    "    <soap:Body>\n" +
                    "        <ns2:authRequestResponse xmlns:ns2=\"http://ws.equitybank/\">\n" +
                    "            <return>\n" +
                    "                <amount>" + finXmlTagsMap.get("amount") + "</amount>\n" +
                    "                <branchName>" + finXmlTagsMap.get("branchName") + "</branchName>\n" +
                    "                <dealerAccountNumber>" + finXmlTagsMap.get("dealerAccountNumber") + "</dealerAccountNumber>\n" +
                    "                <dealerCode>" + finXmlTagsMap.get("dealerCode") + "</dealerCode>\n" +
                    "                <dealerName>" + customerNames + "</dealerName>\n" +
                    "                <payMethod></payMethod>\n" +
                    "                <payRef></payRef>\n" +
                    "                <respCode>" + responseCode + "</respCode>\n" +
                    "            </return>\n" +
                    "        </ns2:authRequestResponse>\n" +
                    "    </soap:Body>\n" +
                    "</soap:Envelope>";

        } catch (Exception e) {
            throw new CustomException(DEFAULT_PROCESSING_FAILURE + "Failed to parse MobileNumberInquireRes XML To Fin Response: " + e.getMessage());
        }
    }

    @Override
    public String generateFinFloatPurchaseResponse(String responseXml, Map<String, String> finFloatXmlTagsMap) throws CustomException {
        try {
            String responseCode = "00";
            String responseDesc = "SUCCESS";
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document document = builder.parse(new ByteArrayInputStream(responseXml.getBytes()));
            document.getDocumentElement().normalize();

            if ("ERROR".toUpperCase().contains(responseXml)) {
                responseCode = FINACLE_DEFAULT_FAILURE_CODE;
                responseDesc = getTagValue(document, "responseDesc");
            }

            // Build SOAP response
            return "<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" +
                    "    <soap:Body>\n" +
                    "        <ns2:finRequestResponse xmlns:ns2=\"http://ws.equitybank/\">\n" +
                    "            <return>\n" +
                    "                <amount>" + finFloatXmlTagsMap.get("amount") + "</amount>\n" +
                    "                <branchName>" + finFloatXmlTagsMap.get("branchName") + "</branchName>\n" +
                    "                <dealerAccountNumber>" + finFloatXmlTagsMap.get("dealerAccountNumber") + "</dealerAccountNumber>\n" +
                    "                <dealerCode>" + finFloatXmlTagsMap.get("dealerCode") + "</dealerCode>\n" +
                    "                <dealerName>" + responseDesc + "</dealerName>\n" +
                    "                <finacleUserId>" + finFloatXmlTagsMap.get("finacleUserId") + "</finacleUserId>\n" +
                    "                <payMethod>" + finFloatXmlTagsMap.get("payMethod") + "</payMethod>\n" +
                    "                <payRef>" + finFloatXmlTagsMap.get("payRef") + "</payRef>\n" +
                    "                <respCode>" + responseCode + "</respCode>\n" +
                    "                <serviceId>" + finFloatXmlTagsMap.get("serviceId") + "</serviceId>\n" +
                    "                <nationalID>" + finFloatXmlTagsMap.get("nationalID") + "</nationalID>\n" +
                    "            </return>\n" +
                    "        </ns2:finRequestResponse>\n" +
                    "    </soap:Body>\n" +
                    "</soap:Envelope>";

        } catch (Exception e) {
            throw new CustomException(DEFAULT_PROCESSING_FAILURE + "Failed to generate finRequestResponse from XML: " + e.getMessage());
        }
    }

    @Override
    public String thunesErrorResponseXml(String rrn, String errorCode, String errorDescription) {
        return "{\n" +
                "    \"channelStatusInfo\": {\n" +
                "        \"status\": \"FAILURE\",\n" +
                "        \"code\": \"01\",\n" +
                "        \"description\": \"" + errorDescription + "\"\n" +
                "    }\n" +
                "}";
    }

    @Override
    public String wendiErrorResponseXml(String rrn, String errorCode, String errorDescription) {
        return "{\n" +
                "    \"channelStatusInfo\": {\n" +
                "        \"status\": \"FAILURE\",\n" +
                "        \"code\": \"01\",\n" +
                "        \"description\": \"" + errorDescription + "\"\n" +
                "    }\n" +
                "}";
    }

    @Override
    public String generateThunesCreateQuoteRequest(CreateQuoteDto createQuoteDto) throws CustomException {
        return "{\n" +
                "    \"external_id\": \"" + createQuoteDto.getChannelInfo().getRrn() + "\",\n" +
                "    \"payer_id\": \"" + createQuoteDto.getReceiver().getPayerId() + "\",\n" +
                "    \"mode\": \""+ DEFAULT_THUNES_QUOTATION_MODE + "\",\n" +
                "    \"transaction_type\": \"" + createQuoteDto.getTransactionDetails().getTransactionType() + "\",\n" +
                "    \"source\": {\n" +
                "        \"amount\": \"" + createQuoteDto.getSender().getAmount() + "\",\n" +
                "        \"currency\": \"" + createQuoteDto.getSender().getCurrency() + "\",\n" +
                "        \"country_iso_code\": \"" + createQuoteDto.getSender().getCountryCode() + "\"\n" +
                "    },\n" +
                "    \"destination\": {\n" +
                "        \"amount\": null,\n" +
                "        \"currency\": \"" + createQuoteDto.getReceiver().getCurrency() + "\"\n" +
                "    }\n" +
                "}";
    }

    @Override
    public String generateThunesC2CRequest(TransactionRequestDto req) throws CustomException {

//        // Read request data once
//        Destination destination = req.getDestination();
//        Party sender = req.getParties().getSender();
//        Party receiver = req.getParties().getReceiver();
//
//        PersonalDetails senderPd = sender.getPersonalDetails();
//        ContactDetails senderCd = sender.getContactDetails();
//        Identification senderId = sender.getIdentification();
//
//        PersonalDetails receiverPd = receiver.getPersonalDetails();
//        ContactDetails receiverCd = receiver.getContactDetails();
//        Identification receiverId = receiver.getIdentification();
//
//        ChannelInfo channelInfo = req.getChannelInfo();
//        Fees fees = req.getFees();
//        Remittance remittance = req.getRemittance();
//
//        return "{\n" +
//                "  \"credit_party_identifier\": {\n" +
//                "    \"msisdn\": \"" + destination.getMsisdn() + "\",\n" +
//                "    \"bank_account_number\": \"" + destination.getBankAccountNumber() + "\",\n" +
//                "    \"swift_bic_code\": \"" + destination.getSwiftBicCode() + "\"\n" +
//                "  },\n" +
//
//                "  \"sender\": {\n" +
//                "    \"lastname\": \"" + senderPd.getLastname() + "\",\n" +
//                "    \"firstname\": \"" + senderPd.getFirstname() + "\",\n" +
//                "    \"nationality_country_iso_code\": \"" + senderPd.getNationalityCountryCode() + "\",\n" +
//                "    \"date_of_birth\": \"" + senderPd.getDateOfBirth() + "\",\n" +
//                "    \"country_of_birth_iso_code\": \"" + senderPd.getCountryOfBirthCode() + "\",\n" +
//                "    \"gender\": \"" + senderPd.getGender() + "\",\n" +
//                "    \"address\": \"" + senderCd.getAddress() + "\",\n" +
//                "    \"postal_code\": \"" + senderCd.getPostalCode() + "\",\n" +
//                "    \"city\": \"" + senderCd.getCity() + "\",\n" +
//                "    \"country_iso_code\": \"" + senderCd.getCountryCode() + "\",\n" +
//                "    \"msisdn\": \"" + senderCd.getMsisdn() + "\",\n" +
//                "    \"email\": \"" + senderCd.getEmail() + "\",\n" +
//                "    \"id_type\": \"" + senderId.getIdType() + "\",\n" +
//                "    \"id_number\": \"" + senderId.getIdNumber() + "\",\n" +
//                "    \"id_delivery_date\": \"" + senderId.getIdDeliveryDate() + "\",\n" +
//                "    \"occupation\": \"" + sender.getOccupation() + "\"\n" +
//                "  },\n" +
//
//                "  \"beneficiary\": {\n" +
//                "    \"lastname\": \"" + receiverPd.getLastname() + "\",\n" +
//                "    \"firstname\": \"" + receiverPd.getFirstname() + "\",\n" +
//                "    \"nationality_country_iso_code\": \"" + receiverPd.getNationalityCountryCode() + "\",\n" +
//                "    \"date_of_birth\": \"" + receiverPd.getDateOfBirth() + "\",\n" +
//                "    \"country_of_birth_iso_code\": \"" + receiverPd.getCountryOfBirthCode() + "\",\n" +
//                "    \"gender\": \"" + receiverPd.getGender() + "\",\n" +
//                "    \"address\": \"" + receiverCd.getAddress() + "\",\n" +
//                "    \"postal_code\": \"" + receiverCd.getPostalCode() + "\",\n" +
//                "    \"city\": \"" + receiverCd.getCity() + "\",\n" +
//                "    \"country_iso_code\": \"" + receiverCd.getCountryCode() + "\",\n" +
//                "    \"msisdn\": \"" + receiverCd.getMsisdn() + "\",\n" +
//                "    \"email\": \"" + receiverCd.getEmail() + "\",\n" +
//                "    \"id_type\": \"" + receiverId.getIdType() + "\",\n" +
//                "    \"id_country_iso_code\": \"" + receiverId.getIdCountryCode() + "\",\n" +
//                "    \"id_number\": \"" + receiverId.getIdNumber() + "\",\n" +
//                "    \"occupation\": \"" + receiver.getOccupation() + "\"\n" +
//                "  },\n" +
//
//                "  \"external_id\": \"" + channelInfo.getRrn() + "\",\n" +
//                "  \"retail_fee\": " + fees.getPartnerFee() + ",\n" +
//                "  \"retail_fee_currency\": \"" + fees.getPartnerFeeCurrency() + "\",\n" +
//                "  \"purpose_of_remittance\": \"" + remittance.getPurpose() + "\",\n" +
//                "  \"document_reference_number\": \"" + remittance.getDocumentReference() + "\",\n" +
//                "  \"callback_url\": \"" + channelInfo.getCallbackUrl() + "\",\n" +
//                "  \"reference\": \"" + remittance.getReference() + "\"\n" +
//                "}";
        return "";
    }

    @Override
    public String generateThunesC2BRequest(TransactionRequestDto req) throws CustomException {

//        // Read request data once
//        Destination destination = req.getDestination();
//
//        Party sender = req.getParties().getSender();
//        Party receiver = req.getParties().getReceiver();
//
//        PersonalDetails senderPd = sender.getPersonalDetails();
//        ContactDetails senderCd = sender.getContactDetails();
//        Identification senderId = sender.getIdentification();
//
//        BusinessDetails receiverBd = receiver.getBusinessDetails();
//        ContactDetails receiverCd = receiver.getContactDetails();
//        Representative receiverRep = receiver.getRepresentative();
//
//        ChannelInfo channelInfo = req.getChannelInfo();
//        Fees fees = req.getFees();
//        Remittance remittance = req.getRemittance();
//
//        return "{\n" +
//                "  \"credit_party_identifier\": {\n" +
//                "    \"msisdn\": \"" + destination.getMsisdn() + "\",\n" +
//                "    \"bank_account_number\": \"" + destination.getBankAccountNumber() + "\",\n" +
//                "    \"swift_bic_code\": \"" + destination.getSwiftBicCode() + "\"\n" +
//                "  },\n" +
//
//                "  \"sender\": {\n" +
//                "    \"lastname\": \"" + senderPd.getLastname() + "\",\n" +
//                "    \"firstname\": \"" + senderPd.getFirstname() + "\",\n" +
//                "    \"nationality_country_iso_code\": \"" + senderPd.getNationalityCountryCode() + "\",\n" +
//                "    \"date_of_birth\": \"" + senderPd.getDateOfBirth() + "\",\n" +
//                "    \"country_of_birth_iso_code\": \"" + senderPd.getCountryOfBirthCode() + "\",\n" +
//                "    \"gender\": \"" + senderPd.getGender() + "\",\n" +
//                "    \"address\": \"" + senderCd.getAddress() + "\",\n" +
//                "    \"postal_code\": \"" + senderCd.getPostalCode() + "\",\n" +
//                "    \"city\": \"" + senderCd.getCity() + "\",\n" +
//                "    \"country_iso_code\": \"" + senderCd.getCountryCode() + "\",\n" +
//                "    \"msisdn\": \"" + senderCd.getMsisdn() + "\",\n" +
//                "    \"email\": \"" + senderCd.getEmail() + "\",\n" +
//                "    \"id_type\": \"" + senderId.getIdType() + "\",\n" +
//                "    \"id_number\": \"" + senderId.getIdNumber() + "\",\n" +
//                "    \"id_delivery_date\": \"" + senderId.getIdDeliveryDate() + "\",\n" +
//                "    \"occupation\": \"" + sender.getOccupation() + "\"\n" +
//                "  },\n" +
//
//                "  \"receiving_business\": {\n" +
//                "    \"registered_name\": \"" + receiverBd.getRegisteredName() + "\",\n" +
//                "    \"trading_name\": \"" + receiverBd.getTradingName() + "\",\n" +
//                "    \"address\": \"" + receiverCd.getAddress() + "\",\n" +
//                "    \"postal_code\": \"" + receiverCd.getPostalCode() + "\",\n" +
//                "    \"city\": \"" + receiverCd.getCity() + "\",\n" +
//                "    \"country_iso_code\": \"" + receiverBd.getCountryCode() + "\",\n" +
//                "    \"msisdn\": \"" + receiverCd.getMsisdn() + "\",\n" +
//                "    \"email\": \"" + receiverCd.getEmail() + "\",\n" +
//                "    \"registration_number\": \"" + receiverBd.getRegistrationNumber() + "\",\n" +
//                "    \"tax_id\": \"" + receiverBd.getTaxId() + "\",\n" +
//                "    \"date_of_incorporation\": \"" + receiverBd.getDateOfIncorporation() + "\",\n" +
//                "    \"representative_lastname\": \"" + receiverRep.getLastname() + "\",\n" +
//                "    \"representative_firstname\": \"" + receiverRep.getFirstname() + "\",\n" +
//                "    \"representative_id_type\": \"" + receiverRep.getIdType() + "\",\n" +
//                "    \"representative_id_country_iso_code\": \"" + receiverRep.getIdCountryCode() + "\",\n" +
//                "    \"representative_id_number\": \"" + receiverRep.getIdNumber() + "\",\n" +
//                "    \"representative_id_delivery_date\": \"" + receiverRep.getIdDeliveryDate() + "\",\n" +
//                "    \"representative_id_expiration_date\": \"" + receiverRep.getIdExpirationDate() + "\"\n" +
//                "  },\n" +
//
//                "  \"external_id\": \"" + channelInfo.getRrn() + "\",\n" +
//                "  \"retail_fee\": " + fees.getPartnerFee() + ",\n" +
//                "  \"retail_fee_currency\": \"" + fees.getPartnerFeeCurrency() + "\",\n" +
//                "  \"purpose_of_remittance\": \"" + remittance.getPurpose() + "\",\n" +
//                "  \"document_reference_number\": \"" + remittance.getDocumentReference() + "\",\n" +
//                "  \"callback_url\": \"" + channelInfo.getCallbackUrl() + "\",\n" +
//                "  \"reference\": \"" + remittance.getReference() + "\"\n" +
//                "}";

        return "";
    }

    @Override
    public String generateThunesB2BRequest(TransactionRequestDto req) throws CustomException {

//        // Read request data once
//        Destination destination = req.getDestination();
//
//        Party sender = req.getParties().getSender();
//        Party receiver = req.getParties().getReceiver();
//
//        BusinessDetails senderBd = sender.getBusinessDetails();
//        ContactDetails senderCd = sender.getContactDetails();
//        Representative senderRep = sender.getRepresentative();
//
//        BusinessDetails receiverBd = receiver.getBusinessDetails();
//        ContactDetails receiverCd = receiver.getContactDetails();
//        Representative receiverRep = receiver.getRepresentative();
//
//        ChannelInfo channelInfo = req.getChannelInfo();
//        Fees fees = req.getFees();
//        Remittance remittance = req.getRemittance();
//
//        return "{\n" +
//                "  \"credit_party_identifier\": {\n" +
//                "    \"msisdn\": \"" + destination.getMsisdn() + "\",\n" +
//                "    \"bank_account_number\": \"" + destination.getBankAccountNumber() + "\",\n" +
//                "    \"swift_bic_code\": \"" + destination.getSwiftBicCode() + "\"\n" +
//                "  },\n" +
//
//                "  \"sending_business\": {\n" +
//                "    \"registered_name\": \"" + senderBd.getRegisteredName() + "\",\n" +
//                "    \"trading_name\": \"" + senderBd.getTradingName() + "\",\n" +
//                "    \"address\": \"" + senderCd.getAddress() + "\",\n" +
//                "    \"postal_code\": \"" + senderCd.getPostalCode() + "\",\n" +
//                "    \"city\": \"" + senderCd.getCity() + "\",\n" +
//                "    \"country_iso_code\": \"" + senderBd.getCountryCode() + "\",\n" +
//                "    \"msisdn\": \"" + senderCd.getMsisdn() + "\",\n" +
//                "    \"email\": \"" + senderCd.getEmail() + "\",\n" +
//                "    \"registration_number\": \"" + senderBd.getRegistrationNumber() + "\",\n" +
//                "    \"tax_id\": \"" + senderBd.getTaxId() + "\",\n" +
//                "    \"date_of_incorporation\": \"" + senderBd.getDateOfIncorporation() + "\",\n" +
//                "    \"representative_lastname\": \"" + senderRep.getLastname() + "\",\n" +
//                "    \"representative_firstname\": \"" + senderRep.getFirstname() + "\",\n" +
//                "    \"representative_id_type\": \"" + senderRep.getIdType() + "\",\n" +
//                "    \"representative_id_country_iso_code\": \"" + senderRep.getIdCountryCode() + "\",\n" +
//                "    \"representative_id_number\": \"" + senderRep.getIdNumber() + "\",\n" +
//                "    \"representative_id_delivery_date\": \"" + senderRep.getIdDeliveryDate() + "\",\n" +
//                "    \"representative_id_expiration_date\": \"" + senderRep.getIdExpirationDate() + "\"\n" +
//                "  },\n" +
//
//                "  \"receiving_business\": {\n" +
//                "    \"registered_name\": \"" + receiverBd.getRegisteredName() + "\",\n" +
//                "    \"trading_name\": \"" + receiverBd.getTradingName() + "\",\n" +
//                "    \"address\": \"" + receiverCd.getAddress() + "\",\n" +
//                "    \"postal_code\": \"" + receiverCd.getPostalCode() + "\",\n" +
//                "    \"city\": \"" + receiverCd.getCity() + "\",\n" +
//                "    \"country_iso_code\": \"" + receiverBd.getCountryCode() + "\",\n" +
//                "    \"msisdn\": \"" + receiverCd.getMsisdn() + "\",\n" +
//                "    \"email\": \"" + receiverCd.getEmail() + "\",\n" +
//                "    \"registration_number\": \"" + receiverBd.getRegistrationNumber() + "\",\n" +
//                "    \"tax_id\": \"" + receiverBd.getTaxId() + "\",\n" +
//                "    \"date_of_incorporation\": \"" + receiverBd.getDateOfIncorporation() + "\",\n" +
//                "    \"representative_lastname\": \"" + receiverRep.getLastname() + "\",\n" +
//                "    \"representative_firstname\": \"" + receiverRep.getFirstname() + "\",\n" +
//                "    \"representative_id_type\": \"" + receiverRep.getIdType() + "\",\n" +
//                "    \"representative_id_country_iso_code\": \"" + receiverRep.getIdCountryCode() + "\",\n" +
//                "    \"representative_id_number\": \"" + receiverRep.getIdNumber() + "\",\n" +
//                "    \"representative_id_delivery_date\": \"" + receiverRep.getIdDeliveryDate() + "\",\n" +
//                "    \"representative_id_expiration_date\": \"" + receiverRep.getIdExpirationDate() + "\"\n" +
//                "  },\n" +
//
//                "  \"external_id\": \"" + channelInfo.getRrn() + "\",\n" +
//                "  \"retail_fee\": " + fees.getPartnerFee() + ",\n" +
//                "  \"retail_fee_currency\": \"" + fees.getPartnerFeeCurrency() + "\",\n" +
//                "  \"purpose_of_remittance\": \"" + remittance.getPurpose() + "\",\n" +
//                "  \"document_reference_number\": \"" + remittance.getDocumentReference() + "\",\n" +
//                "  \"callback_url\": \"" + channelInfo.getCallbackUrl() + "\",\n" +
//                "  \"reference\": \"" + remittance.getReference() + "\"\n" +
//                "}";

        return "";
    }

    @Override
    public String generateWendiB2CNamecheckRequest(NamecheckRequest namecheckRequest) {

        return "{\n" +
                "    \"clientId\": \"" + wendiClientId + "\",\n" +
                "    \"action\": \"" + WENDI_B2C_NAMECHECK_ACTION + "\",\n" +
                "    \"Data\": {\n" +
                "        \"requestId\": \"" + namecheckRequest.getChannelInfo().getRrn() + "\",\n" +
                "        \"msisdn\": \"" + namecheckRequest.getReceiver().getMsisdn() + "\"\n" +
                "    }\n" +
                "}";
    }

    @Override
    public String generateThunesCreditPartyInfoRequest(CreditPartyInformation creditPartyInformation) throws CustomException {
        return buildCreditPartyPayload(creditPartyInformation.getReceiver().getServiceId(),
                creditPartyInformation.getReceiver().getMsisdn(),
                creditPartyInformation.getReceiver().getBankAccountNumber(),
                creditPartyInformation.getReceiver().getBusinessRegisteredName(),
                creditPartyInformation.getReceiver().getPayerId(),
                creditPartyInformation.getReceiver().getTransactionType());
    }

    @Override
    public String generateThunesCreditPartyVerifyRequest(CreditPartyVerify creditPartyVerify) throws CustomException {
        return buildCreditPartyPayload(creditPartyVerify.getReceiver().getServiceId(),
                creditPartyVerify.getReceiver().getMsisdn(),
                creditPartyVerify.getReceiver().getBankAccountNumber(),
                creditPartyVerify.getReceiver().getBusinessRegisteredName(),
                creditPartyVerify.getReceiver().getPayerId(),
                creditPartyVerify.getReceiver().getTransactionType());
    }

    // Build the JSON payload for both credit-party-information and credit-party-verify.
    private String buildCreditPartyPayload(String serviceId, String msisdn, String bankAccountNumber, String registeredName, String payerId, String transactionType) throws CustomException {
        String resolvedMsisdn = "";
        String resolvedBankAccountNumber = "";

        if ("1".equals(serviceId)) {
            resolvedMsisdn = msisdn == null ? "" : msisdn;
        } else if ("2".equals(serviceId)) {
            resolvedBankAccountNumber = bankAccountNumber == null ? "" : bankAccountNumber;
        } else {
            throw new CustomException(DEFAULT_PROCESSING_FAILURE + "Provided service id [" + serviceId + "] is invalid");
        }

        String safeRegisteredName = registeredName == null ? "" : registeredName;

        return "{\n" +
                "  \"credit_party_identifier\": {\n" +
                "    \"bank_account_number\": \"" + resolvedBankAccountNumber + "\",\n" +
                "    \"msisdn\": \"" + resolvedMsisdn + "\",\n" +
                "    \"payer_id\": \"" + payerId + "\",\n" +
                "    \"swift_bic_code\": \"\",\n" +
                "    \"transaction_type\": \"" + transactionType + "\"\n" +
                "  },\n" +
                "  \"receiving_business\": {\n" +
                "    \"registered_name\": \"" + safeRegisteredName + "\"\n" +
                "  }\n" +
                "}\n";
    }

    private String getTagValue(Document document, String tagName) {
        NodeList nodeList = document.getElementsByTagName(tagName);
        if (nodeList.getLength() > 0) {
            Node node = nodeList.item(0);
            if (node != null && node.getNodeType() == Node.ELEMENT_NODE) {
                return node.getTextContent().trim();
            }
        }
        return "";
    }

    private String getDummySignature() {
        // For finacle over the counter float purchase namecheck and transaction,
        // use a dummy signature which will NOT be used in authentication, but rather to avoid bad request error

        return "jZzbRrd8Ycwg8xClrOdddkZcHjXHnUtgf6FA9gMFtCMF720S8rZPiVgtc0nPBuNXa4WlYvK+elzapEDbxUvA+oiyWtPZYM+fqI/UAxMjCtJifvr8z7ztjOx0Tq7La63Yvju06g6AWjhs3LrZa8ECBqQkQNdK9DBTcBT/oSP0Nla3IHq/WREA40ttMPtgbQoCmp/ZCL7Rmw8ulm/A2VEUvM14LEfn2jMzij1DWPzidsCkA6q7CYPPHLFIBVpevEpTNp9WTm80RWYr8oZx5jT8i4FAFMnN58kXd1/QHfjgMxvfkP+T3XmFg2Kv5PdF7rOF0XvsaY9u6hfy2NbnQwaSMg==";
    }

    /**
     * The requestUUID will be the MessageDateTime value in the GMT+3 timezone,
     * like: 2024-11-08T11:50:07.930580000
     **/
    private String composeMessageDateTime() {
        // Get the current date and time
        LocalDateTime now = LocalDateTime.now();

        // Convert to GMT+3 timezone
        ZonedDateTime gmtPlus3DateTime = now.atZone(ZoneId.of("GMT+3"));

        // Define the pattern according to the required format
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.nnnnnnnnn");

        // Format the datetime to a string
        return gmtPlus3DateTime.format(formatter);
    }
}
