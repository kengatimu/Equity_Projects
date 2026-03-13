package com.equitybank.gag.papss.its.jpos.jposService;

import com.equitybank.gag.papss.its.exception.CustomException;
import com.equitybank.gag.papss.its.pojo.papssMessages.InboundMessageReqObject;

public interface TransactionDispatcherService {
    void dispatch(InboundMessageReqObject inboundPapssReq) throws CustomException;
}
