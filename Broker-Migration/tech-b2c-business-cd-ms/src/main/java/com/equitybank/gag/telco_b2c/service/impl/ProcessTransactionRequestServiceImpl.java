package com.equitybank.gag.telco_b2c.service.impl;

import com.equitybank.gag.telco_b2c.dto.thunes.transfer.transaction.TransactionRequestDto;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.service.ProcessTransactionRequestService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ProcessTransactionRequestServiceImpl implements ProcessTransactionRequestService {
    private static final Logger log = LoggerFactory.getLogger(ProcessTransactionRequestServiceImpl.class);

    @Override
    public String processSendTransactionRequest(TransactionRequestDto transactionRequestDto) throws CustomException {
        return null;
    }
}
