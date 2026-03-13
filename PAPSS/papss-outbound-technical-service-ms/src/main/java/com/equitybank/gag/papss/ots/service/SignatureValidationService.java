package com.equitybank.gag.papss.ots.service;

import com.equitybank.gag.papss.ots.dto.channelRequest.fxRate.GetFxRateReq;
import com.equitybank.gag.papss.ots.dto.channelRequest.getParticipants.GetPapssParticipantsReq;
import com.equitybank.gag.papss.ots.dto.channelRequest.namecheck.ChannelNamecheckDetailsReq;
import com.equitybank.gag.papss.ots.dto.channelRequest.statusCheck.ChannelStatusCheckDetailsReq;
import com.equitybank.gag.papss.ots.dto.channelRequest.transaction.ChannelCreditTransferDetailsReq;
import com.equitybank.gag.papss.ots.exception.CustomException;

public interface SignatureValidationService {
    void validateGetParticipantsSignature(GetPapssParticipantsReq getPapssParticipantsReq) throws CustomException;

    void validateGetFxRateSignature(GetFxRateReq getFxRateReq) throws CustomException;

    void validateNamecheckSignature(ChannelNamecheckDetailsReq channelNamecheckDetailsReq) throws CustomException;

    void validateTransactionSignature(ChannelCreditTransferDetailsReq channelCreditTransferDetailsReq) throws CustomException;

    void validateStatusCheckSignature(ChannelStatusCheckDetailsReq statusCheckDetailsReq) throws CustomException;

}
