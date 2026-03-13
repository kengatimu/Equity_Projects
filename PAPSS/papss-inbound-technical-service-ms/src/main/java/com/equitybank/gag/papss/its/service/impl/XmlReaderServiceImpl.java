package com.equitybank.gag.papss.its.service.impl;

import com.equitybank.gag.papss.its.enums.PapssStatusCodes;
import com.equitybank.gag.papss.its.enums.TransactionType;
import com.equitybank.gag.papss.its.exception.CustomException;
import com.equitybank.gag.papss.its.service.XmlReaderService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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

import static com.equitybank.gag.papss.its.config.StatusCodeMessages.*;

@Service
public class XmlReaderServiceImpl implements XmlReaderService {
    private static final Logger log = LoggerFactory.getLogger(XmlReaderServiceImpl.class);

    private final Map<String, String> papssErrorMap;

    @Autowired
    public XmlReaderServiceImpl(@Qualifier("papssErrorCodeMapping") Map<String, String> papssErrorMap) {
        this.papssErrorMap = papssErrorMap;
    }

    @Override
    public Map<String, String> processInboundXml(String rrn, String xmlContent, String type) throws CustomException {
        Map<String, String> resultMap = new HashMap<>();
        try {
            // Create a namespace-aware XML factory for PAPSS inbound payloads
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            factory.setNamespaceAware(true);

            // Disallow DOCTYPE declarations to prevent XXE attacks
            factory.setFeature("http://apache.org/xml/features/disallow-doctype-decl", true);

            // Disable external general entities
            factory.setFeature("http://xml.org/sax/features/external-general-entities", false);

            // Disable external parameter entities
            factory.setFeature("http://xml.org/sax/features/external-parameter-entities", false);

            // Prevent loading of external DTDs
            factory.setFeature("http://apache.org/xml/features/nonvalidating/load-external-dtd", false);

            // Disable XInclude processing
            factory.setXIncludeAware(false);

            // Prevent entity expansion
            factory.setExpandEntityReferences(false);

            // Enable secure processing to mitigate XML DoS vectors
            factory.setFeature(XMLConstants.FEATURE_SECURE_PROCESSING, true);

            // Explicitly block access to external DTDs
            factory.setAttribute(XMLConstants.ACCESS_EXTERNAL_DTD, "");

            // Explicitly block access to external XML schemas
            factory.setAttribute(XMLConstants.ACCESS_EXTERNAL_SCHEMA, "");

            // Build hardened document builder
            DocumentBuilder builder = factory.newDocumentBuilder();

            // Parse inbound PAPSS XML safely
            Document doc = builder.parse(new ByteArrayInputStream(xmlContent.getBytes(StandardCharsets.UTF_8)));

            if (TransactionType.NAMECHECK.name().equals(type.toUpperCase())) {
                handleAcmt023Inbound(rrn, doc, resultMap);
            } else if (TransactionType.CREDIT_TRANSFER.name().equals(type.toUpperCase())) {
                handlePacs008Inbound(rrn, doc, resultMap);
            } else {
                log.error("{}: Unsupported Inbound Type For XML Reader Service: {}", rrn, type);
                throw new CustomException(DEFAULT_ERROR + "Unsupported Inbound Transaction Type: " + type);
            }
        } catch (Exception e) {
            throw new CustomException(e.getMessage());
        }
        return resultMap;
    }

