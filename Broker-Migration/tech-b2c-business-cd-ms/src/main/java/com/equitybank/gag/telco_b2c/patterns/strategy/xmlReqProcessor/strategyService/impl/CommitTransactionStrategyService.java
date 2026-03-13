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
import org.springframework.core.task.TaskExecutor;
import org.springframework.stereotype.Service;

import java.security.SignatureException;
import java.util.Map;

import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.ID_MISMATCH;
import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.PENDING_CODE;
import static com.equitybank.gag.telco_b2c.enums.TransactionStatus.PENDING;

@Service("commitTransactionStrategy")
public class CommitTransactionStrategyService implements XmlTypeProcessingStrategyService {

    private static final Logger log = LoggerFactory.getLogger(CommitTransactionStrategyService.class);

    private final XmlFieldsValidatorService xmlFieldsValidatorService;
    private final XmlProcessingCommonClassesService xmlProcessingCommonClassesService;
    private final TransactionValidationAndMappingService transactionValidationAndMappingService;
    private final ImtCommitTransactionService imtCommitTransactionService;
    private final CustomMapperService customMapperService;
    private final TaskExecutor taskExecutor;
    private final PayloadService payloadService;

    public CommitTransactionStrategyService(XmlFieldsValidatorService xmlFieldsValidatorService,
                                            XmlProcessingCommonClassesService xmlProcessingCommonClassesService,
                                            TransactionValidationAndMappingService transactionValidationAndMappingService,
                                            ImtCommitTransactionService imtCommitTransactionService,
                                            CustomMapperService customMapperService,
                                            TaskExecutor taskExecutor,
                                            PayloadService payloadService) {
        this.xmlFieldsValidatorService = xmlFieldsValidatorService;
        this.xmlProcessingCommonClassesService = xmlProcessingCommonClassesService;
        this.transactionValidationAndMappingService = transactionValidationAndMappingService;
        this.imtCommitTransactionService = imtCommitTransactionService;
        this.customMapperService = customMapperService;
        this.taskExecutor = taskExecutor;
        this.payloadService = payloadService;
    }

    @Override
    public String process(boolean isInternal, String requestXml, Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException, SignatureException {
        // Validate signature and mandatory fields
        validateRequest(isInternal, xmlTagsMap, rrn, type);

        // Update DB with new fields from the request
        updateTransactionRecordWithRequestInputs(rrn, xmlTagsMap, type);

        // Get DB record for the given RRN and type
        TransactionDetails transactionDetails = getSavedDbRecord(rrn, type);

        // Validate MGI Transaction Session ID
        verifyMgiTranSessionId(transactionDetails, xmlTagsMap);

        // Add amount to xmlTagsMap for downstream processing
        updateAmountToMap(transactionDetails, xmlTagsMap);

        // Add reference number and receiver name to xmlTagsMap
        updateImtReferenceToMap(transactionDetails, xmlTagsMap);

        // Continue async commit processing in a new thread
        continueInANewThread(transactionDetails, requestXml, xmlTagsMap, rrn, type);

        // Return pending response to channel
        return composePendingStatusResponse(rrn);
    }

    private TransactionDetails getSavedDbRecord(String rrn, String type) throws CustomException {
        return transactionValidationAndMappingService.getDatabaseRecord(rrn, type);
    }

    // Validates structure and signature of the request
    private void validateRequest(boolean isInternal, Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException, SignatureException {
        xmlFieldsValidatorService.validateXmlRequestFields(xmlTagsMap, type);
        transactionValidationAndMappingService.validateSignature(isInternal, xmlTagsMap, new request(), new Envelope(), rrn, type);
    }

    // Update DB with the request field changes
    private void updateTransactionRecordWithRequestInputs(String rrn, Map<String, String> xmlTagsMap, String type) throws CustomException {
        TransactionDetails record = transactionValidationAndMappingService.getDatabaseRecord(rrn, type);
        TransactionDetails entity = customMapperService.composeTransactionRecordEntity(record, xmlTagsMap, type);
        if (entity != null) {
            xmlProcessingCommonClassesService.updateDatabaseRecord(entity, rrn, type);
        }
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

    // Add amount from DB to the xmlTagsMap
    private void updateAmountToMap(TransactionDetails transactionDetails, Map<String, String> xmlTagsMap) throws CustomException {
        String originalAmountWithFees = String.valueOf(transactionDetails.getAmount());
        log.info("Saved Original Amount " + originalAmountWithFees);
        xmlTagsMap.put("amount", originalAmountWithFees);
    }

    // Add IMT reference number and receiver name to the xmlTagsMap
    private void updateImtReferenceToMap(TransactionDetails transactionDetails, Map<String, String> xmlTagsMap) {
        String originalImtReferenceNumber = transactionDetails.getImtReferenceNumber();
        String receiverName = transactionDetails.getReceiverName();
        log.info("RRN {}: Setting IMT reference {} and receiver name {} to map", transactionDetails.getRrn(), originalImtReferenceNumber, receiverName);
        xmlTagsMap.put("imtReferenceNumber", originalImtReferenceNumber);
        xmlTagsMap.put("receiverName", receiverName);
    }

    // Async thread to process the commit transaction
    private void continueInANewThread(TransactionDetails transactionDetails, String requestXml, Map<String, String> xmlTagsMap, String rrn, String type) {
        taskExecutor.execute(() -> {
            log.info("RRN {}: Starting async commit transaction thread for {}", rrn, type);
            imtCommitTransactionService.processImtAsyncCommitTransactionRequest(transactionDetails, requestXml, xmlTagsMap, rrn, type);
        });
    }

    // Compose a standard pending response to return to channel
    private String composePendingStatusResponse(String rrn) {
        return payloadService.imtPendingResponseXml(rrn, PENDING_CODE, PENDING.getDescription(), PENDING);
    }
}
