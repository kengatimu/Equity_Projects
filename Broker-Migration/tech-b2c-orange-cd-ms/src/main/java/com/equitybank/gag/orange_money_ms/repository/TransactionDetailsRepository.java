package com.equitybank.gag.orange_money_ms.repository;

import com.equitybank.gag.orange_money_ms.entity.TransactionDetails;
import com.equitybank.gag.orange_money_ms.enums.RequestTypes;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface TransactionDetailsRepository extends JpaRepository<TransactionDetails, Long> {

    Optional<TransactionDetails> findByRrn(String rrn);

    Optional<TransactionDetails> findByRrnAndOperationType(String rrn, RequestTypes operationType);

}
