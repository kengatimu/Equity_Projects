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

@Service("feeLookupStrategy")
public class FeeLookupStrategyService implements XmlTypeProcessingStrategyService {
    private static final Logger log = LoggerFactory.getLogger(FeeLookupStrategyService.class);

    private final XmlProcessingCommonClassesService xmlProcessingCommonClassesService;
    private final TransactionValidationAndMappingService transactionValidationAndMappingService;
    private final XmlFieldsValidatorService xmlFieldsValidatorService;
    private final ImtCallerService imtCallerService;
    private final DatabaseService databaseService;

    public FeeLookupStrategyService(XmlProcessingCommonClassesService xmlProcessingCommonClassesService,
                                    TransactionValidationAndMappingService transactionValidationAndMappingService,
                                    XmlFieldsValidatorService xmlFieldsValidatorService,
                                    ImtCallerService imtCallerService,
                                    DatabaseService databaseService) {
        this.xmlProcessingCommonClassesService = xmlProcessingCommonClassesService;
        this.transactionValidationAndMappingService = transactionValidationAndMappingService;
        this.xmlFieldsValidatorService = xmlFieldsValidatorService;
        this.imtCallerService = imtCallerService;
        this.databaseService = databaseService;
    }

    @Override
    public String process(boolean isInternal, String requestXml, Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException, SignatureException {

        // Get bank id
        String bankId = xmlTagsMap.getOrDefault("bankId", "");

        // Check if sending to the same country
//        enforceReceiverCountryRestrictions(xmlTagsMap);

        // Check if a duplicate record exists in the database for the given RRN and type
        checkForDuplicate(rrn, type);

        // Map the incoming request XML and associated tags to a TransactionDetails entity
        TransactionDetails entity = composeInitialEntity(requestXml, xmlTagsMap, type, rrn);

        // Save the initial transaction record to the database
        persistInitialTransactionRecord(entity);

        // Validate the request by checking fields, signature, and any other necessary validations
        validateRequest(isInternal, xmlTagsMap, rrn, type);

        // Send the request to the external service and receive the XML response
        String responseXml = sendToExternalService(new TransactionDetails(), xmlTagsMap, bankId, requestXml, type, rrn);

        // Get the transaction record
        TransactionDetails transactionDetails = getDbRecord(rrn, type);

        // Process the received response, updating the database and handling success or failure scenarios
        return processResponse(transactionDetails, bankId, rrn, responseXml, type, true);

    }

    private void enforceReceiverCountryRestrictions(Map<String, String> xmlTagsMap) throws CustomException {
        String bankId = xmlTagsMap.get("bankId");
        String receiverCountry = xmlTagsMap.get("receiveCountry");

        // Ensure values are not null before comparing
        if (bankId == null || receiverCountry == null) {
            throw new CustomException("Missing required bankId or receiver country in XML tags");
        }

        // Normalize for case-insensitive comparison
        bankId = bankId.trim();
        receiverCountry = receiverCountry.trim().toUpperCase();

        // Bank 54 sending to KEN (same country)
        if ("54".equals(bankId) && "KEN".equals(receiverCountry)) {
            throw new CustomException("Sending to the same country as sender (KEN) is not allowed for Bank 54.");
        }

        // Bank 43 sending to COD (same country)
        if ("43".equals(bankId) && "COD".equals(receiverCountry)) {
            throw new CustomException("Sending to the same country as sender (COD) is not allowed for Bank 43.");
        }
    }

    private void checkForDuplicate(String rrn, String type) throws CustomException {
        xmlProcessingCommonClassesService.checkForDuplicateRecord(rrn, type);
    }

    private TransactionDetails composeInitialEntity(String requestXml, Map<String, String> xmlTagsMap, String type, String rrn) {
        return transactionValidationAndMappingService.getEntity(requestXml, new request(), new Envelope(), xmlTagsMap, type, rrn);
    }

    @Transactional
    private void persistInitialTransactionRecord(TransactionDetails entity) {
        databaseService.persistInitialTransactionRecord(entity);
    }

    private void validateRequest(boolean isInternal, Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException, SignatureException {
        xmlFieldsValidatorService.validateXmlRequestFields(xmlTagsMap, type);
        transactionValidationAndMappingService.validateSignature(isInternal, xmlTagsMap, new request(), new Envelope(), rrn, type);
    }

    private String sendToExternalService(TransactionDetails transactionDetails, Map<String, String> xmlTagsMap, String bankId, String requestXml, String type, String rrn) throws CustomException {
        return xmlProcessingCommonClassesService.sendRequestAndGetResponse(transactionDetails, xmlTagsMap, bankId, requestXml, type, rrn);
    }

    private TransactionDetails getDbRecord(String rrn, String type) throws CustomException {
        return xmlProcessingCommonClassesService.getSavedDbRecord(rrn, type);
    }

    private String processResponse(TransactionDetails transactionDetails, String bankId, String rrn, String responseXml, String type, boolean b) throws CustomException {
        return imtCallerService.processResponse(transactionDetails, bankId, rrn, responseXml, type, true);
    }
}
