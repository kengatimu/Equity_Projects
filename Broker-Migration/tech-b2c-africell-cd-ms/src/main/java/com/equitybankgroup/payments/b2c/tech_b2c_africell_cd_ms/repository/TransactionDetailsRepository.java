package com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.repository;

import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.model.TransactionDetails;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface TransactionDetailsRepository extends JpaRepository<TransactionDetails, Long> {
    Optional<TransactionDetails> findByRrn(String rrn);
}
