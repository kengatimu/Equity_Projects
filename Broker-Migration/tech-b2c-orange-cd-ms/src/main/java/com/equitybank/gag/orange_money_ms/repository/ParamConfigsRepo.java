package com.equitybank.gag.orange_money_ms.repository;


import com.equitybank.gag.orange_money_ms.entity.ParamConfigs;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ParamConfigsRepo extends JpaRepository<ParamConfigs, Long> {
    Optional<ParamConfigs> findByConfigId(String configId);
}