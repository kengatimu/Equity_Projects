package com.equitybank.payments.imt.b2c.drcbroker.service.mapper;

import com.equitybank.payments.imt.b2c.drcbroker.domain.ParamConfigs;
import com.equitybank.payments.imt.b2c.drcbroker.service.dto.BrokerParamConfigsDTO;

import org.mapstruct.*;

/**
 * Mapper for the entity {@link ParamConfigs} and its DTO {@link ParamConfigs}.
 */
@Mapper(componentModel = "spring", uses = {})
public interface ParamConfigsMapper extends EntityMapper<BrokerParamConfigsDTO, ParamConfigs> {}
