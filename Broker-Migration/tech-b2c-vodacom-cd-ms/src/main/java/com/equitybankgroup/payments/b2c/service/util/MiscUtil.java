/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.service.util;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.StringReader;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Random;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.xml.bind.JAXBContext;
import jakarta.xml.bind.JAXBElement;
import jakarta.xml.bind.JAXBException;
import jakarta.xml.bind.Marshaller;
import jakarta.xml.bind.Unmarshaller;
import java.io.StringWriter;
import java.util.UUID;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParserFactory;
import javax.xml.transform.sax.SAXSource;
import javax.xml.transform.stream.StreamSource;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.SAXNotRecognizedException;
import org.xml.sax.SAXNotSupportedException;

/**
 *
 * @author ronaldcheruiyot
 */
public class MiscUtil {

    public static String getRandomUUID() {
        return UUID.randomUUID().toString();
    }

    public static String objToStr(Object obj, Class theclass) {
        try {
            JAXBContext jaxbContext = JAXBContext.newInstance(theclass);
            Marshaller jaxbMarshaller = jaxbContext.createMarshaller();
            jaxbMarshaller.setProperty("jaxb.formatted.output", Boolean.valueOf(true));
            StringWriter jaxwriter = new StringWriter();
            jaxbMarshaller.marshal(obj, jaxwriter);
            StringBuffer jaxrespBfr = jaxwriter.getBuffer();
            return jaxrespBfr.toString();
        } catch (JAXBException e) {
            e.printStackTrace(System.out);
            System.out.println("JAXBException: " + e.getMessage());
            return null;
        }
    }

    public static boolean isNullOrEmpty(String value) {
        return ((value == null) || value.isEmpty());
    }

    public static boolean isNullOrEmpty(Object value) {
        return (value == null);
    }

    public static boolean isNotNullAndNotEmpty(String value) {
        return ((value != null) && !value.isEmpty());
    }

    public static String getCurrentTimestamp(String format) {
        LocalDateTime now = LocalDateTime.now();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern(format);

        String formattedDate = now.format(formatter);

        return formattedDate;
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

    public static Map<String, String> extractAllTagValues(String document) {
        Map<String, String> tagValues = new HashMap<>();
        try {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document doc = builder.parse(new ByteArrayInputStream(document.getBytes()));

            Element root = doc.getDocumentElement();
            traverseNodes(root, tagValues, root.getNodeName(), new HashMap<>(), null);
        } catch (IOException | ParserConfigurationException | SAXException e) {
            System.out.println("Error occurred while parsing document: " + e.getMessage());
            e.printStackTrace(System.out);
        }
        return tagValues;
    }

    private static void traverseNodes(Node node, Map<String, String> tagValues, String path, Map<String, Integer> indexMap, String currentDataItemName) {
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

    public static String generateRandomRRN(long currentTime, int length) {

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

    public static Set<String> stringToSet(String input, String delimiter) {
        String[] output = input.split(delimiter);
        if (output.length <= 0) {
            return new HashSet<>();
        }
        Set<String> set = new HashSet<>();
        set.addAll(Arrays.asList(output));
        return set;
    }
    
    public static String extractCDATAContents(String xml) {
        String cdataStart = "<![CDATA[";
        String cdataEnd = "]]>";
        return extractContentsInsideXML(cdataStart, cdataEnd, xml);
    }

    public static String extractContentsInsideXML(String startTag, String endTag, String xml) {

        if (xml == null || xml.isEmpty()) {
            return null;
        }

        int startIdx = xml.indexOf(startTag);
        int endIdx = xml.indexOf(endTag);

        if (startIdx != -1 && endIdx != -1 && endIdx > startIdx) {
            return xml.substring(startIdx + startTag.length(), endIdx);
        }

        return null;

    }

    public static void main(String[] args) throws JAXBException {
        System.out.println(MiscUtil.getCurrentTimestamp("yyyyMMddHHmmss"));
        String b2bRequest = "<?xml version='1.0' encoding='UTF-8'?> <soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\">     <soapenv:Body>         <res:ResultMsg xmlns:res=\"http://api-v1.gen.mm.vodafone.com/mminterface/result\">             <![CDATA[<?xml version=\"1.0\" encoding=\"UTF-8\"?>                 <result>                     <ResultType>0</ResultType>                     <ResultCode>0</ResultCode>                     <ResultDesc>The service request is processed successfully.</ResultDesc>                     <OriginatorConversationID>651687760B280</OriginatorConversationID>                     <ConversationID>AG_20200331_0000489fb215f462d909</ConversationID>                     <TransactionID>OCV9HC71HP</TransactionID>                     <ResultParameters>                         <ResultParameter>                             <Key>Currency</Key>                             <Value>KES</Value>                         </ResultParameter>                         <ResultParameter>                             <Key>DebitAccountCurrentBalance</Key>                             <Value>{Amount={BasicAmount=8995089.00,MinimumAmount=899508900,CurrencyCode=KES}}</Value>                         </ResultParameter>                     </ResultParameters>                     <ReferenceData>  16  C1 - Public                         <ReferenceItem>                             <Key>QueueTimeoutURL</Key>                             <Value>http://10.66.49.789:7888/new</Value>                         </ReferenceItem>                     </ReferenceData>                 </result>             ]]>         </res:ResultMsg>     </soapenv:Body> </soapenv:Envelope> ";

        
        b2bRequest = extractCDATAContents(b2bRequest);
        System.out.println(b2bRequest);
        Map<String, String> values = MiscUtil.extractAllTagValues(b2bRequest);

        Iterator<Map.Entry<String, String>> it = values.entrySet().iterator();

        while (it.hasNext()) {
            Map.Entry<String, String> entry = it.next();
            System.out.println("Key: " + entry.getKey() + ", Value: " + entry.getValue());
        }

    }

}
