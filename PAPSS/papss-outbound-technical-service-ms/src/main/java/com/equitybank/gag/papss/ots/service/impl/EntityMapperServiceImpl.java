package com.equitybank.gag.papss.ots.service.impl;

import com.equitybank.gag.papss.ots.entity.*;
import com.equitybank.gag.papss.ots.enums.OperationType;
import com.equitybank.gag.papss.ots.enums.TransactionStatus;
import com.equitybank.gag.papss.ots.enums.TransactionType;
import com.equitybank.gag.papss.ots.dto.channelRequest.transaction.ChannelCreditTransferDetailsReq;
import com.equitybank.gag.papss.ots.dto.channelResponse.ChannelResponse;
import com.equitybank.gag.papss.ots.exception.CustomException;
import com.equitybank.gag.papss.ots.service.DateService;
import com.equitybank.gag.papss.ots.service.EntityMapperService;
import com.google.gson.Gson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Map;

import static com.equitybank.gag.papss.ots.config.ApplicationConstants.TAX_RATE;
import static com.equitybank.gag.papss.ots.enums.TransactionStatus.FINACLE_INITIAL;

@Service
public class EntityMapperServiceImpl implements EntityMapperService {
    private static final Logger log = LoggerFactory.getLogger(EntityMapperServiceImpl.class);

    private final Gson gson;
    private final String kesCreditGL;
    private final String usdCreditGL;
    private final String commissionGl;
    private final DateService dateService;

    @Autowired
    public EntityMapperServiceImpl(Gson gson,
                                   @Value("${accounts.credit-gl.papss-settlement.kes}") String kesCreditGL,
                                   @Value("${accounts.credit-gl.papss-settlement.usd}") String usdCreditGL,
                                   @Value("${accounts.credit-gl.bank-income.kes}") String commissionGl,
                                   DateService dateService) {
        this.gson = gson;
        this.kesCreditGL = kesCreditGL;
        this.usdCreditGL = usdCreditGL;
        this.commissionGl = commissionGl;
        this.dateService = dateService;
    }

