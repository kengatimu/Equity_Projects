package com.equitybank.gag.telco_b2c.service;

import com.equitybank.gag.telco_b2c.entity.ParamConfigs;
import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.enums.RequestTypes;
import com.equitybank.gag.telco_b2c.exception.CustomException;

import java.util.Optional;

public interface DatabaseService {
    void checkTransactionRecord(String rrn, String type, String operation) throws CustomException;

    void persistInitialTransactionRecord(TransactionDetails entity);

    Optional<TransactionDetails> getTransactionRecord(String rrn, String requestType);

    Optional<ParamConfigs> getConfigRecord();

    void updateConfigRecord(String rate);

    void updateTransactionRecord(TransactionDetails entity);
}
