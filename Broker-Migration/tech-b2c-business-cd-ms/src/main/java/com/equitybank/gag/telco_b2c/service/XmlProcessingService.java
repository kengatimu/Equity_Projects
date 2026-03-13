package com.equitybank.gag.telco_b2c.service;

import com.equitybank.gag.telco_b2c.exception.CustomException;
import java.security.SignatureException;

import java.util.Map;

public interface XmlProcessingService {
    String processXmlRequests(boolean isInternal, String feeLookupXml, Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException, SignatureException;
}
