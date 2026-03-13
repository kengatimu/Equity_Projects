package com.equitybank.gag.telco_b2c.service;

import java.util.Map;

public interface ExtractXmlFieldsService {
    Map<String, String> extractResponseDetails(String xmlString, String type);
}