    @Override
    public Map<String, String> processPacs002Response(String rrn, String xmlContent) throws CustomException {
        Map<String, String> pacs002ResponseMap = new HashMap<>();
        try {
            // Create a namespace-aware XML factory for pacs.002 responses
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            factory.setNamespaceAware(true);

            // Disallow DOCTYPE declarations to prevent XXE attacks
            factory.setFeature("http://apache.org/xml/features/disallow-doctype-decl", true);

            // Disable external general entities
            factory.setFeature("http://xml.org/sax/features/external-general-entities", false);

            // Disable external parameter entities
            factory.setFeature("http://xml.org/sax/features/external-parameter-entities", false);

            // Prevent loading of external DTDs
            factory.setFeature("http://apache.org/xml/features/nonvalidating/load-external-dtd", false);

            // Disable XInclude processing
            factory.setXIncludeAware(false);

            // Prevent entity expansion
            factory.setExpandEntityReferences(false);

            // Enable secure processing to mitigate XML DoS vectors
            factory.setFeature(XMLConstants.FEATURE_SECURE_PROCESSING, true);

            // Explicitly block access to external DTDs
            factory.setAttribute(XMLConstants.ACCESS_EXTERNAL_DTD, "");

            // Explicitly block access to external XML schemas
            factory.setAttribute(XMLConstants.ACCESS_EXTERNAL_SCHEMA, "");

            // Build hardened document builder
            DocumentBuilder builder = factory.newDocumentBuilder();

            // Parse pacs.002 XML safely
            Document doc = builder.parse(new ByteArrayInputStream(xmlContent.getBytes(StandardCharsets.UTF_8)));

            // Root <FIToFIPmtStsRpt>
            Node fiToFiPmtStsRpt = getNodeByName(doc.getDocumentElement(), "FIToFIPmtStsRpt");
            if (fiToFiPmtStsRpt == null) {
                throw new CustomException(DEFAULT_PAC002_RESPONSE_FAILURE + "FIToFIPmtStsRpt is missing");
            }

            // Check Group Status (GrpSts)
            Node orgnlGrpInfAndSts = getNodeByName(fiToFiPmtStsRpt, "OrgnlGrpInfAndSts");
            String grpStatus = orgnlGrpInfAndSts != null ? getTextContentByTagName(orgnlGrpInfAndSts, "GrpSts") : "";

            if (!grpStatus.isEmpty()) {
                pacs002ResponseMap.put("status", grpStatus);

                // ACSC is final success
                if ("ACSC".equalsIgnoreCase(grpStatus)) {
                    pacs002ResponseMap.put("statusCode", "00");
                    pacs002ResponseMap.put("statusDesc", PapssStatusCodes.ACSC.getDescription());
                }
                // ACCP is final success
                if ("ACCP".equalsIgnoreCase(grpStatus)) {
                    pacs002ResponseMap.put("statusCode", "00");
                    pacs002ResponseMap.put("statusDesc", PapssStatusCodes.ACCP.getDescription());
                }
                return pacs002ResponseMap;
            }

            // Fallback to Transaction Status (TxSts)
            Node txInfAndSts = getNodeByName(fiToFiPmtStsRpt, "TxInfAndSts");
            if (txInfAndSts == null) {
                throw new CustomException(DEFAULT_PAC002_RESPONSE_FAILURE + "TxInfAndSts is missing");
            }

            String txStatus = getTextContentByTagName(txInfAndSts, "TxSts");
            pacs002ResponseMap.put("status", txStatus);

            // If RJCT, read rejection reason code
            if ("RJCT".equalsIgnoreCase(txStatus)) {
                Node stsRsnInf = getNodeByName(txInfAndSts, "StsRsnInf");
                Node rsn = stsRsnInf != null ? getNodeByName(stsRsnInf, "Rsn") : null;

                String reasonCode = rsn != null ? getTextContentByTagName(rsn, "Cd") : "";
                pacs002ResponseMap.put("statusCode", reasonCode);

                // Get status desc
//                Map<String, String> errorMap = getPapssErrorDesc(papssErrorMap.get(reasonCode));
                Map<String, String> errorMap = getPapssErrorDesc(reasonCode);
                pacs002ResponseMap.put("statusDesc", errorMap.get("message"));

            } else {
                // Default to default generic papss error code
                pacs002ResponseMap.put("statusCode", "MS03");
                pacs002ResponseMap.put("statusDesc", "Generic error");
            }
            return pacs002ResponseMap;

        } catch (Exception e) {
            log.error("{}: Error processing pacs.002 inbound XML: {}", rrn, e.getMessage());
            throw new CustomException(DEFAULT_PAC002_RESPONSE_FAILURE + e.getMessage());
        }
    }

