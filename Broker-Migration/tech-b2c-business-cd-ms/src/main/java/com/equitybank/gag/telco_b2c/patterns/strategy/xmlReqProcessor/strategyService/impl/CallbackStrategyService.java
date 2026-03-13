package com.equitybank.gag.telco_b2c.patterns.strategy.xmlReqProcessor.strategyService.impl;

import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.patterns.strategy.xmlReqProcessor.strategyService.XmlTypeProcessingStrategyService;
import com.equitybank.gag.telco_b2c.service.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.security.SignatureException;
import java.util.Map;

@Service("callbackStrategy")
public class CallbackStrategyService implements XmlTypeProcessingStrategyService {
    private static final Logger log = LoggerFactory.getLogger(CallbackStrategyService.class);

    private final TransactionValidationAndMappingService transactionValidationAndMappingService;
    private final DebitCreditService debitCreditService;
    private final PayloadService payloadService;
    private final HttpService httpService;

    public CallbackStrategyService(TransactionValidationAndMappingService transactionValidationAndMappingService,
                                   DebitCreditService debitCreditService, PayloadService payloadService,
                                   HttpService httpService) {
        this.transactionValidationAndMappingService = transactionValidationAndMappingService;
        this.debitCreditService = debitCreditService;
        this.payloadService = payloadService;
        this.httpService = httpService;
    }

    @Override
    public String process(boolean isInternal, String requestXml, Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException, SignatureException {
        // For db access, default type to moneygram-commit-transaction
        type = "moneygram-commit-transaction";

        // Load existing transaction record from DB
        TransactionDetails transactionDetails = getSavedDbRecord(rrn, type);

        // Extract callback URL and bank ID
        String callbackUrl = transactionDetails.getCallback().getCallbackUrl();
        String bankId = transactionDetails.getBankId();

        // Send callback to external system
        return processCallback(bankId, xmlTagsMap, callbackUrl, requestXml, rrn, type);
    }

    private TransactionDetails getSavedDbRecord(String rrn, String type) throws CustomException {
        return transactionValidationAndMappingService.getDatabaseRecord(rrn, type);
    }

    private String processCallback(String bankId, Map<String, String> xmlTagsMap, String callbackUrl, String requestXml, String rrn, String type) {
        // Get final status
        String status = xmlTagsMap.get("status").toUpperCase();

        // Reverse transaction if Error
        if ("ERROR".contains(status)) {
            log.info("RRN {}: Reversing transaction due to ERROR status", rrn);
            debitCreditService.doReversal(rrn, type, bankId);
        }
        // Call channel with callback response
        httpService.callbackHttpCall(callbackUrl, requestXml, rrn, type);

        // Return response to technical service
        return payloadService.technicalServiceCallBackResponse(rrn);
    }
}
