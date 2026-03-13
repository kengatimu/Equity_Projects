package com.equitybank.gag.papss.ots.service;

import com.equitybank.gag.papss.ots.dto.channelResponse.ChannelResponse;
import com.equitybank.gag.papss.ots.entity.TransactionMaster;
import com.equitybank.gag.papss.ots.exception.CustomException;

import java.util.Map;

public interface PayloadChannelResponseComposerService {
    ChannelResponse composeGetParticipantsResponse(String xmlResponse) throws CustomException;

    ChannelResponse composeGetFxRateResponse(String xmlResponse) throws CustomException;

    ChannelResponse composeNamecheckResponse(String rrn, Map<String, String> resultMap, String type);

    ChannelResponse composeTransactionResponse(String rrn, Map<String, String> resultMap, String type);

    ChannelResponse composeStatusCheckResponse(String rrn, Map<String, String> resultMap, String type);

    ChannelResponse composePendingResponse(String rrn, Map<String, String> resultMap);

    ChannelResponse composeStatusCheckDbResponse(String originalRrn, TransactionMaster entity) throws CustomException;

}
