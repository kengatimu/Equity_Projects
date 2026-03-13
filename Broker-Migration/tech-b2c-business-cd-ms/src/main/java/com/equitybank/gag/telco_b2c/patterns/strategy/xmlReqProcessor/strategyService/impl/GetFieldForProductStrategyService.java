package com.equitybank.gag.telco_b2c.patterns.strategy.xmlReqProcessor.strategyService.impl;

import com.equitybank.gag.telco_b2c.dto.airtime.request.Envelope;
import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.mapper.CustomMapperService;
import com.equitybank.gag.telco_b2c.patterns.strategy.xmlReqProcessor.strategyService.XmlTypeProcessingStrategyService;
import com.equitybank.gag.telco_b2c.service.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.security.SignatureException;
import java.util.Map;

@Service("getFieldForProductStrategy")
public class GetFieldForProductStrategyService implements XmlTypeProcessingStrategyService {
    private static final Logger log = LoggerFactory.getLogger(GetFieldForProductStrategyService.class);

    private final XmlProcessingCommonClassesService xmlProcessingCommonClassesService;
    private final XmlFieldsValidatorService xmlFieldsValidatorService;
    private final TransactionValidationAndMappingService transactionValidationAndMappingService;
    private final CustomMapperService customMapperService;
    private final ImtCallerService imtCallerService;

    public GetFieldForProductStrategyService(XmlProcessingCommonClassesService xmlProcessingCommonClassesService,
                                             XmlFieldsValidatorService xmlFieldsValidatorService,
                                             TransactionValidationAndMappingService transactionValidationAndMappingService,
                                             CustomMapperService customMapperService,
                                             ImtCallerService imtCallerService) {
        this.xmlProcessingCommonClassesService = xmlProcessingCommonClassesService;
        this.xmlFieldsValidatorService = xmlFieldsValidatorService;
        this.transactionValidationAndMappingService = transactionValidationAndMappingService;
        this.customMapperService = customMapperService;
        this.imtCallerService = imtCallerService;
    }

    @Override
    public String process(boolean isInternal, String requestXml, Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException, SignatureException {

        // Validate request fields and signature
        validateRequest(isInternal, xmlTagsMap, rrn, type);

        // Extract bank ID
        String bankId = xmlTagsMap.getOrDefault("bankId", "");

        // Update database record with request inputs
        updateTransactionRecordWithRequestInputs(rrn, xmlTagsMap, type);

        // Step 4: Retrieve saved DB transaction record
        TransactionDetails transactionDetails = transactionValidationAndMappingService.getDatabaseRecord(rrn, type);

        // Step 5: Send request to external system and receive response
        String responseXml = xmlProcessingCommonClassesService.sendRequestAndGetResponse(transactionDetails, xmlTagsMap, bankId, requestXml, type, rrn);

        // Step 6: Process and return the response
        return processResponse(transactionDetails, bankId, rrn, responseXml, type, false);
    }

    // Validates XML fields and signature
    private void validateRequest(boolean isInternal, Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException, SignatureException {
        xmlFieldsValidatorService.validateXmlRequestFields(xmlTagsMap, type);
        transactionValidationAndMappingService.validateSignature(isInternal, xmlTagsMap, new request(), new Envelope(), rrn, type);
    }

    // Composes updated transaction entity and updates the DB
    private void updateTransactionRecordWithRequestInputs(String rrn, Map<String, String> xmlTagsMap, String type) throws CustomException {
        TransactionDetails transactionRecord = transactionValidationAndMappingService.getDatabaseRecord(rrn, type);
        TransactionDetails entity = customMapperService.composeTransactionRecordEntity(transactionRecord, xmlTagsMap, type);

        if (entity != null) {
            xmlProcessingCommonClassesService.updateDatabaseRecord(entity, rrn, type);

            // Optionally: use async version instead. Not recommended here.
            // xmlProcessingCommonClassesService.updateDatabaseAsync(entity, rrn, type);
        }
    }

    // Process external XML response
    private String processResponse(TransactionDetails transactionDetails, String bankId, String rrn, String responseXml, String type, boolean readResponseString) throws CustomException {
        return imtCallerService.processResponse(transactionDetails, bankId, rrn, responseXml, type, readResponseString);
    }
}
