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

import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.*;

@Service("imtReceiveReversalStrategy")
public class ImtReceiveReversalStrategyService implements XmlTypeProcessingStrategyService {
    private static final Logger log = LoggerFactory.getLogger(ImtReceiveReversalStrategyService.class);

    private final XmlFieldsValidatorService xmlFieldsValidatorService;
    private final TransactionValidationAndMappingService transactionValidationAndMappingService;
    private final XmlProcessingCommonClassesService xmlProcessingCommonClassesService;
    private final ImtCallerService imtCallerService;

    public ImtReceiveReversalStrategyService(XmlFieldsValidatorService xmlFieldsValidatorService,
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
        // Extract bank ID from request
        String bankId = xmlTagsMap.get("bankId");

        // Validate field structure and signature
        validateRequest(isInternal, xmlTagsMap, rrn, type);

        // Load saved transaction details
        // TODO: Check this logic, Verify if a transaction record exists in the database for the given RRN
        TransactionDetails transactionDetails = getSavedDbRecord(rrn, type);

        // Confirm reference number matches
        verifyReferenceNumber(transactionDetails, xmlTagsMap, rrn);

        // Confirm reversal amount is valid
        verifyReceiveReversalAmount(xmlTagsMap, rrn, type);

        // Send reversal request externally and get response
        String responseXml = xmlProcessingCommonClassesService.sendRequestAndGetResponse(transactionDetails, xmlTagsMap, bankId, requestXml, type, rrn);

        // Return processed channel response
        return processResponse(transactionDetails, bankId, rrn, responseXml, type, false);
    }

    private void validateRequest(boolean isInternal, Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException, SignatureException {
        xmlFieldsValidatorService.validateXmlRequestFields(xmlTagsMap, type);
        transactionValidationAndMappingService.validateSignature(isInternal, xmlTagsMap, new request(), new Envelope(), rrn, type);
    }

    private TransactionDetails getSavedDbRecord(String rrn, String type) throws CustomException {
        return transactionValidationAndMappingService.getDatabaseRecord(rrn, type);
    }

    private void verifyReferenceNumber(TransactionDetails transactionDetails, Map<String, String> xmlTagsMap, String rrn) throws CustomException {
        String originalReferenceNumber = transactionDetails.getImtReferenceNumber();
        String incomingRef = xmlTagsMap.get("referenceNumber");
        log.info("RRN {}: Comparing reference number - OriginalReferenceNumber: {}, RequestReferenceNumber: {}", rrn, originalReferenceNumber, incomingRef);
        if (!originalReferenceNumber.equalsIgnoreCase(incomingRef)) {
            throw new CustomException(IMT_REFERENCE_NUMBER_MISMATCH);
        }
    }

    private void verifyReceiveReversalAmount(Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException {
        String originalAmount = String.valueOf(getSavedDbRecord(rrn, type).getAmount());
        log.info("Saved Original receiveAmount: " + originalAmount);
        if (!originalAmount.equalsIgnoreCase(xmlTagsMap.get("receiveAmount"))) {
            throw new CustomException(AMOUNT_MISMATCH);
        }
    }

    private String processResponse(TransactionDetails transactionDetails, String bankId, String rrn, String responseXml, String type, boolean readResponseString) throws CustomException {
        return imtCallerService.processResponse(transactionDetails, bankId, rrn, responseXml, type, readResponseString);
    }
}
