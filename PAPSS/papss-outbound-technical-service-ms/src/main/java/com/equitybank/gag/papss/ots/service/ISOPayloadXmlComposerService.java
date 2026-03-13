package com.equitybank.gag.papss.ots.service;

import com.equitybank.gag.papss.ots.dto.channelRequest.namecheck.ChannelNamecheckDetailsReq;
import com.equitybank.gag.papss.ots.dto.channelRequest.statusCheck.ChannelStatusCheckDetailsReq;
import com.equitybank.gag.papss.ots.dto.channelRequest.transaction.ChannelCreditTransferDetailsReq;
import com.equitybank.gag.papss.ots.entity.TransactionMaster;
import com.equitybank.gag.papss.ots.exception.CustomException;
import org.jpos.transaction.Context;

import java.util.Map;

public interface ISOPayloadXmlComposerService {
    String composeAcmt023NamecheckRequest(ChannelNamecheckDetailsReq channelNamecheckDetailsReq) throws CustomException;

    String composePacs008TransactionRequest(Context ctx, ChannelCreditTransferDetailsReq channelCreditTransferDetailsReq) throws CustomException;

    String composePacs028StatusCheckRequest(ChannelStatusCheckDetailsReq channelStatusCheckDetailsReq, TransactionMaster existingRecord) throws CustomException;

    String composeFxRateUpdateRequest(Map<String, String> fxRateParamsMap) throws CustomException;
}
