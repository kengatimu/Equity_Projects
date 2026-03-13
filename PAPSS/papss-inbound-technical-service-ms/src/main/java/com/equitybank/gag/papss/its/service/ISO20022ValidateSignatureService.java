package com.equitybank.gag.papss.its.service;

import com.equitybank.gag.papss.its.exception.CustomException;

public interface ISO20022ValidateSignatureService {
    void validateSignature(String rrn, String namecheckRequestXml) throws CustomException;
}
