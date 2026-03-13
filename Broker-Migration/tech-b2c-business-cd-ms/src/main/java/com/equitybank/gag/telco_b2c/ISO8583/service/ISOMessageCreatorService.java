package com.equitybank.gag.telco_b2c.ISO8583.service;

import com.equitybank.gag.telco_b2c.dto.airtime.request.Envelope;
import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import org.jpos.iso.ISOMsg;

import java.util.Map;

public interface ISOMessageCreatorService {
    ISOMsg createMainTransactionIsoMsg(TransactionDetails transactionDetails, request request, Envelope airtimeRequest, Map<String, String> xmlTagsMap, String type) throws CustomException;
}
