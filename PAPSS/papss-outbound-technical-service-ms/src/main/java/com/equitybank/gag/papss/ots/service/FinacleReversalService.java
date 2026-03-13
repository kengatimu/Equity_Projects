package com.equitybank.gag.papss.ots.service;

import com.equitybank.gag.papss.ots.dto.channelResponse.ChannelResponse;
import com.equitybank.gag.papss.ots.entity.TransactionMaster;
import com.equitybank.gag.papss.ots.exception.CustomException;
import org.jpos.transaction.Context;

public interface FinacleReversalService {
    // Attempts a Finacle reversal based on a flag in the jPOS Context.
    void handleJposAbortReversal(Context ctx, String rrn);

    // Attempts a Finacle reversal triggered by a separate process (like a status check).
    void performConditionalStatusCheckReversal(String rrn, TransactionMaster existingRecord, ChannelResponse channelResponse) throws CustomException;
}
