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

@Service("receiveGetFieldForProductStrategy")
public class ReceiveGetFieldForProductStrategyService implements XmlTypeProcessingStrategyService {
    private static final Logger log = LoggerFactory.getLogger(ReceiveGetFieldForProductStrategyService.class);

    private final XmlProcessingCommonClassesService xmlProcessingCommonClassesService;
    private final XmlFieldsValidatorService xmlFieldsValidatorService;
    private final TransactionValidationAndMappingService transactionValidationAndMappingService;
    private final CustomMapperService customMapperService;
    private final ImtCallerService imtCallerService;

    public ReceiveGetFieldForProductStrategyService(XmlProcessingCommonClassesService xmlProcessingCommonClassesService,
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

        // Validate XML fields and digital signature
        validateRequest(isInternal, xmlTagsMap, rrn, type);

        // Extract bank ID
        String bankId = xmlTagsMap.getOrDefault("bankId", "");

        // Update existing DB record with request fields
        updateTransactionRecordWithRequestInputs(rrn, xmlTagsMap, type);

        // Retrieve previously saved DB record
        TransactionDetails transactionDetails = xmlProcessingCommonClassesService.getSavedDbRecord(rrn, type);

        // Send request to external system and receive response
        String responseXml = xmlProcessingCommonClassesService.sendRequestAndGetResponse(transactionDetails, xmlTagsMap, bankId, requestXml, type, rrn);

        // Process and return final response
        return processResponse(transactionDetails, bankId, rrn, responseXml, type, false);
    }

    // Validates structure and signature of the request
    private void validateRequest(boolean isInternal, Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException, SignatureException {
        xmlFieldsValidatorService.validateXmlRequestFields(xmlTagsMap, type);
        transactionValidationAndMappingService.validateSignature(isInternal, xmlTagsMap, new request(), new Envelope(), rrn, type);
    }

    // Updates the DB record with the request input fields
    private void updateTransactionRecordWithRequestInputs(String rrn, Map<String, String> xmlTagsMap, String type) throws CustomException {
        TransactionDetails transactionRecord = transactionValidationAndMappingService.getDatabaseRecord(rrn, type);
        TransactionDetails entity = customMapperService.composeTransactionRecordEntity(transactionRecord, xmlTagsMap, type);

        if (entity != null) {
            xmlProcessingCommonClassesService.updateDatabaseRecord(entity, rrn, type);
        }
    }

    private String processResponse(TransactionDetails transactionDetails, String bankId, String rrn, String responseXml, String type, boolean readResponseString) throws CustomException {
        return imtCallerService.processResponse(transactionDetails, bankId, rrn, responseXml, type, readResponseString);
    }
}
