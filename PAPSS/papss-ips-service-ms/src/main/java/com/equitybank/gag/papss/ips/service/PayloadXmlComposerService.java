package com.equitybank.gag.papss.ips.service;

import com.equitybank.gag.papss.ips.pojo.channelRequest.namecheck.ChannelNamecheckDetailsReq;
import com.equitybank.gag.papss.ips.pojo.channelRequest.transaction.ChannelCreditTransferDetailsReq;

public interface PayloadXmlComposerService {
    String composeAcmt023NamecheckRequest(ChannelNamecheckDetailsReq channelNamecheckDetailsReq);

    String composePacs008TransactionRequest(ChannelCreditTransferDetailsReq channelCreditTransferDetailsReq);
}
