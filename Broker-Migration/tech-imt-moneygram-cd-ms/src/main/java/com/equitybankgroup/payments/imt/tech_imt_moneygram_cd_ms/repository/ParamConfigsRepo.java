package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.repository;


import com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.model.ParamConfigs;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ParamConfigsRepo extends JpaRepository<ParamConfigs, Long> {
    Optional<ParamConfigs> findByConfigId(String configId);
}