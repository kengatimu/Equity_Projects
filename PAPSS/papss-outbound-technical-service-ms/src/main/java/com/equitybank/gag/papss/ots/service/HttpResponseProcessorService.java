package com.equitybank.gag.papss.ots.service;

import com.equitybank.gag.papss.ots.exception.CustomException;
import com.equitybank.gag.papss.ots.dto.channelResponse.ChannelResponse;
import org.jpos.transaction.Context;

public interface HttpResponseProcessorService {
    ChannelResponse processNamecheckResponse(String rrn, String httpResponseString, String type) throws CustomException;

    ChannelResponse processTransactionResponse(Context ctx, String rrn, String httpResponseString, String type) throws CustomException;

    ChannelResponse processStatusCheckResponse(String rrn, String originalRrn, String httpResponseString, String type) throws CustomException;
}
