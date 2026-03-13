package com.equitybank.gag.papss.ots.service;

import com.equitybank.gag.papss.ots.dto.channelRequest.fxRate.GetFxRateReq;
import com.equitybank.gag.papss.ots.dto.channelRequest.getParticipants.GetPapssParticipantsReq;
import com.equitybank.gag.papss.ots.exception.CustomException;
import com.equitybank.gag.papss.ots.dto.channelResponse.ChannelResponse;
import org.jpos.transaction.Context;

public interface HttpAdapterService {
    String sendHttpGetParticipants(String rrn, GetPapssParticipantsReq getPapssParticipantsReq) throws CustomException;

    String sendHttpFxRateRequest(String rrn, GetFxRateReq getFxRateReq) throws CustomException;

    String sendHttpNamecheckRequest(String rrn, String signedAcmt023XmlReq, String type) throws CustomException;

    String sendHttpTransactionRequest(Context ctx, String rrn, String signedPacs008XmlReq, String type) throws CustomException;

    void sendHttpChannelCallbackResponse(String rrn, String channelCallbackUrl, ChannelResponse channelResponse) throws CustomException;

    String sendHttpStatusCheckRequest(String rrn, String signedPacs028XmlReq, String type) throws CustomException;

}
