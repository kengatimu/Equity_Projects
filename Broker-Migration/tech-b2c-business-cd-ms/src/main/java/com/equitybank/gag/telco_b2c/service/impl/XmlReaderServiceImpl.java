package com.equitybank.gag.telco_b2c.service.impl;

import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.service.TypeResolverService;
import com.equitybank.gag.telco_b2c.service.XmlReaderService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.*;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.StringReader;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.Map;

import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.DEFAULT_PROCESSING_FAILURE;
import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.FIELD_VALIDATION_ERROR;

@Service
public class XmlReaderServiceImpl implements XmlReaderService {
    private static final Logger log = LoggerFactory.getLogger(XmlReaderServiceImpl.class);

    private final TypeResolverService typeResolverService;

    @Autowired
    public XmlReaderServiceImpl(TypeResolverService typeResolverService) {
        this.typeResolverService = typeResolverService;
    }

    @Override
    public Map<String, String> parseXml(String xmlString, String type, String rrn) throws CustomException {
        // Initialize a map to store the extracted XML values
        Map<String, String> xmlValuesMap = new HashMap<>();

        try {
            // Create a new document builder factory and builder
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();

            // Parse the input XML string into a Document object
            Document document = builder.parse(new ByteArrayInputStream(xmlString.getBytes()));

            // Normalize the XML structure to avoid any inconsistencies
            document.getDocumentElement().normalize();

            // Retrieve the root element's tag name
            String rootTagName = document.getDocumentElement().getTagName().trim();
            log.info("RootTag: " + rootTagName);

            // Remove namespace elements from root tag
            String rootTag = removeNamespaceElement(rootTagName).trim();
            log.info("Removed Namespace RootTag: " + rootTag);

            // Parse appropriate xml.
            // Remember bank2wallet, airtime-top up and float purchase have dtos and therefore are not part of this check.
            switch (rootTag) {
                // Parse namecheck requests
                case "mobileNumberInquireReq":
                    parseNamecheckRequest(document, xmlValuesMap);
                    break;

                // Parse status check requests
                case "eazzycashStatusReq":
                    parseStatusCheckRequest(document, xmlValuesMap);
                    break;

                // Parse status check response
                case "eazzycashStatusRes":
                    parseStatusCheckResponse(document, xmlValuesMap);
                    break;

                // Parse all responses to channel
                case "response":
                    parseEazzycashResponse(document, xmlValuesMap);
                    break;

                // Parse moneygram callback responses to chanel
                case "statusDetails":
                    if ("moneygram-commit-callback".equals(type)) {
                        parseCallbackResponse(document, xmlValuesMap);
                    }
                    break;

                // Parse airtime-topup responses, all moneygram requests, and finacle float purchase
                case "Envelope":
                    if (typeResolverService.isMoneyGramService(type)) {
                        parseMoneyGramRequest(document, rootTagName, xmlValuesMap, type, rrn);
                    } else if ("float-purchase-namecheck".equalsIgnoreCase(type)) {
                        //finacle over the counter float purchase namecheck
                        parseNamecheckSoapEnvelope(document, xmlValuesMap);
                    } else if ("floatPurchase".equalsIgnoreCase(type)) {
                        //finacle over the counter float purchase transaction
                        parseTransactionSoapEnvelope(document, xmlValuesMap);
                    } else {
                        parseTopUpResponse(document, xmlValuesMap);
                    }
                    break;

                default:
                    // Unknown XML root tag
                    throw new CustomException(FIELD_VALIDATION_ERROR + "Unknown XML root tag: " + rootTag);
            }

        } catch (ParserConfigurationException | IOException | SAXException | CustomException e) {
            throw new CustomException(e.getMessage());
        }

        // Return the map containing the parsed XML values
        return xmlValuesMap;
    }

    @Override
    public Map<String, String> parseCallbackXmlString(String xmlString, String operationType) throws CustomException {
        Map<String, String> resultMap = new HashMap<>();

        try {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            factory.setNamespaceAware(true);
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document doc = builder.parse(new ByteArrayInputStream(xmlString.getBytes()));

            if ("transaction".equalsIgnoreCase(operationType)) {
                handleCallbackResponse(doc, resultMap);
            } else {
                log.error("Unsupported operation type: " + operationType);
            }
        } catch (ParserConfigurationException | IOException | SAXException e) {
            log.error("Exception occurred when parsing response XML: " + e.getMessage());
            if ("mobile-number-inquire-request".equalsIgnoreCase(operationType)) {
                throw new CustomException("400|Error Parsing Namecheck Xml Request");
            }
        }
        log.info("Received Callback Result Map: " + resultMap);
        return resultMap;
    }

    private void handleCallbackResponse(Document doc, Map<String, String> resultMap) {
        NodeList dataItems = doc.getElementsByTagName("dataItem");

        for (int i = 0; i < dataItems.getLength(); i++) {
            Element item = (Element) dataItems.item(i);
            String name = getCallbackTagValue(item, "name");
            String value = getCallbackTagValue(item, "value");

            switch (name) {
                case "ResultCode" -> resultMap.put("resultCode", value);
                case "ResultDesc" -> resultMap.put("resultDesc", value);
                case "TransactionID" -> resultMap.put("transactionId", value);
                case "ThirdPartyReference" -> resultMap.put("thirdPartyReference", value);
            }
        }
    }

    private static String getCallbackTagValue(Element element, String tagName) {
        NodeList nodeList = element.getElementsByTagName(tagName);
        return (nodeList.getLength() > 0) ? nodeList.item(0).getTextContent().trim() : "";
    }

