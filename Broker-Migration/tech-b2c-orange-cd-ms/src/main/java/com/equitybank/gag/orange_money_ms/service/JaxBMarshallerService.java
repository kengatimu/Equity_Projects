package com.equitybank.gag.orange_money_ms.service;

import com.equitybank.gag.orange_money_ms.dto.b2c.status.request.StatusEnvelope;
import com.equitybank.gag.orange_money_ms.dto.b2c.tran.request.Envelope;
import com.equitybank.gag.orange_money_ms.exception.CustomException;

public interface JaxBMarshallerService {

    String marshallTransactionRequestToXml(Envelope request, String rrn) throws CustomException;

    String marshallStatusCheckRequestToXml(StatusEnvelope request, String rrn) throws CustomException;
}
