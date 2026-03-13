package com.equitybank.gag.telco_b2c.repository;


import com.equitybank.gag.telco_b2c.entity.ParamConfigs;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ParamConfigsRepo extends JpaRepository<ParamConfigs, Long> {
    Optional<ParamConfigs> findByConfigId(String configId);
}