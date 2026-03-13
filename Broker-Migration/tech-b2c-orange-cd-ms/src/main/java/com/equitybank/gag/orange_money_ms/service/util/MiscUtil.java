/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybank.gag.orange_money_ms.service.util;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.StringReader;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.net.URL;
import java.net.UnknownHostException;
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
import javax.xml.bind.Unmarshaller;
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
    
    public static void main(String[] args) {
        String request = "<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" +
"    <soap:Body>\n" +
"        <ns2:TransferStatusInquiry xmlns:ns2=\"http://b2w.banktowallet.com/b2w\">\n" +
"            <TranRequestInfo>\n" +
"                <mmHeaderInfo>\n" +
"                    <operatorCode>ORANGEMONEYML</operatorCode>\n" +
"                    <requestId>OR2403283ADW1F</requestId>\n" +
"                    <requestToken></requestToken>\n" +
"                    <requestType>TRANINQ</requestType>\n" +
"                    <affiliateCode>EML</affiliateCode>\n" +
"                </mmHeaderInfo>\n" +
"                <externalRefNo>OR240328B2CY8D</externalRefNo>\n" +
"            </TranRequestInfo>\n" +
"        </ns2:TransferStatusInquiry>\n" +
"    </soap:Body>\n" +
"</soap:Envelope>";
         Map<String, String> map = extractAllTagValues(request);
         Iterator<Map.Entry<String, String>> it = map.entrySet().iterator();
         while(it.hasNext())
         {
             Map.Entry<String, String> entry = it.next();
             System.out.println("KEY: " + entry.getKey() + "; VALUE: " + entry.getValue());
         }
    }
    
}
