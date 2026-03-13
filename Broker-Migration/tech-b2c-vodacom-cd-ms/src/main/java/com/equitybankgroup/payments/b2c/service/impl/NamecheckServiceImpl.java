package com.equitybankgroup.payments.b2c.service.impl;

import com.equitybankgroup.payments.b2c.dto.vodacom.namecheck.request.Identity;
import com.equitybankgroup.payments.b2c.dto.vodacom.namecheck.request.Transaction;
import com.equitybankgroup.payments.b2c.dto.vodacom.namecheck.request.TransactionData;
import com.equitybankgroup.payments.b2c.dto.vodacom.namecheck.response.ResponseData;
import com.equitybankgroup.payments.b2c.error.CustomException;
import com.equitybankgroup.payments.b2c.service.NamecheckService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class NamecheckServiceImpl<T> implements NamecheckService<T> {

    private static final Logger log = LoggerFactory.getLogger(NamecheckServiceImpl.class);
    private static final String IDENTIFIER_ROLE = "A-Party";
    private static final String AGENT_IDENTIFIER_TYPE = "Shortcode";
    private static final String CUSTOMER_IDENTIFIER_TYPE = "MSISDN";
    private static final String CUSTOMER_COMMAND_ID = "QueryCustomerKYC";
    private static final String AGENT_COMMAND_ID = "QueryOrganizationKYC";

    private final String userName;
    private final String password;
    private final String tokenUrl;
    private final String namecheckUrl;
    private final RestTemplate restTemplate;
    private final ObjectMapper objectMapper;
    private final Gson gson;

    public NamecheckServiceImpl(@Value("${vodacom.cd.namecheck.tokenUsername}") String userName,
                                @Value("${vodacom.cd.namecheck.tokenPassword}") String password,
                                @Value("${vodacom.cd.namecheck.tokenUrl}") String tokenUrl,
                                @Value("${vodacom.cd.namecheck.url}") String namecheckUrl,
                                @Qualifier("defaultRestTemplate") RestTemplate restTemplate,
                                ObjectMapper objectMapper,
                                Gson gson) {
        this.userName = userName;
        this.password = password;
        this.tokenUrl = tokenUrl;
        this.namecheckUrl = namecheckUrl;
        this.restTemplate = restTemplate;
        this.objectMapper = objectMapper;
        this.gson = gson;
    }

    @Override
    public String processNamecheckRequest(String nameCheckXmlRequest, Map<String, String> xmlMapValues) throws CustomException {
        try {
            // Construct TransactionData Object;
            TransactionData transactionData = getTransactionData(xmlMapValues);

            // Get JWT token from Vodacom
            String jwtToken = callVodacomTokenService(userName, password, xmlMapValues);

            if (jwtToken == null || "invalid_credentials".equals(jwtToken)) {
                throw new CustomException("ERROR Authentication failed: Invalid credentials");
            }

            // Call Vodacom Namecheck
            log.info("Received JWT Token Successfully. Proceeding To Call Namecheck Services...");
            return callVodacomNamecheckService(jwtToken, transactionData, xmlMapValues);

        } catch (CustomException e) {
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public Map<String, String> parseXML(String nameCheckXmlRequest) throws CustomException {
        Document doc;
        try {
            doc = DocumentBuilderFactory.newInstance().newDocumentBuilder()
                    .parse(new ByteArrayInputStream(nameCheckXmlRequest.getBytes()));

            Map<String, String> xmlMapValues = new HashMap<>();

            // Safe handling for XML values in case of null
            Node mobileNumberNode = doc.getElementsByTagName("mobileNumber").item(0);
            Node channelNode = doc.getElementsByTagName("channel").item(0);
            Node telcomNode = doc.getElementsByTagName("telcom").item(0);
            Node tillNode = doc.getElementsByTagName("tillNumber").item(0);
            Node msgIdNode = doc.getElementsByTagName("msgId").item(0);
            Node bankIdNode = doc.getElementsByTagName("bankId").item(0);

            xmlMapValues.put("mobileNumber", mobileNumberNode != null ? mobileNumberNode.getTextContent() : "");
            xmlMapValues.put("channel", channelNode != null ? channelNode.getTextContent() : "");
            xmlMapValues.put("telcom", telcomNode != null ? telcomNode.getTextContent() : "");
            xmlMapValues.put("tillNumber", tillNode != null ? tillNode.getTextContent() : "");
            xmlMapValues.put("msgId", msgIdNode != null ? msgIdNode.getTextContent() : "");
            xmlMapValues.put("bankId", bankIdNode != null ? bankIdNode.getTextContent() : "");

            log.info("Xml Map: " + xmlMapValues);

            return xmlMapValues;

        } catch (SAXException | IOException | ParserConfigurationException e) {
            throw new CustomException("ERROR Parsing Namecheck Xml Request Failed");
        }
    }

    private String callVodacomTokenService(String userName, String password, Map<String, String> xmlMapValues) throws CustomException {
        JsonNode jsonNode;
        URI drcVodacomTokenUrl;
        try {
            String bankId  = xmlMapValues.get("bankId");

            // Create headers for the GET request
            HttpHeaders headers = new HttpHeaders();
            headers.set("Content-Type", "application/json");
            headers.set("username", userName);
            headers.set("password", password);

            // Create the HTTP entity
            HttpEntity<String> entity = new HttpEntity<>(headers);

            // Validate supported bank ID
            if (!"43".equals(bankId)) {
                throw new CustomException("ERROR. Only Vodacom DRC is supported for this service");
            }
            // Construct URL (no query parameters)
            drcVodacomTokenUrl = new URI(tokenUrl);

            // Send the GET request
            log.info("Calling Vodacom Get Token Service via URL: " + drcVodacomTokenUrl);
            ResponseEntity<String> responseEntity = restTemplate.exchange(drcVodacomTokenUrl, HttpMethod.GET, entity, String.class);

            // Parse the response to extract the access_token
            jsonNode = objectMapper.readTree(responseEntity.getBody());
            return jsonNode.get("access_token").asText();
        } catch (JsonProcessingException | URISyntaxException e) {
            throw new CustomException("ERROR Token Generation Failed");
        }
    }

    private String callVodacomNamecheckService(String jwtToken, TransactionData transactionData, Map<String, String> xmlMapValues) throws CustomException {
        String bankId  = xmlMapValues.get("bankId");
        ResponseEntity<String> responseEntity;

        // Create headers for the POST request
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/json");
        headers.set("Authorization", "Bearer " + jwtToken);

        // Request Body
//        String requestBody = gson.toJson(transactionData);

        String requestBody = "{\n" +
"    \"OriginatorConversationID\": \"" + transactionData.getOriginatorConversationID() + "\",\n" +
"    \"Timestamp\": \"" + transactionData.getTimestamp() + "\",\n" +
"    \"Identities\": [\n" +
"        {\n" +
"            \"IdentifierRole\": \"" + transactionData.getIdentities().get(0).getIdentifierRole()  + "\",\n" +
"            \"IdentifierType\": \"" + transactionData.getIdentities().get(0).getIdentifierType()  + "\",\n" +
"            \"Identifier\": \"" + transactionData.getIdentities().get(0).getIdentifier() + "\"\n" +
"        }\n" +
"    ],\n" +
"    \"Transaction\": {\n" +
"        \"CommandID\": \"" + transactionData.getTransaction().getCommandID() + "\"\n" +
"    }\n" +
"}";

        // Create the HTTP entity
        HttpEntity<String> entity = new HttpEntity<>(requestBody, headers);

        // Send the POST request to the mock service
        if ("43".equals(bankId)) {
            log.info("Vodacom Namecheck Request Body: {}", requestBody);
            log.info("Calling Vodacom Namecheck Service On URL: {} ", namecheckUrl);
            responseEntity = restTemplate.exchange(namecheckUrl, HttpMethod.POST, entity, String.class);
        } else {
            throw new CustomException("ERROR. Only Vodacom DRC is supported for this service");
        }
        // Return the response body
        String responseBody = responseEntity.getBody();
        log.info("Received Response From Vodacom: {} ", responseBody);

        return responseBody;
    }

    private TransactionData getTransactionData(Map<String, String> xmlMapValues) {
        // Check if customer or merchant
        String commandId = CUSTOMER_COMMAND_ID;
        String identifierType = CUSTOMER_IDENTIFIER_TYPE;

        // Merchant, tillNumber will be present in the request
        if (!xmlMapValues.get("tillNumber").isEmpty()) {
            commandId = AGENT_COMMAND_ID;
            identifierType = AGENT_IDENTIFIER_TYPE;
        }
        TransactionData transactionData = new TransactionData();
        transactionData.setOriginatorConversationID(xmlMapValues.get("msgId"));
        transactionData.setTimestamp(new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()));

        Identity identity = new Identity();
        identity.setIdentifierRole(IDENTIFIER_ROLE);
        identity.setIdentifierType(identifierType);
        identity.setIdentifier(xmlMapValues.get("mobileNumber"));

        // Add Identity to a List
        List<Identity> identities = new ArrayList<>();
        identities.add(identity);
        transactionData.setIdentities(identities);

        Transaction transaction = new Transaction();
        transaction.setCommandID(commandId);
        transactionData.setTransaction(transaction);

        return transactionData;
    }
    
    public static void main(String[] args) {
        String responseStr = "{\n" +
"    \"ResultCode\": \"0\",\n" +
"    \"ResultDesc\": \"Process service request successfully.\",\n" +
"    \"OriginatorConversationID\": \"000000131634\",\n" +
"    \"ConversationID\": \"JychXI0DkgLdSkZH7D9v8ze3J24HmD4i\",\n" +
"    \"ResultData\": {\n" +
"        \"Kind of premium subscriber\": \"\",\n" +
"        \"Place of birth\": \"[[KYC][Personnal upgraded info][Place of birth]]\",\n" +
"        \"ICAPID\": \"655767868787778\",\n" +
"        \"Email address\": \"\",\n" +
"        \"Nationality\": \"[[KYC][Personnal upgraded info][Nationality]]\",\n" +
"        \"Gender\": \"0\",\n" +
"        \"Address commune\": \"GOMBE\",\n" +
"        \"Address province\": \"\",\n" +
"        \"Id Card Recevied\": \"0\",\n" +
"        \"First Name\": \"TEST CUSTOMER\",\n" +
"        \"Middle Name\": \"[[KYC][Personnal upgraded info][Middle Name]]\",\n" +
"        \"Last Name\": \"GATIMU\",\n" +
"        \"Date of Birth\": \"556577676\",\n" +
"        \"Address street\": \"19 KALEMIE, GARE\",\n" +
"        \"Address town\": \"kinshasa\"\n" +
"    },\n" +
"    \"audit\": {\n" +
"        \"start_time\": \"20250722101529\",\n" +
"        \"completed_time\": \"20250722101530\",\n" +
"        \"original_time\": \"20250721182249\"\n" +
"    }\n" +
"}";    
        System.out.println(responseStr);
        ResponseData responseData = (new Gson()).fromJson(responseStr, ResponseData.class);
        System.out.println((new Gson()).toJson(responseData));
        
    }
}