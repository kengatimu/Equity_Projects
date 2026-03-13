package com.equitybank.gag.telco_b2c.ISO8583.service;

import com.equitybank.gag.telco_b2c.exception.CustomException;
import org.jpos.iso.ISOMsg;

public interface FinacleCallerService {
    ISOMsg sendFinacleISORequest(ISOMsg request, String bankId, String rrn, String type, String mainTransaction) throws CustomException;

    ISOMsg sendFinacleInquireISORequest(ISOMsg statusReq, String bankId, String rrn) throws CustomException;
}
