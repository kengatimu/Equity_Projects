package com.equitybank.gag.mtn_money_ms.service.impl;

import com.equitybank.gag.mtn_money_ms.service.PayloadService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;

import static com.equitybank.gag.mtn_money_ms.config.ApplicationConstants.BANK_CODE;

@Service
public class PayloadServiceImpl implements PayloadService {
    private static final Logger log = LoggerFactory.getLogger(PayloadServiceImpl.class);

    @Override
    public String composeTelcoFloatNamecheckTelcoRequest(Map<String, String> xmlMapValues) {
        return "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
                "<ns2:getaccountholderinforequest\n" +
                "    xmlns:ns2=\"http://www.ericsson.com/em/emm/provisioning/v2_1\">\n" +
                "    <identity>ID:" + xmlMapValues.get("mobileNumber") + "/MSISDN</identity>\n" +
                "</ns2:getaccountholderinforequest>";
    }

    @Override
    public String composeFloatPurchaseNameCheckSuccessResponse(Map<String, String> xmlMapValues, Map<String, String> extractedTelcoResponseMap) {
        String customerNames = extractedTelcoResponseMap.get("firstname") + " " + extractedTelcoResponseMap.get("surname");
        return "<MobileNumberInquireRes xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" " +
                "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">" +
                "<msgId>" + xmlMapValues.get("msgId") + "</msgId>" +
                "<channel>" + xmlMapValues.get("channel") + "</channel>" +
                "<telcom>" + xmlMapValues.get("telcom") + "</telcom>" +
                "<mobileNumber>" + xmlMapValues.get("mobileNumber") + "</mobileNumber>" +
                "<responseCode>00</responseCode>" +
                "<customerNames>" + customerNames + "</customerNames>" +
                "</MobileNumberInquireRes>";
    }

    @Override
    public String composeNameCheckErrorResponse(Map<String, String> xmlMapValues) {
        // Namecheck for float purchase is breaking. We should return error response code of 01
        String tillNumber = xmlMapValues.get("tillNumber");
        if (tillNumber != null && !tillNumber.isEmpty()) {
            return "<MobileNumberInquireRes>\n" +
                    "    <msgId>" + xmlMapValues.get("msgId") + "</msgId>\n" +
                    "    <channel>" + xmlMapValues.get("channel") + "</channel>\n" +
                    "    <telcom>" + xmlMapValues.get("telcom") + "</telcom>\n" +
                    "    <mobileNumber>" + xmlMapValues.get("mobileNumber") + "</mobileNumber>\n" +
                    "    <responseCode>01</responseCode>\n" +
                    "    <customerNames></customerNames>\n" +
                    "</MobileNumberInquireRes>";
        }
        return "<MobileNumberInquireRes>\n" +
                "    <msgId>" + xmlMapValues.get("msgId") + "</msgId>\n" +
                "    <channel>" + xmlMapValues.get("channel") + "</channel>\n" +
                "    <telcom>" + xmlMapValues.get("telcom") + "</telcom>\n" +
                "    <mobileNumber>" + xmlMapValues.get("mobileNumber") + "</mobileNumber>\n" +
                "    <responseCode>00</responseCode>\n" +
                "    <customerNames>" + xmlMapValues.get("mobileNumber") + "</customerNames>\n" +
                "</MobileNumberInquireRes>";
    }

    @Override
    public String composeTelcoFloatPurchaseTelcoRequest(Map<String, String> xmlMapValues) {
        return "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
                "<ns2:depositrequest\n" +
                "    xmlns:ns2=\"http://www.ericsson.com/em/en/settlement/v1_0\">\n" +
                "    <bankcode>" + BANK_CODE + "</bankcode>\n" +
                "    <accountnumber>" + xmlMapValues.get("sourceAccount") + "</accountnumber>\n" +
                "    <transactiontimestamp>\n" +
                "        <timestamp>" + getCurrentTimestamp() + "</timestamp>\n" +
                "    </transactiontimestamp>\n" +
                "    <amount>\n" +
                "        <amount>" + xmlMapValues.get("amount") + "</amount>\n" +
                "        <currency>" + xmlMapValues.get("currency") + "</currency>\n" +
                "    </amount>\n" +
                "    <receiver>FRI:" + xmlMapValues.get("number") + " MSISDN</receiver>\n" +
                "    <banktransactionid>" + xmlMapValues.get("rrn") + "</banktransactionid>\n" +
                "    <receiverfirstname>" + getNames(xmlMapValues, "firstName") + "</receiverfirstname>\n" +
                "    <receiversurname>" + getNames(xmlMapValues, "surname") + "</receiversurname>\n" +
                "    <message>My Float</message>\n" +
                "</ns2:depositrequest>";
    }

    @Override
    public String composeFloatPurchaseSuccessResponse(Map<String, String> xmlMapValues, Map<String, String> extractedTelcoResponseMap) {
        return "<response>\n" +
                "    <msgId>" + xmlMapValues.get("rrn") + "</msgId>\n" +
                "    <eazzycashres>\n" +
                "        <status>OK</status>\n" +
                "        <responseCode>00</responseCode>\n" +
                "        <tranID>" + extractedTelcoResponseMap.get("financialtransactionid") + "</tranID>\n" +
                "        <telcoResponseCode>0</telcoResponseCode>\n" +
                "\t\t<telcoResponseDesc>" + extractedTelcoResponseMap.get("status") + "</telcoResponseDesc>\n" +
                "    </eazzycashres>\n" +
                "</response>";
    }

