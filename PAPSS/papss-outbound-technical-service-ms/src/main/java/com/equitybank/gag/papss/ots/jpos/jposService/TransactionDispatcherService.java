package com.equitybank.gag.papss.ots.jpos.jposService;

import com.equitybank.gag.papss.ots.dto.channelRequest.transaction.ChannelCreditTransferDetailsReq;
import com.equitybank.gag.papss.ots.exception.CustomException;

public interface TransactionDispatcherService {

    // Dispatches an incoming ChannelCreditTransferDetailsReq to the least busy TM queue.
    void dispatch(ChannelCreditTransferDetailsReq req) throws CustomException;
}