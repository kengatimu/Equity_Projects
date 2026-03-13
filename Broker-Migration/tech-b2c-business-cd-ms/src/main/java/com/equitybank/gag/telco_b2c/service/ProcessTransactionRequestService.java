package com.equitybank.gag.telco_b2c.service;

import com.equitybank.gag.telco_b2c.dto.thunes.transfer.transaction.TransactionRequestDto;
import com.equitybank.gag.telco_b2c.exception.CustomException;

public interface ProcessTransactionRequestService {
    String processSendTransactionRequest(TransactionRequestDto transactionRequestDto) throws CustomException;
}
