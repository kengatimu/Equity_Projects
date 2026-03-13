package com.bishop.papss_channel_mock_service.service;

import com.bishop.papss_channel_mock_service.dto.channelRequest.namecheck.ChannelNamecheckDetailsReq;
import com.bishop.papss_channel_mock_service.dto.channelRequest.statusCheck.ChannelStatusCheckDetailsReq;
import com.bishop.papss_channel_mock_service.dto.channelRequest.transaction.ChannelCreditTransferDetailsReq;
import com.bishop.papss_channel_mock_service.dto.channelResponse.ChannelResponse;
import com.bishop.papss_channel_mock_service.exception.CustomException;

public interface HttpAdapterService {
    ChannelResponse sendNamecheckRequest(ChannelNamecheckDetailsReq namecheckRequest) throws CustomException;

    ChannelResponse sendTransactionRequest(ChannelCreditTransferDetailsReq transactionRequest) throws CustomException;

    ChannelResponse sendStatusCheckRequest(ChannelStatusCheckDetailsReq statusCheckDetailsReq) throws CustomException;
}
