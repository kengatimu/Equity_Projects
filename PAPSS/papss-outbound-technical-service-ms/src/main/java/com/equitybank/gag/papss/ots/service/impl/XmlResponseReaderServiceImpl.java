package com.equitybank.gag.papss.ots.service.impl;

import com.equitybank.gag.papss.ots.enums.TransactionType;
import com.equitybank.gag.papss.ots.exception.CustomException;
import com.equitybank.gag.papss.ots.jpos.space.configs.JposConstants;
import com.equitybank.gag.papss.ots.service.XmlResponseReaderService;
import org.jpos.transaction.Context;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import javax.xml.XMLConstants;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.ByteArrayInputStream;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

import static com.equitybank.gag.papss.ots.config.ApplicationConstants.DEFAULT_ERROR;
import static com.equitybank.gag.papss.ots.config.ApplicationConstants.DEFAULT_RESPONSE_PROCESSING_FAILURE;

@Service
public class XmlResponseReaderServiceImpl implements XmlResponseReaderService {
    private static final Logger log = LoggerFactory.getLogger(XmlResponseReaderServiceImpl.class);

    private final Map<String, String> papssErrorMap;

    public XmlResponseReaderServiceImpl(@Qualifier("papssErrorCodeMapping") Map<String, String> papssErrorMap) {
        this.papssErrorMap = papssErrorMap;
    }

