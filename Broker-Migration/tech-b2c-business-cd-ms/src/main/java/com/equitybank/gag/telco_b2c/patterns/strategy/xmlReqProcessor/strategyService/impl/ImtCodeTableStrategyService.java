package com.equitybank.gag.telco_b2c.patterns.strategy.xmlReqProcessor.strategyService.impl;

import com.equitybank.gag.telco_b2c.dto.airtime.request.Envelope;
import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.patterns.strategy.xmlReqProcessor.strategyService.XmlTypeProcessingStrategyService;
import com.equitybank.gag.telco_b2c.service.*;

import org.springframework.stereotype.Service;

import java.security.SignatureException;
import java.util.Map;

@Service("imtCodeTableStrategy")
public class ImtCodeTableStrategyService implements XmlTypeProcessingStrategyService {

    private final XmlFieldsValidatorService xmlFieldsValidatorService;
    private final TransactionValidationAndMappingService transactionValidationAndMappingService;
    private final XmlProcessingCommonClassesService xmlProcessingCommonClassesService;

    public ImtCodeTableStrategyService(XmlFieldsValidatorService xmlFieldsValidatorService,
                                       TransactionValidationAndMappingService transactionValidationAndMappingService,
                                       XmlProcessingCommonClassesService xmlProcessingCommonClassesService) {
        this.xmlFieldsValidatorService = xmlFieldsValidatorService;
        this.transactionValidationAndMappingService = transactionValidationAndMappingService;
        this.xmlProcessingCommonClassesService = xmlProcessingCommonClassesService;
    }

    @Override
    public String process(boolean isInternal, String requestXml, Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException, SignatureException {
        // Extract bank ID from the request map
        String bankId = xmlTagsMap.get("bankId");

        // Validate XML fields and digital signature
        validateRequest(isInternal, xmlTagsMap, rrn, type);

        // Perform external call using a dummy transaction object
        return xmlProcessingCommonClassesService.sendRequestAndGetResponse(new TransactionDetails(), xmlTagsMap, bankId, requestXml, type, rrn);
    }

    private void validateRequest(boolean isInternal, Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException, SignatureException {
        xmlFieldsValidatorService.validateXmlRequestFields(xmlTagsMap, type);
        transactionValidationAndMappingService.validateSignature(isInternal, xmlTagsMap, new request(), new Envelope(), rrn, type);
    }
}
