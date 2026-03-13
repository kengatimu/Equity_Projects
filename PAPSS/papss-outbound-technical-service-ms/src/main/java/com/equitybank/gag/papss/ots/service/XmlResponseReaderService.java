package com.equitybank.gag.papss.ots.service;

import com.equitybank.gag.papss.ots.exception.CustomException;
import org.jpos.transaction.Context;

import java.util.Map;

public interface XmlResponseReaderService {
    Map<String, String> processXmlResponse (Context ctx, String rrn, String originalRrn, String xmlContent, String type) throws CustomException;
}
