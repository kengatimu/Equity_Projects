package com.equitybank.gag.papss.its.service.impl;

import com.equitybank.gag.papss.its.entity.*;
import com.equitybank.gag.papss.its.enums.OperationType;
import com.equitybank.gag.papss.its.enums.TransactionStatus;
import com.equitybank.gag.papss.its.pojo.channelResponse.ChannelResponse;
import com.equitybank.gag.papss.its.service.DateService;
import com.equitybank.gag.papss.its.service.EntityMapperService;
import com.equitybank.gag.papss.its.service.PapssIdResolverService;
import com.google.gson.Gson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Map;

import static com.equitybank.gag.papss.its.config.StatusCodeMessages.*;


@Service
public class EntityMapperServiceImpl implements EntityMapperService {
    private static final Logger log = LoggerFactory.getLogger(EntityMapperServiceImpl.class);

    private final Gson gson;
    private final String debitGlKes;
    private final String debitGlUsd;
    private final String commissionGl;
    private final DateService dateService;
    private final PapssIdResolverService papssIdResolverService;

    @Autowired
    public EntityMapperServiceImpl(Gson gson,
                                   @Value("${accounts.debit-gl.papss-settlement.kes}") String debitGlKes,
                                   @Value("${accounts.debit-gl.papss-settlement.usd}") String debitGlUsd,
                                   @Value("${accounts.credit-gl.bank-income.kes}") String commissionGl,
                                   DateService dateService,
                                   PapssIdResolverService papssIdResolverService) {
        this.gson = gson;
        this.debitGlKes = debitGlKes;
        this.debitGlUsd = debitGlUsd;
        this.commissionGl = commissionGl;
        this.dateService = dateService;
        this.papssIdResolverService = papssIdResolverService;
    }

