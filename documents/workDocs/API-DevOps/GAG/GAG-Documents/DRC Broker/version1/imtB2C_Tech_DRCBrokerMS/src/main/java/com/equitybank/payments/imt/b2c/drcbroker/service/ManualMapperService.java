package com.equitybank.payments.imt.b2c.drcbroker.service;

import com.equitybank.payments.imt.b2c.drcbroker.service.model.error.status.ErrorStatus;

public interface ManualMapperService {
    Object mapValuesManually (Object input, String type, String rrn, ErrorStatus errorStatus);

}
