package com.equitybank.gag.papss.ots.service;

import com.equitybank.gag.papss.ots.entity.TransactionMaster;
import com.equitybank.gag.papss.ots.enums.TransactionType;
import com.equitybank.gag.papss.ots.exception.CustomException;

public interface DatabaseService {
    void checkTransactionExists(String rrn, TransactionType type) throws CustomException;

    void saveInitialCreditTransferEntity(String rrn, TransactionMaster entity) throws CustomException;

    TransactionMaster getSavedRecord(String rrn, TransactionType type) throws CustomException;

    void updateDbRecord(TransactionMaster entity);
}
