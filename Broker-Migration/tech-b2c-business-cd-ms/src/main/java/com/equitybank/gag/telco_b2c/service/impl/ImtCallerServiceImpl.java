package com.equitybank.gag.telco_b2c.service.impl;

import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.exception.CustomExceptionForReversal;
import com.equitybank.gag.telco_b2c.mapper.CustomMapperService;
import com.equitybank.gag.telco_b2c.service.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.task.TaskExecutor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

import static com.equitybank.gag.telco_b2c.config.ApplicationConstants.MONEY_GRAM;
import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.DEFAULT_MONEYGRAM_FAILURE;

@Service
public class ImtCallerServiceImpl implements ImtCallerService {
    private static final Logger log = LoggerFactory.getLogger(ImtCallerServiceImpl.class);

    private final ExtractXmlFieldsService extractXmlFieldsService;
    private final TypeResolverService typeResolverService;
    private final AddExtraFieldsService addExtraFieldsService;
    private final CustomMapperService customMapperService;
    private final DebitCreditService debitCreditService;
    private final XmlReaderService xmlReaderService;
    private final DatabaseService databaseService;
    private final TaskExecutor taskExecutor;
    private final HttpService httpService;

    @Autowired
    public ImtCallerServiceImpl(ExtractXmlFieldsService extractXmlFieldsService,
                                TypeResolverService typeResolverService,
                                AddExtraFieldsService addExtraFieldsService,
                                CustomMapperService customMapperService,
                                DebitCreditService debitCreditService,
                                XmlReaderService xmlReaderService,
                                DatabaseService databaseService,
                                @Qualifier("taskExecutor") TaskExecutor taskExecutor,
                                HttpService httpService) {
        this.extractXmlFieldsService = extractXmlFieldsService;
        this.typeResolverService = typeResolverService;
        this.addExtraFieldsService = addExtraFieldsService;
        this.customMapperService = customMapperService;
        this.debitCreditService = debitCreditService;
        this.xmlReaderService = xmlReaderService;
        this.databaseService = databaseService;
        this.taskExecutor = taskExecutor;
        this.httpService = httpService;
    }

    @Override
    public String sendRequestAndGetResponse(String bankId, String requestXml, String type, String rrn) throws CustomException {
        try {
            // Add moneygram static fields.
            // This is an optional feature.
            // Comment if not needed
            String updatedRequestXml = addStaticMoneyGramFields(requestXml, type);

            // Remove the channel info
            String imtXmlReq = removeChannelInfoTagFromRequest(updatedRequestXml, type);
            return httpService.httpCall(imtXmlReq, MONEY_GRAM, rrn, type, bankId, "");
        } catch (CustomExceptionForReversal e) {
            // If a CustomExceptionForReversal is caught, perform a reversal
            debitCreditService.doReversal(rrn, type, bankId);

            // Then rethrow as CustomException
            throw new CustomException(e.getMessage());
        } catch (CustomException e) {
            throw new CustomException(e.getMessage());
        }
    }

    private String addStaticMoneyGramFields(String requestXml, String type) {
        // Define the tag name
        String tagName = switch (type) {
            case "moneygram-fee-lookup" -> "feeLookupRequest";
            case "moneygram-receive-reference-number-request" -> "referenceNumberRequest";
            case "moneygram-get-field-for-product", "moneygram-receive-get-field-for-product" ->
                    "getFieldsForProductRequest";
            case "moneygram-send-validation-request" -> "sendValidationRequest";
            case "moneygram-receive-validation-request" -> "receiveValidationRequest";
            case "moneygram-commit-transaction", "moneygram-receive-commit-transaction" -> "commitTransactionRequest";
            case "moneygram-send-reversal" -> "sendReversalRequest";
            case "moneygram-amend-transaction" -> "amendTransactionRequest";
            case "moneygram-receive-reversal" -> "receiveReversalRequest";
            case "moneygram-code-table-service" -> "codeTableRequest";
            default -> "";
        };

        // Add the static fields
        return addExtraFieldsService.addMoneygramExtraFields(requestXml, tagName);
    }

    private String removeChannelInfoTagFromRequest(String requestXml, String type) throws CustomExceptionForReversal {
        // Disable channel info removal
//        try {
//            return xmlReaderService.removeChannelInfo(requestXml, type);
//        } catch (CustomException e) {
//            throw new CustomExceptionForReversal(e.getMessage());
//        }

        return requestXml;
    }

    @Override
    public String processResponse(TransactionDetails transactionDetails, String bankId, String rrn, String responseXml, String type, boolean readResponseString) throws CustomException {
        try {
            if (responseContainsError(responseXml)) {
                handleErrorResponse(rrn, type, responseXml);
            } else {
                switch (type) {
                    // If send reversal request or receive reversal request is successful from IMT, reverse also from Finacle
                    case "moneygram-send-reversal", "moneygram-receive-reversal" ->
                            reverseFromFinacle(rrn, type, bankId);
                    case "moneygram-receive-reference-number-request" ->
                            processReferenceNumberResponse(transactionDetails, rrn, responseXml, type);
                    case "moneygram-commit-transaction", "moneygram-receive-commit-transaction" ->
                            processCommitTransactionResponse(transactionDetails, rrn, responseXml, type);
                    case "moneygram-send-validation-request" ->
                            processSendValidationResponse(transactionDetails, rrn, responseXml, type);
                    case "moneygram-detail-lookup" ->
                            processDetailsLookupResponse(transactionDetails, rrn, responseXml, type);
                    default -> processDefaultCase(transactionDetails, rrn, readResponseString, responseXml, type);
                }
            }
            return responseXml;

        } catch (CustomExceptionForReversal e) {
            // If a reversal-specific exception is caught, perform a reversal and rethrow as CustomException
            reverseFromFinacle(rrn, type, bankId);
            throw new CustomException(e.getMessage());
        } catch (CustomException e) {
            throw new CustomException(e.getMessage());
        } catch (Exception e) {
            log.error("{}: {}", rrn, e.getMessage());
            throw new CustomException(e.getMessage());
        }
    }

