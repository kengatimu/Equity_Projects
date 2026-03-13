package com.equitybank.gag.mtn_money_ms.mapper;


import com.equitybank.gag.mtn_money_ms.entity.TransactionDetails;
import com.equitybank.gag.mtn_money_ms.service.DatabaseService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.util.Optional;

@Service
public class CustomMapperServiceImpl implements CustomMapperService {
    private static final Logger log = LoggerFactory.getLogger(CustomMapperServiceImpl.class);

    private final DatabaseService databaseService;

    @Autowired
    public CustomMapperServiceImpl(DatabaseService databaseService) {
        this.databaseService = databaseService;
    }

    @Override
    public TransactionDetails composeEntityForSuccessResponseUpdate(String xmlResponse, Map<String, String> extractedTelcoResponseMap, String rrn, String type) {
        String tranType = "floatPurchase-status".equalsIgnoreCase(type) ? "floatPurchase" : type;

        Optional<TransactionDetails> optionalTransactionDetails = getTransactionDetails(rrn, tranType);
        String status;
        String statusCode;
        String statusMessage;

        // Determine status and messages
        if ("floatpurchase".equalsIgnoreCase(type)) {
            status = "OK";
            statusCode = "00";
            statusMessage = "SUCCESS";
        } else {
            status = extractedTelcoResponseMap.get("status");
            switch (status.toUpperCase()) {
                case "SUCCESSFUL" -> {
                    status = "OK";
                    statusCode = "00";
                    statusMessage = "SUCCESS";
                }
                case "PENDING" -> {
                    statusCode = "001";
                    statusMessage = "Transaction in PENDING status from Telco";
                }
                default -> {
                    statusCode = "01";
                    statusMessage = "Transaction in FAILED status from Telco";
                }
            }
        }

        if (optionalTransactionDetails.isPresent()) {
            TransactionDetails transactionDetails = optionalTransactionDetails.get();

            // Set status details
            transactionDetails.getStatusDetails().setStatus(status);
            transactionDetails.getStatusDetails().setStatusCode(statusCode);
            transactionDetails.getStatusDetails().setStatusMessage(statusMessage);
            transactionDetails.getStatusDetails().setTranId(extractedTelcoResponseMap.get("financialtransactionid"));

            // Set payload details
            transactionDetails.getPayloadDetails().setTelcoResponse(xmlResponse);
            return transactionDetails;
        }
        return null;
    }

    @Override
    public TransactionDetails composeEntityForErrorResponseUpdate(String xmlResponse, String rrn, String errorCode, String errorDescription, String status, String type) {
        Optional<TransactionDetails> optionalTransactionDetails = getTransactionDetails(rrn, type);
        if (optionalTransactionDetails.isPresent()) {
            TransactionDetails transactionDetails = optionalTransactionDetails.get();

            // Set status details
            transactionDetails.getStatusDetails().setStatus(status);
            transactionDetails.getStatusDetails().setStatusCode(errorCode);
            transactionDetails.getStatusDetails().setStatusMessage(errorDescription);

            // Set payload details
            transactionDetails.getPayloadDetails().setChannelResponse(xmlResponse);
            return transactionDetails;
        }
        return null;
    }

    private Optional<TransactionDetails> getTransactionDetails(String rrn, String type) {
        return databaseService.getTransactionRecord(rrn, type);
    }
}