    @Override
    public String removeChannelInfo(String xmlString, String type) throws CustomException {
        try {
            // Parse the input XML string
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            factory.setNamespaceAware(true);
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document document = builder.parse(new InputSource(new StringReader(xmlString)));

            // Get the root element
            Element root = document.getDocumentElement();

            // Find the channelInfo element and remove it
            NodeList channelInfoNodes = root.getElementsByTagName("channelInfo");
            if (channelInfoNodes.getLength() > 0) {
                Node channelInfo = channelInfoNodes.item(0);
                channelInfo.getParentNode().removeChild(channelInfo);
            }

            // Convert the updated document back to a string
            TransformerFactory transformerFactory = TransformerFactory.newInstance();
            Transformer transformer = transformerFactory.newTransformer();
            transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "no");
            transformer.setOutputProperty(OutputKeys.INDENT, "yes");
            StringWriter writer = new StringWriter();
            transformer.transform(new DOMSource(document), new StreamResult(writer));

            return writer.getBuffer().toString();
        } catch (ParserConfigurationException | IOException | TransformerException | SAXException e) {
            throw new CustomException(String.format("%sFailed to remove channelInfo element from XML String", DEFAULT_PROCESSING_FAILURE));
        }
    }

    private void parseEazzycashResponse(Document document, Map<String, String> xmlValuesMap) {
        NodeList eazzycashresList = document.getElementsByTagName("eazzycashres");
        if (eazzycashresList.getLength() > 0) {
            Node eazzycashresNode = eazzycashresList.item(0);
            if (eazzycashresNode.getNodeType() == Node.ELEMENT_NODE) {
                Element eazzycashresElement = (Element) eazzycashresNode;

                String status = getTagValue("status", eazzycashresElement);
                String responseCode = getTagValue("responseCode", eazzycashresElement);
                String responseDesc = getTagValue("responseDesc", eazzycashresElement).isEmpty()
                        ? getTagValue("telcoResponseDesc", eazzycashresElement)
                        : getTagValue("responseDesc", eazzycashresElement);

                if (responseCode.isBlank()) {
                    // Separate the error code from the error
                    String[] errorArray = status.split("\\|");
                    if (errorArray.length > 1) {
                        status = errorArray[0];
                        responseCode = errorArray[1];
                    } else {
                        status = errorArray[0];
                    }
                }

                // Put the values in the map
                xmlValuesMap.put("status", status);
                xmlValuesMap.put("responseCode", responseCode);
                xmlValuesMap.put("responseDesc", responseDesc);
            }
        }
    }

    private void parseTopUpResponse(Document document, Map<String, String> xmlValuesMap) {
        NodeList topupResponseList = document.getElementsByTagName("topupResponse");

        if (topupResponseList.getLength() == 0) {
            topupResponseList = document.getElementsByTagName("ns2:topupResponse");
        }

        if (topupResponseList.getLength() > 0) {
            Node topupResponseNode = topupResponseList.item(0);
            if (topupResponseNode.getNodeType() == Node.ELEMENT_NODE) {
                Element topupResponseElement = (Element) topupResponseNode;

                String returnedStatus = getTagValue("return", topupResponseElement);
                log.info("Return field: " + returnedStatus);

                // Separate the returnedStatus code from the returnedStatus
                String[] returnedStatusArray = returnedStatus.split("\\|");
                String responseCode = "";
                String status = "";
                if (returnedStatusArray.length > 1) {
                    status = returnedStatusArray[0];
                    responseCode = returnedStatusArray[1];
                }

                // Put the values in the map
                xmlValuesMap.put("status", status.toUpperCase());
                xmlValuesMap.put("responseDesc", responseCode);
                xmlValuesMap.put("responseCode", responseCode);
            }
        }
    }

    private void parseNamecheckSoapEnvelope(Document document, Map<String, String> xmlValuesMap) {
        NodeList authRequestList = document.getElementsByTagName("ws:authRequest");
        if (authRequestList.getLength() == 0) {
            authRequestList = document.getElementsByTagName("authRequest");
        }

        if (authRequestList.getLength() > 0) {
            Element authRequest = (Element) authRequestList.item(0);
            NodeList dealerList = authRequest.getElementsByTagName("dealer");
            if (dealerList.getLength() > 0) {
                Element dealer = (Element) dealerList.item(0);
                putIfPresent(xmlValuesMap, "amount", dealer);
                putIfPresent(xmlValuesMap, "branchName", dealer);
                putIfPresent(xmlValuesMap, "dealerAccountNumber", dealer);
                putIfPresent(xmlValuesMap, "dealerCode", dealer);
                putIfPresent(xmlValuesMap, "dealerName", dealer);
                putIfPresent(xmlValuesMap, "payMethod", dealer);
                putIfPresent(xmlValuesMap, "payRef", dealer);
                putIfPresent(xmlValuesMap, "respCode", dealer);
            }
        }
    }

    private void parseTransactionSoapEnvelope(Document document, Map<String, String> xmlValuesMap) {
        NodeList finRequestList = document.getElementsByTagName("ws:finRequest");
        if (finRequestList.getLength() == 0) {
            finRequestList = document.getElementsByTagName("finRequest");
        }

        if (finRequestList.getLength() > 0) {
            Element finRequest = (Element) finRequestList.item(0);
            NodeList dealerList = finRequest.getElementsByTagName("dealer");
            if (dealerList.getLength() > 0) {
                Element dealer = (Element) dealerList.item(0);
                putIfPresent(xmlValuesMap, "amount", dealer);
                putIfPresent(xmlValuesMap, "branchName", dealer);
                putIfPresent(xmlValuesMap, "nationalID", dealer);
                putIfPresent(xmlValuesMap, "dealerAccountNumber", dealer);
                putIfPresent(xmlValuesMap, "dealerCode", dealer);
                putIfPresent(xmlValuesMap, "dealerName", dealer);
                putIfPresent(xmlValuesMap, "finacleUserId", dealer);
                putIfPresent(xmlValuesMap, "payMethod", dealer);
                putIfPresent(xmlValuesMap, "payRef", dealer);
                putIfPresent(xmlValuesMap, "respCode", dealer);
                putIfPresent(xmlValuesMap, "serviceId", dealer);
                putIfPresent(xmlValuesMap, "valueDate", dealer);
                putIfPresent(xmlValuesMap, "checkNumber", dealer);
                putIfPresent(xmlValuesMap, "chequeType", dealer);
                putIfPresent(xmlValuesMap, "limit", dealer);
            }
        }
    }

    private void parseMoneyGramRequest(Document document, String rootTagName, Map<String, String> xmlValuesMap, String type, String rrn) throws CustomException {
        // Remove namespace elements from root tag
        String bodyTag = removeNamespaceElement(rootTagName);

        // Body tag with namespace
        String bodyTagWithNamespace = getFullBodyTag(rootTagName, bodyTag);

        // Retrieve the list of elements from the document
//        NodeList bodyList = isMoneyGramReceiveService(type) ? document.getElementsByTagName("S:Body") : document.getElementsByTagName("soapenv:Body");
        NodeList bodyList = document.getElementsByTagName(bodyTagWithNamespace);

        // If "<namespace>:Body" is not found, try retrieving the list of "Body" elements
        if (bodyList.getLength() == 0) {
            bodyList = document.getElementsByTagName("Body");
        }

        // Check if the body element is present
        if (bodyList.getLength() == 0) {
            throw new CustomException(String.format("%sCould not get the xml body list", DEFAULT_PROCESSING_FAILURE));
        }

        // Get the first "Body" element
        Element bodyElement = (Element) bodyList.item(0);

        // Extract common channel information from the body element
        extractChannelInfo(bodyElement, xmlValuesMap, type);

        // Extract specific request values based on the request type
        switch (type) {
            case "moneygram-fee-lookup" -> extractFeeLookupRequest(bodyElement, xmlValuesMap);
            case "moneygram-receive-reference-number-request" ->
                    extractReferenceNumberRequest(bodyElement, xmlValuesMap);
            case "moneygram-get-field-for-product" -> extractSendGFFPRequest(bodyElement, xmlValuesMap);
            case "moneygram-receive-get-field-for-product" -> extractReceiveGFFPRequest(bodyElement, xmlValuesMap);
            case "moneygram-send-validation-request" -> extractSendValidationRequest(bodyElement, xmlValuesMap);
            case "moneygram-receive-validation-request" -> extractReceiveValidationRequest(bodyElement, xmlValuesMap);
            case "moneygram-commit-transaction" -> extractCommitTransactionRequest(bodyElement, xmlValuesMap);
            case "moneygram-receive-commit-transaction" -> extractReceiveCommitTransaction(bodyElement, xmlValuesMap);
            case "moneygram-detail-lookup" -> extractDetailLookupRequest(bodyElement, xmlValuesMap);
            case "moneygram-send-reversal" -> extractSendReversalRequest(bodyElement, xmlValuesMap);
            case "moneygram-amend-transaction" -> extractAmendTransactionRequest(bodyElement, xmlValuesMap);
            case "moneygram-receive-reversal" -> extractReceiveReversalRequest(bodyElement, xmlValuesMap);
            case "moneygram-code-table-service" -> extractCodeTableRequest(bodyElement, xmlValuesMap);
            default -> {
                log.error("{}: Could not parse the xml. Unknown type: {}", rrn, type);
                throw new CustomException(String.format("%sCould not parse xml. Unknown type: %s", DEFAULT_PROCESSING_FAILURE, type));
            }
        }
    }

    private String removeNamespaceElement(String elementTag) {
        // Extract the local name if it contains a colon
        String localName = elementTag.contains(":")
                ? elementTag.split(":")[1]
                : elementTag;

        // Validate that the local name is "Envelope" (case-insensitive)
        if (localName.equalsIgnoreCase("Envelope")) {
            return "Envelope";
        }

        // Validate that the local name is "Body" (case-insensitive)
        if (localName.equalsIgnoreCase("Body")) {
            return "Body";
        }

        return localName;
    }

    private String getFullBodyTag(String rootTagName, String bodyTag) {
        return rootTagName.contains(":")
                ? rootTagName.split(":")[0] + ":" + bodyTag
                : rootTagName;
    }

