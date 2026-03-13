package com.equitybankgroup.payments.b2c.repository;

import com.equitybankgroup.payments.b2c.enums.RequestTypes;
import com.equitybankgroup.payments.b2c.model.TransactionDetails;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface TransactionDetailsRepository extends JpaRepository<TransactionDetails, Long> {
    Optional<TransactionDetails> findByRrnAndOperationType(String rrn, RequestTypes operationType);
}
