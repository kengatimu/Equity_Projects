package com.bishop.papss_channel_mock_service.service;

import com.bishop.papss_channel_mock_service.dto.channelRequest.namecheck.ChannelNamecheckDetailsReq;
import com.bishop.papss_channel_mock_service.dto.channelRequest.statusCheck.ChannelStatusCheckDetailsReq;
import com.bishop.papss_channel_mock_service.dto.channelRequest.transaction.ChannelCreditTransferDetailsReq;
import com.bishop.papss_channel_mock_service.dto.channelResponse.ChannelResponse;
import com.bishop.papss_channel_mock_service.enums.TransactionType;
import com.bishop.papss_channel_mock_service.exception.CustomException;

public interface ProcessRequestService {
    ChannelResponse processNamecheck (ChannelNamecheckDetailsReq namecheckRequest, TransactionType type) throws CustomException;

    ChannelResponse processTransaction (ChannelCreditTransferDetailsReq transactionRequest, TransactionType type) throws CustomException;

    ChannelResponse processStatusCheck(ChannelStatusCheckDetailsReq statusCheckDetailsReq, TransactionType type) throws CustomException;
}
