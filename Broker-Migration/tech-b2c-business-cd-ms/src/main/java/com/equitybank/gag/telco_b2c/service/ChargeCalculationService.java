package com.equitybank.gag.telco_b2c.service;

import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.exception.CustomException;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

public interface ChargeCalculationService {
    Map<String, String> calculateCharges (TransactionDetails transactionDetails, request request, Map<String, String> xmlTagsMap, String type) throws CustomException;
}