    @Override
    public TransactionMaster composeInitialCreditTransferEntity(String rrn, Map<String, String> requestMap) {
        // SENDER DETAILS
        SenderDetails senderDetails = new SenderDetails();
        senderDetails.setRrn(rrn);
        senderDetails.setInstitutionId(requestMap.getOrDefault("senderInstitutionId", ""));
        senderDetails.setBic(requestMap.getOrDefault("senderBic", ""));
        senderDetails.setCountryCode(requestMap.getOrDefault("senderCountryCode", ""));
        senderDetails.setCurrency(requestMap.getOrDefault("senderCurrency", ""));
        senderDetails.setAccountNumber(requestMap.getOrDefault("senderAccount", ""));
        senderDetails.setAccountName(requestMap.getOrDefault("senderName", ""));
        senderDetails.setAddress(requestMap.getOrDefault("senderAddress", ""));
        senderDetails.setCreatedAt(dateService.getUtcNow());

        // RECEIVER DETAILS
        ReceiverDetails receiverDetails = new ReceiverDetails();
        receiverDetails.setRrn(rrn);
        receiverDetails.setInstitutionId(papssIdResolverService.resolvePapssId());
        receiverDetails.setBic(EQUITY_SWIFT_BIC_CODE);
        receiverDetails.setCountryCode(requestMap.getOrDefault("receiverCountryCode", ""));
        receiverDetails.setCurrency(requestMap.getOrDefault("receiverCurrency", ""));
        receiverDetails.setAccountNumber(requestMap.getOrDefault("receiverAccount", ""));
        receiverDetails.setAccountName(requestMap.getOrDefault("receiverName", ""));
        receiverDetails.setEmailAddress(requestMap.getOrDefault("receiverEmail", ""));
        receiverDetails.setCreatedAt(dateService.getUtcNow());

        // CHANNEL INFO
        ChannelInfo channelInfo = new ChannelInfo();
        channelInfo.setRrn(rrn);
        channelInfo.setChannelId(requestMap.getOrDefault("channelId", ""));
        channelInfo.setSourceSystemId(requestMap.getOrDefault("sourceSystemId", ""));
        channelInfo.setCallbackUrl(requestMap.getOrDefault("callbackUrl", ""));
        channelInfo.setCreatedAt(dateService.getUtcNow());

        // FINACLE TRANSACTION
        FinacleTransaction finacleTransaction = new FinacleTransaction();
        finacleTransaction.setRrn(rrn);
        finacleTransaction.setDebitAccount(debitGlUsd);
        finacleTransaction.setCreditAccount(requestMap.getOrDefault("receiverAccount", ""));
        finacleTransaction.setCommissionAccount(commissionGl);
        finacleTransaction.setFinacleStatus(TransactionStatus.FINACLE_INITIAL);
        finacleTransaction.setFinacleResponseCode("");
        finacleTransaction.setFinacleResponseDesc("");
        finacleTransaction.setAmount(new BigDecimal(requestMap.getOrDefault("receiverAmount", "0")));
        finacleTransaction.setFeeAmount(BigDecimal.ZERO);
        finacleTransaction.setTransactionCurrency(requestMap.getOrDefault("transactionCurrency", ""));
        finacleTransaction.setFinacleTranId("");
        finacleTransaction.setReversalStatus(TransactionStatus.FINACLE_INITIAL);
        finacleTransaction.setReversalResponseCode("");
        finacleTransaction.setReversalResponseDesc("");
        finacleTransaction.setReversalAmount(BigDecimal.ZERO);
        finacleTransaction.setReversalFeeAmount(BigDecimal.ZERO);
        finacleTransaction.setReversalTransactionRef("");
        finacleTransaction.setReversalCreatedAt(dateService.getUtcNow());
        finacleTransaction.setReversalCompletedAt(dateService.getUtcNow());
        finacleTransaction.setCreatedAt(dateService.getUtcNow());
        finacleTransaction.setUpdatedAt(dateService.getUtcNow());

        // PAPSS CALLBACK DETAILS
        PapssCallbackDetails papssCallbackDetails = new PapssCallbackDetails();
        papssCallbackDetails.setRrn(rrn);
        papssCallbackDetails.setPapssStatus("");
        papssCallbackDetails.setPapssStatusCode("");
        papssCallbackDetails.setPapssReasonCode("");
        papssCallbackDetails.setPapssStatusDescription("");
        papssCallbackDetails.setReceivedAt(dateService.getUtcNow());
        papssCallbackDetails.setCreatedAt(dateService.getUtcNow());
        papssCallbackDetails.setUpdatedAt(dateService.getUtcNow());

        // TRANSACTION PAYLOAD
        TransactionPayload transactionPayload = new TransactionPayload();
        transactionPayload.setRrn(rrn);
        transactionPayload.setChannelRequest(gson.toJson(requestMap)); // Save parsed request
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

        // TRANSACTION MASTER
        TransactionMaster entity = new TransactionMaster();
        entity.setSenderDetails(senderDetails);
        entity.setReceiverDetails(receiverDetails);
        entity.setChannelInfo(channelInfo);
        entity.setFinacleTransaction(finacleTransaction);
        entity.setPapssCallbackDetails(papssCallbackDetails);
        entity.setTransactionPayload(transactionPayload);

        // OTHER TRANSACTION MASTER FIELDS
        entity.setRrn(rrn);
        entity.setFinacleRrn(requestMap.getOrDefault("finacleRrn", ""));
        entity.setEndToEndId(requestMap.getOrDefault("endToEndId", rrn));
        entity.setPapssMessageId(requestMap.getOrDefault("messageId", requestMap.get("papssMessageId")));
        entity.setBankId(DEFAULT_BANK_ID_KE);
        entity.setChannelId(requestMap.getOrDefault("channelId", ""));
        entity.setSourceSystemId(requestMap.getOrDefault("sourceSystemId", ""));
        entity.setIpsStatus("");
        entity.setIpsStatusCode("");
        entity.setIpsStatusDescription("");
        entity.setIpsStatusReason("");
        entity.setStatus(TransactionStatus.PENDING);
        entity.setResponseCode(TransactionStatus.PENDING.getCode());
        entity.setResponseMessage(TransactionStatus.PENDING.getDescription());
        entity.setFinacleStatus(TransactionStatus.FINACLE_INITIAL);
        entity.setFinacleResponseCode(TransactionStatus.FINACLE_INITIAL.getCode());
        entity.setFinacleResponseMessage(TransactionStatus.FINACLE_INITIAL.getDescription());
        entity.setOperationType(OperationType.INBOUND);
        entity.setTransactionType(com.equitybank.gag.papss.its.enums.TransactionType.CREDIT_TRANSFER);
        entity.setReceiverAmount(new BigDecimal(requestMap.getOrDefault("receiverAmount", "0")));
        entity.setSenderAmount(new BigDecimal(requestMap.getOrDefault("senderAmount", "0")));
        entity.setFxRate(requestMap.getOrDefault("fxRate", "0"));
        entity.setPapssFeeAmount(BigDecimal.ZERO);
        entity.setTransactionCurrency(requestMap.getOrDefault("transactionCurrency", ""));
        entity.setSourceCurrency(requestMap.getOrDefault("senderCurrency", ""));
        entity.setDestinationCurrency(requestMap.getOrDefault("receiverCurrency", ""));
        entity.setDestinationCountry(requestMap.getOrDefault("receiverCountryCode", ""));
        entity.setPaymentReason(requestMap.getOrDefault("purpose", ""));
        entity.setNarration(requestMap.getOrDefault("narration", ""));
        entity.setCreatedAt(dateService.getUtcNow());
        entity.setUpdatedAt(dateService.getUtcNow());
        entity.setCompletedAt(dateService.getUtcNow());

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

        existingRecord.setStatus(TransactionStatus.valueOf(channelResponse.getChannelStatusInfo().getStatus()));
        existingRecord.setResponseCode(channelResponse.getChannelStatusInfo().getCode());
        existingRecord.setResponseMessage(channelResponse.getChannelStatusInfo().getDescription());
        existingRecord.setIpsStatus(channelResponse.getIpsStatusInfo().getStatus().getType());
        existingRecord.setIpsStatusReason(channelResponse.getIpsStatusInfo().getStatus().getReason());
        existingRecord.setIpsStatusCode(channelResponse.getIpsStatusInfo().getStatus().getCode());
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
