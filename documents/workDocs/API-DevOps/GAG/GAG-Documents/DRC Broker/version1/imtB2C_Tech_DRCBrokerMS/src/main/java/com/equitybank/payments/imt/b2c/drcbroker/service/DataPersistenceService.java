package com.equitybank.payments.imt.b2c.drcbroker.service;


import com.equitybank.payments.imt.b2c.drcbroker.service.model.error.status.ErrorStatus;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.response.BusinessServiceResponseModel;

public interface DataPersistenceService {
    String persistData(Object data, Object response, String type, ErrorStatus errorStatus);
}
