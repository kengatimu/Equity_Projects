package com.equitybank.gag.papss.ips.service;

import com.equitybank.gag.papss.ips.exception.CustomException;

public interface GenerateXMLDigitalSignatureService {
    String generateXMLDigitalSignature(String rrn, String isoXmlRequest, String type) throws CustomException;
}