    @Override
    public TransactionMaster composeInitialCreditTransferEntity(ChannelCreditTransferDetailsReq channelCreditTransferDetailsReq) throws CustomException {

//        String creditGl = usdCreditGL;
//        if ("KES".equalsIgnoreCase(currency)) {
//            creditGl = kesCreditGL;
//        }

        String rrn = channelCreditTransferDetailsReq.getChannelInfo().getRrn();
        String currency = channelCreditTransferDetailsReq.getTransactionInfo().getTransactionCurrency();
        BigDecimal bankFeeAmountBigDecimal = new BigDecimal(channelCreditTransferDetailsReq.getTransactionInfo().getBankFeeAmount());
        BigDecimal papssFeeAmountBigDecimal = new BigDecimal(channelCreditTransferDetailsReq.getTransactionInfo().getPapssFeeAmount());
        BigDecimal bankFeeTaxBigDecimal = bankFeeAmountBigDecimal.multiply(new BigDecimal(TAX_RATE));
        BigDecimal papssFeeTaxBigDecimal = papssFeeAmountBigDecimal.multiply(new BigDecimal(TAX_RATE));
        BigDecimal totalTaxBigDecimal = bankFeeTaxBigDecimal.add(papssFeeTaxBigDecimal);

        SenderDetails senderDetails = new SenderDetails();
        senderDetails.setRrn(rrn);
        senderDetails.setInstitutionId(channelCreditTransferDetailsReq.getSender().getInstitutionId());
        senderDetails.setBic(channelCreditTransferDetailsReq.getSender().getBic());
        senderDetails.setCountryCode(channelCreditTransferDetailsReq.getSender().getCountryCode());
        senderDetails.setCurrency(channelCreditTransferDetailsReq.getSender().getCurrency());
        senderDetails.setAccountNumber(channelCreditTransferDetailsReq.getSender().getAccountNumber());
        senderDetails.setAccountName(channelCreditTransferDetailsReq.getSender().getAccountName());
        senderDetails.setAddress(channelCreditTransferDetailsReq.getSender().getAddress());
        senderDetails.setCreatedAt(dateService.getUtcNow());

        ReceiverDetails receiverDetails = new ReceiverDetails();
        receiverDetails.setRrn(rrn);
        receiverDetails.setInstitutionId(channelCreditTransferDetailsReq.getReceiver().getInstitutionId());
        receiverDetails.setBic(channelCreditTransferDetailsReq.getReceiver().getBic());
        receiverDetails.setCountryCode(channelCreditTransferDetailsReq.getReceiver().getCountryCode());
        receiverDetails.setCurrency(channelCreditTransferDetailsReq.getReceiver().getCurrency());
        receiverDetails.setAccountNumber(channelCreditTransferDetailsReq.getReceiver().getAccountNumber());
        receiverDetails.setAccountName(channelCreditTransferDetailsReq.getReceiver().getAccountName());
        receiverDetails.setEmailAddress(channelCreditTransferDetailsReq.getReceiver().getEmailAddress());
        receiverDetails.setCreatedAt(dateService.getUtcNow());

        ChannelInfo channelInfo = new ChannelInfo();
        channelInfo.setRrn(rrn);
        channelInfo.setChannelId(channelCreditTransferDetailsReq.getChannelInfo().getChannelId());
        channelInfo.setSourceSystemId(channelCreditTransferDetailsReq.getChannelInfo().getSourceSystemId());
        channelInfo.setCallbackUrl(channelCreditTransferDetailsReq.getChannelInfo().getCallbackURL());
        channelInfo.setCreatedAt(dateService.getUtcNow());

        FinacleTransaction finacleTransaction = new FinacleTransaction();
        finacleTransaction.setRrn(rrn);
        finacleTransaction.setDebitAccount(channelCreditTransferDetailsReq.getSender().getAccountNumber());
        finacleTransaction.setCreditAccount(usdCreditGL);
        finacleTransaction.setCommissionAccount(commissionGl);
        finacleTransaction.setFinacleStatus(FINACLE_INITIAL);
        finacleTransaction.setFinacleResponseCode("");
        finacleTransaction.setFinacleResponseDesc("");
        finacleTransaction.setAmount(new BigDecimal(channelCreditTransferDetailsReq.getTransactionInfo().getSenderAmount()));
        finacleTransaction.setFeeAmount(new BigDecimal(channelCreditTransferDetailsReq.getTransactionInfo().getBankFeeAmount()));
        finacleTransaction.setTransactionCurrency(channelCreditTransferDetailsReq.getSender().getCurrency());
        finacleTransaction.setFinacleTranId("");
        finacleTransaction.setReversalStatus(FINACLE_INITIAL);
        finacleTransaction.setReversalResponseCode("");
        finacleTransaction.setReversalResponseDesc("");
        finacleTransaction.setReversalAmount(BigDecimal.ZERO);
        finacleTransaction.setReversalFeeAmount(BigDecimal.ZERO);
        finacleTransaction.setReversalTransactionRef("");
        finacleTransaction.setReversalCreatedAt(dateService.getUtcNow());
        finacleTransaction.setReversalCompletedAt(dateService.getUtcNow());
        finacleTransaction.setCreatedAt(dateService.getUtcNow());
        finacleTransaction.setUpdatedAt(dateService.getUtcNow());

        PapssCallbackDetails papssCallbackDetails = new PapssCallbackDetails();
        papssCallbackDetails.setRrn(rrn);
        papssCallbackDetails.setPapssStatus("");
        papssCallbackDetails.setPapssStatusCode("");
        papssCallbackDetails.setPapssReasonCode("");
        papssCallbackDetails.setPapssStatusDescription("");
        papssCallbackDetails.setReceivedAt(dateService.getUtcNow());
        papssCallbackDetails.setCreatedAt(dateService.getUtcNow());
        papssCallbackDetails.setUpdatedAt(dateService.getUtcNow());

        TransactionPayload transactionPayload = new TransactionPayload();
        transactionPayload.setRrn(rrn);
        transactionPayload.setChannelRequest(gson.toJson(channelCreditTransferDetailsReq));
        transactionPayload.setChannelResponse("");
        transactionPayload.setChannelCallbackResponse("");
        transactionPayload.setFinChargesIsoRequest(new byte[0]);
        transactionPayload.setFinChargesIsoResponse(new byte[0]);
        transactionPayload.setFinTxnIsoRequest(new byte[0]);
        transactionPayload.setFinTxnIsoResponse(new byte[0]);
        transactionPayload.setFinTxnReversalIsoRequest(new byte[0]);
        transactionPayload.setFinTxnReversalIsoResponse(new byte[0]);
        transactionPayload.setFinChargesReversalIsoRequest(new byte[0]);
        transactionPayload.setFinChargesReversalIsoResponse(new byte[0]);
        transactionPayload.setCreatedAt(dateService.getUtcNow());
        transactionPayload.setUpdatedAt(dateService.getUtcNow());

        TransactionMaster entity = new TransactionMaster();
        entity.setSenderDetails(senderDetails);
        entity.setReceiverDetails(receiverDetails);
        entity.setChannelInfo(channelInfo);
        entity.setFinacleTransaction(finacleTransaction);
        entity.setPapssCallbackDetails(papssCallbackDetails);
        entity.setTransactionPayload(transactionPayload);

        // Other TransactionMaster Entries
        entity.setRrn(rrn);
        entity.setEndToEndId(rrn);
        entity.setBankId(channelCreditTransferDetailsReq.getChannelInfo().getBankId());
        entity.setChannelId(channelCreditTransferDetailsReq.getChannelInfo().getChannelId());
        entity.setSourceSystemId(channelCreditTransferDetailsReq.getChannelInfo().getSourceSystemId());
        entity.setIpsStatus("");
        entity.setIpsStatusCode("");
        entity.setIpsStatusDescription("");
        entity.setIpsStatusReason("");
        entity.setStatus(TransactionStatus.PENDING);
        entity.setResponseCode("");
        entity.setResponseMessage("");
        entity.setFinacleStatus(FINACLE_INITIAL);
        entity.setFinacleResponseCode("");
        entity.setFinacleResponseMessage("");
        entity.setOperationType(OperationType.OUTBOUND);
        entity.setTransactionType(TransactionType.CREDIT_TRANSFER);
        entity.setFxRate(channelCreditTransferDetailsReq.getTransactionInfo().getFxRate());
        entity.setSenderAmount(new BigDecimal(channelCreditTransferDetailsReq.getTransactionInfo().getSenderAmount()));
        entity.setReceiverAmount(new BigDecimal(channelCreditTransferDetailsReq.getTransactionInfo().getReceiverAmount()));
        entity.setBankFeeAmount(bankFeeAmountBigDecimal);
        entity.setPapssFeeAmount(papssFeeAmountBigDecimal);
        entity.setBankFeeTax(bankFeeTaxBigDecimal);
        entity.setPapssFeeTax(papssFeeTaxBigDecimal);
        entity.setTotalTaxAmount(totalTaxBigDecimal);
        entity.setBankFeeAmountNet(bankFeeAmountBigDecimal.subtract(bankFeeTaxBigDecimal));
        entity.setPapssFeeAmountNet(papssFeeAmountBigDecimal.subtract(papssFeeTaxBigDecimal));
        entity.setTransactionCurrency(channelCreditTransferDetailsReq.getSender().getCurrency());
        entity.setSourceCurrency(channelCreditTransferDetailsReq.getSender().getCurrency());
        entity.setDestinationCurrency(channelCreditTransferDetailsReq.getReceiver().getCurrency());
        entity.setDestinationCountry(channelCreditTransferDetailsReq.getReceiver().getCountryCode());
        entity.setPaymentReason(channelCreditTransferDetailsReq.getTransactionInfo().getPaymentReason());
        entity.setNarration(channelCreditTransferDetailsReq.getTransactionInfo().getNarration());
        entity.setCreatedAt(dateService.getUtcNow());
        entity.setUpdatedAt(dateService.getUtcNow());
        entity.setCompletedAt(dateService.getUtcNow());
        entity.setPapssMessageId(rrn);
        entity.setPapssTxnCreationTime(String.valueOf(dateService.getUtcNow()));

        return entity;
    }

