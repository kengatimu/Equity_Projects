package com.equitybank.gag.telco_b2c.service;

import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.exception.CustomException;

import java.util.Map;

public interface TelcoAccountResolverService {
    Map<String, String> resolveTelcoNameForFinacleFloatPurchase(Map<String, String> xmlTagsMap) throws CustomException;
}
