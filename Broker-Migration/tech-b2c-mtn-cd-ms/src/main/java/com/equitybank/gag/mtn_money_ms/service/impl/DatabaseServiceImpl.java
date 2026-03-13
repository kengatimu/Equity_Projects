package com.equitybank.gag.mtn_money_ms.service.impl;

import com.equitybank.gag.mtn_money_ms.entity.TransactionDetails;
import com.equitybank.gag.mtn_money_ms.repository.TransactionDetailsRepository;
import com.equitybank.gag.mtn_money_ms.service.DatabaseService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Lazy;
import org.springframework.core.task.TaskExecutor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Service
public class DatabaseServiceImpl implements DatabaseService {
    private static final Logger log = LoggerFactory.getLogger(DatabaseServiceImpl.class);

    private final TransactionDetailsRepository transactionDetailsRepository;
    private final TaskExecutor taskExecutor;

    @Autowired
    public DatabaseServiceImpl(@Lazy TransactionDetailsRepository transactionDetailsRepository,
                               @Qualifier("taskExecutor") TaskExecutor taskExecutor) {
        this.transactionDetailsRepository = transactionDetailsRepository;
        this.taskExecutor = taskExecutor;
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<TransactionDetails> getTransactionRecord(String rrn, String type) {
        Optional<TransactionDetails> optionalTransaction = transactionDetailsRepository.findByRrnAndRequestType(rrn, type);
        if (optionalTransaction.isPresent()) {
            log.info("Transaction With RRN: {} Found", rrn);
            TransactionDetails transactionDetails = optionalTransaction.get();
            return Optional.of(transactionDetails);
        }
        log.info("Transaction With RRN: {} and RequestType {} Does Not Exists", rrn, type);
        return Optional.empty();
    }

    @Override
    @Transactional
    public void updateTransactionRecord(TransactionDetails entity) {
        String rrn = entity.getRrn();
        taskExecutor.execute(() ->
        {
            try {
                transactionDetailsRepository.save(entity);
                log.info("{}: Transaction updated successfully.", rrn);
            } catch (Exception e) {
                log.error("{}: Failed to update transaction record. Exception occurred: {}", rrn, e.getMessage());
            }
        });
    }
}
