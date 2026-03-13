package com.equitybank.gag.papss.ips.service.impl;

import com.equitybank.gag.papss.ips.service.XmlResponseReaderService;
import com.equitybank.gag.papss.ips.exception.CustomException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.ByteArrayInputStream;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

import static com.equitybank.gag.papss.ips.config.StatusCodeMessages.DEFAULT_ERROR;
import static com.equitybank.gag.papss.ips.config.StatusCodeMessages.DEFAULT_RESPONSE_PROCESSING_FAILURE;

@Service
public class XmlResponseReaderServiceImpl implements XmlResponseReaderService {
    private static final Logger log = LoggerFactory.getLogger(XmlResponseReaderServiceImpl.class);


    @Override
    public Map<String, String> processXmlResponse(String rrn, String xmlContent, String type) throws CustomException {
        Map<String, String> resultMap = new HashMap<>();
        try {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            factory.setNamespaceAware(true); // handle XML namespaces
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document doc = builder.parse(new ByteArrayInputStream(xmlContent.getBytes(StandardCharsets.UTF_8)));

            switch (type.toUpperCase()) {
                case "NAMECHECK" -> handleNamecheckResponse(rrn, doc, resultMap, type);
                case "CREDIT_TRANSFER", "CREDIT_TRANSFER_CALLBACK" -> handleTransactionResponse(rrn, doc, resultMap, type);
                case "STATUS_CHECK" -> handleStatusCheckResponse(rrn, doc, resultMap, type);
                default -> {
                    log.error("{}: Unsupported Type For ProcessXmlResponse Reader Service: {}", rrn, type);
                    throw new CustomException(DEFAULT_ERROR + "Unsupported Transaction Type: " + type);
                }
            }
        } catch (Exception e) {
            log.error("{}: Exception occurred when parsing received response XML: {}", rrn, e.getMessage());
            throw new CustomException(e.getMessage());
        }
        return resultMap;
    }

    private void handleNamecheckResponse(String rrn, Document doc, Map<String, String> resultMap, String type) throws CustomException {
        try {
            Node idVrfctnRpt = getNodeByName(doc.getDocumentElement(), "IdVrfctnRpt");
            if (idVrfctnRpt == null){
                throw new CustomException(DEFAULT_RESPONSE_PROCESSING_FAILURE + "IdVrfctnRpt is missing or null");
            }

            String msgId = getTextContentByTagName(idVrfctnRpt, "MsgId");
            resultMap.put("msgId", msgId);

            String vrfctn = getTextContentByTagName(idVrfctnRpt, "Vrfctn");
            resultMap.put("status", vrfctn);

            String originalAccountId = getTextContentByTagName(idVrfctnRpt, "Id");
            String receiverInstId = getTextContentByTagName(idVrfctnRpt, "MmbId");
            resultMap.put("originalAccountId", originalAccountId);
            resultMap.put("receiverInstId", receiverInstId);

            if ("true".equalsIgnoreCase(vrfctn)) {
                // Successful: extract name, email, account ID, and assignee member ID
                String name = getTextContentByTagName(idVrfctnRpt, "Nm");
                String email = getTextContentByTagName(idVrfctnRpt, "EmailAdr");

                // Update the map
                resultMap.put("name", name);
                resultMap.put("email", email);

            } else {
                // Unsuccessful: extract reason code
                String reasonCode = getTextContentByTagName(idVrfctnRpt, "Cd");
                resultMap.put("reasonCode", reasonCode);
            }
        } catch (Exception e) {
            log.error("{}: Exception Occurred While Reading Received {} Response Xml: {}", rrn, type, e.getMessage());
            throw new CustomException(DEFAULT_RESPONSE_PROCESSING_FAILURE + e.getMessage());
        }
    }

    private void handleTransactionResponse(String rrn, Document doc, Map<String, String> resultMap, String type) throws CustomException {
        try {
            Node fIToFIPmtStsRpt = getNodeByName(doc.getDocumentElement(), "FIToFIPmtStsRpt");
            if (fIToFIPmtStsRpt == null){
                throw new CustomException(DEFAULT_RESPONSE_PROCESSING_FAILURE + "FIToFIPmtStsRpt is missing or null");
            }

            String msgId = getTextContentByTagName(fIToFIPmtStsRpt, "MsgId");
            resultMap.put("msgId", msgId);

            String grpSts = getTextContentByTagName(fIToFIPmtStsRpt, "GrpSts");
            resultMap.put("status", grpSts);

            if (!"ACCP".equalsIgnoreCase(grpSts) && !"ACSC".equalsIgnoreCase(grpSts)) {
                // Unsuccessful: extract reason code
                String reasonCode = getTextContentByTagName(fIToFIPmtStsRpt, "Cd");
                resultMap.put("reasonCode", reasonCode);
            }

        } catch (Exception e) {
            log.error("{}: Exception Occurred While Reading Received {} Response Xml: {}", rrn, type, e.getMessage());
            throw new CustomException(DEFAULT_RESPONSE_PROCESSING_FAILURE + e.getMessage());
        }
    }

    private void handleStatusCheckResponse(String rrn, Document doc, Map<String, String> resultMap, String type) {
        // Placeholder for pacs.028 response parsing
        resultMap.put("info", "pacs028 not yet implemented");
    }

    private Node getNodeByName(Node node, String localName) {
        NodeList children = node.getChildNodes();
        for (int i = 0; i < children.getLength(); i++) {
            Node n = children.item(i);
            if (n.getLocalName() != null && n.getLocalName().equals(localName)) {
                return n;
            }
            Node recursive = getNodeByName(n, localName);
            if (recursive != null) return recursive;
        }
        return null;
    }

    private String getTextContentByTagName(Node node, String tagName) {
        Node target = getNodeByName(node, tagName);
        return target != null ? target.getTextContent().trim() : "";
    }
}
