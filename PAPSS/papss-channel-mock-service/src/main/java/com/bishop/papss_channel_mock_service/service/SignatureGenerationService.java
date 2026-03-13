package com.bishop.papss_channel_mock_service.service;

import com.bishop.papss_channel_mock_service.dto.channelRequest.namecheck.ChannelNamecheckDetailsReq;
import com.bishop.papss_channel_mock_service.dto.channelRequest.statusCheck.ChannelStatusCheckDetailsReq;
import com.bishop.papss_channel_mock_service.dto.channelRequest.transaction.ChannelCreditTransferDetailsReq;
import com.bishop.papss_channel_mock_service.exception.CustomException;

public interface SignatureGenerationService {
    String generateNamecheckSignature(ChannelNamecheckDetailsReq namecheckRequest) throws CustomException;

    String generateTransactionSignature(ChannelCreditTransferDetailsReq transactionRequest) throws CustomException;

    String generateStatusCheckSignature(ChannelStatusCheckDetailsReq statusCheckDetailsReq) throws CustomException;
}
