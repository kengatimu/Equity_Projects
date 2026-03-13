package com.equitybank.gag.mtn_money_ms.mapper;


import com.equitybank.gag.mtn_money_ms.entity.TransactionDetails;

import java.util.Map;

public interface CustomMapperService {

    TransactionDetails composeEntityForSuccessResponseUpdate(String xmlResponse, Map<String, String> extractedTelcoResponseMap, String rrn, String type);

    TransactionDetails composeEntityForErrorResponseUpdate(String xmlResponse, String rrn, String errorCode, String errorDescription, String status, String type);

}
