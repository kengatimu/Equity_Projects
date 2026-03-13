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

import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.ID_MISMATCH;
import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.PENDING_CODE;
import static com.equitybank.gag.telco_b2c.enums.TransactionStatus.PENDING;

@Service("receiveCommitTransactionStrategy")
public class ReceiveCommitTransactionStrategyService implements XmlTypeProcessingStrategyService {
    private static final Logger log = LoggerFactory.getLogger(ReceiveCommitTransactionStrategyService.class);

    private final XmlFieldsValidatorService xmlFieldsValidatorService;
    private final XmlProcessingCommonClassesService xmlProcessingCommonClassesService;
    private final ImtCommitTransactionService imtCommitTransactionService;
    private final TransactionValidationAndMappingService transactionValidationAndMappingService;
    private final CustomMapperService customMapperService;
    private final PayloadService payloadService;

    public ReceiveCommitTransactionStrategyService(XmlFieldsValidatorService xmlFieldsValidatorService,
                                                   XmlProcessingCommonClassesService xmlProcessingCommonClassesService,
                                                   ImtCommitTransactionService imtCommitTransactionService,
                                                   TransactionValidationAndMappingService transactionValidationAndMappingService,
                                                   CustomMapperService customMapperService,
                                                   PayloadService payloadService) {
        this.xmlFieldsValidatorService = xmlFieldsValidatorService;
        this.xmlProcessingCommonClassesService = xmlProcessingCommonClassesService;
        this.imtCommitTransactionService = imtCommitTransactionService;
        this.transactionValidationAndMappingService = transactionValidationAndMappingService;
        this.customMapperService = customMapperService;
        this.payloadService = payloadService;
    }

    @Override
    public String process(boolean isInternal, String requestXml, Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException, SignatureException {
        // Validate request fields and digital signature
        validateRequest(isInternal, xmlTagsMap, rrn, type);

        // Map request values into the database transaction record
        updateTransactionRecordWithRequestInputs(rrn, xmlTagsMap, type);

        // Load the existing transaction record
        TransactionDetails transactionDetails = getSavedDbRecord(rrn, type);

        // Confirm that session ID from request matches saved record
        verifyMgiTranSessionId(transactionDetails, xmlTagsMap);

        // Place the saved amount into the request map
        updateAmountToMap(transactionDetails, xmlTagsMap);

        // Continue commit processing in a background thread
        continueInANewThread(transactionDetails, requestXml, xmlTagsMap, rrn, type);

        // Return pending response to channel
        return composePendingStatusResponse(rrn);
    }

    private void validateRequest(boolean isInternal, Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException, SignatureException {
        xmlFieldsValidatorService.validateXmlRequestFields(xmlTagsMap, type);
        transactionValidationAndMappingService.validateSignature(isInternal, xmlTagsMap, new request(), new Envelope(), rrn, type);
    }

    private void updateTransactionRecordWithRequestInputs(String rrn, Map<String, String> xmlTagsMap, String type) throws CustomException {
        TransactionDetails transactionRecord = transactionValidationAndMappingService.getDatabaseRecord(rrn, type);
        TransactionDetails entity = customMapperService.composeTransactionRecordEntity(transactionRecord, xmlTagsMap, type);
        if (entity != null) {
            xmlProcessingCommonClassesService.updateDatabaseRecord(entity, rrn, type);
        }
    }

    private TransactionDetails getSavedDbRecord(String rrn, String type) throws CustomException {
        return transactionValidationAndMappingService.getDatabaseRecord(rrn, type);
    }

    // Validate that mgiTransactionSessionID in the request matches the DB record
    private void verifyMgiTranSessionId(TransactionDetails transactionDetails, Map<String, String> xmlTagsMap) throws CustomException {
        String originalSessionId = transactionDetails.getMgiTransactionSessionID();
        String incomingSessionId = xmlTagsMap.get("mgiTransactionSessionID");
        log.info("RRN {}: Comparing session ID - OriginalSessionId: {}, RequestSessionId: {}", transactionDetails.getRrn(), originalSessionId, incomingSessionId);
        if (!originalSessionId.equalsIgnoreCase(incomingSessionId)) {
            throw new CustomException(ID_MISMATCH);
        }
    }

    private void updateAmountToMap(TransactionDetails transactionDetails, Map<String, String> xmlTagsMap) {
        String originalAmount = String.valueOf(transactionDetails.getAmount());
        log.info("Saved Original Amount: {}", originalAmount);
        xmlTagsMap.put("amount", originalAmount);
    }

    private void continueInANewThread(TransactionDetails transactionDetails, String requestXml, Map<String, String> xmlTagsMap, String rrn, String type) {
        imtCommitTransactionService.processImtAsyncReceiveCommitTransactionRequest(transactionDetails, requestXml, xmlTagsMap, rrn, type);
    }

    private String composePendingStatusResponse(String rrn) {
        return payloadService.imtPendingResponseXml(rrn, PENDING_CODE, PENDING.getDescription(), PENDING);
    }
}
