package com.equitybank.payments.imt.b2c.drcbroker.service;

import com.equitybank.payments.imt.b2c.drcbroker.service.model.error.status.ErrorStatus;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.request.BusinessServiceRequestModel;

public interface ValidationService {
    BusinessServiceRequestModel validateInputs(BusinessServiceRequestModel requestModel, String type, ErrorStatus errorStatus);
}
