package com.equitybank.gag.dummy_telco_b2c_ms.service;

public interface TelcoTransactionProcessService {
    String feeLookupFailure();

    String feeLookupSuccess();

    String responseFinalStatusSuccess();

    String responsePendingStatusSuccess();

    String responseFinalStatusFailure();
}
