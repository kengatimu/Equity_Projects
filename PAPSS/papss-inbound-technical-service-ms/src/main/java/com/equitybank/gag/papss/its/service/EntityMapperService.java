package com.equitybank.gag.papss.its.service;

import com.equitybank.gag.papss.its.entity.TransactionMaster;
import com.equitybank.gag.papss.its.pojo.channelResponse.ChannelResponse;

import java.util.Map;

public interface EntityMapperService {
    TransactionMaster composeInitialCreditTransferEntity(String rrn, Map<String, String> requestMap);

    TransactionMaster composeDbStatusDetailsEntity(String rrn, ChannelResponse channelResponse, TransactionMaster existingRecord);

    TransactionMaster composeFailedStatus(String rrn, TransactionMaster existingRecord, Map<String, String> errorMessageMap);
}
