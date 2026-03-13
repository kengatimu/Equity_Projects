package com.equitybank.gag.mtn_money_ms.service.impl;

import com.equitybank.gag.mtn_money_ms.entity.TransactionDetails;
import com.equitybank.gag.mtn_money_ms.exception.CustomException;
import com.equitybank.gag.mtn_money_ms.service.DatabaseService;
import com.equitybank.gag.mtn_money_ms.service.InitialValidatorService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

import static com.equitybank.gag.mtn_money_ms.config.StatusCodeMessages.NOT_FOUND;

@Service
public class InitialValidatorServiceImpl implements InitialValidatorService {
    private static final Logger log = LoggerFactory.getLogger(InitialValidatorServiceImpl.class);

    private final DatabaseService databaseService;

    @Autowired
    public InitialValidatorServiceImpl(DatabaseService databaseService) {
        this.databaseService = databaseService;
    }

    @Override
    public TransactionDetails getDatabaseRecord(String rrn, String type) throws CustomException {
        try {
            Optional<TransactionDetails> optionalTransactionDetails = databaseService.getTransactionRecord(rrn, type);
            if (optionalTransactionDetails.isPresent()) {
                return optionalTransactionDetails.get();
            }
            throw new CustomException(NOT_FOUND);
        } catch (CustomException e) {
            throw new CustomException(e.getMessage());
        }
    }
}
