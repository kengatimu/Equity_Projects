package com.equitybank.gag.orange_money_ms.service.impl;

import com.equitybank.gag.orange_money_ms.entity.TransactionDetails;
import com.equitybank.gag.orange_money_ms.exception.CustomException;
import com.equitybank.gag.orange_money_ms.repository.TransactionDetailsRepository;
import com.equitybank.gag.orange_money_ms.service.DatabaseService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;
import java.util.concurrent.Executor;

import static com.equitybank.gag.orange_money_ms.config.StatusCodeMessages.NOT_FOUND;

@Service
public class DatabaseServiceImpl implements DatabaseService {
    private static final Logger log = LoggerFactory.getLogger(DatabaseServiceImpl.class);


    private final TransactionDetailsRepository transactionDetailsRepository;
    private final Executor executor;

    @Autowired
    public DatabaseServiceImpl(@Lazy TransactionDetailsRepository transactionDetailsRepository,
                               @Qualifier("taskExecutor") Executor executor) {
        this.transactionDetailsRepository = transactionDetailsRepository;
        this.executor = executor;
    }

    @Override
    @Transactional(readOnly = true)
    public void confirmTransactionRecord(String rrn) throws CustomException {
        Optional<TransactionDetails> optionalTransaction = transactionDetailsRepository.findByRrn(rrn);
        if (optionalTransaction.isEmpty()) {
            throw new CustomException(NOT_FOUND);
        }
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<TransactionDetails> getTransactionRecord(String rrn) {
        Optional<TransactionDetails> optionalTransaction = transactionDetailsRepository.findByRrn(rrn);
        if (optionalTransaction.isPresent()) {
            return optionalTransaction;
        }
        log.info("Transaction With RRN: {} Does Not Exists", rrn);
        return Optional.empty();
    }

    @Override
    @Transactional
    public void updateTransactionRecord(TransactionDetails entity) {
        String rrn = entity.getRrn();
        executor.execute(() ->
        {
            try {
                transactionDetailsRepository.save(entity);
                log.info("Transaction with rrn: {} updated successfully.", rrn);
            } catch (Exception e) {
                log.error("{}: Failed to update transaction record. Exception occurred: {}", rrn, e.getMessage());
            }
        });
    }
}
