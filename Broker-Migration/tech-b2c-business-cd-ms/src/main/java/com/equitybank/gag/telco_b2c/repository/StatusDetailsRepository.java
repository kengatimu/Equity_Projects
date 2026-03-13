package com.equitybank.gag.telco_b2c.repository;

import com.equitybank.gag.telco_b2c.entity.StatusDetails;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface StatusDetailsRepository extends JpaRepository<StatusDetails, Long> {
    Optional<StatusDetails> findByRrn(String rrn);
}
