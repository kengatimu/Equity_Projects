/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.service.util;

import com.fasterxml.jackson.dataformat.xml.XmlMapper;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.StringReader;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Random;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBElement;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;
import javax.xml.datatype.DatatypeConfigurationException;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.stream.StreamSource;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

/**
 *
 * @author ronaldcheruiyot
 */
public class MiscUtil {

    public static boolean isNullOrEmpty(String value) {
        return ((value == null) || value.isEmpty());
    }

    public static boolean isNullOrEmpty(Object value) {
        return (value == null);
    }

    public static boolean isNotNullAndNotEmpty(String value) {
        return ((value != null) && !value.isEmpty());
    }

    public static String generateRandomRRN(int length) {

        long currentTime = System.currentTimeMillis();

        String currentTimestamp = String.valueOf(currentTime);

        int remainingDigits = length - currentTimestamp.length();

        Random random = new Random();
        StringBuilder randomDigits = new StringBuilder();
        for (int i = 0; i < remainingDigits; i++) {
            int digit = random.nextInt(10);
            randomDigits.append(digit);
        }

        String timestampWithRandom = (currentTimestamp + randomDigits.toString());
        if (timestampWithRandom.length() > 12) {
            timestampWithRandom = timestampWithRandom.substring(0, 12);
        }
        return timestampWithRandom;
    }

    public static Object strToObject(String reqBody, Class<?> type) throws JAXBException {
        StringReader strWay4Reader = new StringReader(reqBody.trim());
        JAXBContext jaxbContextUmWay4 = JAXBContext.newInstance(type);
        Unmarshaller unmarshallerWay4 = jaxbContextUmWay4.createUnmarshaller();
        JAXBElement rootWay4 = unmarshallerWay4.unmarshal(new StreamSource(strWay4Reader), type);
        Object inqRequest = rootWay4.getValue();
        strWay4Reader = null;
        jaxbContextUmWay4 = null;
        unmarshallerWay4 = null;
        rootWay4 = null;
        return inqRequest;

    }

    public static String getCurrentTimestamp(String format) {
        LocalDateTime now = LocalDateTime.now();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern(format);

        String formattedDate = now.format(formatter);

        return formattedDate;
    }

    public static Map<String, Object> extractAllTagValues(String document) {
        Map<String, Object> tagValues = new HashMap<>();
        Map<String, String> keyValueMap = new HashMap<>();
        try {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document doc = builder.parse(new ByteArrayInputStream(document.getBytes()));

            Element root = doc.getDocumentElement();
            traverseNodes(root, tagValues, root.getNodeName(), new HashMap<>(), null);

            NodeList keyValuePairs = doc.getElementsByTagName("keyValuePair");

            for (int i = 0; i < keyValuePairs.getLength(); i++) {
                Element keyValuePairElement = (Element) keyValuePairs.item(i);

                // Extract <xmlTag> and <fieldValue>
                String xmlTag = getTextValue(keyValuePairElement, "xmlTag");
                String fieldValue = getTextValue(keyValuePairElement, "fieldValue");

                if (xmlTag != null && fieldValue != null) {
                    keyValueMap.put(xmlTag, fieldValue);
                }
            }
            tagValues.put("keyValuePair", keyValueMap);

        } catch (IOException | ParserConfigurationException | SAXException e) {
            System.out.println("Error occurred while parsing document: " + e.getMessage());
            e.printStackTrace(System.out);
        }
        return tagValues;
    }
    
    private static String getTextValue(Element parentElement, String tagName) {
        NodeList nodeList = parentElement.getElementsByTagName(tagName);
        if (nodeList.getLength() > 0) {
            return nodeList.item(0).getTextContent();
        }
        return null;
    }

    private static void traverseNodes(Node node, Map<String, Object> tagValues, String path, Map<String, Integer> indexMap, String currentDataItemName) {
        NodeList childNodes = node.getChildNodes();
        if (childNodes.getLength() <= 0) {
            System.out.println("Document has no child nodes!!");
        }

        for (int i = 0; i < childNodes.getLength(); i++) {
            Node childNode = childNodes.item(i);
            String nodeName = childNode.getNodeName();
            String currentPath;

            // Check if the node is repeated and update the index
            if (indexMap.containsKey(nodeName)) {
                int index = indexMap.get(nodeName);
                indexMap.put(nodeName, index + 1);
                currentPath = path + "/" + nodeName + "[" + index + "]";
            } else {
                indexMap.put(nodeName, 1);
                currentPath = path + "/" + nodeName;
            }

            if (childNode.getNodeType() == Node.TEXT_NODE) {
                if (currentDataItemName != null) {
                    if (childNode.getParentNode().getNodeName().equalsIgnoreCase("value")) {
                        tagValues.put(currentDataItemName, childNode.getTextContent());
                    }

//                    System.out.println("currentDataItemName: " + currentDataItemName + ", childNode.getTextContent(): " + childNode.getTextContent() + ", childNode.getParentNode().getNodeName(): " + childNode.getParentNode().getNodeName());
                } else {
                    tagValues.put(path, childNode.getTextContent());
                }
            } else if (childNode.getNodeType() == Node.ELEMENT_NODE) {
                if (childNode.getNodeName().equals("dataItem")) {
                    traverseNodes(childNode, tagValues, currentPath, new HashMap<>(), null);
                } else if (childNode.getNodeName().equals("name")) {
                    currentDataItemName = childNode.getTextContent();
                } else if (childNode.hasChildNodes()) {
                    traverseNodes(childNode, tagValues, currentPath, indexMap, currentDataItemName);
                }
            }
        }
    }

