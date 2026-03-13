package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.service.util;

import com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.exception.CustomException;

import static com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.service.util.StatusCodeMessages.DEFAULT_PROCESSING_FAILURE;

import com.google.common.base.CaseFormat;
import com.moneygram.agentconnect1512.AmendTransactionRequest;
import com.moneygram.agentconnect1512.ChannelTypeEnum;
import com.moneygram.agentconnect1512.CommitTransactionRequest;
import com.moneygram.agentconnect1512.DetailLookupRequest;
import com.moneygram.agentconnect1512.FeeLookupRequest;
import com.moneygram.agentconnect1512.GetFieldsForProductRequest;
import com.moneygram.agentconnect1512.KeyValuePair;
import com.moneygram.agentconnect1512.ProductType;
import com.moneygram.agentconnect1512.ReceiveValidationRequest;
import com.moneygram.agentconnect1512.ReferenceNumberRequest;
import com.moneygram.agentconnect1512.SendReversalRequest;
import com.moneygram.agentconnect1512.SendValidationRequest;
import com.moneygram.agentconnect1512.TargetAudienceType;
import com.moneygram.agentconnect1512.ThirdPartyType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
import java.math.BigDecimal;
import java.text.ParseException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.xml.datatype.DatatypeConfigurationException;

@Service
public class XmlReaderService {

    private static final Logger log = LoggerFactory.getLogger(XmlReaderService.class);

    private final String token;
    private final String agentID;
    private final String agentSequence;

    @Autowired
    public XmlReaderService(@Value("${moneygram.params.token}") String token,
                            @Value("${moneygram.params.agentId}") String agentID,
                            @Value("${moneygram.params.agentSequence}") String agentSequence) {
        this.token = token;
        this.agentID = agentID;
        this.agentSequence = agentSequence;
    }

    //    public static Map<String, String> getMap()
//    {
//    
//    }
    public Object parseXml(String xmlString, String type, ProductType productType) throws CustomException {
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
            String rootTag = document.getDocumentElement().getTagName().trim();

            // Determine the type of XML response and delegate to the appropriate parsing method
            if ("response".equals(rootTag)) {
                parseEazzycashResponse(document, xmlValuesMap);
            } else if ("moneygram-commit-callback".equals(rootTag)) {
                parseCallbackResponse(document, xmlValuesMap);
            } else if (rootTag.toLowerCase().contains("envelope")) { // Generalized check for Envelope or soap:Envelope
                if (isMoneyGramService(type)) {
                    return parseMoneyGramRequest(document, xmlString, type, productType);
                } else {
                    parseTopUpResponse(document, xmlValuesMap);
                }
            } else {
                // Unexpected XML format
                throw new CustomException(DEFAULT_PROCESSING_FAILURE + "Unexpected XML format");
            }
        } catch (Exception e) {
            log.error("An error occurred when reading xml values: {}", e.getMessage());
            e.printStackTrace(System.out);
            throw new CustomException(e.getMessage());
        }

