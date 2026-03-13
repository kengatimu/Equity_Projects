package com.bishop.papss_channel_mock_service.service.impl;

import com.bishop.papss_channel_mock_service.dto.channelRequest.namecheck.ChannelNamecheckDetailsReq;
import com.bishop.papss_channel_mock_service.dto.channelRequest.statusCheck.ChannelStatusCheckDetailsReq;
import com.bishop.papss_channel_mock_service.dto.channelRequest.transaction.ChannelCreditTransferDetailsReq;
import com.bishop.papss_channel_mock_service.dto.channelResponse.ChannelResponse;
import com.bishop.papss_channel_mock_service.enums.TransactionType;
import com.bishop.papss_channel_mock_service.exception.CustomException;
import com.bishop.papss_channel_mock_service.service.ProcessRequestService;
import com.bishop.papss_channel_mock_service.service.SignatureGenerationService;
import com.bishop.papss_channel_mock_service.service.HttpAdapterService;
import com.google.gson.Gson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service
public class ProcessRequestServiceImpl implements ProcessRequestService {
    private static final Logger log = LoggerFactory.getLogger(ProcessRequestServiceImpl.class);

    private final Gson gson;
    private final HttpAdapterService httpAdapterService;
    private final SignatureGenerationService signatureGenerationService;

    public ProcessRequestServiceImpl(Gson gson,
                                     HttpAdapterService httpAdapterService,
                                     SignatureGenerationService signatureGenerationService) {
        this.gson = gson;
        this.httpAdapterService = httpAdapterService;
        this.signatureGenerationService = signatureGenerationService;
    }

    @Override
    public ChannelResponse processNamecheck(ChannelNamecheckDetailsReq namecheckRequest, TransactionType type) throws CustomException {
        // Generate the signature
        String signature = signatureGenerationService.generateNamecheckSignature(namecheckRequest);

        // Update signature value
        updateRequestDto(namecheckRequest, new ChannelCreditTransferDetailsReq(), new ChannelStatusCheckDetailsReq(), signature, type);

        // Send request to gag
        return httpAdapterService.sendNamecheckRequest(namecheckRequest);
    }

    @Override
    public ChannelResponse processTransaction(ChannelCreditTransferDetailsReq transactionRequest, TransactionType type) throws CustomException {
        // Generate the signature
        String signature = signatureGenerationService.generateTransactionSignature(transactionRequest);

        // Update signature value
        updateRequestDto(new ChannelNamecheckDetailsReq(), transactionRequest, new ChannelStatusCheckDetailsReq(), signature, type);

        // Send request to gag
        return httpAdapterService.sendTransactionRequest(transactionRequest);
    }

    @Override
    public ChannelResponse processStatusCheck(ChannelStatusCheckDetailsReq statusCheckDetailsReq, TransactionType type) throws CustomException {
        // Generate the signature
        String signature = signatureGenerationService.generateStatusCheckSignature(statusCheckDetailsReq);

        // Update signature value
        updateRequestDto(new ChannelNamecheckDetailsReq(), new ChannelCreditTransferDetailsReq(), statusCheckDetailsReq, signature, type);

        // Send request to gag
        return httpAdapterService.sendStatusCheckRequest(statusCheckDetailsReq);
    }

    private void updateRequestDto(ChannelNamecheckDetailsReq namecheckRequest, ChannelCreditTransferDetailsReq transactionRequest, ChannelStatusCheckDetailsReq statusCheckDetailsReq, String signature, TransactionType type) {
        if (type.equals(TransactionType.NAMECHECK)) {
            namecheckRequest.setSignature(signature);
        } else if (type.equals(TransactionType.CREDIT_TRANSFER)) {
            transactionRequest.setSignature(signature);
        }else {
            statusCheckDetailsReq.setSignature(signature);
        }
    }
}
