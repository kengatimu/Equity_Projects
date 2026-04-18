package com.equitybank.payments.imt.b2c.drcbroker.service.impl;

import com.equitybank.payments.imt.b2c.drcbroker.domain.AtmCodeDetails;
import com.equitybank.payments.imt.b2c.drcbroker.service.ModelMapperService;
import com.equitybank.payments.imt.b2c.drcbroker.service.dto.BrokerServiceSendToWalletDTO;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.error.status.ErrorStatus;
import org.modelmapper.ModelMapper;
import org.modelmapper.convention.MatchingStrategies;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ModelMapperServiceImpl implements ModelMapperService {
    private static final Logger log = LoggerFactory.getLogger(ModelMapperServiceImpl.class);

    private final ModelMapper modelMapper;

    @Autowired
    public ModelMapperServiceImpl(ModelMapper modelMapper) {
        this.modelMapper = modelMapper;
    }

    @Override
    public <T> Object mapObjects(Object input, String returnType, String beneficiaryAccount, String rrn, ErrorStatus errorStatus) {
        try {
            modelMapper.getConfiguration().setMatchingStrategy(MatchingStrategies.STRICT);
            if (returnType.equalsIgnoreCase("BrokerServiceSendToWalletDTO")) {
                BrokerServiceSendToWalletDTO brokerServiceSendToWalletDTO = modelMapper.map(input, BrokerServiceSendToWalletDTO.class);
                log.info(beneficiaryAccount + ": BrokerServiceSendToWalletDTO::: " + brokerServiceSendToWalletDTO);
                return brokerServiceSendToWalletDTO;
            } else if (returnType.equalsIgnoreCase("entity")) {
                AtmCodeDetails entity = modelMapper.map(input, AtmCodeDetails.class);
                log.info(beneficiaryAccount + ": BrokerServiceAtmCodeDetails Entity::: " + entity);
                return entity;
            }
        } catch (Exception e) {
            errorStatus.setStatus("Failed");
            errorStatus.setStatusCode("800");
            errorStatus.setStatusDesc(" Internal Exception Occurred During Model Mapping: " + e.getMessage());
            errorStatus.setStatusMessage(rrn);
            log.info(beneficiaryAccount + ": ModelMapper Service Failed. Exception Occurred At ModelMapperServiceImpl.mapObjects: " + e.getMessage());
        }
        return null;
    }
}
