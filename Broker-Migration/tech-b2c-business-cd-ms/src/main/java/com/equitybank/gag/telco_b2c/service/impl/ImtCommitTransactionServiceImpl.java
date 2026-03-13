package com.equitybank.gag.telco_b2c.service.impl;

import com.equitybank.gag.telco_b2c.dto.airtime.request.Envelope;
import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.exception.GlobalExceptionHandler;
import com.equitybank.gag.telco_b2c.service.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class ImtCommitTransactionServiceImpl implements ImtCommitTransactionService {
    private static final Logger log = LoggerFactory.getLogger(ImtCommitTransactionServiceImpl.class);

    private final ExtractXmlFieldsService extractXmlFieldsService;
    private final TransactionValidationAndMappingService transactionValidationAndMappingService;
    private final GlobalExceptionHandler globalExceptionHandler;
    private final DebitCreditService debitCreditService;
    private final ImtCallerService imtCallerService;
    private final PayloadService payloadService;
    private final HttpService httpService;

    @Autowired
    public ImtCommitTransactionServiceImpl(ExtractXmlFieldsService extractXmlFieldsService,
                                           TransactionValidationAndMappingService transactionValidationAndMappingService,
                                           GlobalExceptionHandler globalExceptionHandler,
                                           DebitCreditService debitCreditService,
                                           ImtCallerService imtCallerService,
                                           PayloadService payloadService,
                                           HttpService httpService) {
        this.extractXmlFieldsService = extractXmlFieldsService;
        this.transactionValidationAndMappingService = transactionValidationAndMappingService;
        this.globalExceptionHandler = globalExceptionHandler;
        this.debitCreditService = debitCreditService;
        this.imtCallerService = imtCallerService;
        this.payloadService = payloadService;
        this.httpService = httpService;
    }


    @Override
    public void processImtAsyncCommitTransactionRequest(TransactionDetails transactionDetails, String requestXml, Map<String, String> xmlTagsMap, String rrn, String type) {
        try {
            // Get the bankId
            String bankId = xmlTagsMap.get("bankId");

            // Check if debit credit is enabled
            boolean debitCreditEnabled = checkDebitCreditEnabled(type);

            // Call service for debit credit
            callDebitCreditService(transactionDetails, bankId, debitCreditEnabled, new request(), new Envelope(), xmlTagsMap, rrn, type);

            // Send the request to the external service and receive the XML response
            String responseXml = sendRequestAndGetResponse(bankId, requestXml, type, rrn);
            log.info("{}: Transaction Processed Successfully. Commit Transaction Response: \n{}", rrn, responseXml);

            // Get the current state of the record
            transactionDetails = getSavedDbRecord(rrn, type);

            // Process the received response, updating the database as needed
            processResponse(transactionDetails, bankId, rrn, responseXml, type);

            // Create success response xml
            String channelResponseXml = createChannelSuccessResponseXml(rrn, responseXml, type);

            // Send success callback to channel
            sendSuccessCallbackToChannel(rrn, channelResponseXml, type);

        } catch (CustomException e) {
            log.error("{}: Exception Occurred In Async Thread: {}", rrn, e.getMessage());

            // Send failure callback response to the channel via global exception class
            sendCallbackToChannel(e, xmlTagsMap, type);
        }
    }

    @Override
    public void processImtAsyncReceiveCommitTransactionRequest(TransactionDetails transactionDetails, String requestXml, Map<String, String> xmlTagsMap, String rrn, String type) {
        try {
            // Get the bankId
            String bankId = xmlTagsMap.get("bankId");

            // TODO: Check if receiver account is valid in finacle: Only send to MG when the account is valid

            // Send the request to the moneygram and receive the XML response
            String responseXml = sendRequestAndGetResponse(bankId, requestXml, type, rrn);
            log.info("{}: Transaction Processed Successfully. Commit Transaction Response: \n{}", rrn, responseXml);

            // Get the current state of the record
            transactionDetails = getSavedDbRecord(rrn, type);

            // Process the received response, updating the database as needed
            processResponse(transactionDetails, bankId, rrn, responseXml, type);

            // Check if debit credit is enabled
            boolean debitCreditEnabled = checkDebitCreditEnabled(type);

            // Call service for debit credit
            callDebitCreditService(transactionDetails, bankId, debitCreditEnabled, new request(), new Envelope(), xmlTagsMap, rrn, type);

            // Create success response xml
            String channelResponseXml = createChannelSuccessResponseXml(rrn, responseXml, type);

            // Send success callback to channel
            sendSuccessCallbackToChannel(rrn, channelResponseXml, type);

        } catch (CustomException e) {
            log.error("{}: Exception Occurred In Async Thread: {}", rrn, e.getMessage());

            // Send failure callback response to the channel via global exception class
            sendCallbackToChannel(e, xmlTagsMap, type);
        }
    }

    private String createChannelSuccessResponseXml(String rrn, String responseXml, String type) {
        Map<String, String> responseDetailsMap = extractXmlFieldsService.extractResponseDetails(responseXml, type);
        return payloadService.imtFinalSuccessResponseXml(rrn, responseDetailsMap);
    }

    private void sendSuccessCallbackToChannel(String rrn, String responseXml, String type) throws CustomException {
        try {
            // Get channel details
            TransactionDetails transactionDetails = getSavedDbRecord(rrn, type);
            String callbackUrl = transactionDetails.getCallback().getCallbackUrl();

            // Log response xml to console and return it to channel
            log.info("{}: Sending Callback To Channel With Success Commit Response: \n{}", rrn, responseXml);
            httpService.callbackHttpCall(callbackUrl, responseXml, rrn, type);

        } catch (CustomException e) {
            throw new CustomException(e.getMessage());
        }
    }

    private TransactionDetails getSavedDbRecord(String rrn, String type) throws CustomException {
        return transactionValidationAndMappingService.getDatabaseRecord(rrn, type);
    }

    private void sendCallbackToChannel(CustomException e, Map<String, String> xmlTagsMap, String type) {
        globalExceptionHandler.handleCustomCallbackException(e, xmlTagsMap, type);
    }

    private boolean checkDebitCreditEnabled(String type) {
        return debitCreditService.checkDebitCreditEnable(type);
    }

    private void callDebitCreditService(TransactionDetails transactionDetails, String bankId, boolean debitCreditEnabled, request request, Envelope airtimeRequest, Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException {
        log.info("debitCreditEnabled {}", debitCreditEnabled);
        try {
            if (!debitCreditEnabled) {
                return;
            }
            debitCreditService.doDebitCredit(transactionDetails, bankId, request, airtimeRequest, xmlTagsMap, rrn, type);
        } catch (CustomException e) {
            throw new CustomException(e.getMessage());
        }
    }

    private String sendRequestAndGetResponse(String bankId, String requestXml, String type, String rrn) throws CustomException {
        return imtCallerService.sendRequestAndGetResponse(bankId, requestXml, type, rrn);
    }

    private void processResponse(TransactionDetails transactionDetails, String bankId, String rrn, String responseXml, String type) throws CustomException {
        imtCallerService.processResponse(transactionDetails, bankId, rrn, responseXml, type, false);
    }
}
