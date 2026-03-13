package com.equitybank.gag.orange_money_ms.service;

import com.equitybank.gag.orange_money_ms.entity.TransactionDetails;
import com.equitybank.gag.orange_money_ms.exception.CustomException;

import java.util.Optional;

public interface DatabaseService {
    void confirmTransactionRecord(String rrn) throws CustomException;

    Optional<TransactionDetails> getTransactionRecord(String rrn);

    void updateTransactionRecord(TransactionDetails entity);
}
