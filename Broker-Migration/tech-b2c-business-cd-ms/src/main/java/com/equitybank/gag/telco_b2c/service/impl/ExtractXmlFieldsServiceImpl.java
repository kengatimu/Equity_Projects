package com.equitybank.gag.telco_b2c.service.impl;

import com.equitybank.gag.telco_b2c.service.ExtractXmlFieldsService;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

@Service
public class ExtractXmlFieldsServiceImpl implements ExtractXmlFieldsService {
    @Override
    public Map<String, String> extractResponseDetails(String responseXml, String type) {
        String mgiTransactionSessionID;
        Map<String, String> responseDetailsMap = new HashMap<>();

        switch (type) {
            case "moneygram-fee-lookup" -> {
                // Get tag values
                String sendAmount = extractValue(responseXml, "<ac:sendAmount>", "</ac:sendAmount>", "<sendAmount>", "</sendAmount>");
                String sendCurrency = extractValue(responseXml, "<ac:sendCurrency>", "</ac:sendCurrency>", "<sendCurrency>", "</sendCurrency>");
                String totalAmountToCollect = extractValue(responseXml, "<ac:totalAmountToCollect>", "</ac:totalAmountToCollect>", "<totalAmountToCollect>", "</totalAmountToCollect>");

                // Update map with the tag values
                responseDetailsMap.put("sendAmount", sendAmount);
                responseDetailsMap.put("totalAmountToCollect", totalAmountToCollect);
                responseDetailsMap.put("sendCurrency", sendCurrency);
                responseDetailsMap.put("totalFeeAndTaxes", calculateFees(sendAmount, totalAmountToCollect));

            }
            case "moneygram-receive-reference-number-request" -> {
                mgiTransactionSessionID = extractValue(responseXml, "<ac:mgiTransactionSessionID>", "</ac:mgiTransactionSessionID>", "<mgiTransactionSessionID>", "</mgiTransactionSessionID>");
                String transactionStatus = extractValue(responseXml, "<ac:transactionStatus>", "</ac:transactionStatus>", "<transactionStatus>", "</transactionStatus>");
                String receiveCurrency = extractValue(responseXml, "<ac:receiveCurrency>", "</ac:receiveCurrency>", "<receiveCurrency>", "</receiveCurrency>");
                String receiveAmount = extractValue(responseXml, "<ac:receiveAmount>", "</ac:receiveAmount>", "<receiveAmount>", "</receiveAmount>");
                String senderFirstName = extractValue(responseXml, "<ac:senderFirstName>", "</ac:senderFirstName>", "<senderFirstName>", "</senderFirstName>");
                String senderMiddleName = extractValue(responseXml, "<ac:senderMiddleName>", "</ac:senderMiddleName>", "<senderMiddleName>", "</senderMiddleName>");
                String senderLastName = extractValue(responseXml, "<ac:senderLastName>", "</ac:senderLastName>", "<senderLastName>", "</senderLastName>");
                String receiverFirstName = extractValue(responseXml, "<ac:receiverFirstName>", "</ac:receiverFirstName>", "<receiverFirstName>", "</receiverFirstName>");
                String receiverMiddleName = extractValue(responseXml, "<ac:receiverMiddleName>", "</ac:receiverMiddleName>", "<receiverMiddleName>", "</receiverMiddleName>");
                String receiverLastName = extractValue(responseXml, "<ac:receiverLastName>", "</ac:receiverLastName>", "<receiverLastName>", "</receiverLastName>");
                String deliveryOption = extractValue(responseXml, "<ac:deliveryOption>", "</ac:deliveryOption>", "<deliveryOption>", "</deliveryOption>");
                String originatingCountry = extractValue(responseXml, "<ac:originatingCountry>", "</ac:originatingCountry>", "<originatingCountry>", "</originatingCountry>");
                String originalSendCurrency = extractValue(responseXml, "<ac:originalSendCurrency>", "</ac:originalSendCurrency>", "<originalSendCurrency>", "</originalSendCurrency>");
                String originalSendFee = extractValue(responseXml, "<ac:originalSendFee>", "</ac:originalSendFee>", "<originalSendFee>", "</originalSendFee>");

                // Update map with the tag values
                responseDetailsMap.put("transactionId", mgiTransactionSessionID);
                responseDetailsMap.put("transactionStatus", transactionStatus);
                responseDetailsMap.put("receiveCurrency", receiveCurrency);
                responseDetailsMap.put("receiveAmount", receiveAmount);
                responseDetailsMap.put("senderFirstName", senderFirstName);
                responseDetailsMap.put("senderMiddleName", senderMiddleName);
                responseDetailsMap.put("senderLastName", senderLastName);
                responseDetailsMap.put("receiverFirstName", receiverFirstName);
                responseDetailsMap.put("receiverMiddleName", receiverMiddleName);
                responseDetailsMap.put("receiverLastName", receiverLastName);
                responseDetailsMap.put("deliveryOption", deliveryOption);
                responseDetailsMap.put("originatingCountry", originatingCountry);
                responseDetailsMap.put("originalSendCurrency", originalSendCurrency);
                responseDetailsMap.put("originalSendFee", originalSendFee);

            }
            case "moneygram-commit-transaction", "moneygram-receive-commit-transaction" -> {
                String doCheckIn = extractValue(responseXml, "<ac:doCheckIn>", "</ac:doCheckIn>", "<doCheckIn>", "</doCheckIn>");
                String timeStamp = extractValue(responseXml, "<ac:timeStamp>", "</ac:timeStamp>", "<timeStamp>", "</timeStamp>");
                String flags = extractValue(responseXml, "<ac:flags>", "</ac:flags>", "<flags>", "</flags>");
                String referenceNumber = extractValue(responseXml, "<ac:referenceNumber>", "</ac:referenceNumber>", "<referenceNumber>", "</referenceNumber>");
                String expectedDateOfDelivery = extractValue(responseXml, "<ac:expectedDateOfDelivery>", "</ac:expectedDateOfDelivery>", "<expectedDateOfDelivery>", "</expectedDateOfDelivery>");
                String transactionDateTime = extractValue(responseXml, "<ac:transactionDateTime>", "</ac:transactionDateTime>", "<transactionDateTime>", "</transactionDateTime>");

                // Update map with the tag values
                responseDetailsMap.put("doCheckIn", doCheckIn);
                responseDetailsMap.put("timeStamp", timeStamp);
                responseDetailsMap.put("flags", flags);
                responseDetailsMap.put("referenceNumber", referenceNumber);
                responseDetailsMap.put("expectedDateOfDelivery", expectedDateOfDelivery);
                responseDetailsMap.put("transactionDateTime", transactionDateTime);
                return responseDetailsMap;
            }

            case "moneygram-send-validation-request" -> {
                String referenceNumber = extractValue(responseXml, "<ac:referenceNumber>", "</ac:referenceNumber>", "<referenceNumber>", "</referenceNumber>");

                // Get the amount values
                String sendAmount = extractValue(responseXml, "<ac:sendAmount>", "</ac:sendAmount>", "<sendAmount>", "</sendAmount>");
                String sendCurrency = extractValue(responseXml, "<ac:sendCurrency>", "</ac:sendCurrency>", "<sendCurrency>", "</sendCurrency>");
                String totalAmountToCollect = extractValue(responseXml, "<ac:totalAmountToCollect>", "</ac:totalAmountToCollect>", "<totalAmountToCollect>", "</totalAmountToCollect>");

                // Update map with the tag values
                responseDetailsMap.put("referenceNumber", referenceNumber);
                responseDetailsMap.put("sendAmount", sendAmount);
                responseDetailsMap.put("totalAmountToCollect", totalAmountToCollect);
                responseDetailsMap.put("sendCurrency", sendCurrency);
                responseDetailsMap.put("totalFeeAndTaxes", calculateFees(sendAmount, totalAmountToCollect));
                return responseDetailsMap;
            }

            case "moneygram-detail-lookup" -> {
                String transactionStatus = extractValue(responseXml, "<ac:transactionStatus>", "</ac:transactionStatus>", "<transactionStatus>", "</transactionStatus>");

                // Update map with the tag values
                responseDetailsMap.put("transactionStatus", transactionStatus);
                return responseDetailsMap;
            }
            case "moneygram-amend-transaction" -> {
                String transactionSucceeded = extractValue(responseXml, "<ac:transactionSucceeded>", "</ac:transactionSucceeded>", "<transactionSucceeded>", "</transactionSucceeded>");

                // Update map with the tag values
                responseDetailsMap.put("transactionSucceeded", transactionSucceeded);
                return responseDetailsMap;
            }
            case "exception" -> {
                String errorCode = extractValue(responseXml, "<ac:errorCode>", "</ac:errorCode>", "<errorCode>", "</errorCode>");
                String errorDescription = extractValue(responseXml, "<ac:errorString>", "</ac:errorString>", "<errorString>", "</errorString>");

                // Update map with the tag values
                responseDetailsMap.put("errorCode", errorCode);
                responseDetailsMap.put("errorDescription", errorDescription);
                return responseDetailsMap;
            }
        }
        return responseDetailsMap;
    }

    private String calculateFees(String sendAmount, String totalAmountToCollect) {
        BigDecimal sendAmountB = new BigDecimal(sendAmount);
        BigDecimal totalAmountToCollectB = new BigDecimal(totalAmountToCollect);

        // Calculate the difference
        BigDecimal difference = totalAmountToCollectB.subtract(sendAmountB);

        // Return the difference as a string
        return difference.toString();
    }

    private static String extractValue(String xml, String startTag1, String endTag1, String startTag2, String endTag2) {
        // XML itself is null or blank
        if (xml == null || xml.isEmpty()) {
            return "";
        }

        int start = xml.indexOf(startTag1);
        int end = xml.indexOf(endTag1, start);
        int tagLength;

        // If the first tag set is not found, try the second set
        if (start == -1 || end == -1) {
            start = xml.indexOf(startTag2);
            end = xml.indexOf(endTag2, start);
            tagLength = startTag2.length();
        } else {
            tagLength = startTag1.length();
        }

        // If any of the tags are found, extract the value
        if (start != -1 && end != -1) {
            return xml.substring(start + tagLength, end).trim();
        }

        return "";
    }
}
