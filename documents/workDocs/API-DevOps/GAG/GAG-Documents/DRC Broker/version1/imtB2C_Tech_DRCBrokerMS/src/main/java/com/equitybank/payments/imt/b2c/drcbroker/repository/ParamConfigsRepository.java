package com.equitybank.payments.imt.b2c.drcbroker.repository;

import com.equitybank.payments.imt.b2c.drcbroker.domain.ParamConfigs;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

/**
 * Spring Data SQL repository for the BusinessParamConfigs entity.
 */
@SuppressWarnings("unused")
@Repository
public interface ParamConfigsRepository extends JpaRepository<ParamConfigs, Long> {

//    @Cacheable(value = "imtB2CTechDRCBrokerMSCache", key = "#configId", unless = "#result == null")
    Optional<ParamConfigs> findByConfigId(String configId);
}
