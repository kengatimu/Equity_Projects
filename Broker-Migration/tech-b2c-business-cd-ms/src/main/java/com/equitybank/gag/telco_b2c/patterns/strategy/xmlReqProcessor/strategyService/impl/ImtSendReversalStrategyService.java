package com.equitybank.gag.telco_b2c.patterns.strategy.xmlReqProcessor.strategyService.impl;

import com.equitybank.gag.telco_b2c.dto.airtime.request.Envelope;
import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.patterns.strategy.xmlReqProcessor.strategyService.XmlTypeProcessingStrategyService;
import com.equitybank.gag.telco_b2c.service.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.security.SignatureException;
import java.util.Map;

@Service("imtSendReversalStrategy")
public class ImtSendReversalStrategyService implements XmlTypeProcessingStrategyService {
    private static final Logger log = LoggerFactory.getLogger(ImtSendReversalStrategyService.class);

    private final XmlFieldsValidatorService xmlFieldsValidatorService;
    private final TransactionValidationAndMappingService transactionValidationAndMappingService;
    private final XmlProcessingCommonClassesService xmlProcessingCommonClassesService;
    private final ImtCallerService imtCallerService;

    public ImtSendReversalStrategyService(XmlFieldsValidatorService xmlFieldsValidatorService,
                                          TransactionValidationAndMappingService transactionValidationAndMappingService,
                                          XmlProcessingCommonClassesService xmlProcessingCommonClassesService,
                                          ImtCallerService imtCallerService) {
        this.xmlFieldsValidatorService = xmlFieldsValidatorService;
        this.transactionValidationAndMappingService = transactionValidationAndMappingService;
        this.xmlProcessingCommonClassesService = xmlProcessingCommonClassesService;
        this.imtCallerService = imtCallerService;
    }

    @Override
    public String process(boolean isInternal, String requestXml, Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException, SignatureException {
        // Validate input fields and signature
        validateRequest(isInternal, xmlTagsMap, rrn, type);

        // Extract bank ID from the request tags
        String bankId = xmlTagsMap.get("bankId");

        // Retrieve the saved DB transaction record
        TransactionDetails transactionDetails = getSavedDbRecord(rrn, type);

        // Send the request externally and get the response XML
        String responseXml = xmlProcessingCommonClassesService.sendRequestAndGetResponse(transactionDetails, xmlTagsMap, bankId, requestXml, type, rrn);

        // Process and return the final channel response
        return processResponse(transactionDetails, bankId, rrn, responseXml, type, false);
    }

    private void validateRequest(boolean isInternal, Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException, SignatureException {
        // Validate field presence and structure
        xmlFieldsValidatorService.validateXmlRequestFields(xmlTagsMap, type);

        // Perform signature verification
        transactionValidationAndMappingService.validateSignature(isInternal, xmlTagsMap, new request(), new Envelope(), rrn, type);
    }

    private TransactionDetails getSavedDbRecord(String rrn, String type) throws CustomException {
        // Fetch transaction record using RRN and type
        return transactionValidationAndMappingService.getDatabaseRecord(rrn, type);
    }

    private String processResponse(TransactionDetails transactionDetails, String bankId, String rrn, String responseXml, String type, boolean readResponseString) throws CustomException {
        return imtCallerService.processResponse(transactionDetails, bankId, rrn, responseXml, type, readResponseString);
    }
}
