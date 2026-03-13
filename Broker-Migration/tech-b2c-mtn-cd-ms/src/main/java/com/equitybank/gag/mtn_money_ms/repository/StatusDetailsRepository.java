package com.equitybank.gag.mtn_money_ms.repository;

import com.equitybank.gag.mtn_money_ms.entity.StatusDetails;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface StatusDetailsRepository extends JpaRepository<StatusDetails, Long> {
    Optional<StatusDetails> findByRrn(String rrn);
}
