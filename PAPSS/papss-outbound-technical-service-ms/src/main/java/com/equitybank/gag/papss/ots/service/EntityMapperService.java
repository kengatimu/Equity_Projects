package com.equitybank.gag.papss.ots.service;

import com.equitybank.gag.papss.ots.entity.TransactionMaster;
import com.equitybank.gag.papss.ots.dto.channelRequest.transaction.ChannelCreditTransferDetailsReq;
import com.equitybank.gag.papss.ots.dto.channelResponse.ChannelResponse;
import com.equitybank.gag.papss.ots.exception.CustomException;

import java.util.Map;

public interface EntityMapperService {
    TransactionMaster composeInitialCreditTransferEntity(ChannelCreditTransferDetailsReq channelCreditTransferDetailsReq) throws CustomException;

    TransactionMaster composeDbStatusDetailsEntity(String rrn, ChannelResponse channelResponse, TransactionMaster existingRecord);

    TransactionMaster composeDbFinalStatusDetailsEntity(String rrn, ChannelResponse channelResponse, TransactionMaster existingRecord);

    TransactionMaster composeFailedStatus(String rrn, TransactionMaster existingRecord, Map<String, String> errorMessageMap);
}
