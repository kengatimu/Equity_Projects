package com.equitybank.gag.telco_b2c.mapper;

import com.equitybank.gag.telco_b2c.dto.airtime.request.Envelope;
import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.dto.thunes.transfer.transaction.TransactionRequestDto;
import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.enums.CbsStatus;
import org.jpos.iso.ISOMsg;

import java.util.Map;

public interface CustomMapperService {
    TransactionDetails composeInitialTransactionEntity(request request, String type);

    TransactionDetails composeInitialFloatPurchaseToEntity(request request, String type);

    TransactionDetails composeEntityForErrorResponseUpdate(String xmlResponse, String rrn, String errorCode, String errorDescription, String status, String type);

    TransactionDetails composeInitialAirtimeTopUpEntity(Envelope request, String type);

    TransactionDetails composeIsoRequestMessageEntity(ISOMsg isoMessage, String rrn, String type);

    TransactionDetails composeIsoResponseMessageEntity(ISOMsg isoTransactionResponse, String rrn, String type);

    TransactionDetails composeFinacleStatusEntity(String rrn, String type, CbsStatus status, String errorDesc, String responseCode);

    TransactionDetails composeFinacleSuccessEntity(String rrn, String type, String cbsTranId);

    TransactionDetails composeReversalFailureEntity(String rrn, String type, String reversalStatusMsg);

    TransactionDetails composeFinacleReversalSuccessEntity(String rrn, String type);

    TransactionDetails composeInitialMGFeeLookupToEntity(String requestXml, Map<String, String> xmlStringMap, String rrn, String type);

    TransactionDetails composeInitialReferenceNumberReqToEntity(String requestXml, Map<String, String> xmlStringMap, String rrn, String type);

    TransactionDetails composeImtSuccessResponseEntity(TransactionDetails transactionDetails, Map<String, String> responseDetailsMap, String responseXml, String rrn, String type);

    TransactionDetails composeChargeEntity(String charge, String rrn, String type);

    TransactionDetails composeTransactionRecordEntity(TransactionDetails transactionRecord, Map<String, String> xmlTagsMap, String type);

    TransactionDetails composeCallbackEntity(String rrn, String tranStatus, String statusMessage, String requestBodyString, String type);

    TransactionDetails composeTelcoPendingStatusEntity(String rrn, String responseXmlString, String type);

    TransactionDetails composeTelcoCallbackEntity(Map<String, String> xmlTagsMap, String rrn, String responseXmlString, String type);

    TransactionDetails composeDbStatus(String rrn, Map<String, String> receivedValuesMap, String responseXmlString, String type);

    TransactionDetails composeInitialThunesTransactionEntity(TransactionRequestDto req, String type);
}
