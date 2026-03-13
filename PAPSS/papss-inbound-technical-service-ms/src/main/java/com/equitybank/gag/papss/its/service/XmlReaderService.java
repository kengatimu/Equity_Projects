package com.equitybank.gag.papss.its.service;

import com.equitybank.gag.papss.its.exception.CustomException;

import java.util.Map;

public interface XmlReaderService {
    Map<String, String> processInboundXml(String rrn, String xmlContent, String type) throws CustomException;

    Map<String, String> processPacs002Response(String rrn, String xmlContent) throws CustomException;
}