    @Override
    public TransactionMaster composeDbStatusDetailsEntity(String rrn, ChannelResponse channelResponse, TransactionMaster existingRecord) {
        String papssDesc = channelResponse.getIpsStatusInfo().getStatus().getDescription();
        String papssStatusDescription = (papssDesc == null) ? "" : papssDesc.substring(0, Math.min(250, papssDesc.length()));

        TransactionPayload transactionPayload = existingRecord.getTransactionPayload();
        transactionPayload.setChannelResponse(gson.toJson(channelResponse));
        transactionPayload.setUpdatedAt(dateService.getUtcNow());
        existingRecord.setTransactionPayload(transactionPayload);

        existingRecord.setStatus(TransactionStatus.valueOf(channelResponse.getOriginalTxnStatusInfo().getStatus()));
        existingRecord.setResponseCode(channelResponse.getOriginalTxnStatusInfo().getCode());
        existingRecord.setResponseMessage(channelResponse.getOriginalTxnStatusInfo().getDescription());
        existingRecord.setIpsStatus(channelResponse.getIpsStatusInfo().getStatus().getType());
        existingRecord.setIpsStatusReason(channelResponse.getIpsStatusInfo().getStatus().getReason());
        existingRecord.setIpsStatusCode(channelResponse.getIpsStatusInfo().getStatus().getCode());
        existingRecord.setIpsStatusDescription(papssStatusDescription);
        existingRecord.setUpdatedAt(dateService.getUtcNow());
        existingRecord.setCompletedAt(dateService.getUtcNow());

        return existingRecord;
    }

