package com.equitybank.gag.papss.ots.service.impl;

import com.equitybank.gag.papss.ots.entity.TransactionMaster;
import com.equitybank.gag.papss.ots.enums.TransactionType;
import com.equitybank.gag.papss.ots.exception.CustomException;
import com.equitybank.gag.papss.ots.repository.TransactionMasterRepository;
import com.equitybank.gag.papss.ots.service.DatabaseService;
import jakarta.persistence.OptimisticLockException;
import jakarta.persistence.PersistenceException;
import org.hibernate.StaleObjectStateException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Lazy;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.orm.ObjectOptimisticLockingFailureException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.TransactionTemplate;

import static com.equitybank.gag.papss.ots.config.ApplicationConstants.*;

@Service
public class DatabaseServiceImpl implements DatabaseService {
    private static final Logger log = LoggerFactory.getLogger(DatabaseServiceImpl.class);

    private final TransactionMasterRepository transactionMasterRepository;
    private final TransactionTemplate transactionTemplate;

    @Autowired
    public DatabaseServiceImpl(@Lazy TransactionMasterRepository transactionMasterRepository,
                               @Qualifier("Transactional") TransactionTemplate transactionTemplate) {
        this.transactionMasterRepository = transactionMasterRepository;
        this.transactionTemplate = transactionTemplate;
    }

    @Override
    @Transactional(readOnly = true)
    public void checkTransactionExists(String rrn, TransactionType type) throws CustomException {
        boolean recordExists = transactionMasterRepository.existsByRrnAndTransactionType(rrn, type);

        if (recordExists) {
            log.error("{}: Duplicate transaction found for RRN: {}", rrn, rrn);
            throw new CustomException(DUPLICATE_RECORD);
        }
    }

    @Override
    @Transactional
    public void saveInitialCreditTransferEntity(String rrn, TransactionMaster entity) throws CustomException {
        // Force DB write (using saveAndFlush), since we want to break the thread if exception is thrown
        try {
            transactionMasterRepository.saveAndFlush(entity);
            log.info("{}: Successfully persisted initial transaction record with RRN: {}", rrn, rrn);
        } catch (DataIntegrityViolationException e) {
            log.error("{}: Integrity violation when saving transaction entity: {}", rrn, e.getMessage());
            throw new CustomException(DEFAULT_DATABASE_ERROR + e.getMessage());
        } catch (PersistenceException | DataAccessException e) {
            log.error("{}: Persistence error occurred: {}", rrn, e.getMessage());
            throw new CustomException(DEFAULT_DATABASE_ERROR + e.getMessage());
        } catch (Exception e) {
            log.error("{}: Unexpected error occurred: {}", rrn, e.getMessage());
            throw new CustomException(DEFAULT_DATABASE_ERROR + e.getMessage());
        }
    }

    @Override
    @Transactional(readOnly = true)
    public TransactionMaster getSavedRecord(String rrn, TransactionType type) throws CustomException {
        return transactionMasterRepository
                .findByRrnAndTransactionType(rrn, type)
                .orElseThrow(() -> new CustomException(RECORD_NOT_FOUND));
    }

    // Since we are using a background thread, @Transactional annotation will not apply here.
    // To keep the transactional behavior, we use TransactionTemplate to explicitly:
    // begin, commit, or rollback a transaction inside the thread.

    // Attempts to update the transaction record in the database.
    // Retries up to 5 times in case of deadlocks or transient failures.
    // Waits 200 milliseconds between retries before attempting again.
    // If all retries are exhausted, logs an error and gives up.
    @Override
    public void updateDbRecord(TransactionMaster entity) {
        String rrn = entity.getRrn();
        int retryCount = 0;
        int maxRetries = 5;
        long retryDelayMillis = 200; // Delay between retries (in milliseconds)

        while (true) {
            try {
                transactionTemplate.executeWithoutResult(status -> transactionMasterRepository.save(entity));
                log.info("{}: Transaction updated successfully.", rrn);
                return; // Exit after successful save
            } catch (ObjectOptimisticLockingFailureException | OptimisticLockException | StaleObjectStateException e) {
                // Don't retry if the entity is stale
                log.warn("{}: Skipping update — Stale record detected (Entity already updated by another thread).", rrn);
                break;
            } catch (Exception e) {
                retryCount++;
                log.error("{}: Failed to update transaction record on attempt {}. Exception [{}]: {}. Proceeding to retry...",
                        rrn, retryCount, e.getClass().getSimpleName(), e.getMessage());

                if (retryCount >= maxRetries) {
                    log.error("{}: Giving up after {} retries.", rrn, maxRetries);
                    break;
                }

                try {
                    Thread.sleep(retryDelayMillis);
                } catch (InterruptedException interruptedException) {
                    Thread.currentThread().interrupt();
                    log.error("{}: Retry sleep interrupted. Exiting retry loop.", rrn);
                    break;
                }
            }
        }
    }
}
