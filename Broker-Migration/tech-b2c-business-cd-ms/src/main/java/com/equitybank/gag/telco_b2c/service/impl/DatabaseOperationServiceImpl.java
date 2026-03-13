package com.equitybank.gag.telco_b2c.service.impl;

import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.repository.TransactionDetailsRepository;
import com.equitybank.gag.telco_b2c.service.DatabaseOperationService;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Service
public class DatabaseOperationServiceImpl implements DatabaseOperationService {
    private static final Logger log = LoggerFactory.getLogger(DatabaseOperationServiceImpl.class);

    private final TransactionDetailsRepository transactionDetailsRepository;

    @Autowired
    public DatabaseOperationServiceImpl(TransactionDetailsRepository transactionDetailsRepository) {
        this.transactionDetailsRepository = transactionDetailsRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public TransactionDetails getRecordByRRN(String rrn) {
        return getTransactionByRrn(rrn);
    }

    @Override
    @Transactional(readOnly = true)
    public List<TransactionDetails> getLastTenRecords() {
        return lastTenRecords();
    }

    @Override
    @Transactional(readOnly = true)
    public List<TransactionDetails> getRecordsForToday() {
        return recordsForTheDay();
    }

    @Override
    @Transactional(readOnly = true)
    public List<TransactionDetails> getRecordsBySpecificDate(LocalDateTime start, LocalDateTime end) {
        return recordsBySpecificDay(start, end);
    }

    private TransactionDetails getTransactionByRrn(String rrn) {
        Optional<TransactionDetails> optionalRecord = transactionDetailsRepository.findByRrn(rrn);
        if (optionalRecord.isPresent()) {
            return optionalRecord.get();
        }
        log.info("Transaction With RRN: {} Does Not Exist", rrn);
        return new TransactionDetails();
    }

    private List<TransactionDetails> lastTenRecords() {
        try {
            // To return last 10 records, use pageable of size 10
            Pageable pageable = PageRequest.of(0, 10); // Page number 0, size 10
            return transactionDetailsRepository.findTop10ByOrderByDateCreatedDesc(pageable);
        } catch (Exception e) {
            log.error("No Records Exist In The Database. {}", e.getMessage());
            return Collections.emptyList();
        }
    }

    private List<TransactionDetails> recordsForTheDay() {
        // Define the GMT+3 time zone
        ZoneId gmtPlus3 = ZoneId.of("GMT+3");

        // Get the current date in GMT+3 time zone
        LocalDate today = LocalDate.now(gmtPlus3);

        // Calculate the start and end of the day in GMT+3 and truncate to seconds
        LocalDateTime startOfDay = today.atStartOfDay()
                .atZone(gmtPlus3)
                .toLocalDateTime()
                .truncatedTo(ChronoUnit.SECONDS); // "yyyy-MM-dd 00:00:00" in GMT+3

        LocalDateTime endOfDay = today.atTime(LocalTime.MAX)
                .atZone(gmtPlus3)
                .toLocalDateTime()
                .truncatedTo(ChronoUnit.SECONDS); // "yyyy-MM-dd 23:59:59" in GMT+3

        try {
            return transactionDetailsRepository.findAllForCurrentDay(startOfDay, endOfDay);
        } catch (Exception e) {
            log.error("{} No Records Exist For Today: {}", today, e.getMessage());
            return Collections.emptyList();
        }
    }

    private List<TransactionDetails> recordsBySpecificDay(LocalDateTime start, LocalDateTime end) {
        try {
            return transactionDetailsRepository.findRecordsByDateCreatedBetween(start, end);
        } catch (Exception e) {
            log.error("No Records Exist For Specified Date Staring With: {}. {}", start, e.getMessage());
            return Collections.emptyList();
        }
    }
}
