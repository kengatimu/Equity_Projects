package com.equitybank.gag.telco_b2c.patterns.strategy.xmlReqProcessor.strategyService.impl;

import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.patterns.strategy.xmlReqProcessor.strategyService.XmlTypeProcessingStrategyService;
import com.equitybank.gag.telco_b2c.service.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.security.SignatureException;
import java.util.Map;

@Service("statusCheckStrategy")
public class StatusCheckStrategyService implements XmlTypeProcessingStrategyService {
    private static final Logger log = LoggerFactory.getLogger(StatusCheckStrategyService.class);

    private static final String DEFAULT_VODACOM = "VODACOM-MONEY";

    private final XmlProcessingCommonClassesService xmlProcessingCommonClassesService;
    private final TransactionValidationAndMappingService transactionValidationAndMappingService;
    private final PayloadService payloadService;

    public StatusCheckStrategyService(XmlProcessingCommonClassesService xmlProcessingCommonClassesService,
                                      TransactionValidationAndMappingService transactionValidationAndMappingService,
                                      PayloadService payloadService) {
        this.xmlProcessingCommonClassesService = xmlProcessingCommonClassesService;
        this.transactionValidationAndMappingService = transactionValidationAndMappingService;
        this.payloadService = payloadService;
    }

    @Override
    public String process(boolean isInternal, String requestXml, Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException, SignatureException {
        // Validate input
        xmlProcessingCommonClassesService.validateRequest(isInternal, xmlTagsMap, rrn, type);

        // Normalize telco name: Omni channel sometimes refer vodacom as mpesa.
        String telco = xmlTagsMap.get("telco").toUpperCase();
        String telcom = telco.contains("MPESA") || telco.contains("M-PESA") ? DEFAULT_VODACOM : telco;
        xmlTagsMap.put("telco", telcom);

        // Retrieve existing transaction record
        TransactionDetails transactionDetails = transactionValidationAndMappingService.getDatabaseRecord(rrn, type);

        // Get the saved status and only call telco if status is TIMEOUT, PENDING, INITIALIZED or status code -1
        String status = transactionDetails.getStatus();
        String statusCode = transactionDetails.getStatusCode();

        // Shortcut if already finalized
        if (!isPending(status, statusCode)) {
            log.info("{}: Returning existing status for {}", rrn, type);
            return payloadService.composeStatusCheckResponse(transactionDetails, rrn);
        }

        // Otherwise, send fresh status check
        String bankId = xmlTagsMap.getOrDefault("bankId", "");
        return xmlProcessingCommonClassesService.sendRequestAndGetResponse(transactionDetails, xmlTagsMap, bankId, requestXml, type, rrn);
    }

    private boolean isPending(String status, String statusCode) {
        return "TIMEOUT".equalsIgnoreCase(status)
                || "PENDING".equalsIgnoreCase(status)
                || "INITIALIZED".equalsIgnoreCase(status)
                || "-1".equals(statusCode)
                || "-3".equals(statusCode);
    }
}
