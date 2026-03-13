package com.equitybank.gag.papss.its.jpos.jposService;

import com.equitybank.gag.papss.its.enums.TransactionType;
import com.equitybank.gag.papss.its.exception.CustomException;
import org.jpos.iso.ISOMsg;

public interface SendToFinacleService {
    ISOMsg sendTransaction(String rrn, ISOMsg isoMsg, String bankId, TransactionType type) throws CustomException;

    ISOMsg sendStatusCheck(String rrn, ISOMsg isoMsg, String bankId, TransactionType type) throws CustomException;

    ISOMsg sendAccountEnquiry(String rrn, ISOMsg isoMsg, String bankId, TransactionType type) throws CustomException;

    ISOMsg sendReversalRequest(String rrn, ISOMsg isoMsg, String bankId, TransactionType type) throws CustomException;
}

