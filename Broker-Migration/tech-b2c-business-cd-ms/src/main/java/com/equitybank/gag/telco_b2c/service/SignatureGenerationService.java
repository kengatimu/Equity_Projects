package com.equitybank.gag.telco_b2c.service;

import com.equitybank.gag.telco_b2c.dto.airtime.request.Envelope;
import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.exception.CustomException;

public interface SignatureGenerationService {
    String generateTransactionSignature(request request) throws CustomException;

    String generateAirtimeSignature(Envelope airtimeRequest) throws CustomException;
}
