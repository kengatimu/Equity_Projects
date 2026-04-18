package com.equitybank.payments.imt.b2c.drcbroker.service;

import com.equitybank.payments.imt.b2c.drcbroker.service.model.error.status.ErrorStatus;

public interface AsyncResponseService {
    <T> Object processAsyncResponse(Object input, String type, ErrorStatus errorStatus);
}
