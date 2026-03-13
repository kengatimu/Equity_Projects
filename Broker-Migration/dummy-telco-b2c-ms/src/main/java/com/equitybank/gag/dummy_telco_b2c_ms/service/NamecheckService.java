package com.equitybank.gag.dummy_telco_b2c_ms.service;

import com.equitybank.gag.dummy_telco_b2c_ms.dto.namecheck.vodacom.request.TransactionData;
import com.equitybank.gag.dummy_telco_b2c_ms.dto.namecheck.vodacom.response.ResponseData;

public interface NamecheckService<T> {
    ResponseData<T> processNamecheckRequest(TransactionData transactionData);
}
