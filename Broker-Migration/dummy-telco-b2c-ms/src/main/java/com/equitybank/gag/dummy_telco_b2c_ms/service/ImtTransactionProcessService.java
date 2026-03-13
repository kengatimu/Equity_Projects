package com.equitybank.gag.dummy_telco_b2c_ms.service;

public interface ImtTransactionProcessService {
    String imtFailureResponse();

    String commitRequestSuccess();

    String commitRequestFailure();

    String feeLookupSuccess();

    String referenceNumberRequestSuccess();

    String receiveGFFPSuccess();

    String receiveValidationSuccess();

    String receiveCommitSuccess();
}
