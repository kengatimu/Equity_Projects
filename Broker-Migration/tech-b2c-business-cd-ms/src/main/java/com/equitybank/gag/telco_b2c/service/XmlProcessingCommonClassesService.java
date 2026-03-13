package com.equitybank.gag.telco_b2c.service;

import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.exception.CustomException;

import java.security.SignatureException;
import java.util.Map;

public interface XmlProcessingCommonClassesService {
    void checkForDuplicateRecord(String rrn, String type) throws CustomException;

    void validateRequest(boolean isInternal, Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException, SignatureException;

    TransactionDetails getSavedDbRecord(String rrn, String type) throws CustomException;

    void updateDatabaseRecord(TransactionDetails entity, String rrn, String type) throws CustomException;

    void updateDatabaseAsync(TransactionDetails entity, String rrn, String type) throws CustomException;

    String sendRequestAndGetResponse(TransactionDetails transactionDetails, Map<String, String> xmlTagsMap, String bankId, String requestXml, String type, String rrn) throws CustomException;

}
