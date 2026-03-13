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
import org.springframework.transaction.annotation.Transactional;

import java.security.SignatureException;
import java.util.Map;

@Service("imtReferenceNumberStrategy")
public class ImtReferenceNumberStrategyService implements XmlTypeProcessingStrategyService {
    private static final Logger log = LoggerFactory.getLogger(ImtReferenceNumberStrategyService.class);

    private final XmlProcessingCommonClassesService xmlProcessingCommonClassesService;
    private final TransactionValidationAndMappingService transactionValidationAndMappingService;
    private final XmlFieldsValidatorService xmlFieldsValidatorService;
    private final DatabaseService databaseService;
    private final ImtCallerService imtCallerService;

    public ImtReferenceNumberStrategyService(XmlProcessingCommonClassesService xmlProcessingCommonClassesService,
                                             TransactionValidationAndMappingService transactionValidationAndMappingService,
                                             XmlFieldsValidatorService xmlFieldsValidatorService,
                                             DatabaseService databaseService,
                                             ImtCallerService imtCallerService) {
        this.xmlProcessingCommonClassesService = xmlProcessingCommonClassesService;
        this.transactionValidationAndMappingService = transactionValidationAndMappingService;
        this.xmlFieldsValidatorService = xmlFieldsValidatorService;
        this.databaseService = databaseService;
        this.imtCallerService = imtCallerService;
    }

    @Override
    public String process(boolean isInternal, String requestXml, Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException, SignatureException {

        // Extract bank ID from XML tag map
        String bankId = xmlTagsMap.get("bankId");

        // Check for duplicate transaction record
        checkForDuplicate(rrn, type);

        // Compose initial DB entity from XML input
        TransactionDetails entity = composeInitialEntity(requestXml, xmlTagsMap, type, rrn);

        // Persist initial transaction record to database
        persistInitialTransactionRecord(entity);

        // Validate input fields and signature
        validateRequest(isInternal, xmlTagsMap, rrn, type);

        // Send request to external system and receive XML response
        String responseXml = sendToExternalService(xmlTagsMap, bankId, requestXml, type, rrn);

        // Process the response and return the result
        return processResponse(bankId, rrn, responseXml, type);
    }

    // Check for duplicate transaction based on RRN and type
    private void checkForDuplicate(String rrn, String type) throws CustomException {
        transactionValidationAndMappingService.checkForDatabaseRecord(rrn, type, "duplicate-check");
    }

    // Build the initial TransactionDetails entity from request XML and tags
    private TransactionDetails composeInitialEntity(String requestXml, Map<String, String> xmlTagsMap, String type, String rrn) {
        return transactionValidationAndMappingService.getEntity(requestXml, new request(), new Envelope(), xmlTagsMap, type, rrn);
    }

    // Save the initial transaction record in the database
    @Transactional
    private void persistInitialTransactionRecord(TransactionDetails entity) {
        databaseService.persistInitialTransactionRecord(entity);
    }

    // Validate XML fields and digital signature
    private void validateRequest(boolean isInternal, Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException, SignatureException {
        xmlFieldsValidatorService.validateXmlRequestFields(xmlTagsMap, type);
        transactionValidationAndMappingService.validateSignature(isInternal, xmlTagsMap, new request(), new Envelope(), rrn, type);
    }

    // Send the request to external service and return the XML response string
    private String sendToExternalService(Map<String, String> xmlTagsMap, String bankId, String requestXml, String type, String rrn) throws CustomException {
        return xmlProcessingCommonClassesService.sendRequestAndGetResponse(new TransactionDetails(), xmlTagsMap, bankId, requestXml, type, rrn);
    }

    // Process the received XML response and return final processed output
    private String processResponse(String bankId, String rrn, String responseXml, String type) throws CustomException {
        return imtCallerService.processResponse(new TransactionDetails(), bankId, rrn, responseXml, type, true);
    }
}