    @Override
    public TransactionMaster composeDbFinalStatusDetailsEntity(String rrn, ChannelResponse channelResponse, TransactionMaster existingRecord) {
        String papssStatus = channelResponse.getIpsStatusInfo().getStatus().getType() == null ? "" : channelResponse.getIpsStatusInfo().getStatus().getType();
        String papssStatusCode = channelResponse.getIpsStatusInfo().getStatus().getCode() == null ? "" : channelResponse.getIpsStatusInfo().getStatus().getCode();
        String papssStatusReason = channelResponse.getIpsStatusInfo().getStatus().getReason() == null ? "" : channelResponse.getIpsStatusInfo().getStatus().getReason();
        String papssDesc = channelResponse.getIpsStatusInfo().getStatus().getDescription();
        String papssStatusDescription = (papssDesc == null) ? "" : papssDesc.substring(0, Math.min(250, papssDesc.length()));

        TransactionPayload transactionPayload = existingRecord.getTransactionPayload();
        transactionPayload.setChannelCallbackResponse(gson.toJson(channelResponse));
        transactionPayload.setUpdatedAt(dateService.getUtcNow());
        existingRecord.setTransactionPayload(transactionPayload);

        PapssCallbackDetails papssCallbackDetails = existingRecord.getPapssCallbackDetails();
        papssCallbackDetails.setPapssStatus(papssStatus);
        papssCallbackDetails.setPapssStatusCode(papssStatusCode);
        papssCallbackDetails.setPapssReasonCode(papssStatusReason);
        papssCallbackDetails.setPapssStatusDescription(papssStatusDescription);
        papssCallbackDetails.setReceivedAt(dateService.getUtcNow());
        existingRecord.setPapssCallbackDetails(papssCallbackDetails);

        existingRecord.setStatus(TransactionStatus.valueOf(channelResponse.getChannelStatusInfo().getStatus()));
        existingRecord.setResponseCode(channelResponse.getChannelStatusInfo().getCode());
        existingRecord.setResponseMessage(channelResponse.getChannelStatusInfo().getDescription());
        existingRecord.setIpsStatus(papssStatus);
        existingRecord.setIpsStatusReason(papssStatusReason);
        existingRecord.setIpsStatusCode(papssStatusCode);
        existingRecord.setIpsStatusDescription(papssStatusDescription);
        existingRecord.setUpdatedAt(dateService.getUtcNow());
        existingRecord.setCompletedAt(dateService.getUtcNow());

        return existingRecord;
    }

    @Override
    public TransactionMaster composeFailedStatus(String rrn, TransactionMaster existingRecord, Map<String, String> errorMessageMap) {
        existingRecord.setStatus(TransactionStatus.valueOf(errorMessageMap.getOrDefault("status", "FAILURE")));
        existingRecord.setResponseCode(errorMessageMap.getOrDefault("errorCode", "01"));
        existingRecord.setResponseMessage(errorMessageMap.getOrDefault("errorDescription", "FAILURE"));
        existingRecord.setUpdatedAt(dateService.getUtcNow());
        existingRecord.setCompletedAt(dateService.getUtcNow());

        return existingRecord;
    }
}
