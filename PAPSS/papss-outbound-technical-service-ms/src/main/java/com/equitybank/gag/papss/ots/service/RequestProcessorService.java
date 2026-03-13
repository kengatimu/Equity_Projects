package com.equitybank.gag.papss.ots.service;

import com.equitybank.gag.papss.ots.dto.channelRequest.fxRate.GetFxRateReq;
import com.equitybank.gag.papss.ots.dto.channelRequest.getParticipants.GetPapssParticipantsReq;
import com.equitybank.gag.papss.ots.dto.channelRequest.statusCheck.ChannelStatusCheckDetailsReq;
import com.equitybank.gag.papss.ots.enums.TransactionType;
import com.equitybank.gag.papss.ots.exception.CustomException;
import com.equitybank.gag.papss.ots.dto.channelRequest.namecheck.ChannelNamecheckDetailsReq;
import com.equitybank.gag.papss.ots.dto.channelRequest.transaction.ChannelCreditTransferDetailsReq;
import com.equitybank.gag.papss.ots.dto.channelResponse.ChannelResponse;
import org.springframework.validation.BindingResult;

import java.util.Map;

public interface RequestProcessorService {
    ChannelResponse processGetParticipants(String rrn, GetPapssParticipantsReq getPapssParticipantsReq, BindingResult bindingResult) throws CustomException;

    ChannelResponse processGetFxRateRequest(String rrn, GetFxRateReq getFxRateReq, BindingResult bindingResult) throws CustomException;

    ChannelResponse processNamecheckRequest(ChannelNamecheckDetailsReq channelNamecheckDetailsReq, BindingResult bindingResult, String type) throws CustomException;

    ChannelResponse processTransactionRequest(ChannelCreditTransferDetailsReq channelCreditTransferDetailsReq, BindingResult bindingResult, String type) throws CustomException;

    ChannelResponse processStatusCheckRequest(ChannelStatusCheckDetailsReq statusCheckDetailsReq, BindingResult bindingResult, String type) throws CustomException;

    void processCallbackResponse (String rrn, String creditTransferCallbackXml, TransactionType type);

}
