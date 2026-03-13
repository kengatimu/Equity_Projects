package com.equitybank.gag.orange_money_ms.service;

import com.equitybank.gag.orange_money_ms.exception.CustomException;

public interface HttpStatusCheckService {
    String getTransactionFinalStatus(String telcoReferenceNumber, String rrn) throws CustomException;
}
