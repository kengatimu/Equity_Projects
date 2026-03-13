package com.equitybank.gag.mtn_money_ms.service;

import com.equitybank.gag.mtn_money_ms.entity.TransactionDetails;
import com.equitybank.gag.mtn_money_ms.exception.CustomException;

public interface InitialValidatorService {
    TransactionDetails getDatabaseRecord(String rrn, String type) throws CustomException;
}
