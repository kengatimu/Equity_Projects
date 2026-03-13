package com.equitybank.gag.telco_b2c.service;

import com.equitybank.gag.telco_b2c.entity.TransactionDetails;

import java.util.Map;

public interface ImtCommitTransactionService {
    void processImtAsyncCommitTransactionRequest(TransactionDetails transactionDetails, String requestXml, Map<String, String> xmlTagsMap, String rrn, String type);

    void processImtAsyncReceiveCommitTransactionRequest(TransactionDetails transactionDetails, String requestXml, Map<String, String> xmlTagsMap, String rrn, String type);
}
