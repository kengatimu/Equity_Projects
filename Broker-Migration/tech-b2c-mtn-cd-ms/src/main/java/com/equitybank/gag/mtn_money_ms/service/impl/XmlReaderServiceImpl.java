package com.equitybank.gag.mtn_money_ms.service.impl;

import com.equitybank.gag.mtn_money_ms.exception.CustomException;
import com.equitybank.gag.mtn_money_ms.service.XmlReaderService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Service
public class XmlReaderServiceImpl implements XmlReaderService {
    private static final Logger log = LoggerFactory.getLogger(XmlReaderServiceImpl.class);

    @Override
    public Map<String, String> parseXmlString(String xmlString, String operationType) throws CustomException {
        Map<String, String> resultMap = new HashMap<>();

        try {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            factory.setNamespaceAware(true);
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document doc = builder.parse(new ByteArrayInputStream(xmlString.getBytes()));

            switch (operationType.toLowerCase()) {
                case "generic-failure-response" -> handleGenericFailure(doc, resultMap);
                case "float-purchase-namecheck-success-response" -> handleFloatPurchaseNamecheckRequest(doc, resultMap);
                case "deposit-success-response" -> handleTransactionResponse(doc, resultMap, "deposit");
                case "status-check-success-response" -> handleTransactionResponse(doc, resultMap, "status");
                case "float-purchase-request" -> handleFloatPurchaseRequest(doc, resultMap);
                case "mobile-number-inquire-request" -> handleMobileNumberInquireRequest(doc, resultMap);
                case "status-check-request" -> handleStatusCheckRequest(doc, resultMap);
                default -> log.error("Unsupported operation type: " + operationType);
            }
        } catch (ParserConfigurationException | IOException | SAXException e) {
            log.error("Exception occurred when parsing response XML: " + e.getMessage());
            if ("mobile-number-inquire-request".equalsIgnoreCase(operationType)) {
                throw new CustomException("400|Error Parsing Namecheck Xml Request");
            }
        }
        return resultMap;
    }

    private void handleGenericFailure(Document doc, Map<String, String> resultMap) {
        String errorCode = doc.getDocumentElement().getAttribute("errorcode");
        resultMap.put("errorcode", errorCode.isEmpty() ? "" : errorCode);

        NodeList argumentsList = doc.getElementsByTagName("arguments");
        if (argumentsList.getLength() > 0) {
            Element argumentElement = (Element) argumentsList.item(0);
            resultMap.put("argument", argumentElement.getAttribute("value"));
        } else {
            resultMap.put("argument", "");
        }
    }

    private static void handleFloatPurchaseNamecheckRequest(Document doc, Map<String, String> resultMap) {
        resultMap.put("firstname", getTagValue(doc, "firstname"));
        resultMap.put("surname", getTagValue(doc, "surname"));
        resultMap.put("accountholderstatus", getTagValue(doc, "accountholderstatus"));
    }

    private void handleTransactionResponse(Document doc, Map<String, String> resultMap, String type) {
        String status = getTagValue(doc, "status");
        resultMap.put("status", status);

        if ("Success".equalsIgnoreCase(status) || "SUCCESSFUL".equalsIgnoreCase(status)) {
            resultMap.put("financialtransactionid", getTagValue(doc, "financialtransactionid"));
            if ("status".equals(type)) {
                resultMap.put("providertransactionid", getTagValue(doc, "providertransactionid"));
            }
        } else {
            resultMap.put("financialtransactionid", "");
            if ("status".equals(type)) {
                resultMap.put("providertransactionid", "");
            }
        }
    }

    private static void handleFloatPurchaseRequest(Document doc, Map<String, String> resultMap) {
        resultMap.put("sourceAccount", getTagValue(doc, "sourceAccount"));
        resultMap.put("amount", getTagValue(doc, "amount"));
        resultMap.put("currency", getTagValue(doc, "currency"));
        resultMap.put("number", getTagValue(doc, "number"));
        resultMap.put("rrn", getTagValue(doc, "rrn"));
        resultMap.put("name", getTagValue(doc, "name"));
    }

    private static void handleMobileNumberInquireRequest(Document doc, Map<String, String> resultMap) {
        resultMap.put("mobileNumber", getTagValue(doc, "mobileNumber"));
        resultMap.put("tillNumber", getTagValue(doc, "tillNumber"));
        resultMap.put("timestamp", getTagValue(doc, "timestamp"));
        resultMap.put("msgId", getTagValue(doc, "msgId"));
        resultMap.put("telcom", getTagValue(doc, "telcom"));
        resultMap.put("channel", getTagValue(doc, "channel"));
        resultMap.put("bankId", getTagValue(doc, "bankId"));
    }

    private void handleStatusCheckRequest(Document doc, Map<String, String> resultMap) {
        resultMap.put("rrn", getTagValue(doc, "rrn"));
        resultMap.put("channel", getTagValue(doc, "channel"));
        resultMap.put("bankId", getTagValue(doc, "bankId"));
        resultMap.put("telco", getTagValue(doc, "telco"));
    }

    private static String getTagValue(Document doc, String tagName) {
        NodeList nodeList = doc.getElementsByTagName(tagName);
        return (nodeList.getLength() > 0) ? nodeList.item(0).getTextContent() : "";
    }
}
