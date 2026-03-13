package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.repository;

import com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.model.StatusDetails;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface StatusDetailsRepository extends JpaRepository<StatusDetails, Long> {
    Optional<StatusDetails> findByRrn(String rrn);
}