    private Map<String, String> getPapssErrorDesc(String reasonCode) {
        Map<String, String> papssErrorDescMap = new HashMap<>();

        // Defensive defaults
        papssErrorDescMap.put("code", "MS03");
        papssErrorDescMap.put("message", "Generic error");

        if (reasonCode == null || reasonCode.isBlank()) {
            return papssErrorDescMap;
        }

        String prefix = reasonCode + ":";

        // Resolve from map VALUES (since keys are numeric)
        for (String value : papssErrorMap.values()) {
            if (value != null && value.startsWith(prefix)) {
                String[] parts = value.split(":", 2);
                papssErrorDescMap.put("code", parts[0]);
                papssErrorDescMap.put("message", parts.length > 1 ? parts[1] : "Generic error");
                return papssErrorDescMap;
            }
        }

        // Nothing matched::: return MS03:Generic error
        return papssErrorDescMap;
    }

//    private Map<String, String> getPapssErrorDesc(String papssErrorDesc) {
//        Map<String, String> papssErrorDescMap = new HashMap<>();
//
//        if (papssErrorDesc == null || papssErrorDesc.isEmpty()) {
//            papssErrorDesc = "MS03:Generic error";
//        }
//
//        String[] parts = papssErrorDesc.split(":", 2); // Limit to 2 parts
//
//        if (parts.length == 2) {
//            papssErrorDescMap.put("code", parts[0]);
//            papssErrorDescMap.put("message", parts[1]);
//        } else {
//            // Fallback if format is not as expected
//            papssErrorDescMap.put("code", "MS03");
//            papssErrorDescMap.put("message", papssErrorDesc);
//        }
//
//        return papssErrorDescMap;
//    }

    private void handleAcmt023Inbound(String rrn, Document doc, Map<String, String> resultMap) throws CustomException {
        try {
            // Root <IdVrfctnReq>
            Node idVrfctnReq = getNodeByName(doc.getDocumentElement(), "IdVrfctnReq");
            if (idVrfctnReq == null) {
                throw new CustomException(DEFAULT_PROCESSING_FAILURE + "IdVrfctnReq is missing");
            }

            // 1. AppHdr - BizMsgIdr
            resultMap.put("bizMsgId", getTextContentByTagName(doc, "BizMsgIdr"));

            // 2. Assignment details
            resultMap.put("msgId", getTextContentByTagName(idVrfctnReq, "MsgId"));
            resultMap.put("assignmentCreatedAt", getTextContentByTagName(idVrfctnReq, "CreDtTm"));

            // 3. Sender Institution (Assgnr)
            Node assgnr = getNodeByName(idVrfctnReq, "Assgnr");
            String senderInstitutionId = assgnr != null ? getTextContentByTagName(assgnr, "MmbId") : "";
            resultMap.put("senderInstitutionId", senderInstitutionId);

            // Sender BIC (Assgnr)
            String senderBic = assgnr != null ? getTextContentByTagName(assgnr, "BICFI") : "";
            resultMap.put("senderBic", senderBic);

            // Receiver Institution (Assgne)
            Node assgne = getNodeByName(idVrfctnReq, "Assgne");
            String receiverInstitutionId = assgne != null ? getTextContentByTagName(assgne, "MmbId") : "";
            resultMap.put("receiverInstitutionId", receiverInstitutionId);

            // Receiver BIC from AppHdr
            Node appHdr = getNodeByName(doc.getDocumentElement(), "AppHdr");
            Node toNode = getNodeByName(appHdr, "To");
            Node finInstTo = toNode != null ? getNodeByName(toNode, "FinInstnId") : null;

            String receiverBic =
                    finInstTo != null ? getTextContentByTagName(finInstTo, "BICFI") : "";
            resultMap.put("receiverBic", receiverBic);

            // Account number (BBAN)
            Node vrfctn = getNodeByName(idVrfctnReq, "Vrfctn");
            Node ptyAndAcctId = vrfctn != null ? getNodeByName(vrfctn, "PtyAndAcctId") : null;
            Node acct = ptyAndAcctId != null ? getNodeByName(ptyAndAcctId, "Acct") : null;
            Node othr = acct != null ? getNodeByName(acct, "Othr") : null;

            String accountNumber = othr != null ? getTextContentByTagName(othr, "Id") : "";
            resultMap.put("accountNumber", accountNumber);

            // === ORIGINAL ID FOR ACMT.024 (MANDATORY) ===
            // <Vrfctn><Id>20251201SL100288185616</Id>
            String originalId = vrfctn != null ? getTextContentByTagName(vrfctn, "Id") : "";
            resultMap.put("originalId", originalId);

        } catch (Exception e) {
            log.error("{}: Error processing acmt.023 inbound XML: {}", rrn, e.getMessage());
            throw new CustomException(DEFAULT_PROCESSING_FAILURE + e.getMessage());
        }
    }