        // Return the map containing the parsed XML values
        return null;
    }

    private boolean isMoneyGramService(String type) {
        Set<String> moneyGramServiceSet = Set.of(
                "moneygram-fee-lookup",
                "moneygram-get-field-for-product",
                "moneygram-send-validation-request",
                "moneygram-commit-transaction",
                "moneygram-detail-lookup",
                "moneygram-send-reversal",
                "moneygram-reference-number-request",
                "moneygram-receive-validation-request",
                "moneygram-receive-reversal",
                "moneygram-code-table-service",
                "moneygram-amend-transaction");
        return moneyGramServiceSet.contains(type);
    }

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
                String responseDesc = getTagValue("responseDesc", eazzycashresElement);

                // Put the values in the map
                xmlValuesMap.put("status", status);
                xmlValuesMap.put("responseCode", responseCode);
                xmlValuesMap.put("responseDesc", responseDesc);
            }
        }
    }

    private void parseTopUpResponse(Document document, Map<String, String> xmlValuesMap) {
        NodeList topupResponseList = document.getElementsByTagName("topupResponse");
        if (topupResponseList.getLength() > 0) {
            Node topupResponseNode = topupResponseList.item(0);
            if (topupResponseNode.getNodeType() == Node.ELEMENT_NODE) {
                Element topupResponseElement = (Element) topupResponseNode;

                String error = getTagValue("return", topupResponseElement);

                // Separate the error code from the error
                String[] errorArray = error.split("\\|");
                String responseCode = "";
                String status = "";
                if (errorArray.length > 1) {
                    status = errorArray[0];
                    responseCode = errorArray[1];
                }

                // Put the values in the map
                xmlValuesMap.put("status", status);
                xmlValuesMap.put("responseDesc", "");
                xmlValuesMap.put("responseCode", responseCode);
            }
        }
    }

    private Object parseMoneyGramRequest(Document document, String xmlString, String type, ProductType productType) throws CustomException, ParseException, DatatypeConfigurationException, Exception {
        // Retrieve the list of "soapenv:Body" elements from the document
        NodeList bodyList = document.getElementsByTagName("soapenv:Body");

        // If "soapenv:Body" is not found, try retrieving the list of "Body" elements
        if (bodyList.getLength() == 0) {
            bodyList = document.getElementsByTagName("Body");
        }

        // Check if the body element is present
        if (bodyList.getLength() == 0) {
            throw new CustomException(String.format("%sCould not get the xml body list", DEFAULT_PROCESSING_FAILURE));
        }

        // Get the first "Body" element
        Element bodyElement = (Element) bodyList.item(0);

        // Extract specific request values based on the request type
        if (type.equalsIgnoreCase("moneygram-fee-lookup")) {
            return extractFeeLookupRequest(bodyElement, productType);
        }
        if (type.equalsIgnoreCase("moneygram-get-field-for-product")) {
            return extractGetFieldsForProductRequest(bodyElement, productType);
        }
        if (type.equalsIgnoreCase("moneygram-send-validation-request")) {

            return extractSendValidationRequest(xmlString);
        }
        if (type.equalsIgnoreCase("moneygram-commit-transaction")) {
            return extractCommitTransactionRequest(xmlString, productType);
        }
        if (type.equalsIgnoreCase("moneygram-amend-transaction")) {
            return extractAmendTransactionRequest(xmlString, productType);
        }
        if (type.equalsIgnoreCase("moneygram-send-reversal")) {
            return extractSendReversalRequest(xmlString, productType);
        }
        if (type.equalsIgnoreCase("moneygram-detail-lookup")) {
            return extractDetailLookupRequest(xmlString, productType);
        }
        if (type.equalsIgnoreCase("moneygram-reference-number-request")) {
            return extractReferenceNumberRequest(xmlString, productType);
        }
        if (type.equalsIgnoreCase("moneygram-receive-validation-request")) {
            return extractReceiveValidationRequest(xmlString, productType);
        }
        
         

        /*
        <unitProfileID>%s</unitProfileID>
<agentID>%s</agentID>
<agentSequence>%s</agentSequence>
<token>%s</token>
<timeStamp>%s</timeStamp>
<apiVersion>%s</apiVersion>
<clientSoftwareVersion>%s</clientSoftwareVersion>
<channelType>%s</channelType>
        switch (type) {
            case "moneygram-fee-lookup" -> return extractFeeLookupRequest(bodyElement);
            case "moneygram-get-field-for-product" -> extractGetFieldsForProductRequest(bodyElement, xmlValuesMap);
            case "moneygram-send-validation-request" -> extractSendValidationRequest(bodyElement, xmlValuesMap);
            case "moneygram-commit-transaction" -> extractCommitTransactionRequest(bodyElement, xmlValuesMap);
            case "moneygram-detail-lookup" -> extractDetailLookupRequest(bodyElement, xmlValuesMap);
            case "moneygram-send-reversal" -> extractSendReversalRequest(bodyElement, xmlValuesMap);
            case "moneygram-amend-transaction" -> extractAmendTransactionRequest(bodyElement, xmlValuesMap);
            case "moneygram-reference-number-request" -> extractReferenceNumberRequest(bodyElement, xmlValuesMap);
            case "moneygram-receive-validation-request" -> extractReceiveValidationRequest(bodyElement, xmlValuesMap);
            case "moneygram-receive-reversal" -> extractReceiveReversalRequest(bodyElement, xmlValuesMap);
            case "moneygram-code-table-service" -> extractCodeTableRequest(bodyElement, xmlValuesMap);
            default -> {
                log.error("{}: Could not parse the xml. Unknown type: {}", rrn, type);
                throw new CustomException(String.format("%sCould not parse xml. Unknown type: %s", DEFAULT_PROCESSING_FAILURE, type));
            }
        }
         */
        return null;
    }

    private FeeLookupRequest extractFeeLookupRequest(Element bodyElement, ProductType productType) throws ParseException, DatatypeConfigurationException, IllegalArgumentException {
        // Retrieve the list of "feeLookupRequest" elements from the body element
        NodeList feeLookupRequestList = bodyElement.getElementsByTagName("feeLookupRequest");

        // Check if feeLookupRequest element is present
        if (feeLookupRequestList.getLength() > 0) {
            // Get the first "feeLookupRequest" element
            Element feeLookupRequestElement = (Element) feeLookupRequestList.item(0);
            FeeLookupRequest feeLookupRequest = new FeeLookupRequest();
//            feeLookupRequest.setAgentID(getTagValue("agentID", feeLookupRequestElement));
            feeLookupRequest.setAgentID(agentID);
            feeLookupRequest.setAgentSequence(agentSequence);
            feeLookupRequest.setToken(token);
            feeLookupRequest.setTimeStamp(StringTransformer.createXMLGregorianCalendar(getTagValue("timeStamp", feeLookupRequestElement)));
            feeLookupRequest.setApiVersion("11");
            feeLookupRequest.setClientSoftwareVersion("1.1");
            feeLookupRequest.setChannelType(ChannelTypeEnum.LOCATION);
            feeLookupRequest.setTargetAudience(TargetAudienceType.AGENT_FACING);
            feeLookupRequest.setProductType(productType);

            String amountExcludingFee = getTagValue("amountExcludingFee", feeLookupRequestElement);
            String amountIncludingFee = getTagValue("amountIncludingFee", feeLookupRequestElement);
            String receiveAmount = getTagValue("receiveAmount", feeLookupRequestElement);

            if (!MiscUtil.isNullOrEmpty(amountExcludingFee)) {
                feeLookupRequest.setAmountExcludingFee(new BigDecimal(amountExcludingFee));

            } else if (!MiscUtil.isNullOrEmpty(amountIncludingFee)) {
                feeLookupRequest.setAmountIncludingFee(new BigDecimal(amountIncludingFee));

            } else if (!MiscUtil.isNullOrEmpty(receiveAmount)) {
                feeLookupRequest.setReceiveAmount(new BigDecimal(receiveAmount));

            } else throw new IllegalArgumentException("Invalid amount!!");


            feeLookupRequest.setReceiveCountry(getTagValue("receiveCountry", feeLookupRequestElement));
            feeLookupRequest.setAllOptions(Boolean.valueOf(getTagValue("allOptions", feeLookupRequestElement)));
            String deliveryOption = getTagValue("deliveryOption", feeLookupRequestElement);
            if (!MiscUtil.isNullOrEmpty(deliveryOption)) {
                feeLookupRequest.setDeliveryOption(deliveryOption);
            }

            return feeLookupRequest;
        }
        return null;
    }

    private GetFieldsForProductRequest extractGetFieldsForProductRequest(Element bodyElement, ProductType productType) throws ParseException, DatatypeConfigurationException {
        // Retrieve the list of "getFieldsForProductRequest" elements from the body element
        NodeList getFieldForProductRequestList = bodyElement.getElementsByTagName("getFieldsForProductRequest");

        // Check if getFieldsForProductRequest element is present
        if (getFieldForProductRequestList.getLength() > 0) {
            // Get the first "getFieldsForProductRequest" element
            Element getFieldForProductRequestElement = (Element) getFieldForProductRequestList.item(0);
            GetFieldsForProductRequest getFieldsForProductRequest = new GetFieldsForProductRequest();
            // Extract and put values into the map if present

//            getFieldsForProductRequest.setAgentID(getTagValue("agentID", getFieldForProductRequestElement));
//            getFieldsForProductRequest.setAgentSequence(getTagValue("agentSequence", getFieldForProductRequestElement));
//            getFieldsForProductRequest.setToken(getTagValue("token", getFieldForProductRequestElement));

            getFieldsForProductRequest.setAgentID(agentID);
            getFieldsForProductRequest.setAgentSequence(agentSequence);
            getFieldsForProductRequest.setToken(token);

            getFieldsForProductRequest.setTimeStamp(StringTransformer.createXMLGregorianCalendar(MiscUtil.getCurrentTimestamp()));
            getFieldsForProductRequest.setApiVersion("1512");
            getFieldsForProductRequest.setClientSoftwareVersion("1");
            getFieldsForProductRequest.setChannelType(ChannelTypeEnum.LOCATION);
            getFieldsForProductRequest.setTargetAudience(TargetAudienceType.AGENT_FACING);
            getFieldsForProductRequest.setReceiveCountry(getTagValue("receiveCountry", getFieldForProductRequestElement));
            getFieldsForProductRequest.setDeliveryOption(getTagValue("deliveryOption", getFieldForProductRequestElement));
            getFieldsForProductRequest.setThirdPartyType(ThirdPartyType.NONE);
            String receiveAgentID = getTagValue("receiveAgentID", getFieldForProductRequestElement);
            if ((receiveAgentID != null) && !receiveAgentID.isEmpty()) {
                getFieldsForProductRequest.setReceiveAgentID(getTagValue("receiveAgentID", getFieldForProductRequestElement));
            }
            getFieldsForProductRequest.setReceiveCurrency(getTagValue("receiveCurrency", getFieldForProductRequestElement));
            getFieldsForProductRequest.setAmount(new BigDecimal(getTagValue("amount", getFieldForProductRequestElement)));
            getFieldsForProductRequest.setSendCurrency(getTagValue("sendCurrency", getFieldForProductRequestElement));
            getFieldsForProductRequest.setProductType(productType);
            getFieldsForProductRequest.setConsumerId(getTagValue("consumerId", getFieldForProductRequestElement));
            getFieldsForProductRequest.setFormFreeStaging(Boolean.valueOf(getTagValue("formFreeStaging", getFieldForProductRequestElement)));
            return getFieldsForProductRequest;

        }
        return null;
    }

    private SendValidationRequest extractSendValidationRequest(String xmlRequest /*, Map<String, String> extrafields*/) throws Exception {
        List<Object> objects = StringTransformer.transform(xmlRequest, SendValidationRequest.class);
        SendValidationRequest sendValidationRequest = (SendValidationRequest) (objects.get(0));
        sendValidationRequest.setAgentID(agentID);
        sendValidationRequest.setAgentSequence(agentSequence);
        sendValidationRequest.setToken(token);
        sendValidationRequest.setApiVersion("11");
        sendValidationRequest.setClientSoftwareVersion("1");
        sendValidationRequest.setChannelType(ChannelTypeEnum.LOCATION);
        sendValidationRequest.setTargetAudience(TargetAudienceType.AGENT_FACING);
        sendValidationRequest.setLanguage("en");
        sendValidationRequest.setTimeStamp(MiscUtil.toXMLGregorianCalendar(MiscUtil.getCurrentTimestamp()));
        sendValidationRequest.setOperatorName("EQUITY");

        if (objects.size() > 1) {
            Map<String, String> keyValuePairs = (Map<String, String>) (objects.get(1));

            Iterator<Map.Entry<String, String>> it = keyValuePairs.entrySet().iterator();
            while (it.hasNext()) {
                Map.Entry<String, String> entry = it.next();
                KeyValuePair keyValue = new KeyValuePair();
                keyValue.setXmlTag(entry.getKey());
                keyValue.setFieldValue(entry.getValue());
                sendValidationRequest.getFieldValues().getKeyValuePair().add(keyValue);
            }
        }

        return sendValidationRequest;
    }
    
    /*
    private void extractReceiveValidationRequest(Element bodyElement, Map<String, String> xmlValuesMap) {
        // Retrieve the list of "receiveValidationRequest" elements from the body element
        NodeList receiveValidationRequestList = bodyElement.getElementsByTagName("receiveValidationRequest");

        // Check if receiveValidationRequest element is present
        if (receiveValidationRequestList.getLength() > 0) {
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
            putIfPresent(xmlValuesMap, "receiverPhotoIdCity", receiveValidationRequestElement);
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
            putIfPresent(xmlValuesMap, "receiverMotherMaidenName", receiveValidationRequestElement);
            putIfPresent(xmlValuesMap, "receiverFatherFirstName", receiveValidationRequestElement);

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
    }
    */

    private ReceiveValidationRequest extractReceiveValidationRequest(String xmlRequest, ProductType productType) throws Exception {
        List<Object> objects = StringTransformer.transform(xmlRequest, ReceiveValidationRequest.class);
        ReceiveValidationRequest receiveValidationRequest = (ReceiveValidationRequest) (objects.get(0));
        receiveValidationRequest.setAgentID(agentID);
        receiveValidationRequest.setAgentSequence(agentSequence);
        receiveValidationRequest.setToken(token);
        receiveValidationRequest.setApiVersion("11");
        receiveValidationRequest.setClientSoftwareVersion("1");
        receiveValidationRequest.setChannelType(ChannelTypeEnum.LOCATION);
        receiveValidationRequest.setTargetAudience(TargetAudienceType.AGENT_FACING);
        receiveValidationRequest.setLanguage("en");
        receiveValidationRequest.setTimeStamp(MiscUtil.toXMLGregorianCalendar(MiscUtil.getCurrentTimestamp()));
        receiveValidationRequest.setOperatorName("EQUITY");
        return receiveValidationRequest;
    }

    private void extractReceiveReversalRequest(Element bodyElement, Map<String, String> xmlValuesMap) {
        // Retrieve the list of "receiveReversalRequest" elements from the body element
        NodeList receiveReversalRequestList = bodyElement.getElementsByTagName("receiveReversalRequest");

        // Check if receiveReversalRequest element is present
        if (receiveReversalRequestList.getLength() > 0) {
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
    }

    private void extractCodeTableRequest(Element bodyElement, Map<String, String> xmlValuesMap) {
        // Retrieve the list of "codeTableRequest" elements from the body element
        NodeList codeTableRequestRequestList = bodyElement.getElementsByTagName("codeTableRequest");

        // Check if codeTableRequest element is present
        if (codeTableRequestRequestList.getLength() > 0) {
            // Get the first "codeTableRequest" element
            Element codeTableRequestElement = (Element) codeTableRequestRequestList.item(0);

            // Extract and put values into the map if present
            putIfPresent(xmlValuesMap, "rrn", codeTableRequestElement);
            putIfPresent(xmlValuesMap, "channelId", codeTableRequestElement);
            putIfPresent(xmlValuesMap, "sourceSystemId", codeTableRequestElement);
            putIfPresent(xmlValuesMap, "bankId", codeTableRequestElement);
            putIfPresent(xmlValuesMap, "signature", codeTableRequestElement);
            putIfPresent(xmlValuesMap, "agentAllowedOnly", codeTableRequestElement);
        }
    }

    /*
    private void extractCommitTransactionRequest(Element bodyElement, Map<String, String> xmlValuesMap) {
        // Retrieve the list of "commitTransactionRequest" elements from the body element
        NodeList commitTransactionRequestList = bodyElement.getElementsByTagName("commitTransactionRequest");

        // Check if commitTransactionRequest element is present
        if (commitTransactionRequestList.getLength() > 0) {
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
    }
     */
    private CommitTransactionRequest extractCommitTransactionRequest(String xmlRequest, ProductType productType) throws Exception {
        {
            List<Object> objects = StringTransformer.transform(xmlRequest, CommitTransactionRequest.class);
            CommitTransactionRequest commitTransactionRequest = (CommitTransactionRequest) (objects.get(0));
            commitTransactionRequest.setAgentID(agentID);
            commitTransactionRequest.setAgentSequence(agentSequence);
            commitTransactionRequest.setToken(token);
            commitTransactionRequest.setApiVersion("11");
            commitTransactionRequest.setClientSoftwareVersion("1");
            commitTransactionRequest.setChannelType(ChannelTypeEnum.LOCATION);
            commitTransactionRequest.setTargetAudience(TargetAudienceType.AGENT_FACING);
            commitTransactionRequest.setLanguage("en");
            commitTransactionRequest.setTimeStamp(MiscUtil.toXMLGregorianCalendar(MiscUtil.getCurrentTimestamp()));
            commitTransactionRequest.setProductType(productType);
//        commitTransactionRequest.setOperatorName("EQUITY");
            return commitTransactionRequest;
        }
    }

    private void parseCallbackResponse(Document document, Map<String, String> xmlValuesMap) {
        // Retrieve the list of "statusDetails" elements from the body element
        NodeList statusDetailsList = document.getElementsByTagName("statusDetails");

        // Check if statusDetails element is present
        if (statusDetailsList.getLength() > 0) {
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
    }
    
    /*
    private void extractDetailLookupRequest(Element bodyElement, Map<String, String> xmlValuesMap) {
        // Retrieve the list of "detailLookupRequest" elements from the body element
        NodeList detailLookupRequestList = bodyElement.getElementsByTagName("detailLookupRequest");

        // Check if detailLookupRequest element is present
        if (detailLookupRequestList.getLength() > 0) {
            // Get the first "detailLookupRequest" element
            Element detailLookupRequestElement = (Element) detailLookupRequestList.item(0);

            // Extract and put values into the map if present
            putIfPresent(xmlValuesMap, "rrn", detailLookupRequestElement);
            putIfPresent(xmlValuesMap, "channelId", detailLookupRequestElement);
            putIfPresent(xmlValuesMap, "sourceSystemId", detailLookupRequestElement);
            putIfPresent(xmlValuesMap, "bankId", detailLookupRequestElement);
            putIfPresent(xmlValuesMap, "signature", detailLookupRequestElement);
        }
    }
    */

    private DetailLookupRequest extractDetailLookupRequest(String xmlRequest, ProductType productType) throws Exception {
        List<Object> objects = StringTransformer.transform(xmlRequest, DetailLookupRequest.class);
        DetailLookupRequest detailLookupRequest = (DetailLookupRequest) (objects.get(0));
        detailLookupRequest.setAgentID(agentID);
        detailLookupRequest.setAgentSequence(agentSequence);
        detailLookupRequest.setToken(token);
        detailLookupRequest.setApiVersion("11");
        detailLookupRequest.setClientSoftwareVersion("1");
        detailLookupRequest.setChannelType(ChannelTypeEnum.LOCATION);
        detailLookupRequest.setTargetAudience(TargetAudienceType.AGENT_FACING);
        detailLookupRequest.setLanguage("en");
        detailLookupRequest.setTimeStamp(MiscUtil.toXMLGregorianCalendar(MiscUtil.getCurrentTimestamp()));
        return detailLookupRequest;
    }

    /*
    private void extractSendReversalRequest(Element bodyElement, Map<String, String> xmlValuesMap, ProductType productType) {
        // Retrieve the list of "sendReversalRequest" elements from the body element
        NodeList sendReversalRequestList = bodyElement.getElementsByTagName("sendReversalRequest");

        // Check if sendReversalRequest element is present
        if (sendReversalRequestList.getLength() > 0) {
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
    }
     */
    private SendReversalRequest extractSendReversalRequest(String xmlRequest, ProductType productType) throws DatatypeConfigurationException, Exception {
        /*
        <sendReversalRequest xmlns="http://www.moneygram.com/AgentConnect1512">
    <agentID>xxxxxxxx</agentID>
    <agentSequence>1</agentSequence>
    <token>xxxx</token>
    <timeStamp>2024-11-25T03:22:49.860-06:00</timeStamp>
    <apiVersion>1512</apiVersion>
    <clientSoftwareVersion>1</clientSoftwareVersion>
    <channelType>LOCATION</channelType>
    <sendAmount>10</sendAmount>
    <feeAmount>15</feeAmount>
    <sendCurrency>USD</sendCurrency>
    <referenceNumber>48598488</referenceNumber>
    <reversalType>R</reversalType>
    <sendReversalReason>WRONG_SERVICE</sendReversalReason>
</sendReversalRequest>
         */
        List<Object> objects = StringTransformer.transform(xmlRequest, SendReversalRequest.class);

        SendReversalRequest sendReversalRequest = (SendReversalRequest) (objects.get(0));
        sendReversalRequest.setAgentID(agentID);
        sendReversalRequest.setAgentSequence("1");
        sendReversalRequest.setToken(token);
        sendReversalRequest.setApiVersion("1512");
        sendReversalRequest.setClientSoftwareVersion("1");
        sendReversalRequest.setChannelType(ChannelTypeEnum.LOCATION);
        sendReversalRequest.setTimeStamp(MiscUtil.toXMLGregorianCalendar(MiscUtil.getCurrentTimestamp()));

        return sendReversalRequest;
    }

    /*
    private void extractAmendTransactionRequest(Element bodyElement, Map<String, String> xmlValuesMap) {
        // Retrieve the list of "amendTransactionRequest" elements from the body element
        NodeList amendTransactionRequestList = bodyElement.getElementsByTagName("amendTransactionRequest");

        // Check if amendTransactionRequest element is present
        if (amendTransactionRequestList.getLength() > 0) {
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
    }
     */
    private AmendTransactionRequest extractAmendTransactionRequest(String xmlRequest, ProductType productType) throws Exception {
        /*
        <amendTransactionRequest xmlns=http://www.moneygram.com/AgentConnect1512>
    <agentID>xxxxxxxx</agentID>
    <agentSequence>1</agentSequence>
    <token>xxxx</token>
    <timeStamp>2024-11-25T03:21:53.630-06:00</timeStamp>
    <apiVersion>1512</apiVersion>
    <clientSoftwareVersion>1</clientSoftwareVersion>
    <channelType>LOCATION</channelType>
    <referenceNumber>48598488</referenceNumber>
    <operatorName>user67</operatorName>
    <receiverFirstName>Tovino</receiverFirstName>
    <receiverLastName>Alexder</receiverLastName>
</amendTransactionRequest>
         */
        List<Object> objects = StringTransformer.transform(xmlRequest, AmendTransactionRequest.class);

        AmendTransactionRequest amendTransactionRequest = (AmendTransactionRequest) (objects.get(0));
        amendTransactionRequest.setAgentID(agentID);
        amendTransactionRequest.setAgentSequence("1");
        amendTransactionRequest.setToken(token);
        amendTransactionRequest.setApiVersion("1512");
        amendTransactionRequest.setClientSoftwareVersion("1");
        amendTransactionRequest.setChannelType(ChannelTypeEnum.LOCATION);
        amendTransactionRequest.setTimeStamp(MiscUtil.toXMLGregorianCalendar(MiscUtil.getCurrentTimestamp()));

        return amendTransactionRequest;
    }

    /*
    private void extractReferenceNumberRequest(Element bodyElement, Map<String, String> xmlValuesMap) {
        // Retrieve the list of "referenceNumberRequest" elements from the body element
        NodeList referenceNumberRequestList = bodyElement.getElementsByTagName("referenceNumberRequest");

        // Check if referenceNumberRequest element is present
        if (referenceNumberRequestList.getLength() > 0) {
            // Get the first "referenceNumberRequest" element
            Element referenceNumberRequestElement = (Element) referenceNumberRequestList.item(0);

            // Extract and put values into the map if present
            putIfPresent(xmlValuesMap, "referenceNumber", referenceNumberRequestElement);
            putIfPresent(xmlValuesMap, "pin", referenceNumberRequestElement);
            putIfPresent(xmlValuesMap, "operatorName", referenceNumberRequestElement);
        }
    }
    */
    private ReferenceNumberRequest extractReferenceNumberRequest(String xmlRequest, ProductType productType) throws DatatypeConfigurationException, Exception {
        List<Object> objects = StringTransformer.transform(xmlRequest, ReferenceNumberRequest.class);

        ReferenceNumberRequest referenceNumberRequest = (ReferenceNumberRequest) (objects.get(0));
        referenceNumberRequest.setAgentID(agentID);
        referenceNumberRequest.setAgentSequence("1");
        referenceNumberRequest.setToken(token);
        referenceNumberRequest.setApiVersion("1512");
        referenceNumberRequest.setClientSoftwareVersion("1");
        referenceNumberRequest.setChannelType(ChannelTypeEnum.LOCATION);
        referenceNumberRequest.setTimeStamp(MiscUtil.toXMLGregorianCalendar(MiscUtil.getCurrentTimestamp()));

        return referenceNumberRequest;
    }


    private void putIfPresent(Map<String, String> map, String tagName, Element parentElement) {
        log.info("Tag name: " + tagName);
        // Get the value of the specified tag from the parent element
        String value = getTagValue(tagName, parentElement);
        map.put(tagName, value);
    }

    private static String getTagValue(String tag, Element element) {
        NodeList nodeList = element.getElementsByTagName(tag);
        if (nodeList.getLength() > 0) {
            Node node = nodeList.item(0);
            if (node.getNodeType() == Node.ELEMENT_NODE) {
                return node.getTextContent(); // Get the text content of the element
            }
        }
        log.warn("The tag ({}) is not found in this request. Getting the next tag...", tag);
        return ""; // Return blank if the tag is not found or if there are issues
    }

    public static void main(String[] args) {
        // Original XML response as a string
        String originalResponse = "<FeeLookupResponse>"
                + "    <doCheckIn>false</doCheckIn>"
                + "    <timeStamp>2024-11-05T09:06:14.172+00:00</timeStamp>"
                + "    <flags>1</flags>"
                + "    <feeInfo>"
                + "        <feeInfo>"
                + "            <validReceiveAmount>70.74</validReceiveAmount>"
                + "            <validReceiveCurrency>GHS</validReceiveCurrency>"
                + "            <validExchangeRate>7.073715</validExchangeRate>"
                + "            <estimatedReceiveAmount>0</estimatedReceiveAmount>"
                + "            <estimatedExchangeRate>0.000000</estimatedExchangeRate>"
                + "            <totalAmount>15.81</totalAmount>"
                + "            <receiveCountry>GHA</receiveCountry>"
                + "            <deliveryOption>WILL_CALL</deliveryOption>"
                + "            <receiveAmountAltered>false</receiveAmountAltered>"
                + "            <deliveryOptId>0</deliveryOptId>"
                + "            <deliveryOptDisplayName>10 Minute Service</deliveryOptDisplayName>"
                + "            <mgiTransactionSessionID>16773711E173079757438930474005NN</mgiTransactionSessionID>"
                + "            <sendAmountAltered>false</sendAmountAltered>"
                + "            <receiveAmounts>"
                + "                <receiveAmount>70.74</receiveAmount>"
                + "                <receiveCurrency>GHS</receiveCurrency>"
                + "                <validCurrencyIndicator>true</validCurrencyIndicator>"
                + "                <payoutCurrency>GHS</payoutCurrency>"
                + "                <totalReceiveFees>0.00</totalReceiveFees>"
                + "                <totalReceiveTaxes>0.00</totalReceiveTaxes>"
                + "                <totalReceiveAmount>70.74</totalReceiveAmount>"
                + "                <receiveFeesAreEstimated>false</receiveFeesAreEstimated>"
                + "                <receiveTaxesAreEstimated>false</receiveTaxesAreEstimated>"
                + "                <detailEstimatedReceiveAmounts>"
                + "                    <amountType>mgiReceiveFee</amountType>"
                + "                    <amount>0.00</amount>"
                + "                    <amountCurrency>GHS</amountCurrency>"
                + "                </detailEstimatedReceiveAmounts>"
                + "            </receiveAmounts>"
                + "        </feeInfo>"
                + "    </feeInfo>"
                + "</FeeLookupResponse>";

        // Wrap the original XML response in the SOAP envelope with namespaces
        String soapEnvelope = wrapInSoapEnvelope(originalResponse, "FeeLookupResponse");
        System.out.println(soapEnvelope);
    }

    public static String wrapInSoapEnvelope(String response, String tagName) {
        // Define the SOAP envelope and add necessary namespaces
        String soapStart = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:ac=\"http://www.moneygram.com/AgentConnect1512\"><soapenv:Header/><soapenv:Body>";

        String soapEnd = "</soapenv:Body></soapenv:Envelope>";
        String formatedTagName = CaseFormat.UPPER_CAMEL.to(CaseFormat.LOWER_CAMEL, tagName);
        // Add the "ac:" namespace prefix to each element
        String namespacedResponse = response
                .replace("<" + tagName + ">", "<ac:" + formatedTagName + ">")
                .replace("</" + tagName + ">", "</ac:" + formatedTagName + ">")
                .replaceAll("<(\\w+)>", "<ac:$1>")
                .replaceAll("</(\\w+)>", "</ac:$1>");

        // Combine everything into the final SOAP message
        return soapStart + namespacedResponse + soapEnd;
    }

}
