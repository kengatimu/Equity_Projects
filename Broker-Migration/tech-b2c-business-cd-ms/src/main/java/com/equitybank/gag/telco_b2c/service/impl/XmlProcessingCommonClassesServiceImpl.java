package com.equitybank.gag.telco_b2c.service.impl;

import com.equitybank.gag.telco_b2c.dto.airtime.request.Envelope;
import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.exception.CustomExceptionForReversal;
import com.equitybank.gag.telco_b2c.service.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.task.TaskExecutor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.SignatureException;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.DEFAULT_PROCESSING_FAILURE;

@Service
public class XmlProcessingCommonClassesServiceImpl implements XmlProcessingCommonClassesService {
    private static final Logger log = LoggerFactory.getLogger(XmlProcessingCommonClassesServiceImpl.class);

    private final TaskExecutor taskExecutor;
    private final TransactionValidationAndMappingService transactionValidationAndMappingService;
    private final XmlFieldsValidatorService xmlFieldsValidatorService;
    private final ImtCallerService imtCallerService;
    private final DatabaseService databaseService;
    private final PayloadService payloadService;
    private final HttpService httpService;


    public XmlProcessingCommonClassesServiceImpl(@Qualifier("taskExecutor") TaskExecutor taskExecutor,
                                                 TransactionValidationAndMappingService transactionValidationAndMappingService,
                                                 XmlFieldsValidatorService xmlFieldsValidatorService,
                                                 ImtCallerService imtCallerService,
                                                 DatabaseService databaseService,
                                                 PayloadService payloadService,
                                                 HttpService httpService) {
        this.taskExecutor = taskExecutor;
        this.transactionValidationAndMappingService = transactionValidationAndMappingService;
        this.xmlFieldsValidatorService = xmlFieldsValidatorService;
        this.imtCallerService = imtCallerService;
        this.databaseService = databaseService;
        this.payloadService = payloadService;
        this.httpService = httpService;
    }

    @Override
    @Transactional(readOnly = true)
    public void checkForDuplicateRecord(String rrn, String type) throws CustomException {
        transactionValidationAndMappingService.checkForDatabaseRecord(rrn, type, "duplicate-check");
    }

    @Override
    public void validateRequest(boolean isInternal, Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException, SignatureException {
        xmlFieldsValidatorService.validateXmlRequestFields(xmlTagsMap, type);
        transactionValidationAndMappingService.validateSignature(isInternal, xmlTagsMap, new request(), new Envelope(), rrn, type);
    }

    @Override
    public TransactionDetails getSavedDbRecord(String rrn, String type) throws CustomException {
        return transactionValidationAndMappingService.getDatabaseRecord(rrn, type);
    }

    // This will update the database in async (background thread). Therefore, not need for @Transaction annotation
    @Override
    public void updateDatabaseAsync(TransactionDetails entity, String rrn, String type) {
        taskExecutor.execute(() -> {
            if (entity != null) {
                log.info("{}: Saving {} entity record", rrn, type);
                databaseService.updateTransactionRecord(entity);
            } else {
                log.warn("{}: Could not save {} entity record in database. Entity is null", rrn, type);
            }
        });
    }

    // To avoid stale db update errors use this
    @Override
    public void updateDatabaseRecord(TransactionDetails entity, String rrn, String type) {
        if (entity != null) {
            log.info("{}: Saving {} entity record", rrn, type);
            databaseService.updateTransactionRecord(entity);
        } else {
            log.warn("{}: Could not save {} entity record in database. Entity is null", rrn, type);
        }
    }

    @Override
    public String sendRequestAndGetResponse(TransactionDetails transactionDetails, Map<String, String> xmlTagsMap, String bankId, String requestXml, String type, String rrn) throws CustomException {
        try {
            // Send Moneygram requests
            if (type.toLowerCase().contains("moneygram")) {
                return imtCallerService.sendRequestAndGetResponse(bankId, requestXml, type, rrn);
            }

            // Get the telco name
            String telco = Optional.ofNullable(xmlTagsMap.get("telcom"))
                    .or(() -> Optional.ofNullable(xmlTagsMap.get("telco")))
                    .orElseThrow(() -> new CustomException(DEFAULT_PROCESSING_FAILURE + "Missing telco information"));
            String telcoUpper = telco.toUpperCase();

            // Define supported telcos for status check
            List<String> supportedTelcos = List.of("MTN", "AIRTEL", "VODACOM", "ORANGE");
            boolean isSupported = false;
            for (String supportedTelco : supportedTelcos) {
                if (telcoUpper.contains(supportedTelco)) {
                    isSupported = true;
                    break;
                }
            }

            // Handle unsupported status-check request
            boolean isStatusCheck = type.toLowerCase().contains("status-check");
            if (isStatusCheck && !isSupported) {
                log.info("{}: Status Check Service For The Provided Telco: {} Is Not Available. Returning DB Details", rrn, telcoUpper);
                return payloadService.composeStatusCheckResponse(transactionDetails, rrn);
            }

            // Get the channel id inorder to handle finacle reversals later
            String channelId = xmlTagsMap.getOrDefault("channel", "");

            // Route the request based on type
            return isStatusCheck || isNameCheckType(type)
                    ? httpService.httpCall(requestXml, telco, rrn, type, bankId, channelId)
                    : imtCallerService.sendRequestAndGetResponse(bankId, requestXml, type, rrn);
        } catch (CustomExceptionForReversal | CustomException e) {
            throw new CustomException(e.getMessage());
        }
    }

    private boolean isNameCheckType(String type) {
        return List.of("bank-to-wallet-namecheck", "airtime-topup-namecheck", "float-purchase-namecheck").contains(type);

    }
}