//    private boolean isMoneyGramReceiveService(String type) {
//        Set<String> moneyGramReceiveServiceSet = Set.of(
//                "moneygram-receive-reference-number-request",
//                "moneygram-receive-validation-request",
//                "moneygram-receive-reversal");
//        return moneyGramReceiveServiceSet.contains(type);
//    }

    private void extractChannelInfo(Element bodyElement, Map<String, String> xmlValuesMap, String type) {
        // Retrieve the list of "channelInfo" elements from the body element
        NodeList channelInfoList = bodyElement.getElementsByTagName("channelInfo");

        // Check if channelInfo element is present
        if (channelInfoList.getLength() > 0) {
            // Get the first "channelInfo" element
            Element channelInfoElement = (Element) channelInfoList.item(0);

            // Extract and put values into the map if present
            putIfPresent(xmlValuesMap, "rrn", channelInfoElement);
            putIfPresent(xmlValuesMap, "channelId", channelInfoElement);
            putIfPresent(xmlValuesMap, "sourceSystemId", channelInfoElement);
            putIfPresent(xmlValuesMap, "bankId", channelInfoElement);
            putIfPresent(xmlValuesMap, "senderAccountNumber", channelInfoElement);
            putIfPresent(xmlValuesMap, "receiverAccountNumber", channelInfoElement);
            putIfPresent(xmlValuesMap, "callbackUrl", channelInfoElement);
            putIfPresent(xmlValuesMap, "signature", channelInfoElement);
            putIfPresent(xmlValuesMap, "transactionCurrency", channelInfoElement);

//            putIfPresent(xmlValuesMap, "amount", channelInfoElement);
//            putIfPresent(xmlValuesMap, "transactionCurrency", channelInfoElement);
//            putIfPresent(xmlValuesMap, "destinationAccountNumber", channelInfoElement);
        }
    }

    private void extractFeeLookupRequest(Element bodyElement, Map<String, String> xmlValuesMap) throws CustomException {
        // Retrieve the list of "feeLookupRequest" elements from the body element
        NodeList feeLookupRequestList = bodyElement.getElementsByTagName("feeLookupRequest");

        // Check if "feeLookupRequest" element is present
        if (feeLookupRequestList.getLength() == 0) {
            throw new CustomException(String.format("%sRoot tag feeLookupRequest not found", DEFAULT_PROCESSING_FAILURE));
        }

        // Get the first "feeLookupRequest" element
        Element feeLookupRequestElement = (Element) feeLookupRequestList.item(0);

        // Extract and put values into the map if present
        putIfPresent(xmlValuesMap, "productType", feeLookupRequestElement);
        putIfPresent(xmlValuesMap, "operatorName", feeLookupRequestElement);
        putIfPresent(xmlValuesMap, "amountIncludingFee", feeLookupRequestElement);
        putIfPresent(xmlValuesMap, "amountExcludingFee", feeLookupRequestElement);
        putIfPresent(xmlValuesMap, "receiveAmount", feeLookupRequestElement);
        putIfPresent(xmlValuesMap, "receiveCountry", feeLookupRequestElement);
        putIfPresent(xmlValuesMap, "deliveryOption", feeLookupRequestElement);
        putIfPresent(xmlValuesMap, "mgiRewardsNumber", feeLookupRequestElement);
        putIfPresent(xmlValuesMap, "receiveAgentID", feeLookupRequestElement);
        putIfPresent(xmlValuesMap, "receiveCurrency", feeLookupRequestElement);
        putIfPresent(xmlValuesMap, "sendCurrency", feeLookupRequestElement);
        putIfPresent(xmlValuesMap, "mgCustomerReceiveNumber", feeLookupRequestElement);
        putIfPresent(xmlValuesMap, "allOptions", feeLookupRequestElement);
        putIfPresent(xmlValuesMap, "promoCode", feeLookupRequestElement);
    }

    private void extractReferenceNumberRequest(Element bodyElement, Map<String, String> xmlValuesMap) throws CustomException {
        // Retrieve the list of "referenceNumberRequest" elements from the body element
        NodeList referenceNumberRequestList = bodyElement.getElementsByTagName("referenceNumberRequest");

        // Check if "referenceNumberRequest" element is present
        if (referenceNumberRequestList.getLength() == 0) {
            throw new CustomException(String.format("%sRoot tag referenceNumberRequest not found", DEFAULT_PROCESSING_FAILURE));
        }

        // Get the first "referenceNumberRequest" element
        Element referenceNumberRequestElement = (Element) referenceNumberRequestList.item(0);

        // Extract and put values into the map if present
        putIfPresent(xmlValuesMap, "referenceNumber", referenceNumberRequestElement);
        putIfPresent(xmlValuesMap, "pin", referenceNumberRequestElement);
        putIfPresent(xmlValuesMap, "operatorName", referenceNumberRequestElement);

    }

    private void extractSendGFFPRequest(Element bodyElement, Map<String, String> xmlValuesMap) throws CustomException {
        // Retrieve the list of "getFieldsForProductRequest" elements from the body element
        NodeList getFieldForProductRequestList = bodyElement.getElementsByTagName("getFieldsForProductRequest");

        // Check if "getFieldsForProductRequest" element is present
        if (getFieldForProductRequestList.getLength() == 0) {
            throw new CustomException(String.format("%sRoot tag getFieldsForProductRequest not found", DEFAULT_PROCESSING_FAILURE));
        }

        // Get the first "getFieldsForProductRequest" element
        Element getFieldForProductRequestElement = (Element) getFieldForProductRequestList.item(0);

        // Extract and put values into the map if present
        putIfPresent(xmlValuesMap, "receiveCountry", getFieldForProductRequestElement);
        putIfPresent(xmlValuesMap, "deliveryOption", getFieldForProductRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyType", getFieldForProductRequestElement);
        putIfPresent(xmlValuesMap, "receiveAgentID", getFieldForProductRequestElement);
        putIfPresent(xmlValuesMap, "customerReceiveNumber", getFieldForProductRequestElement);
        putIfPresent(xmlValuesMap, "receiveCurrency", getFieldForProductRequestElement);
        putIfPresent(xmlValuesMap, "amount", getFieldForProductRequestElement);
        putIfPresent(xmlValuesMap, "sendCurrency", getFieldForProductRequestElement);
        putIfPresent(xmlValuesMap, "productType", getFieldForProductRequestElement);
        putIfPresent(xmlValuesMap, "consumerId", getFieldForProductRequestElement);
        putIfPresent(xmlValuesMap, "formFreeStaging", getFieldForProductRequestElement);
    }

    private void extractReceiveGFFPRequest(Element bodyElement, Map<String, String> xmlValuesMap) throws CustomException {
        // Retrieve the list of receive "getFieldsForProductRequest" elements from the body element
        NodeList getFieldForProductRequestList = bodyElement.getElementsByTagName("getFieldsForProductRequest");

        // Check if "getFieldsForProductRequest" element is present
        if (getFieldForProductRequestList.getLength() == 0) {
            throw new CustomException(String.format("%sRoot tag getFieldsForProductRequest not found", DEFAULT_PROCESSING_FAILURE));
        }

        // Get the first "getFieldsForProductRequest" element
        Element getFieldForProductRequestElement = (Element) getFieldForProductRequestList.item(0);

        // Extract and put values into the map if present
        putIfPresent(xmlValuesMap, "receiveCountry", getFieldForProductRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyType", getFieldForProductRequestElement);
        putIfPresent(xmlValuesMap, "receiveCurrency", getFieldForProductRequestElement);
        putIfPresent(xmlValuesMap, "sendCurrency", getFieldForProductRequestElement);
        putIfPresent(xmlValuesMap, "amount", getFieldForProductRequestElement);
        putIfPresent(xmlValuesMap, "productType", getFieldForProductRequestElement);
        putIfPresent(xmlValuesMap, "consumerId", getFieldForProductRequestElement);
        putIfPresent(xmlValuesMap, "formFreeStaging", getFieldForProductRequestElement);
    }

    private void extractSendValidationRequest(Element bodyElement, Map<String, String> xmlValuesMap) throws CustomException {
        // Retrieve the list of "sendValidationRequest" elements from the body element
        NodeList sendValidationRequestList = bodyElement.getElementsByTagName("sendValidationRequest");

        // Check if "sendValidationRequest" element is present
        if (sendValidationRequestList.getLength() == 0) {
            throw new CustomException(String.format("%sRoot tag sendValidationRequest not found", DEFAULT_PROCESSING_FAILURE));
        }

        // Get the first "sendValidationRequest" element
        Element sendValidationRequestElement = (Element) sendValidationRequestList.item(0);

        // Extract and put values into the map if present
        putIfPresent(xmlValuesMap, "agentStagingChannel", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "operatorName", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "amount", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "feeAmount", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "mgiRewardsNumber", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "agentCustomerNumber", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "destinationCountry", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "destinationState", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "deliveryOption", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiveCurrency", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiveAgentID", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "accountNumber", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "customerReceiveNumber", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderFirstName", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderMiddleName", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderLastName", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderLastName2", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderAddress", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderAddress2", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderAddress3", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderCity", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderState", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderZipCode", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderCountry", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderHomePhone", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderMailingAddress", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderMailingAddress2", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderMailingAddress3", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderMailingCity", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderMailingState", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderMailingZipCode", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderMailingCountry", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverFirstName", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverMiddleName", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverLastName", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverLastName2", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverAddress", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverAddress2", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverAddress3", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "direction1", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "direction2", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "direction3", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverCity", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverState", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverZipCode", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverCountry", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverPhone", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverPhoneCountryCode", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverEmail", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "testQuestion", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "testAnswer", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "messageField1", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "messageField2", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderPhotoIdType", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderPhotoIdNumber", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderPhotoIdCity", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderPhotoIdState", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderPhotoIdCountry", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderLegalIdType", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderLegalIdNumber", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderDOB", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderOccupation", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyFirstName", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyMiddleName", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyLastName", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyLastName2", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyAddress", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyAddress2", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyAddress3", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyCity", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyState", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyZipCode", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyCountry", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyLegalIdType", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyLegalIdNumber", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyDOB", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyOrg", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderBirthCity", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderBirthCountry", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderLegalIdIssueCountry", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderEmailAddress", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderMobilePhone", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderMobilePhoneCountryCode", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "marketingOptIn", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "pcTerminalNumber", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "agentUseSendData", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "sendCurrency", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "consumerId", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderPhotoIdStored", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderNationalityCountry", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderNationalityAtBirthCountry", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "agentTransactionId", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "mgiTransactionSessionID", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "formFreeStaging", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "primaryReceiptLanguage", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "secondaryReceiptLanguage", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "sendPurposeOfTransaction", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "sourceOfFunds", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "sourceOfFundsOther", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "sendPurposeOfTransactionOther", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "paymentTenderedType", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "relationshipToReceiver", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "relationshipToReceiverOther", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "proofOfFunds", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "proofOfFundsOther", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderGender", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderOccupationOther", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderBirthState", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderNameSuffix", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderNameSuffixOther", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderCitizenshipCountry", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderCitizenshipAtBirthCountry", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderDualCitizenshipCountry", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderPhotoIdIssueMonth", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderPhotoIdIssueYear", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderPhotoIdIssueDay", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderPhotoIdExpirationMonth", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderPhotoIdExpirationYear", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderPhotoIdExpirationDay", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderPhotoIdIssueAuthority", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderLegalIdIssueMonth", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderLegalIdIssueYear", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderLegalIdIssueDay", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderLegalIdExpirationMonth", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderLegalIdExpirationYear", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderLegalIdExpirationDay", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderLegalIdIssueAuthority", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderLegalIdState", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderTransactionEmailNotificationOptIn", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderTransactionSMSNotificationOptIn", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderMarketingEmailNotificationOptIn", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderMarketingSMSNotificationOptIn", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverTransactionEmailNotificationOptIn", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverTransactionSMSNotificationOptIn", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderHomePhoneNotAvailable", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderHomePhoneCountryCode", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverNameSuffix", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverNameSuffixOther", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderFirstNameNotAvailable", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverFirstNameNotAvailable", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyFirstNameNotAvailable", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartySenderBirthCity", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartySenderBirthState", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartySenderBirthCountry", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartySenderGender", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartySenderOccupation", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartySenderOccupationOther", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartySenderNameSuffix", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartySenderNameSuffixOther", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartySenderCitizenshipCountry", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartySenderCitizenshipAtBirthCountry", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartySenderDualCitizenshipCountry", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyLegalIdIssueMonth", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyLegalIdIssueYear", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyLegalIdIssueDay", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyLegalIdExpirationMonth", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyLegalIdExpirationYear", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyLegalIdExpirationDay", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyLegalIdIssueAuthority", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyLegalIdState", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyLegalIdIssueCountry", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderIntendedUseOfMGIServices", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderMotherMaidenName", sendValidationRequestElement);
        putIfPresent(xmlValuesMap, "senderFatherFirstName", sendValidationRequestElement);

        // Process receiptImages if present
        NodeList receiptImagesList = sendValidationRequestElement.getElementsByTagName("receiptImages");
        if (receiptImagesList.getLength() > 0) {
            Element receiptImagesElement = (Element) receiptImagesList.item(0);
            NodeList receiptImageList = receiptImagesElement.getElementsByTagName("receiptImage");
            for (int i = 0; i < receiptImageList.getLength(); i++) {
                Element receiptImageElement = (Element) receiptImageList.item(i);
                putIfPresent(xmlValuesMap, "identifier", receiptImageElement);
                putIfPresent(xmlValuesMap, "mimeType", receiptImageElement);
                putIfPresent(xmlValuesMap, "image", receiptImageElement);
            }
        }

        // Process promoCodeValues if present
        NodeList promoCodeValuesList = sendValidationRequestElement.getElementsByTagName("promoCodeValues");
        if (promoCodeValuesList.getLength() > 0) {
            Element promoCodeValuesElement = (Element) promoCodeValuesList.item(0);
            NodeList promoCodeList = promoCodeValuesElement.getElementsByTagName("promoCode");
            for (int i = 0; i < promoCodeList.getLength(); i++) {
                Element promoCodeElement = (Element) promoCodeList.item(i);
                putIfPresent(xmlValuesMap, "promoCode", promoCodeElement);
            }
        }

        // Process fieldValues if present
        NodeList fieldValuesList = sendValidationRequestElement.getElementsByTagName("fieldValues");
        if (fieldValuesList.getLength() > 0) {
            Element fieldValuesElement = (Element) fieldValuesList.item(0);
            NodeList keyValuePairList = fieldValuesElement.getElementsByTagName("keyValuePair");
            for (int i = 0; i < keyValuePairList.getLength(); i++) {
                Element keyValuePairElement = (Element) keyValuePairList.item(i);
                putIfPresent(xmlValuesMap, "xmlTag", keyValuePairElement);
                putIfPresent(xmlValuesMap, "value", keyValuePairElement);
            }
        }
    }

    private void extractReceiveValidationRequest(Element bodyElement, Map<String, String> xmlValuesMap) throws CustomException {
        // Retrieve the list of "receiveValidationRequest" elements from the body element
        NodeList receiveValidationRequestList = bodyElement.getElementsByTagName("receiveValidationRequest");

        // Check if "receiveValidationRequest" element is present
        if (receiveValidationRequestList.getLength() == 0) {
            throw new CustomException(String.format("%sRoot tag receiveValidationRequest not found", DEFAULT_PROCESSING_FAILURE));
        }

        // Get the first "receiveValidationRequest" element
        Element receiveValidationRequestElement = (Element) receiveValidationRequestList.item(0);

        // Extract and put values into the map if present
        putIfPresent(xmlValuesMap, "agentStagingChannel", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "operatorName", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "referenceNumber", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "pin", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiveCurrency", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "agentCheckNumber", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "agentCheckType", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "agentCheckAmount", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "customerCheckNumber", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "customerCheckType", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "customerCheckAmount", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverAddress", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverAddress2", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverAddress3", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverCity", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverState", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverZipCode", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverCountry", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverMailingAddress", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverMailingAddress2", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverMailingAddress3", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverMailingCity", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverMailingState", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverMailingZipCode", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverMailingCountry", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverPhotoIdType", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverPhotoIdNumber", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverPhotoIdState", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverPhotoIdCountry", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverLegalIdType", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverLegalIdNumber", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverDOB", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverOccupation", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyFirstName", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyMiddleName", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyLastName", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyLastName2", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyAddress", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyAddress2", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyAddress3", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyCity", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyState", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyZipCode", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyCountry", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyLegalIdType", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyLegalIdNumber", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyDOB", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyOrg", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverBirthCity", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverBirthCountry", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverNationalityCountry", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverNationalityAtBirthCountry", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "pcTerminalNumber", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "agentUseReceiveData", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "billerAccountNumber", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "otherPayoutType", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "otherPayoutAmount", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "cardExpirationMonth", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "cardExpirationYear", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "cardSwiped", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "consumerId", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverPhone", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "agentConsumerID", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "agentTransactionId", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "mgiTransactionSessionID", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "formFreeStaging", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "timeToLive", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receivePurposeOfTransaction", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receivePurposeOfTransactionOther", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "relationshipToSender", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "relationshipToSenderOther", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverOccupationOther", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverGender", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverBirthState", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverCitizenshipCountry", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverCitizenshipAtBirthCountry", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverDualCitizenshipCountry", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverPhotoIdIssueMonth", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverPhotoIdIssueYear", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverPhotoIdIssueDay", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverPhotoIdExpirationMonth", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverPhotoIdExpirationYear", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverPhotoIdExpirationDay", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverPhotoIdIssueAuthority", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverLegalIdIssueMonth", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverLegalIdIssueYear", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverLegalIdIssueDay", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverLegalIdExpirationMonth", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverLegalIdExpirationYear", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverLegalIdExpirationDay", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverLegalIdIssueAuthority", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverLegalIdState", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverLegalIdIssueCountry", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverPhoneNotAvailable", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverPhoneCountryCode", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyFirstNameNotAvailable", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyReceiverNameSuffix", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyReceiverNameSuffixOther", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyReceiverGender", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyReceiverOccupation", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyReceiverOccupationOther", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyReceiverBirthCity", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyReceiverBirthState", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyReceiverBirthCountry", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyReceiverCitizenshipCountry", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyReceiverCitizenshipAtBirthCountry", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyReceiverDualCitizenshipCountry", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyLegalIdIssueMonth", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyLegalIdIssueYear", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyLegalIdIssueDay", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyLegalIdExpirationMonth", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyLegalIdExpirationYear", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyLegalIdExpirationDay", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyLegalIdIssueAuthority", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyLegalIdState", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "thirdPartyLegalIdIssueCountry", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "primaryReceiptLanguage", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "secondaryReceiptLanguage", receiveValidationRequestElement);
        putIfPresent(xmlValuesMap, "receiverIntendedUseOfMGIServices", receiveValidationRequestElement);

        // Process receiptImages if present
        NodeList receiptImagesList = receiveValidationRequestElement.getElementsByTagName("receiptImages");
        if (receiptImagesList.getLength() > 0) {
            Element receiptImagesElement = (Element) receiptImagesList.item(0);
            NodeList receiptImageList = receiptImagesElement.getElementsByTagName("receiptImage");
            for (int i = 0; i < receiptImageList.getLength(); i++) {
                Element receiptImageElement = (Element) receiptImageList.item(i);
                putIfPresent(xmlValuesMap, "identifier", receiptImageElement);
                putIfPresent(xmlValuesMap, "mimeType", receiptImageElement);
                putIfPresent(xmlValuesMap, "image", receiptImageElement);
            }
        }

        // Process fieldValues if present
        NodeList fieldValuesList = receiveValidationRequestElement.getElementsByTagName("fieldValues");
        if (fieldValuesList.getLength() > 0) {
            Element fieldValuesElement = (Element) fieldValuesList.item(0);
            NodeList keyValuePairList = fieldValuesElement.getElementsByTagName("keyValuePair");
            for (int i = 0; i < keyValuePairList.getLength(); i++) {
                Element keyValuePairElement = (Element) keyValuePairList.item(i);
                putIfPresent(xmlValuesMap, "xmlTag", keyValuePairElement);
                putIfPresent(xmlValuesMap, "fieldValue", keyValuePairElement);
            }
        }
    }

    private void extractReceiveReversalRequest(Element bodyElement, Map<String, String> xmlValuesMap) throws CustomException {
        // Retrieve the list of "receiveReversalRequest" elements from the body element
        NodeList receiveReversalRequestList = bodyElement.getElementsByTagName("receiveReversalRequest");

        // Check if "receiveReversalRequest" element is present
        if (receiveReversalRequestList.getLength() == 0) {
            throw new CustomException(String.format("%sRoot tag receiveReversalRequest not found", DEFAULT_PROCESSING_FAILURE));
        }

        // Get the first "receiveReversalRequest" element
        Element receiveReversalRequestElement = (Element) receiveReversalRequestList.item(0);

        // Extract and put values into the map if present
        putIfPresent(xmlValuesMap, "rrn", receiveReversalRequestElement);
        putIfPresent(xmlValuesMap, "channelId", receiveReversalRequestElement);
        putIfPresent(xmlValuesMap, "sourceSystemId", receiveReversalRequestElement);
        putIfPresent(xmlValuesMap, "bankId", receiveReversalRequestElement);
        putIfPresent(xmlValuesMap, "signature", receiveReversalRequestElement);
        putIfPresent(xmlValuesMap, "receiveAmount", receiveReversalRequestElement);
        putIfPresent(xmlValuesMap, "referenceNumber", receiveReversalRequestElement);
        putIfPresent(xmlValuesMap, "operatorName", receiveReversalRequestElement);
        putIfPresent(xmlValuesMap, "receiveReversalReason", receiveReversalRequestElement);
    }

    private void extractCodeTableRequest(Element bodyElement, Map<String, String> xmlValuesMap) throws CustomException {
        // Retrieve the list of "codeTableRequest" elements from the body element
        NodeList codeTableRequestList = bodyElement.getElementsByTagName("codeTableRequest");

        // Check if "feeLookupRequest" element is present
        if (codeTableRequestList.getLength() == 0) {
            throw new CustomException(String.format("%sRoot tag codeTableRequest not found", DEFAULT_PROCESSING_FAILURE));
        }

        // Get the first "feeLookupRequest" element
        Element codeTableRequestElement = (Element) codeTableRequestList.item(0);

        // Extract and put values into the map if present
        putIfPresent(xmlValuesMap, "agentAllowedOnly", codeTableRequestElement);
    }

    private void extractCommitTransactionRequest(Element bodyElement, Map<String, String> xmlValuesMap) throws CustomException {
        // Retrieve the list of "commitTransactionRequest" elements from the body element
        NodeList commitTransactionRequestList = bodyElement.getElementsByTagName("commitTransactionRequest");

        // Check if "commitTransactionRequest" element is present
        if (commitTransactionRequestList.getLength() == 0) {
            throw new CustomException(String.format("%sRoot tag commitTransactionRequest not found", DEFAULT_PROCESSING_FAILURE));
        }

        // Get the first "commitTransactionRequest" element
        Element commitTransactionRequestElement = (Element) commitTransactionRequestList.item(0);

        // Extract and put values into the map if present
        putIfPresent(xmlValuesMap, "mgiTransactionSessionID", commitTransactionRequestElement);
        putIfPresent(xmlValuesMap, "productType", commitTransactionRequestElement);
        putIfPresent(xmlValuesMap, "stateRegulatorVersion", commitTransactionRequestElement);

        // Handle the key-value pairs inside the fieldValues element
        NodeList fieldValuesList = commitTransactionRequestElement.getElementsByTagName("fieldValues");

        if (fieldValuesList.getLength() > 0) {
            Element fieldValuesElement = (Element) fieldValuesList.item(0);
            NodeList keyValuePairList = fieldValuesElement.getElementsByTagName("keyValuePair");

            for (int i = 0; i < keyValuePairList.getLength(); i++) {
                Element keyValuePairElement = (Element) keyValuePairList.item(i);
                String xmlTag = getTagValue("xmlTag", keyValuePairElement);
                String fieldValue = getTagValue("fieldValue", keyValuePairElement);

                // Put the xmlTag as the key and the fieldValue as the value in the map
                if (xmlTag != null && fieldValue != null) {
                    xmlValuesMap.put(xmlTag, fieldValue);
                }
            }
        }
    }

    private void extractReceiveCommitTransaction(Element bodyElement, Map<String, String> xmlValuesMap) throws CustomException {
        // Retrieve the list of "commitTransactionRequest" elements from the body element
        NodeList commitTransactionRequestList = bodyElement.getElementsByTagName("commitTransactionRequest");

        // Check if "commitTransactionRequest" element is present
        if (commitTransactionRequestList.getLength() == 0) {
            throw new CustomException(String.format("%sRoot tag commitTransactionRequest not found", DEFAULT_PROCESSING_FAILURE));
        }

        // Get the first "commitTransactionRequest" element
        Element commitTransactionRequestElement = (Element) commitTransactionRequestList.item(0);

        // Extract and put values into the map if present
        putIfPresent(xmlValuesMap, "mgiTransactionSessionID", commitTransactionRequestElement);
        putIfPresent(xmlValuesMap, "productType", commitTransactionRequestElement);

        // Handle the key-value pairs inside the fieldValues element
        NodeList fieldValuesList = commitTransactionRequestElement.getElementsByTagName("fieldValues");

        if (fieldValuesList.getLength() > 0) {
            Element fieldValuesElement = (Element) fieldValuesList.item(0);
            NodeList keyValuePairList = fieldValuesElement.getElementsByTagName("keyValuePair");

            for (int i = 0; i < keyValuePairList.getLength(); i++) {
                Element keyValuePairElement = (Element) keyValuePairList.item(i);
                String xmlTag = getTagValue("xmlTag", keyValuePairElement);
                String fieldValue = getTagValue("fieldValue", keyValuePairElement);

                // Put the xmlTag as the key and the fieldValue as the value in the map
                if (xmlTag != null && fieldValue != null) {
                    xmlValuesMap.put(xmlTag, fieldValue);
                }
            }
        }
    }

    private void parseCallbackResponse(Document document, Map<String, String> xmlValuesMap) throws CustomException {
        // Retrieve the list of "statusDetails" elements from the body element
        NodeList statusDetailsList = document.getElementsByTagName("statusDetails");

        // Check if "statusDetails" element is present
        if (statusDetailsList.getLength() == 0) {
            throw new CustomException(String.format("%sRoot tag statusDetails not found", DEFAULT_PROCESSING_FAILURE));
        }

        // Get the first "statusDetails" element
        Element statusDetailsElement = (Element) statusDetailsList.item(0);

        // Extract and put values into the map if present
        putIfPresent(xmlValuesMap, "rrn", statusDetailsElement);
        putIfPresent(xmlValuesMap, "imtReferenceNumber", statusDetailsElement);
        putIfPresent(xmlValuesMap, "imtSessionTranId", statusDetailsElement);
        putIfPresent(xmlValuesMap, "imtTransactionDate", statusDetailsElement);
        putIfPresent(xmlValuesMap, "status", statusDetailsElement);
        putIfPresent(xmlValuesMap, "responseCode", statusDetailsElement);
        putIfPresent(xmlValuesMap, "responseDesc", statusDetailsElement);
    }

    private void extractDetailLookupRequest(Element bodyElement, Map<String, String> xmlValuesMap) throws CustomException {
        // Retrieve the list of "detailLookupRequest" elements from the body element
        NodeList detailLookupRequestList = bodyElement.getElementsByTagName("detailLookupRequest");

        // Check if "detailLookupRequest" element is present
        if (detailLookupRequestList.getLength() == 0) {
            throw new CustomException(String.format("%sRoot tag detailLookupRequest not found", DEFAULT_PROCESSING_FAILURE));
        }

        // Get the first "detailLookupRequest" element
        Element detailLookupRequestElement = (Element) detailLookupRequestList.item(0);

        // Extract and put values into the map if present
        putIfPresent(xmlValuesMap, "referenceNumber", detailLookupRequestElement);
        putIfPresent(xmlValuesMap, "mgiTransactionSessionID", detailLookupRequestElement);
        putIfPresent(xmlValuesMap, "includeUseData", detailLookupRequestElement);
        putIfPresent(xmlValuesMap, "operatorName", detailLookupRequestElement);
    }

    private void extractSendReversalRequest(Element bodyElement, Map<String, String> xmlValuesMap) throws CustomException {
        // Retrieve the list of "sendReversalRequest" elements from the body element
        NodeList sendReversalRequestList = bodyElement.getElementsByTagName("sendReversalRequest");

        // Check if "sendReversalRequest" element is present
        if (sendReversalRequestList.getLength() == 0) {
            throw new CustomException(String.format("%sRoot tag sendReversalRequest not found", DEFAULT_PROCESSING_FAILURE));
        }

        // Get the first "sendReversalRequest" element
        Element sendReversalRequestElement = (Element) sendReversalRequestList.item(0);

        // Extract and put values into the map if present
        putIfPresent(xmlValuesMap, "sendAmount", sendReversalRequestElement);
        putIfPresent(xmlValuesMap, "feeAmount", sendReversalRequestElement);
        putIfPresent(xmlValuesMap, "sendCurrency", sendReversalRequestElement);
        putIfPresent(xmlValuesMap, "referenceNumber", sendReversalRequestElement);
        putIfPresent(xmlValuesMap, "operatorName", sendReversalRequestElement);
        putIfPresent(xmlValuesMap, "reversalType", sendReversalRequestElement);
        putIfPresent(xmlValuesMap, "sendReversalReason", sendReversalRequestElement);
        putIfPresent(xmlValuesMap, "feeRefund", sendReversalRequestElement);
        putIfPresent(xmlValuesMap, "agentCheckType", sendReversalRequestElement);
        putIfPresent(xmlValuesMap, "agentCheckNumber", sendReversalRequestElement);
        putIfPresent(xmlValuesMap, "agentCheckAmount", sendReversalRequestElement);
        putIfPresent(xmlValuesMap, "customerCheckType", sendReversalRequestElement);
        putIfPresent(xmlValuesMap, "customerCheckNumber", sendReversalRequestElement);
        putIfPresent(xmlValuesMap, "customerCheckAmount", sendReversalRequestElement);
        putIfPresent(xmlValuesMap, "communicationRetryIndicator", sendReversalRequestElement);
    }

    private void extractAmendTransactionRequest(Element bodyElement, Map<String, String> xmlValuesMap) throws CustomException {
        // Retrieve the list of "amendTransactionRequest" elements from the body element
        NodeList amendTransactionRequestList = bodyElement.getElementsByTagName("amendTransactionRequest");

        // Check if "amendTransactionRequest" element is present
        if (amendTransactionRequestList.getLength() == 0) {
            throw new CustomException(String.format("%sRoot tag amendTransactionRequest not found", DEFAULT_PROCESSING_FAILURE));
        }

        // Get the first "amendTransactionRequest" element
        Element amendTransactionRequestElement = (Element) amendTransactionRequestList.item(0);

        // Extract and put values into the map if present
        putIfPresent(xmlValuesMap, "referenceNumber", amendTransactionRequestElement);
        putIfPresent(xmlValuesMap, "operatorName", amendTransactionRequestElement);
        putIfPresent(xmlValuesMap, "receiverFirstName", amendTransactionRequestElement);
        putIfPresent(xmlValuesMap, "receiverMiddleName", amendTransactionRequestElement);
        putIfPresent(xmlValuesMap, "receiverLastName", amendTransactionRequestElement);
        putIfPresent(xmlValuesMap, "receiverLastName2", amendTransactionRequestElement);
        putIfPresent(xmlValuesMap, "receiverNameSuffix", amendTransactionRequestElement);
        putIfPresent(xmlValuesMap, "receiverNameSuffixOther", amendTransactionRequestElement);
        putIfPresent(xmlValuesMap, "receiverFirstNameNotAvailable", amendTransactionRequestElement);
    }

    private void parseNamecheckRequest(Document document, Map<String, String> xmlValuesMap) throws CustomException {
        // Retrieve the list of "mobileNumberInquireReq" elements from the document
        NodeList requestList = document.getElementsByTagName("mobileNumberInquireReq");

        // Check if "mobileNumberInquireReq" element is present
        if (requestList.getLength() == 0) {
            throw new CustomException(DEFAULT_PROCESSING_FAILURE + " Root tag mobileNumberInquireReq not found");
        }

        // Get the first "mobileNumberInquireReq" element
        Element requestElement = (Element) requestList.item(0);

        // Extract and put values into the map if present
        putIfPresent(xmlValuesMap, "msgId", requestElement);
        putIfPresent(xmlValuesMap, "channel", requestElement);
        putIfPresent(xmlValuesMap, "bankId", requestElement);
        putIfPresent(xmlValuesMap, "telcom", requestElement);
        putIfPresent(xmlValuesMap, "mobileNumber", requestElement);
        putIfPresent(xmlValuesMap, "timestamp", requestElement);
        putIfPresent(xmlValuesMap, "amount", requestElement);
        putIfPresent(xmlValuesMap, "signature", requestElement);
    }

    private void parseStatusCheckRequest(Document document, Map<String, String> xmlValuesMap) throws CustomException {
        // Retrieve the list of "mobileNumberInquireReq" elements from the document
        NodeList requestList = document.getElementsByTagName("eazzycashStatusReq");

        // Check if "mobileNumberInquireReq" element is present
        if (requestList.getLength() == 0) {
            throw new CustomException(DEFAULT_PROCESSING_FAILURE + " Root tag eazzycashStatusReq not found");
        }

        // Get the first "mobileNumberInquireReq" element
        Element requestElement = (Element) requestList.item(0);

        // Extract and put values into the map if present
        putIfPresent(xmlValuesMap, "rrn", requestElement);
        putIfPresent(xmlValuesMap, "channel", requestElement);
        putIfPresent(xmlValuesMap, "bankId", requestElement);
        putIfPresent(xmlValuesMap, "telco", requestElement);
        putIfPresent(xmlValuesMap, "signature", requestElement);
    }

    private void parseStatusCheckResponse(Document document, Map<String, String> xmlValuesMap) throws CustomException {
        // Retrieve the list of "mobileNumberInquireReq" elements from the document
        NodeList requestList = document.getElementsByTagName("eazzycashStatusRes");

        // Check if "mobileNumberInquireReq" element is present
        if (requestList.getLength() == 0) {
            throw new CustomException(DEFAULT_PROCESSING_FAILURE + " Root tag eazzycashStatusRes not found");
        }

        // Get the first "mobileNumberInquireReq" element
        Element requestElement = (Element) requestList.item(0);

        // Extract and put values into the map if present
        putIfPresent(xmlValuesMap, "rrn", requestElement);
        putIfPresent(xmlValuesMap, "status", requestElement);
        putIfPresent(xmlValuesMap, "responseCode", requestElement);
        putIfPresent(xmlValuesMap, "responseDesc", requestElement);
    }

    private void putIfPresent(Map<String, String> map, String tagName, Element parentElement) {
        log.info("Tag name: " + tagName);
        // Get the value of the specified tag from the parent element
        String value = getTagValue(tagName, parentElement);
        map.put(tagName, value.trim());
    }

    private static String getTagValue(String tag, Element element) {
        NodeList nodeList = element.getElementsByTagName(tag);
        if (nodeList.getLength() > 0) {
            Node node = nodeList.item(0);
            if (node.getNodeType() == Node.ELEMENT_NODE) {
                return node.getTextContent(); // Get the text content of the element
            }
        }
//        log.warn("The tag ({}) is not found in this request. Getting the next tag...", tag);
        return ""; // Return blank if the tag is not found or if there are issues
    }

}
