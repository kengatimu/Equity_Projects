package com.equitybankgroup.payments.b2c.repository;

import com.equitybankgroup.payments.b2c.model.StatusDetails;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface StatusDetailsRepository extends JpaRepository<StatusDetails, Long> {
    Optional<StatusDetails> findByRrn(String rrn);
}
