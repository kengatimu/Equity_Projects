package com.equitybank.gag.papss.ots.service;

import com.equitybank.gag.papss.ots.exception.CustomException;

public interface ISOSignatureGenerationService {
    String generateXMLDigitalSignature(String rrn, String isoXmlRequest, String type) throws CustomException;
}
