package com.equitybank.gag.papss.its.service;


import com.equitybank.gag.papss.its.exception.CustomException;

public interface ISOSignatureGenerationService {
    String generateXMLDigitalSignature(String rrn, String isoXmlRequest, String type) throws CustomException;
}
