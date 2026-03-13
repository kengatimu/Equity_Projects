package com.equitybank.gag.orange_money_ms.mapper;

import com.equitybank.gag.orange_money_ms.dto.b2c.status.request.StatusEnvelope;
import com.equitybank.gag.orange_money_ms.dto.channel.response.request;
import com.equitybank.gag.orange_money_ms.entity.TransactionDetails;
import com.equitybank.gag.orange_money_ms.exception.CustomException;

public interface CustomMapperService {
    TransactionDetails composeEntityForErrorResponseUpdate(String xmlResponse, String rrn, String errorCode, String errorDescription);

    String composeTelcoTransactionRequestString(request channelRequest) throws CustomException;

    String composeTelcoStatusCheckRequestString(String rrn) throws CustomException;

    TransactionDetails composeEntityForPendingResponseUpdate(String rrn);

    TransactionDetails composeEntityForTelcoRequestUpdate(String rrn, String telcoJsonReq);

    TransactionDetails composeEntityForTelcoResponseUpdate(String rrn, String telcoJsonRes);

    TransactionDetails composeEntityForTranIdUpdate(String tranId, String rrn);

    TransactionDetails composeEntityForFinalStatusSuccess(String telcoResponseString, String xmlResponseString, String rrn);
}
