package com.equitybank.gag.papss.its.jpos.jposService;

import com.equitybank.gag.papss.its.exception.CustomException;
import org.jpos.iso.ISOMsg;

import java.util.Map;

public interface ISOMessageBuilderService {
    ISOMsg buildTransactionMessage(String rrn, Map<String, String> requestMap, String transactionCurrency) throws CustomException;

    ISOMsg buildReversalMessage(String rrn) throws CustomException;

    ISOMsg buildAccountEnquiryMessage(String rrn, String accountNumber) throws CustomException;

}