    private void handlePacs008Inbound(String rrn, Document doc, Map<String, String> resultMap) throws CustomException {
        try {
            // Root <FIToFICstmrCdtTrf>
            Node cdtTrf = getNodeByName(doc.getDocumentElement(), "FIToFICstmrCdtTrf");
            if (cdtTrf == null) {
                throw new CustomException(DEFAULT_PROCESSING_FAILURE + "FIToFICstmrCdtTrf is missing");
            }

            // Channel ID (Take default)
            resultMap.put("channelId", DEFAULT_CHANNEL_ID);

            // Source System ID (Take default)
            resultMap.put("sourceSystemId", DEFAULT_SOURCE_SYSTEM_ID);

            // RRN (MessageSeq from header)
            resultMap.put("rrn", rrn);

            // MsgId
            resultMap.put("messageId", getTextContentByTagName(cdtTrf, "MsgId"));

            // EndToEndId
            resultMap.put("endToEndId", getTextContentByTagName(cdtTrf, "EndToEndId"));

            // papssMessageId (TxId)
            resultMap.put("papssMessageId", getTextContentByTagName(cdtTrf, "TxId"));

            // finacleRrn (right-most 12 digits of rrn)
            String finacleRrn = rrn.length() > 12 ? rrn.substring(rrn.length() - 12) : rrn;
            resultMap.put("finacleRrn", finacleRrn);

            // Transaction Currency, Receiver Amount, Receiver Currency
            Node intrBkAmtNode = getNodeByName(cdtTrf, "IntrBkSttlmAmt");
            String receiverAmount = intrBkAmtNode != null ? intrBkAmtNode.getTextContent().trim() : "";
            String receiverCurrency = intrBkAmtNode != null ? intrBkAmtNode.getAttributes().getNamedItem("Ccy").getTextContent() : "";

            resultMap.put("transactionCurrency", receiverCurrency);
            resultMap.put("receiverAmount", receiverAmount);
            resultMap.put("receiverCurrency", receiverCurrency);

            // Sender Currency + Amount
            Node instdAmtNode = getNodeByName(cdtTrf, "InstdAmt");
            String senderAmount = instdAmtNode != null ? instdAmtNode.getTextContent().trim() : "";
            String senderCurrency = instdAmtNode != null ? instdAmtNode.getAttributes().getNamedItem("Ccy").getTextContent() : "";

            resultMap.put("senderAmount", senderAmount);
            resultMap.put("senderCurrency", senderCurrency);

            // FX Rate
            resultMap.put("fxRate", getTextContentByTagName(cdtTrf, "XchgRate"));

            // Acceptance time
            resultMap.put("acceptanceTime", getTextContentByTagName(cdtTrf, "AccptncDtTm"));

            // Sender Name and Address
            Node dbtr = getNodeByName(cdtTrf, "Dbtr");
            String senderName = dbtr != null ? getTextContentByTagName(dbtr, "Nm") : "";
            String senderAddress = "";

            Node dbtrAddr = dbtr != null ? getNodeByName(dbtr, "PstlAdr") : null;
            if (dbtrAddr != null) {
                String country = getTextContentByTagName(dbtrAddr, "Ctry");
                String adrLine = getTextContentByTagName(dbtrAddr, "AdrLine");
                senderAddress = (adrLine + ", " + country).trim();
                resultMap.put("senderCountryCode", country);
            }

            resultMap.put("senderName", senderName);
            resultMap.put("senderAddress", senderAddress);

            // Sender BIC and Sender Institution ID
            Node dbtrAgt = getNodeByName(cdtTrf, "DbtrAgt");
            Node finInst = dbtrAgt != null ? getNodeByName(dbtrAgt, "FinInstnId") : null;

            String senderBic = finInst != null ? getTextContentByTagName(finInst, "BICFI") : "";
            String senderInstitutionId = finInst != null ? getTextContentByTagName(finInst, "MmbId") : "";

            resultMap.put("senderBic", senderBic);
            resultMap.put("senderInstitutionId", senderInstitutionId);

            // Receiver Name and Address
            Node cdtr = getNodeByName(cdtTrf, "Cdtr");
            String receiverName = cdtr != null ? getTextContentByTagName(cdtr, "Nm") : "";
            String receiverAddress = "";

            Node cdtrAddr = cdtr != null ? getNodeByName(cdtr, "PstlAdr") : null;
            if (cdtrAddr != null) {
                String country = getTextContentByTagName(cdtrAddr, "Ctry");
                String adrLine = getTextContentByTagName(cdtrAddr, "AdrLine");
                receiverAddress = (adrLine + ", " + country).trim();
                resultMap.put("receiverCountryCode", country);
            }

            resultMap.put("receiverName", receiverName);
            resultMap.put("receiverAddress", receiverAddress);

            // Receiver Account
            Node cdtrAcct = getNodeByName(cdtTrf, "CdtrAcct");
            Node id = cdtrAcct != null ? getNodeByName(cdtrAcct, "Id") : null;
            Node other = id != null ? getNodeByName(id, "Othr") : null;
            String receiverAccount = other != null ? getTextContentByTagName(other, "Id") : "";
            resultMap.put("receiverAccount", receiverAccount.trim());

            // Sender Account
            Node dbtrAcct = getNodeByName(cdtTrf, "DbtrAcct");
            Node dbtrAcctId = dbtrAcct != null ? getNodeByName(dbtrAcct, "Id") : null;
            Node dbtrAcctOther = dbtrAcctId != null ? getNodeByName(dbtrAcctId, "Othr") : null;
            String senderAccount = dbtrAcctOther != null ? getTextContentByTagName(dbtrAcctOther, "Id") : "";
            resultMap.put("senderAccount", senderAccount.trim());

            // Narration
            resultMap.put("narration", getTextContentByTagName(cdtTrf, "Ustrd"));

            // Payment reason/ purpose
            Node purp = getNodeByName(cdtTrf, "Purp");
            String purpose = purp != null ? getTextContentByTagName(purp, "Cd") : "";
            resultMap.put("purpose", purpose);

            // Local instrument
            resultMap.put("local_instrument", getTextContentByTagName(cdtTrf, "Cd"));

            // Category purpose
            resultMap.put("ctgy_purp", getTextContentByTagName(cdtTrf, "CtgyPurp"));

            // dbtr_memberId
            resultMap.put("dbtr_memberId", senderInstitutionId);

        } catch (Exception e) {
            log.error("{}: Error processing pacs.008 inbound XML: {}", rrn, e.getMessage());
            throw new CustomException(DEFAULT_PROCESSING_FAILURE + e.getMessage());
        }
    }

    private String getAttributeByTagName(Node node, String tagName, String attributeName) {
        Node target = getNodeByName(node, tagName);
        return target != null && target.getAttributes() != null &&
                target.getAttributes().getNamedItem(attributeName) != null
                ? target.getAttributes().getNamedItem(attributeName).getTextContent()
                : "";
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
