package com.equitybank.gag.telco_b2c.patterns.strategy.xmlReqProcessor.strategyService;

import com.equitybank.gag.telco_b2c.exception.CustomException;

import java.security.SignatureException;
import java.util.Map;

public interface XmlTypeProcessingStrategyService {
    String process(boolean isInternal, String requestXml, Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException, SignatureException;
}

