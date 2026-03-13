package com.equitybank.gag.papss.ips.service;

import com.equitybank.gag.papss.ips.exception.CustomException;

import java.util.Map;

public interface XmlResponseReaderService {
    Map<String, String> processXmlResponse (String rrn, String xmlContent, String type) throws CustomException;
}
