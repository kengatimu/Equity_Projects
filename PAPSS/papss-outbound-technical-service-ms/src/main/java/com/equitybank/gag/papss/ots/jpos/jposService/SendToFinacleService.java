package com.equitybank.gag.papss.ots.jpos.jposService;

import com.equitybank.gag.papss.ots.enums.TransactionType;
import com.equitybank.gag.papss.ots.exception.CustomException;
import org.jpos.iso.ISOMsg;

public interface SendToFinacleService {
    ISOMsg sendTransaction(String rrn, ISOMsg isoMsg, String bankId, TransactionType type, String leg) throws CustomException;

    ISOMsg sendStatusCheck(String rrn, ISOMsg isoMsg, String bankId, TransactionType type) throws CustomException;

    ISOMsg sendAccountInquiry(String rrn, ISOMsg isoMsg, String bankId, TransactionType type) throws CustomException;

    ISOMsg sendReversalRequest(String rrn, ISOMsg isoMsg, String bankId, TransactionType type, String leg) throws CustomException;
}

