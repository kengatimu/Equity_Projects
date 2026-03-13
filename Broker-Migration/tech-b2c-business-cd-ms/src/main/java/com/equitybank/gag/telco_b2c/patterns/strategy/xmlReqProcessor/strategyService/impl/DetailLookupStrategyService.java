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

import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.IMT_REFERENCE_NUMBER_MISMATCH;

@Service("detailLookupStrategy")
public class DetailLookupStrategyService implements XmlTypeProcessingStrategyService {
    private static final Logger log = LoggerFactory.getLogger(DetailLookupStrategyService.class);

    private final XmlFieldsValidatorService xmlFieldsValidatorService;
    private final TransactionValidationAndMappingService transactionValidationAndMappingService;
    private final XmlProcessingCommonClassesService xmlProcessingCommonClassesService;
    private final ImtCallerService imtCallerService;

    public DetailLookupStrategyService(XmlFieldsValidatorService xmlFieldsValidatorService,
                                       TransactionValidationAndMappingService transactionValidationAndMappingService,
                                       XmlProcessingCommonClassesService xmlProcessingCommonClassesService,
                                       CustomMapperService customMapperService,
                                       ImtCallerService imtCallerService) {
        this.xmlFieldsValidatorService = xmlFieldsValidatorService;
        this.transactionValidationAndMappingService = transactionValidationAndMappingService;
        this.xmlProcessingCommonClassesService = xmlProcessingCommonClassesService;
        this.imtCallerService = imtCallerService;
    }

    @Override
    public String process(boolean isInternal, String requestXml, Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException, SignatureException {
        // Validate request fields and digital signature
        validateRequest(isInternal, xmlTagsMap, rrn, type);

        // Load saved transaction record
        TransactionDetails transactionDetails = getSavedDbRecord(rrn, type);

        // Validate that the reference number in request matches saved record
        verifyReferenceNumber(transactionDetails, xmlTagsMap, rrn, type);

        // Get bank ID from request map
        String bankId = xmlTagsMap.getOrDefault("bankId", "");

        // Call external service and get XML response
        String responseXml = xmlProcessingCommonClassesService.sendRequestAndGetResponse(transactionDetails, xmlTagsMap, bankId, requestXml, type, rrn);

        // Process response, update DB and return channel response
        return processResponse(transactionDetails, bankId, rrn, responseXml, type, false);
    }

    private void validateRequest(boolean isInternal, Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException, SignatureException {
        xmlFieldsValidatorService.validateXmlRequestFields(xmlTagsMap, type);
        transactionValidationAndMappingService.validateSignature(isInternal, xmlTagsMap, new request(), new Envelope(), rrn, type);
    }

    private TransactionDetails getSavedDbRecord(String rrn, String type) throws CustomException {
        return transactionValidationAndMappingService.getDatabaseRecord(rrn, type);
    }

    private void verifyReferenceNumber(TransactionDetails transactionDetails, Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException {
        String originalReferenceNumber = transactionDetails.getImtReferenceNumber();
        String requestReferenceNumber = xmlTagsMap.get("referenceNumber");
        log.info("RRN {}: Verifying IMT reference number - OriginalReferenceNumber: {}, RequestReferenceNumber: {}", rrn, originalReferenceNumber, requestReferenceNumber);
        if (!originalReferenceNumber.equalsIgnoreCase(requestReferenceNumber)) {
            throw new CustomException(IMT_REFERENCE_NUMBER_MISMATCH);
        }
    }

    private String processResponse(TransactionDetails transactionDetails, String bankId, String rrn, String responseXml, String type, boolean readResponseString) throws CustomException {
        return imtCallerService.processResponse(transactionDetails, bankId, rrn, responseXml, type, readResponseString);
    }

}
