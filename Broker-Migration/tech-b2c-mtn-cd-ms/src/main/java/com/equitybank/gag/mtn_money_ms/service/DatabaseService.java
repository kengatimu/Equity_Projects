package com.equitybank.gag.mtn_money_ms.service;

import com.equitybank.gag.mtn_money_ms.entity.TransactionDetails;

import java.util.Optional;

public interface DatabaseService {

    Optional<TransactionDetails> getTransactionRecord(String rrn, String requestType);

    void updateTransactionRecord(TransactionDetails entity);
}