    private void processDetailsLookupResponse(TransactionDetails transactionDetails, String rrn, String responseXml, String type) throws CustomException {
        Map<String, String> responseDetailsMap = extractXmlFieldsService.extractResponseDetails(responseXml, type);
        log.info("{}: Fee Lookup Response Details Map: {}", rrn, responseDetailsMap);

        // Update the database with the map details
        updateDatabaseWithResponseDetails(transactionDetails, responseDetailsMap, rrn, responseXml, type);
    }

    private void processSendValidationResponse(TransactionDetails transactionDetails, String rrn, String responseXml, String type) throws CustomException {
        Map<String, String> responseDetailsMap = extractXmlFieldsService.extractResponseDetails(responseXml, type);
        log.info("{}: Send Validation Response Details Map: {}", rrn, responseDetailsMap);

        // Update the database with the map details
        updateDatabaseWithResponseDetails(transactionDetails, responseDetailsMap, rrn, responseXml, type);
    }


    private void processCommitTransactionResponse(TransactionDetails transactionDetails, String rrn, String responseXml, String type) throws CustomException {
        Map<String, String> responseDetailsMap = extractXmlFieldsService.extractResponseDetails(responseXml, type);
        log.info("{}: Send Commit Response Details Map: {}", rrn, responseDetailsMap);

        // Update the database with the map details
        updateDatabaseWithResponseDetails(transactionDetails, responseDetailsMap, rrn, responseXml, type);
    }

    private void processReferenceNumberResponse(TransactionDetails transactionDetails, String rrn, String responseXml, String type) throws CustomException {
        Map<String, String> responseDetailsMap = extractXmlFieldsService.extractResponseDetails(responseXml, type);

        // Update the database with the map details
        updateDatabaseWithResponseDetails(transactionDetails, responseDetailsMap, rrn, responseXml, type);
    }

    private void processDefaultCase(TransactionDetails transactionDetails, String rrn, boolean readResponseString, String responseXml, String type) throws CustomException {
        if (typeResolverService.isNonReversalType(type)) {
            // Only extract response details if a transaction ID is present
            Map<String, String> responseDetailsMap = readResponseString ? extractXmlFieldsService.extractResponseDetails(responseXml, type) : new HashMap<>();

            // Update the database with the success response
            updateDatabaseWithResponseDetails(transactionDetails, responseDetailsMap, rrn, responseXml, type);
        }
    }

    private void reverseFromFinacle(String rrn, String type, String bankId) {
        debitCreditService.doReversal(rrn, type, bankId);
    }

    private boolean responseContainsError(String responseXml) {
        return responseXml.contains("Fault") && responseXml.contains("errorCode");
    }

    private void handleErrorResponse(String rrn, String type, String responseXml) throws CustomExceptionForReversal, CustomException {
        Map<String, String> responseDetailsMap = extractXmlFieldsService.extractResponseDetails(responseXml, "exception");
        String errorCode = responseDetailsMap.get("errorCode");
        String errorDescription = responseDetailsMap.get("errorDescription");
        log.error("{}: Received Error From Moneygram. ErrorCode: {}, ErrorDesc: {}", rrn, errorCode, errorDescription);

        // Handle exceptions that don't require transaction reversal.
        // At this stage, not dr/cr has been done for moneygram-receive-commit-transaction
        if (typeResolverService.isNonReversalType(type) || "moneygram-receive-commit-transaction".equals(type)) {
            throw new CustomException(String.format("%s%s", DEFAULT_MONEYGRAM_FAILURE, errorDescription));
        }
        // Handle other exceptions that require transaction reversal
        throw new CustomExceptionForReversal(String.format("%s%s", DEFAULT_MONEYGRAM_FAILURE, errorDescription));
    }

    private void updateDatabaseWithResponseDetails(TransactionDetails transactionDetails, Map<String, String> responseDetailsMap, String rrn, String responseXml, String type) throws CustomException {
        TransactionDetails entity = customMapperService.composeImtSuccessResponseEntity(transactionDetails, responseDetailsMap, responseXml, rrn, type);
        if (entity != null) {
            updateDatabase(entity, rrn, type);
        }
    }

    // This will update the database in async (background thread). Therefore, not need for @Transaction annotation
    private void updateDatabase(TransactionDetails entity, String rrn, String type) {
        taskExecutor.execute(() -> {
            if (entity != null) {
                log.info("{}: Saving {} entity record", rrn, type);
                databaseService.updateTransactionRecord(entity);
            } else {
                log.warn("{}: Could not save {} entity record in database. Entity is null", rrn, type);
            }
        });
    }
}
