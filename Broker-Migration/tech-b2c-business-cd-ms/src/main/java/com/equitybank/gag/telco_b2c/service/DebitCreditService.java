package com.equitybank.gag.telco_b2c.service;

import com.equitybank.gag.telco_b2c.dto.airtime.request.Envelope;
import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.exception.CustomException;

import java.util.Map;

public interface DebitCreditService {
    boolean checkDebitCreditEnable(String type);

    void doDebitCredit(TransactionDetails transactionDetails, String bankId, request request, Envelope airtimeRequest, Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException;

    void doReversal(String rrn, String type, String bankId);
    
    boolean isDrCrEnabledForCountry(String type, String countryCode);
}