    @Override
    public Map<String, String> processXmlResponse(Context ctx, String rrn, String originalRrn, String xmlContent, String type) throws CustomException {
        Map<String, String> resultMap = new HashMap<>();

        try {
            // Create a namespace-aware XML factory for ISO 20022 payloads
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            factory.setNamespaceAware(true);

            // Prevent XML External Entity (XXE) attacks by disallowing DOCTYPE declarations
            factory.setFeature("http://apache.org/xml/features/disallow-doctype-decl", true);

            // Disable resolution of external general entities
            factory.setFeature("http://xml.org/sax/features/external-general-entities", false);

            // Disable resolution of external parameter entities
            factory.setFeature("http://xml.org/sax/features/external-parameter-entities", false);

            // Prevent loading of external DTDs
            factory.setFeature("http://apache.org/xml/features/nonvalidating/load-external-dtd", false);

            // Disable XInclude processing
            factory.setXIncludeAware(false);

            // Prevent entity expansion inside the XML document
            factory.setExpandEntityReferences(false);

            // Enable JAXP secure processing limits to mitigate DoS vectors (e.g. billion laughs)
            factory.setFeature(XMLConstants.FEATURE_SECURE_PROCESSING, true);

            // Explicitly block access to external DTDs
            factory.setAttribute(XMLConstants.ACCESS_EXTERNAL_DTD, "");

            // Explicitly block access to external XML schemas
            factory.setAttribute(XMLConstants.ACCESS_EXTERNAL_SCHEMA, "");

            // Build the hardened document builder
            DocumentBuilder builder = factory.newDocumentBuilder();

            // Parse the PAPSS XML response from the HTTP payload
            Document doc = builder.parse(new ByteArrayInputStream(xmlContent.getBytes(StandardCharsets.UTF_8)));

            // Route response processing based on transaction type
            switch (type.toUpperCase()) {
                case "NAMECHECK" -> handleNamecheckResponse(rrn, doc, resultMap, type);
                case "CREDIT_TRANSFER", "CREDIT_TRANSFER_CALLBACK", "STATUS_CHECK" ->
                        handleTransactionResponse(ctx, rrn, originalRrn, doc, resultMap, type);
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
            // Locate the IdVrfctnRpt node which holds name check results
            Node idVrfctnRpt = getNodeByName(doc.getDocumentElement(), "IdVrfctnRpt");
            if (idVrfctnRpt == null) {
                throw new CustomException(DEFAULT_RESPONSE_PROCESSING_FAILURE + "IdVrfctnRpt is missing or null");
            }

            // Extract message identifier
            resultMap.put("msgId", getTextContentByTagName(idVrfctnRpt, "MsgId"));

            // Extract verification status
            String vrfctn = getTextContentByTagName(idVrfctnRpt, "Vrfctn");
            resultMap.put("status", vrfctn);

            // Extract account and institution identifiers
            resultMap.put("originalAccountId", getTextContentByTagName(idVrfctnRpt, "Id"));
            resultMap.put("receiverInstId", getTextContentByTagName(idVrfctnRpt, "MmbId"));

            if ("true".equalsIgnoreCase(vrfctn)) {
                // Successful verification: extract customer details
                resultMap.put("name", getTextContentByTagName(idVrfctnRpt, "Nm"));
                resultMap.put("email", getTextContentByTagName(idVrfctnRpt, "EmailAdr"));

                // Optional account currency field
                resultMap.put("accountCurrency", getTextContentByTagName(idVrfctnRpt, "AcctCurrency"));
            } else {
                // Failed verification: extract PAPSS reason code
                resultMap.put("reasonCode", getTextContentByTagName(idVrfctnRpt, "Cd"));
            }

        } catch (Exception e) {
            log.error("{}: Exception Occurred While Reading Received {} Response Xml: {}", rrn, type, e.getMessage());
            throw new CustomException(DEFAULT_RESPONSE_PROCESSING_FAILURE + e.getMessage());
        }
    }

    private void handleTransactionResponse(Context ctx, String rrn, String originalRrn, Document doc, Map<String, String> resultMap, String type) throws CustomException {

        try {
            // Locate the FIToFIPmtStsRpt node which holds transaction status
            Node fIToFIPmtStsRpt = getNodeByName(doc.getDocumentElement(), "FIToFIPmtStsRpt");
            if (fIToFIPmtStsRpt == null) {
                throw new CustomException(DEFAULT_RESPONSE_PROCESSING_FAILURE + "FIToFIPmtStsRpt is missing or null");
            }

            // Preserve original RRN for status check responses
            resultMap.put("originalRrn", originalRrn);

            // Extract message identifier
            resultMap.put("msgId", getTextContentByTagName(fIToFIPmtStsRpt, "MsgId"));

            // Extract group or transaction status
            String grpSts = getTextContentByTagName(fIToFIPmtStsRpt, "GrpSts");
            if (grpSts.isBlank()) {
                grpSts = getTextContentByTagName(fIToFIPmtStsRpt, "TxSts");
            }
            resultMap.put("ipsStatus", grpSts);

            // Handle non-success statuses
            if (!"ACCP".equalsIgnoreCase(grpSts) && !"ACSC".equalsIgnoreCase(grpSts)) {

                String ctxCode = ctx.get(JposConstants.ISO20022_PACS008_STATUS_REASON_CODE);
                String xmlCode = getTextContentByTagName(fIToFIPmtStsRpt, "Cd");

                // For status checks, XML reason code always takes precedence
                if (TransactionType.STATUS_CHECK.name().equalsIgnoreCase(type)) {
                    ctxCode = xmlCode;
                }

                String reasonCode = null;

                // Prefer context-provided reason code when available
                if (ctxCode != null && !ctxCode.isBlank()) {
                    reasonCode = ctxCode;
                }

                // Otherwise, attempt mapping from PAPSS error configuration
                else if (!xmlCode.isBlank()) {
                    for (Map.Entry<String, String> entry : papssErrorMap.entrySet()) {
                        String value = entry.getValue();
                        if (value != null && value.startsWith(xmlCode + ":")) {
                            reasonCode = entry.getKey();
                            break;
                        }
                    }

                    // Fallback to XML reason code if no mapping found
                    if (reasonCode == null) {
                        reasonCode = xmlCode;
                    }
                }

                // Ensure non-null reason code
                resultMap.put("reasonCode", reasonCode != null ? reasonCode : "");
                resultMap.put("reason", xmlCode);

                // Clear PACS.008 reason code from jPOS context
                ctx.put(JposConstants.ISO20022_PACS008_STATUS_REASON_CODE, "");

            } else {
                // Successful transaction status
                resultMap.put("reasonCode", "000");
                resultMap.put("reason", grpSts);

                // Clear PACS.008 reason code from jPOS context
                ctx.put(JposConstants.ISO20022_PACS008_STATUS_REASON_CODE, "");
            }

        } catch (Exception e) {
            log.error("{}: Exception Occurred While Reading Received {} Response Xml: {}", rrn, type, e.getMessage());
            throw new CustomException(DEFAULT_RESPONSE_PROCESSING_FAILURE + e.getMessage());
        }
    }

    private String getTextContentByTagName(Node node, String tagName) {
        Node target = getNodeByName(node, tagName);
        return target != null ? target.getTextContent().trim() : "";
    }

    private Node getNodeByName(Node node, String localName) {
        NodeList children = node.getChildNodes();
        for (int i = 0; i < children.getLength(); i++) {
            Node n = children.item(i);

            if (n.getLocalName() != null && n.getLocalName().equals(localName)) {
                return n;
            }

            Node recursive = getNodeByName(n, localName);
            if (recursive != null) {
                return recursive;
            }
        }
        return null;
    }
}
