package com.equitybank.payments.imt.b2c.drcbroker.service;

import com.equitybank.payments.imt.b2c.drcbroker.domain.ParamConfigs;
import com.equitybank.payments.imt.b2c.drcbroker.service.dto.BrokerParamConfigsDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

/**
 * Service Interface for managing {@link ParamConfigs}.
 */
public interface ParamConfigsService {
    /**
     * Save a businessParamConfigs.
     *
     * @param businessParamConfigsDTO the entity to save.
     * @return the persisted entity.
     */
    BrokerParamConfigsDTO save(BrokerParamConfigsDTO businessParamConfigsDTO);

    /**
     * Partially updates a businessParamConfigs.
     *
     * @param businessParamConfigsDTO the entity to update partially.
     * @return the persisted entity.
     */
    Optional<BrokerParamConfigsDTO> partialUpdate(BrokerParamConfigsDTO businessParamConfigsDTO);

    /**
     * Get all the businessParamConfigs.
     *
     * @param pageable the pagination information.
     * @return the list of entities.
     */
    Page<BrokerParamConfigsDTO> findAll(Pageable pageable);

    /**
     * Get the "id" businessParamConfigs.
     *
     * @param id the id of the entity.
     * @return the entity.
     */
    Optional<BrokerParamConfigsDTO> findOne(Long id);

    /**
     * Delete the "id" businessParamConfigs.
     *
     * @param id the id of the entity.
     */
    void delete(Long id);

    Optional<BrokerParamConfigsDTO> findByConfigId(String configId);
}
