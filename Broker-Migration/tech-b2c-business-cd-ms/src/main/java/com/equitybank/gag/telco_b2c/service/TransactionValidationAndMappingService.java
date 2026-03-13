package com.equitybank.gag.telco_b2c.service;

import com.equitybank.gag.telco_b2c.dto.airtime.request.Envelope;
import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import java.security.SignatureException;

import java.util.Map;

public interface TransactionValidationAndMappingService {
    void checkForDatabaseRecord(String rrn, String type, String operation) throws CustomException;

    TransactionDetails getDatabaseRecord(String rrn, String type) throws CustomException;

    TransactionDetails getEntity(String requestXml, request request, Envelope airtimeRequest, Map<String, String> xmlStringMap, String type, String rrn);

    void validateSignature(boolean isInternal, Map<String, String> xmlTagsMap, request request, Envelope airtimeRequest, String rrn, String type) throws CustomException, SignatureException;

}
