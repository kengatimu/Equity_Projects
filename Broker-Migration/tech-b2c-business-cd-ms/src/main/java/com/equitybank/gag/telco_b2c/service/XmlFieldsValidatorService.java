package com.equitybank.gag.telco_b2c.service;

import com.equitybank.gag.telco_b2c.exception.CustomException;

import java.util.Map;

public interface XmlFieldsValidatorService {
    void validateXmlRequestFields(Map<String, String> xmlTagsMap, String type) throws CustomException;
}
