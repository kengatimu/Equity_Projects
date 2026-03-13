package com.equitybank.gag.telco_b2c.service;

import com.equitybank.gag.telco_b2c.exception.CustomException;

import java.util.Map;

public interface XmlReaderService {
    Map<String, String> parseXml(String xmlString, String type, String rrn) throws CustomException;

    Map<String, String> parseCallbackXmlString(String xmlString, String operationType) throws CustomException;

    String removeChannelInfo(String xmlString, String type) throws CustomException;
}
