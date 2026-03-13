package com.equitybank.gag.papss.its.service;

import com.equitybank.gag.papss.its.entity.TransactionMaster;
import com.equitybank.gag.papss.its.enums.TransactionType;
import com.equitybank.gag.papss.its.exception.CustomException;

public interface DatabaseService {
    void checkTransactionExists(String rrn, TransactionType type) throws CustomException;

    void saveInitialCreditTransferEntity(String rrn, TransactionMaster entity) throws CustomException;

    TransactionMaster getSavedRecord(String rrn, TransactionType type) throws CustomException;

    void updateDbRecord(TransactionMaster entity);
}
