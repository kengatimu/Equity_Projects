package com.equitybank.gag.telco_b2c.patterns.strategy.xmlReqProcessor.strategyService.impl;

import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.patterns.strategy.xmlReqProcessor.strategyService.XmlTypeProcessingStrategyService;
import com.equitybank.gag.telco_b2c.service.XmlProcessingCommonClassesService;
import org.springframework.stereotype.Service;

import java.security.SignatureException;
import java.util.Map;

import static com.equitybank.gag.telco_b2c.config.ApplicationConstants.DEFAULT_SAFARICOM_KE;
import static com.equitybank.gag.telco_b2c.config.ApplicationConstants.DEFAULT_VODACOM_CD;

@Service("nameCheckStrategy")
public class NameCheckStrategyService implements XmlTypeProcessingStrategyService {
    private final XmlProcessingCommonClassesService xmlProcessingCommonClassesService;

    public NameCheckStrategyService(XmlProcessingCommonClassesService xmlProcessingCommonClassesService) {
        this.xmlProcessingCommonClassesService = xmlProcessingCommonClassesService;
    }

    @Override
    public String process(boolean isInternal, String requestXml, Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException, SignatureException {
        try {
            // Get bank id
            String bankId = xmlTagsMap.getOrDefault("bankId", "");

            // Validate fields and signature
            xmlProcessingCommonClassesService.validateRequest(isInternal, xmlTagsMap, rrn, type);

            // Normalize telco name based on bank_id and known aliases
            String telco = xmlTagsMap.get("telcom").toUpperCase();
            boolean isMpesa = telco.contains("MPESA") || telco.contains("M-PESA");

            String normalizedTelco = switch (bankId) {
                case "54" -> isMpesa ? DEFAULT_SAFARICOM_KE : telco;
                case "43" -> isMpesa ? DEFAULT_VODACOM_CD : telco;
                default -> telco;
            };

            // Update the map with the normalize telco name
            xmlTagsMap.put("telcom", normalizedTelco);

            // Send the request to the external service and receive the XML response
            return xmlProcessingCommonClassesService.sendRequestAndGetResponse(new TransactionDetails(), xmlTagsMap, bankId, requestXml, type, rrn);

        } catch (CustomException e) {
            throw new CustomException(e.getMessage());
        }
    }

    //    // TODO remove this in prod:
    private String testVodacomFloatPurchaseNamecheckResponse(String rrn, String telco, Map<String, String> xmlTagsMap) {
        return "<MobileNumberInquireRes>\n" +
                "    <msgId>" + rrn + "</msgId>\n" +
                "    <channel>" + xmlTagsMap.get("channel") + "</channel>\n" +
                "    <telcom>" + xmlTagsMap.get("telcom") + "</telcom>\n" +
                "    <mobileNumber>" + xmlTagsMap.get("mobileNumber") + "</mobileNumber>\n" +
                "    <responseCode>00</responseCode>\n" +
                "    <customerNames>TEST TEST</customerNames>\n" +
                "</MobileNumberInquireRes>";
    }
}
