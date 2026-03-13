package com.equitybank.gag.orange_money_ms.service;

import com.equitybank.gag.orange_money_ms.exception.CustomException;

public interface HttpTransactionRequestService {
    String transactionRequestHttpCall(String requestBody, String rrn) throws CustomException;
}
