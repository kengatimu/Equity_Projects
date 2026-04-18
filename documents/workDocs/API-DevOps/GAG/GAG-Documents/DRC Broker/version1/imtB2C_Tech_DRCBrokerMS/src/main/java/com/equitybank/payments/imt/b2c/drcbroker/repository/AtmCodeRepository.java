package com.equitybank.payments.imt.b2c.drcbroker.repository;

import com.equitybank.payments.imt.b2c.drcbroker.domain.AtmCodeDetails;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface AtmCodeRepository extends JpaRepository<AtmCodeDetails, Long> {
    Optional<AtmCodeDetails> findByRrn(String rrn);
}
