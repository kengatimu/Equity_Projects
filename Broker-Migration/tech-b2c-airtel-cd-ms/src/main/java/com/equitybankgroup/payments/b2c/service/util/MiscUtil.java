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
import jakarta.xml.bind.Unmarshaller;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.net.URL;
import java.net.UnknownHostException;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParserFactory;
import javax.xml.transform.sax.SAXSource;
import javax.xml.transform.stream.StreamSource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
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
@Slf4j
public class MiscUtil {
    
    public static void printHeaders(HttpHeaders headers, String countryCode, String type)
    {
        log.info("======== START PRINT HEADERS[" + countryCode + "][" + type + "]", new Object[]{countryCode, type});
        headers.forEach((key, value) -> {
            log.info(key + ": " + value);
        });
        log.info("======== START PRINT HEADERS[" + countryCode + "][" + type + "]", new Object[]{countryCode, type});
    }
    
    public static boolean isHostAvailable(String url) {
        String hostName = null;
        int port = 0;
        try {
            URL theurl = new URL(url);
            hostName = theurl.getHost();
            port = theurl.getPort();
            if (port < 0) {
                port = 443;
            }
            System.out.println("CHECK CONNECTION: HOSTNAME: " + hostName + ", PORT: " + port);
            Socket socket = new Socket();
            InetSocketAddress socketAddress = new InetSocketAddress(hostName, port);
            socket.connect(socketAddress, 2000);
            socket.close();
            System.out.println(hostName + ":" + port + " CHECK CONNECTION OK!");
            return true;
        } catch (UnknownHostException unknownHost) {
            System.out.println(hostName + ":" + port + "CHECK CONNECTION FAIL: ERROR  UnknownHostException: " + unknownHost.getMessage());
            return false;
        } catch (IOException e) {
            System.out.println(hostName + ":" + port + "CHECK CONNECTION FAIL:  IOException: " + e.getMessage());
            return false;
        }
    }
    
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
            if(timestampWithRandom.length() > 12)
            {
                timestampWithRandom = timestampWithRandom.substring(0, 12);
            }
            return timestampWithRandom;
        }
    
    public static Object strToObject(String reqBody, Class<?> type) throws JAXBException, ParserConfigurationException, SAXNotRecognizedException, SAXNotSupportedException, SAXException {
        StringReader strWay4Reader = new StringReader(reqBody.trim());
        JAXBContext jaxbContextUmWay4 = JAXBContext.newInstance(type);
        Unmarshaller unmarshallerWay4 = jaxbContextUmWay4.createUnmarshaller();
        
        // Disable XXE by configuring the XML parser
        SAXParserFactory spf = SAXParserFactory.newInstance();
        spf.setFeature("http://xml.org/sax/features/external-general-entities", false);
        spf.setFeature("http://xml.org/sax/features/external-parameter-entities", false);
        spf.setFeature("http://apache.org/xml/features/disallow-doctype-decl", true);
        
        SAXSource saxSource = new SAXSource(spf.newSAXParser().getXMLReader(), new InputSource(new StringReader(reqBody)));
        
        JAXBElement rootWay4 = unmarshallerWay4.unmarshal(saxSource, type);
        Object inqRequest = rootWay4.getValue();
        strWay4Reader = null;
        jaxbContextUmWay4 = null;
        unmarshallerWay4 = null;
        rootWay4 = null;
        return inqRequest;

    }
    
    public static String getCurrentTimestamp(String format)
    {
        LocalDateTime now = LocalDateTime.now();
        
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern(format);
        
        String formattedDate = now.format(formatter);
        
        return formattedDate;
    }
    
    public static Map<String, String> extractAllTagValues(String document) throws ParserConfigurationException, SAXException, IOException {
        Map<String, String> tagValues = new HashMap<>();

        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        factory.setFeature("http://apache.org/xml/features/disallow-doctype-decl", true);
        factory.setFeature("http://xml.org/sax/features/external-general-entities", false);
        factory.setFeature("http://xml.org/sax/features/external-parameter-entities", false);
        factory.setExpandEntityReferences(false);

        DocumentBuilder builder = factory.newDocumentBuilder();
        Document doc = builder.parse(new ByteArrayInputStream(document.getBytes()));

        Element root = doc.getDocumentElement();
        traverseNodes(root, tagValues, root.getNodeName(), new HashMap<>(), null);

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
    
    public static void main(String[] args) throws ParserConfigurationException, SAXException, IOException {
        String request = "<Envelope>\n" +
"    <Body>\n" +
"        <topup>\n" +
"            <msisdnA>2547200000000</msisdnA>\n" +
"            <amount>100</amount>\n" +
"            <telcom>AIRTEL</telcom>\n" +
"            <country>CD</country>\n" +
"            <channel>Omni</channel>\n" +
"            <signature>aaBUjKr0V7N7Mnzc3EicpQq14XPWF/Dns4l5nFz05DvGnpZss9JFXngrQ0nDLxKnn2y6L8bEhSH+TGy4blKCRKYRnNjJfFOGuzDTRCChjmaBEzcJMVSWK5+8F6YfEPJqGoM08Op73Kj2cOVHVoYAqit+DKojJRijbKtxZWr1ZpyZC2F60Cjqf1prJglSRhEdjnXGpzVto+k2siGSXUV35mYCL8Hw0OOTV1O/Qz1HH3/YzR9oRXejzVaVGghx/RqCFMy2UdUvPfEdyVyZzYxsg2kp+Zdf8ufj1GTwToUQu207AreyPCye0LUN+jtQiD6+jHy2ENFpcfnuIbv41hWz3A==</signature>\n" +
"            <rrn>875445768780</rrn>\n" +
"        </topup>\n" +
"    </Body>\n" +
"</Envelope>";
         Map<String, String> map = extractAllTagValues(request);
         Iterator<Map.Entry<String, String>> it = map.entrySet().iterator();
         while(it.hasNext())
         {
             Map.Entry<String, String> entry = it.next();
             System.out.println("KEY: " + entry.getKey() + "; VALUE: " + entry.getValue());
         }
         
         System.out.println(getCurrentTimestamp("dd/MM/yyyyHH:mm:ss"));
    }
    
}
