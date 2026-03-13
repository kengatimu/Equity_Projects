package com.equitybank.gag.telco_b2c.service.impl;

import com.equitybank.gag.telco_b2c.entity.ParamConfigs;
import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.repository.ParamConfigsRepo;
import com.equitybank.gag.telco_b2c.repository.TransactionDetailsRepository;
import com.equitybank.gag.telco_b2c.service.DatabaseService;
import jakarta.persistence.OptimisticLockException;
import org.hibernate.StaleObjectStateException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Lazy;
import org.springframework.orm.ObjectOptimisticLockingFailureException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.TransactionTemplate;

import java.util.Map;
import java.util.Optional;

import static com.equitybank.gag.telco_b2c.config.ApplicationConstants.DEFAULT_IMT_REQUEST_TYPE;
import static com.equitybank.gag.telco_b2c.config.ApplicationConstants.DEFAULT_RATE_CONFIG_ID;
import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.DUPLICATE_ERROR;
import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.NOT_FOUND;

@Service
public class DatabaseServiceImpl implements DatabaseService {
    private static final Logger log = LoggerFactory.getLogger(DatabaseServiceImpl.class);

    private final TransactionDetailsRepository transactionDetailsRepository;
    private final TransactionTemplate transactionTemplate;
    private final ParamConfigsRepo paramConfigsRepo;

    @Autowired
    public DatabaseServiceImpl(@Lazy TransactionDetailsRepository transactionDetailsRepository,
                               @Qualifier("Transactional") TransactionTemplate transactionTemplate,
                               ParamConfigsRepo paramConfigsRepo) {
        this.transactionDetailsRepository = transactionDetailsRepository;
        this.transactionTemplate = transactionTemplate;
        this.paramConfigsRepo = paramConfigsRepo;
    }

    @Override
    @Transactional(readOnly = true)
    public void checkTransactionRecord(String rrn, String type, String operation) throws CustomException {
        // Find the transaction record based on RRN and request type
        String tranType = type.toLowerCase().contains("moneygram") ? DEFAULT_IMT_REQUEST_TYPE : type;

        boolean exists = transactionDetailsRepository.existsByRrnAndRequestType(rrn, tranType);
        boolean isDuplicateCheck = "duplicate-check".equalsIgnoreCase(operation);

        // Determine the appropriate exception based on the operation type
        if (isDuplicateCheck && exists) {
            throw new CustomException(DUPLICATE_ERROR);
        } else if (!isDuplicateCheck && !exists) {
            throw new CustomException(NOT_FOUND);
        }
    }

    @Override
    @Transactional
    public void persistInitialTransactionRecord(TransactionDetails entity) {
        transactionDetailsRepository.save(entity);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<TransactionDetails> getTransactionRecord(String rrn, String type) {
        // Determine the transaction type
        String tranType = type.toLowerCase().contains("moneygram") ? DEFAULT_IMT_REQUEST_TYPE : type;
        tranType = Map.of(
                "status-check-banktowallet", "transaction",
                "status-check-airtime", "airtime",
                "status-check-floatpurchase", "floatPurchase"
        ).getOrDefault(tranType.toLowerCase(), tranType);

        Optional<TransactionDetails> optionalTransaction = transactionDetailsRepository.findByRrnAndRequestType(rrn, tranType);
        if (optionalTransaction.isPresent()) {
            log.info("Transaction With RRN: {} Found", rrn);
            return optionalTransaction;
        } else {
            log.info("Transaction With RRN: {} and RequestType {} Does Not Exist", rrn, tranType);
            return Optional.empty();
        }
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<ParamConfigs> getConfigRecord() {
        Optional<ParamConfigs> optionalConfigRecord = paramConfigsRepo.findByConfigId(DEFAULT_RATE_CONFIG_ID);
        if (optionalConfigRecord.isPresent()) {
            return optionalConfigRecord;
        }
        log.info("Config Record With ConfigId: {} Does Not Exists", DEFAULT_RATE_CONFIG_ID);
        return Optional.empty();
    }

    @Override
    @Transactional
    public void updateConfigRecord(String rate) {
        Optional<ParamConfigs> optionalConfigRecord = paramConfigsRepo.findByConfigId(DEFAULT_RATE_CONFIG_ID);
        if (optionalConfigRecord.isPresent()) {
            updateFxRate(optionalConfigRecord.get(), rate);
        } else {
            createNewRecord(rate);
        }
    }

    // Since we are using a background thread, @Transactional annotation will not apply here.
    // To keep the transactional behavior, we use TransactionTemplate to explicitly:
    // begin, commit, or rollback a transaction inside the thread.

    // Attempts to update the transaction record in the database.
    // Retries up to 5 times in case of deadlocks or transient failures.
    // Waits 200 milliseconds between retries before attempting again.
    // If all retries are exhausted, logs an error and gives up.
    @Override
    public void updateTransactionRecord(TransactionDetails entity) {
        String rrn = entity.getRrn();
        int retryCount = 0;
        int maxRetries = 5;
        long retryDelayMillis = 200; // Delay between retries (in milliseconds)

        while (true) {
            try {
                transactionTemplate.executeWithoutResult(status -> transactionDetailsRepository.save(entity));
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

    private void updateFxRate(ParamConfigs paramConfigs, String rate) {
        log.info("Updating Fx Rate Value For {} Record", DEFAULT_RATE_CONFIG_ID);
        log.info("Rate: " + rate);
        paramConfigs.setConfigValue(rate);
        paramConfigs.setConfigBinValue(rate);
        paramConfigsRepo.save(paramConfigs);
    }

    private void createNewRecord(String rate) {
        log.info("Configuration Record With ConfigId: {} Does Not Exists. Creating New Record", DEFAULT_RATE_CONFIG_ID);
        ParamConfigs paramConfigs = new ParamConfigs();
        paramConfigs.setConfigId(DEFAULT_RATE_CONFIG_ID);
        paramConfigs.setConfigDesc("USD/CDF Fx Rate");
        paramConfigs.setConfigStatus("ENABLED");
        paramConfigs.setConfigValue(rate);
        paramConfigs.setConfigBinValue(rate);
        paramConfigs.setDeleted("N");
        paramConfigsRepo.save(paramConfigs);
    }

}
