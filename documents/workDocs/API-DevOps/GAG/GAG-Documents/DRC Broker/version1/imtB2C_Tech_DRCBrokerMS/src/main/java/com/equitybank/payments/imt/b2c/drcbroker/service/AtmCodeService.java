package com.equitybank.payments.imt.b2c.drcbroker.service;

import com.equitybank.payments.imt.b2c.drcbroker.service.dto.BrokerServiceAtmCodeDTO;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.error.status.ErrorStatus;

public interface AtmCodeService {
    BrokerServiceAtmCodeDTO processRequest(String request, ErrorStatus errorStatus);
}
