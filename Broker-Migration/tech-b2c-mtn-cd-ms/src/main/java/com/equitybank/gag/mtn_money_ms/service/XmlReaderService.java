package com.equitybank.gag.mtn_money_ms.service;

import com.equitybank.gag.mtn_money_ms.exception.CustomException;

import java.util.Map;

public interface XmlReaderService {
    Map<String, String> parseXmlString(String xmlString, String operationType) throws CustomException;

}
