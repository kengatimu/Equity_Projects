package com.equitybank.payments.imt.b2c.drcbroker.service.impl;

import com.equitybank.payments.imt.b2c.drcbroker.service.ManualMapperService;
import com.equitybank.payments.imt.b2c.drcbroker.service.dto.BrokerServiceAtmCodeDTO;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.error.status.ErrorStatus;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.request.AtmCodeRequest;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.request.BusinessServiceRequestModel;
import com.google.gson.Gson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ManualMapperServiceImpl implements ManualMapperService {
    private static final Logger log = LoggerFactory.getLogger(ManualMapperServiceImpl.class);

    private final Gson gson;

    @Autowired
    public ManualMapperServiceImpl(Gson gson) {
        this.gson = gson;
    }

    @Override
    public Object mapValuesManually(Object input, String type, String rrn, ErrorStatus errorStatus) {
        if (type.equalsIgnoreCase("brokerServiceAtmCodeDTO")) {
            BusinessServiceRequestModel requestModel = (BusinessServiceRequestModel) input;
            BrokerServiceAtmCodeDTO atmCodeDTO = new BrokerServiceAtmCodeDTO();
            String DEFAULT_CURRENCY = "USD";

            atmCodeDTO.setRrn(requestModel.getEazzycash().getRrn());
            atmCodeDTO.setAmount(requestModel.getEazzycash().getAmount());
            atmCodeDTO.setCurrency(DEFAULT_CURRENCY);
            atmCodeDTO.setAccountNumber(requestModel.getEazzycash().getSender());
            atmCodeDTO.setPhoneNumber(requestModel.getEazzycash().getNumber());
            atmCodeDTO.setBusinessServiceRequest(gson.toJson(requestModel));
            return atmCodeDTO;
        } else if (type.equalsIgnoreCase("brokerServiceAtmCodeRequest")) {
            BrokerServiceAtmCodeDTO brokerServiceAtmCodeDTO = (BrokerServiceAtmCodeDTO) input;
            AtmCodeRequest atmCodeRequest = new AtmCodeRequest();

            atmCodeRequest.setAccountNumber(brokerServiceAtmCodeDTO.getAccountNumber());
            atmCodeRequest.setBeneficiaryPhoneNumber(brokerServiceAtmCodeDTO.getPhoneNumber());
            atmCodeRequest.setAmount(brokerServiceAtmCodeDTO.getAmount());
            atmCodeRequest.setCurrency(brokerServiceAtmCodeDTO.getCurrency());
            atmCodeRequest.setTransactionID(brokerServiceAtmCodeDTO.getRrn());
            return atmCodeRequest;
        }
        errorStatus.setStatus("Failed");
        errorStatus.setStatusCode("400");
        errorStatus.setStatusDesc(" Type: " + type + " Is Unknown");
        errorStatus.setStatusMessage(rrn);
        log.error(errorStatus.getStatusDesc());
        return null;
    }
}
