/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.service.util;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.StringReader;
import java.io.StringWriter;
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
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBElement;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.stream.StreamSource;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.Header;
import org.springframework.http.HttpHeaders;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

/**
 *
 * @author ronaldcheruiyot
 */
@Slf4j
public class MiscUtil {
    
    public static boolean isNullOrEmpty(String value) {
        return ((value == null) || value.isEmpty());
    }

    public static boolean isNullOrEmpty(Object value) {
        return (value == null);
    }
    
    public static boolean isNotNullAndNotEmpty(String value)
    {
        return ((value != null) && !value.isEmpty());
    }
    
    public static String formatAfricellNumber(String msisdn)
    {
        msisdn = msisdn.substring(Math.max(0, msisdn.length() - 9));
        
        msisdn = "0" + msisdn;
        
        return msisdn;

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
            if(timestampWithRandom.length() > length)
            {
                timestampWithRandom = timestampWithRandom.substring(0, length);
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
    
    public static String objectToStr(Object input, Class<?> type) throws JAXBException
    {
        JAXBContext jaxbContext = JAXBContext.newInstance(type);
        Marshaller jaxbMarshaller = jaxbContext.createMarshaller();
        jaxbMarshaller.setProperty("jaxb.formatted.output", true);
        StringWriter jaxwriter = new StringWriter();
        jaxbMarshaller.marshal(input, jaxwriter);
        StringBuffer jaxrespBfr = jaxwriter.getBuffer();
        return jaxrespBfr.toString();
    }
    
    public static String getCurrentTimestamp(String format)
    {
        LocalDateTime now = LocalDateTime.now();
        
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern(format);
        
        String formattedDate = now.format(formatter);
        
        return formattedDate;
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
                    if(childNode.getParentNode().getNodeName().equalsIgnoreCase("value"))
                    {
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
    
    public static Set<String> stringToSet(String input, String delimiter)
    {
        String[] output = input.split(delimiter);
        if(output.length <= 0) return new HashSet<>();
        Set<String> set = new HashSet<>();
        set.addAll(Arrays.asList(output));
        return set;
    }
    
    public static String[] splitBySpace(String input, String defaultValue)
    {
        if(isNullOrEmpty(input)) return new String[]{defaultValue, defaultValue};
        String[] names = input.split("\\s+");
        if(names.length < 2) return new String[]{input, input};
        return new String[]{names[0], names[1]};
        
    }
    
    public static void printHeaders(HttpHeaders headers, String type)
    {
        log.info("[" + type + "]======== START PRINT HEADERS");
        headers.forEach((key, value) -> {
            log.info(key + ":" + value);
        });
        log.info("[" + type + "]======== END PRINT HEADERS");
    }
    
    public static void printHeaders(Header[] headers, String type)
    {
        log.info("[" + type + "]======== START PRINT HEADERS");
        for(Header header : headers)
        {
            log.info(header.getName() + ":" + header.getValue());
        }
        log.info("[" + type + "]======== END PRINT HEADERS");
    }
    
    public static void main(String[] args) {
        String request = "<COMMAND>\n" +
" <TYPE>BKDREGRESP</TYPE>\n" +
" <TXNSTATUSEIG>200</TXNSTATUSEIG>\n" +
" <MSISDN>7701536335</MSISDN>\n" +
" <TXNID>XX180628.0238.C00067</TXNID>\n" +
" <TXNSTATUS>200</TXNSTATUS>\n" +
" <ACCOUNTNO>4141143</ACCOUNTNO>\n" +
" <DATE>0628023853</DATE>\n" +
" <TIME>023853</TIME>\n" +
" <MESSAGE>Your Bank Account 4141143 DeRegistration Successfully\n" +
"and Service charge RUB : 0.00 deducted from your wallet\n" +
"</MESSAGE>\n" +
" <TRID>7701536335201806280238C0650</TRID>\n" +
"</COMMAND>";
         Map<String, String> map = extractAllTagValues(request);
         Iterator<Map.Entry<String, String>> it = map.entrySet().iterator();
         while(it.hasNext())
         {
             Map.Entry<String, String> entry = it.next();
             System.out.println("KEY: " + entry.getKey() + "; VALUE: " + entry.getValue());
         }
         
    }
    
}
