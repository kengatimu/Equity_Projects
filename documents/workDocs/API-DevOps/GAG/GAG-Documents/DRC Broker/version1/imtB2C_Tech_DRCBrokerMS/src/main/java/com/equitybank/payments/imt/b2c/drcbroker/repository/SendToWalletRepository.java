package com.equitybank.payments.imt.b2c.drcbroker.repository;

import com.equitybank.payments.imt.b2c.drcbroker.domain.SendToWalletDetails;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface SendToWalletRepository extends JpaRepository <SendToWalletDetails, Long>{
    Optional<SendToWalletDetails> findByRrn (String rrn);
}
