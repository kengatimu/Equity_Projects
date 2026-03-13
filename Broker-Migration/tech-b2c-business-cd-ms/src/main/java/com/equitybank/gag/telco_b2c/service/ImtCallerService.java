package com.equitybank.gag.telco_b2c.service;

import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.exception.CustomException;

public interface ImtCallerService {
    String sendRequestAndGetResponse(String bankId, String requestXml, String type, String rrn) throws CustomException;

    String processResponse(TransactionDetails transactionDetails, String bankId, String rrn, String responseXml, String type, boolean readResponseString) throws CustomException;
}