    public static Set<String> stringToSet(String input, String delimiter) {
        String[] output = input.split(delimiter);
        if (output.length <= 0) {
            return new HashSet<>();
        }
        Set<String> set = new HashSet<>();
        set.addAll(Arrays.asList(output));
        return set;
    }

    public static String getCurrentTimestamp() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSXXX");
        ZonedDateTime now = ZonedDateTime.now(ZoneId.of("Africa/Nairobi")); // Nairobi time zone (EAT)
        return now.format(formatter);
    }

    public static XMLGregorianCalendar toXMLGregorianCalendar(String iput) throws DatatypeConfigurationException {
        // Input timestamp
        String timestamp = "2024-11-18T12:15:05.786+03:00";

        // Parse the timestamp into a ZonedDateTime
        ZonedDateTime zonedDateTime = ZonedDateTime.parse(timestamp, DateTimeFormatter.ISO_OFFSET_DATE_TIME);

        // Convert to GregorianCalendar
        GregorianCalendar gregorianCalendar = GregorianCalendar.from(zonedDateTime);

        // Create XMLGregorianCalendar from GregorianCalendar
        XMLGregorianCalendar xmlGregorianCalendar = DatatypeFactory.newInstance()
                .newXMLGregorianCalendar(gregorianCalendar);

        // Print result
        System.out.println("XMLGregorianCalendar: " + xmlGregorianCalendar);

        return xmlGregorianCalendar;

    }

    public static String convertToXml(Object response) throws Exception {
        XmlMapper xmlMapper = new XmlMapper();
        return xmlMapper.writeValueAsString(response);
    }

    public static void main(String[] args) {
        String request = "<sendValidationRequest xmlns=\"http://www.moneygram.com/AgentConnect1512\">\n"
                + "            <amount>320.00</amount>\n"
                + "            <destinationCountry>USA</destinationCountry>\n"
                + "            <destinationState>CA</destinationState>\n"
                + "            <deliveryOption>Standard</deliveryOption>\n"
                + "            <receiveCurrency>USD</receiveCurrency>\n"
                + "            <receiveAgentID>Agent002</receiveAgentID>\n"
                + "            <accountNumber>ACC12345</accountNumber>\n"
                + "            <senderFirstName>John</senderFirstName>\n"
                + "            <senderLastName>Smith</senderLastName>\n"
                + "            <senderAddress>123 Main St</senderAddress>\n"
                + "            <senderCity>Los Angeles</senderCity>\n"
                + "            <senderCountry>USA</senderCountry>\n"
                + "            <senderHomePhone>+11234567890</senderHomePhone>\n"
                + "            <receiverFirstName>Jane</receiverFirstName>\n"
                + "            <receiverLastName>Doe</receiverLastName>\n"
                + "            <receiverPhone>+11239876543</receiverPhone>\n"
                + "            <receiverPhoneCountryCode>1</receiverPhoneCountryCode>\n"
                + "            <senderPhotoIdType>Passport</senderPhotoIdType>\n"
                + "            <senderPhotoIdNumber>P123456789</senderPhotoIdNumber>\n"
                + "            <senderPhotoIdCountry>USA</senderPhotoIdCountry>\n"
                + "            <senderLegalIdType>Driver's License</senderLegalIdType>\n"
                + "            <senderLegalIdNumber>D1234567</senderLegalIdNumber>\n"
                + "            <senderDOB>1990-01-01</senderDOB>\n"
                + "            <senderOccupation>Engineer</senderOccupation>\n"
                + "            <senderBirthCountry>USA</senderBirthCountry>\n"
                + "            <sendCurrency>USD</sendCurrency>\n"
                + "            <mgiTransactionSessionID>16773711E172492497686521858318NN</mgiTransactionSessionID>\n"
                + "            <sendPurposeOfTransaction>Purpose</sendPurposeOfTransaction>\n"
                + "            <sourceOfFunds>Self</sourceOfFunds>\n"
                + "            <relationshipToReceiver>Family</relationshipToReceiver>\n"
                + "            <senderHomePhoneCountryCode>111</senderHomePhoneCountryCode>\n"
                + "            <senderIntendedUseOfMGIServices>Personal</senderIntendedUseOfMGIServices>\n"
                + "            <fieldValues>\n"
                + "                <keyValuePair>\n"
                + "                    <xmlTag>ExampleTag</xmlTag>\n"
                + "                    <value>ExampleValue</value>\n"
                + "                </keyValuePair>\n"
                + "            </fieldValues>\n"
                + "        </sendValidationRequest>";
        Map<String, Object> map = extractAllTagValues(request);
        Iterator<Map.Entry<String, Object>> it = map.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry<String, Object> entry = it.next();
            System.out.println("KEY: " + entry.getKey() + "; VALUE: " + entry.getValue());
        }
    }

}