    @Override
    public String composeFloatPurchaseErrorResponse(String rrn, String errorCode, String errorDescription) {
        return "<response>\n" +
                "    <msgId>" + rrn + "</msgId>\n" +
                "    <eazzycashres>\n" +
                "        <status>ERROR</status>\n" +
                "        <responseCode>" + errorCode + "</responseCode>\n" +
                "        <telcoResponseCode>01</telcoResponseCode>\n" +
                "        <telcoResponseDesc>" + errorDescription + "</telcoResponseDesc>\n" +
                "    </eazzycashres>\n" +
                "</response>";
    }

    @Override
    public String composeFloatStatusCheckTelcoRequest(Map<String, String> xmlMapValues) {
        return "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
                "<ns2:gettransactionstatusrequest\n" +
                "    xmlns:ns2=\"http://www.ericsson.com/em/emm/financial/v1_2\">\n" +
                "    <referenceid>" + xmlMapValues.get("rrn") + "</referenceid>\n" +
                "    <financialtransactionid></financialtransactionid>\n" +
                "    <identity></identity>\n" +
                "    <admininitiated>false</admininitiated>\n" +
                "</ns2:gettransactionstatusrequest>";
    }

    @Override
    public String composeStatusCheckResponse(Map<String, String> xmlMapValues, Map<String, String> extractedTelcoResponseMap) {
        String status = extractedTelcoResponseMap.get("status");
        if ("SUCCESS".equalsIgnoreCase(status) || "SUCCESSFUL".equalsIgnoreCase(status)) {
            return "<eazzycashStatusRes>\n" +
                    "    <msgId>" + xmlMapValues.get("rrn") + "</msgId>\n" +
                    "    <eazzycashres>\n" +
                    "        <rrn>" + xmlMapValues.get("rrn") + "</rrn>\n" +
                    "        <status>OK|" + extractedTelcoResponseMap.get("financialtransactionid") + "</status>\n" +
                    "        <responseCode>000</responseCode>\n" +
                    "        <responseDesc>Success</responseDesc>\n" +
                    "    </eazzycashres>\n" +
                    "</eazzycashStatusRes>";
        } else if ("PENDING".equalsIgnoreCase(status)) {
            return "<eazzycashStatusRes>\n" +
                    "    <msgId>" + xmlMapValues.get("rrn") + "</msgId>\n" +
                    "    <eazzycashres>\n" +
                    "        <rrn>" + xmlMapValues.get("rrn") + "</rrn>\n" +
                    "        <status>PENDING</status>\n" +
                    "        <responseCode>001</responseCode>\n" +
                    "        <responseDesc>Telco responded with a PENDING status</responseDesc>\n" +
                    "    </eazzycashres>\n" +
                    "</eazzycashStatusRes>";
        } else {
            return "<eazzycashStatusRes>\n" +
                    "    <msgId>" + xmlMapValues.get("rrn") + "</msgId>\n" +
                    "    <eazzycashres>\n" +
                    "        <rrn>" + xmlMapValues.get("rrn") + "</rrn>\n" +
                    "        <status>" + status + "</status>\n" +
                    "        <responseCode>01</responseCode>\n" +
                    "        <responseDesc>Telco responded with a " + status + " status</responseDesc>\n" +
                    "    </eazzycashres>\n" +
                    "</eazzycashStatusRes>";
        }
    }

    @Override
    public String composeFloatStatusCheckDefaultErrorResponse(String rrn, String errorCode, String errorDescription) {
        return "<eazzycashStatusRes>\n" +
                "    <msgId>" + rrn + "</msgId>\n" +
                "    <eazzycashres>\n" +
                "        <rrn>" + rrn + "</rrn>\n" +
                "        <status>ERROR|" + errorCode + "</status>\n" +
                "        <responseCode>01</responseCode>\n" +
                "        <responseDesc>" + errorDescription + "</responseDesc>\n" +
                "    </eazzycashres>\n" +
                "</eazzycashStatusRes>";
    }

    private String getNames(Map<String, String> xmlMapValues, String nameType) {
        String fullName = xmlMapValues.get("name");

        // If the name is not available or it's a number return it
        if (fullName.isEmpty() || fullName.matches("\\d+")) {
            return fullName;
        }

        // Split the full name by one or more spaces
        String[] nameParts = fullName.trim().split("\\s+");

        // Return the first name or surname based on the nameType
        return switch (nameType.toLowerCase()) {
            case "firstname" -> nameParts.length > 0 ? nameParts[0] : ""; // First part is the first name
            case "surname" ->
                    nameParts.length > 1 ? nameParts[nameParts.length - 1] : ""; // Last part is usually the surname, unless there's only one name
            default -> "";
        };
    }

    private String getCurrentTimestamp() {
        // Get the current time in Nairobi timezone
        ZonedDateTime nowInNairobi = ZonedDateTime.now(ZoneId.of("Africa/Nairobi"));

        // Format the timestamp with milliseconds
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSXXX");
        return nowInNairobi.format(formatter);
    }

}
