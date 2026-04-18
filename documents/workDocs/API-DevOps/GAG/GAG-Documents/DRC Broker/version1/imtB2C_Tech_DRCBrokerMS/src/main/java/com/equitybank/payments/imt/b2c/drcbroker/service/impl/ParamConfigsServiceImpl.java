package com.equitybank.payments.imt.b2c.drcbroker.service.impl;

import com.equitybank.payments.imt.b2c.drcbroker.domain.ParamConfigs;
import com.equitybank.payments.imt.b2c.drcbroker.repository.ParamConfigsRepository;
import com.equitybank.payments.imt.b2c.drcbroker.service.ParamConfigsService;
import com.equitybank.payments.imt.b2c.drcbroker.service.dto.BrokerParamConfigsDTO;
import com.equitybank.payments.imt.b2c.drcbroker.service.mapper.ParamConfigsMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

/**
 * Service Implementation for managing {@link ParamConfigsServiceImpl}.
 */
@Service
@Transactional
public class ParamConfigsServiceImpl implements ParamConfigsService {
    private final Logger log = LoggerFactory.getLogger(ParamConfigsServiceImpl.class);

    private final ParamConfigsRepository paramConfigsRepository;
    private final ParamConfigsMapper paramConfigsMapper;

    @Autowired
    public ParamConfigsServiceImpl(ParamConfigsRepository paramConfigsRepository, ParamConfigsMapper paramConfigsMapper) {
        this.paramConfigsRepository = paramConfigsRepository;
        this.paramConfigsMapper = paramConfigsMapper;
    }


    @Override
    public BrokerParamConfigsDTO save(BrokerParamConfigsDTO businessParamConfigsDTO) {
        log.info("Request to save BusinessParamConfigs : {}", businessParamConfigsDTO);
        ParamConfigs paramConfigs = paramConfigsMapper.toEntity(businessParamConfigsDTO);
        paramConfigs = paramConfigsRepository.save(paramConfigs);
        return paramConfigsMapper.toDto(paramConfigs);
    }

    @Override
    public Optional<BrokerParamConfigsDTO> partialUpdate(BrokerParamConfigsDTO businessParamConfigsDTO) {
        log.info("Request to partially update BusinessParamConfigs : {}", businessParamConfigsDTO);

        return paramConfigsRepository
            .findById(businessParamConfigsDTO.getId())
            .map(
                    existingBrokerParamConfigs -> {
                    paramConfigsMapper.partialUpdate(existingBrokerParamConfigs, businessParamConfigsDTO);

                    return existingBrokerParamConfigs;
                }
            )
            .map(paramConfigsRepository::save)
            .map(paramConfigsMapper::toDto);
    }

    @Override
    @Transactional(readOnly = true)
    public Page<BrokerParamConfigsDTO> findAll(Pageable pageable) {
        log.info("Request to get all BusinessParamConfigs");
        return paramConfigsRepository.findAll(pageable).map(paramConfigsMapper::toDto);
    }

    @Override
    @Transactional(readOnly = true)
    public Optional<BrokerParamConfigsDTO> findOne(Long id) {
        log.info("Request to get BusinessParamConfigs : {}", id);
        return paramConfigsRepository.findById(id).map(paramConfigsMapper::toDto);
    }

    @Override
    public void delete(Long id) {
        log.info("Request to delete BusinessParamConfigs : {}", id);
        paramConfigsRepository.deleteById(id);
    }

    @Override
    public Optional<BrokerParamConfigsDTO> findByConfigId(String configId) {
        log.info("Request to find customer limits by sourceAccount : {}", configId);
        return paramConfigsRepository.findByConfigId(configId).map(paramConfigsMapper::toDto);
    }
}
