package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.repository;


import com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.enums.RequestTypes;
import com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.model.TransactionDetails;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface TransactionDetailsRepository extends JpaRepository<TransactionDetails, Long> {
    Optional<TransactionDetails> findByRrnAndOperationType(String rrn, RequestTypes operationType);
}
