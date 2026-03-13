package com.equitybank.gag.telco_b2c.service;

import com.equitybank.gag.telco_b2c.entity.TransactionDetails;

import java.time.LocalDateTime;
import java.util.List;

public interface DatabaseOperationService {
    TransactionDetails getRecordByRRN(String rrn);

    List<TransactionDetails> getLastTenRecords();

    List<TransactionDetails> getRecordsForToday();

    List<TransactionDetails> getRecordsBySpecificDate(LocalDateTime start, LocalDateTime end);
}
