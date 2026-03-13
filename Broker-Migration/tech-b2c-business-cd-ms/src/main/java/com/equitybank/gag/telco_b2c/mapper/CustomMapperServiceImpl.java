package com.equitybank.gag.telco_b2c.mapper;

import com.equitybank.gag.telco_b2c.ISO8583.service.ISOMsgSerializerAndDeserializerService;
import com.equitybank.gag.telco_b2c.config.ApplicationConstants;
import com.equitybank.gag.telco_b2c.dto.airtime.request.Envelope;
import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.dto.thunes.transfer.transaction.TransactionRequestDto;
import com.equitybank.gag.telco_b2c.entity.*;
import com.equitybank.gag.telco_b2c.enums.CbsStatus;
import com.equitybank.gag.telco_b2c.enums.ImtTransactionType;
import com.equitybank.gag.telco_b2c.enums.TransactionStatus;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.service.DatabaseService;
import com.equitybank.gag.telco_b2c.service.XmlJsonMapperService;
import com.google.gson.Gson;
import org.jpos.iso.ISOMsg;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import static com.equitybank.gag.telco_b2c.config.ApplicationConstants.*;
import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.*;
import static com.equitybank.gag.telco_b2c.enums.CbsStatus.PENDING;
import static com.equitybank.gag.telco_b2c.enums.RequestTypes.*;
import static com.equitybank.gag.telco_b2c.enums.TransactionStatus.*;

@Service
public class CustomMapperServiceImpl implements CustomMapperService {
    private static final Logger log = LoggerFactory.getLogger(CustomMapperServiceImpl.class);

    private final ISOMsgSerializerAndDeserializerService isoMsgSerializerAndDeserializerService;
    private final XmlJsonMapperService xmlJsonMapperService;
    private final DatabaseService databaseService;
    private final Gson gson;

    @Autowired
    public CustomMapperServiceImpl(ISOMsgSerializerAndDeserializerService isoMsgSerializerAndDeserializerService,
                                   XmlJsonMapperService xmlJsonMapperService,
                                   DatabaseService databaseService, Gson gson) {
        this.isoMsgSerializerAndDeserializerService = isoMsgSerializerAndDeserializerService;
        this.xmlJsonMapperService = xmlJsonMapperService;
        this.databaseService = databaseService;
        this.gson = gson;
    }

    @Override
    public TransactionDetails composeInitialTransactionEntity(request request, String type) {
        String rrn = request.getEazzycash().getRrn();
        String currency = request.getEazzycash().getCurrency();
        String bankId = request.getEazzycash().getBankId().isEmpty() ? DEFAULT_BANK_ID : request.getEazzycash().getBankId();

        // Create TransactionDetails transactionDetails
        TransactionDetails transactionDetails = new TransactionDetails();
        transactionDetails.setRrn(rrn);
        transactionDetails.setChannel(request.getEazzycash().getChannel() == null ? DEFAULT_CHANNEL_ID : request.getEazzycash().getChannel());
        transactionDetails.setBankId(bankId);
        transactionDetails.setStatus(TransactionStatus.INITIALIZED.toString());
        transactionDetails.setStatusCode("");
        transactionDetails.setTranId("");
        transactionDetails.setStatusMessage(TransactionStatus.INITIALIZED.getDescription());
        transactionDetails.setCountryCode(bankId);
        transactionDetails.setReceiveCountry(bankId);
        transactionDetails.setRequestType(type);
        transactionDetails.setOperationType(B2C);
        transactionDetails.setAmount(request.getEazzycash().getAmount());
        transactionDetails.setSenderAccount("");
        transactionDetails.setSenderMsisdn(request.getEazzycash().getSender());
        transactionDetails.setSenderName(request.getEazzycash().getName());
        transactionDetails.setTransactionCurrency(currency);
        transactionDetails.setSenderCurrency(currency);
        transactionDetails.setReceiveCurrency(currency);
        transactionDetails.setReceiverMsisdn(request.getEazzycash().getNumber());
        transactionDetails.setTelcoName(request.getEazzycash().getTelco());
        transactionDetails.setOptIn(false);
        transactionDetails.setClientType(ApplicationConstants.DEFAULT_CLIENT_TYPE);
        transactionDetails.setNarration(request.getEazzycash().getNarration() == null ? request.getEazzycash().getTelco() + DEFAULT_BANK_TO_WALLET_NARRATION : request.getEazzycash().getNarration());

        // Set Payload values
        PayloadDetails payloadDetails = new PayloadDetails();
        payloadDetails.setRrn(rrn);
        payloadDetails.setChannelRequest(xmlJsonMapperService.b2cTransactionRequestToXml(request));
        payloadDetails.setChannelResponse("");
        payloadDetails.setChannelCallbackResponse("");
        payloadDetails.setChannelStatusCheckReq("");
        payloadDetails.setChannelStatusCheckRes("");
        payloadDetails.setTelcoRequest("");
        payloadDetails.setTelcoResponse("");
        payloadDetails.setTelcoStatusCheckReq("");
        payloadDetails.setTelcoStatusCheckRes("");
        transactionDetails.setPayloadDetails(payloadDetails);

        // Create and set StatusDetails
        StatusDetails statusDetails = new StatusDetails();
        statusDetails.setRrn(rrn);
        statusDetails.setStatus(TransactionStatus.INITIALIZED.toString());
        statusDetails.setTranId("");
        statusDetails.setStatusCode("");
        statusDetails.setStatusMessage(TransactionStatus.INITIALIZED.getDescription());
        transactionDetails.setStatusDetails(statusDetails);

        // Create and set Cbs details
        CbsTransactionDetails cbsTransactionDetails = new CbsTransactionDetails();
        cbsTransactionDetails.setRrn(rrn);
        cbsTransactionDetails.setCbsStatus(PENDING);
        cbsTransactionDetails.setCbsStatusCode(PENDING_CODE);
        cbsTransactionDetails.setCbsStatusMessage("");
        cbsTransactionDetails.setReversalStatus(null);
        cbsTransactionDetails.setCbsTranId("");
        cbsTransactionDetails.setRetryCount(0);
        cbsTransactionDetails.setFinIsoRequest(null);
        cbsTransactionDetails.setFinIsoResponse(null);
        transactionDetails.setCbsTransactionDetails(cbsTransactionDetails);

        // Create and set Callback
        Callback callback = new Callback();
        callback.setRrn(rrn);
        callback.setCallbackStatus("");
        callback.setCallbackStatusMsg("");
        callback.setCallbackUrl(request.getEazzycash().getCallbackUrl() == null ? "" : request.getEazzycash().getCallbackUrl());
        transactionDetails.setCallback(callback);

        return transactionDetails;
    }

    @Override
    public TransactionDetails composeEntityForErrorResponseUpdate(String xmlResponse, String rrn, String errorCode, String errorDescription, String status, String type) {
        Optional<TransactionDetails> optionalTransactionDetails = getTransactionDetails(rrn, type);
        if (optionalTransactionDetails.isPresent()) {
            TransactionDetails transactionDetails = optionalTransactionDetails.get();
            transactionDetails.setStatusCode(errorCode);
            transactionDetails.setStatusMessage(errorDescription);
            transactionDetails.setStatus(status);

            // Set status details
            transactionDetails.getStatusDetails().setStatusCode(errorCode);
            transactionDetails.getStatusDetails().setStatusMessage(errorDescription);
            transactionDetails.getStatusDetails().setStatus(status);

            // Set payload details
            transactionDetails.getPayloadDetails().setChannelResponse(xmlResponse);

            return transactionDetails;
        }
        return null;
    }

    @Override
    public TransactionDetails composeInitialAirtimeTopUpEntity(Envelope airtimeRequest, String type) {
        String rrn = airtimeRequest.getBody().getTopUp().getRrn();
        String currency = airtimeRequest.getBody().getTopUp().getCurrency();
        String bankId = airtimeRequest.getBody().getTopUp().getCountry().isEmpty() ? DEFAULT_COUNTRY_CODE : airtimeRequest.getBody().getTopUp().getCountry();

        // Create TransactionDetails transactionDetails
        TransactionDetails transactionDetails = new TransactionDetails();
        transactionDetails.setReceiverMsisdn(airtimeRequest.getBody().getTopUp().getMsisdnA());
        transactionDetails.setAmount(airtimeRequest.getBody().getTopUp().getAmount());
        transactionDetails.setTelcoName(airtimeRequest.getBody().getTopUp().getTelcom());
        transactionDetails.setChannel(airtimeRequest.getBody().getTopUp().getChannel());
        transactionDetails.setNarration(airtimeRequest.getBody().getTopUp().getTelcom() + DEFAULT_AIRTIME_PURCHASE_NARRATION);
        transactionDetails.setRrn(rrn);
        transactionDetails.setBankId(DEFAULT_BANK_ID);
        transactionDetails.setCountryCode(bankId);
        transactionDetails.setReceiveCountry(bankId);
        transactionDetails.setRequestType(type);
        transactionDetails.setOperationType(AIRTIME);
        transactionDetails.setSenderAccount("");
        transactionDetails.setSenderMsisdn("");
        transactionDetails.setSenderName("");
        transactionDetails.setTransactionCurrency(currency);
        transactionDetails.setSenderCurrency(currency);
        transactionDetails.setReceiveCurrency(currency);
        transactionDetails.setOptIn(false);
        transactionDetails.setClientType("");
        transactionDetails.setStatus(TransactionStatus.INITIALIZED.toString());
        transactionDetails.setStatusCode("");
        transactionDetails.setStatusMessage(TransactionStatus.INITIALIZED.getDescription());
        transactionDetails.setTranId("");

        // Set Payload values
        PayloadDetails payloadDetails = new PayloadDetails();
        payloadDetails.setRrn(rrn);
        payloadDetails.setChannelRequest(xmlJsonMapperService.airtimeTopUpRequestToXml(airtimeRequest));
        payloadDetails.setChannelResponse("");
        payloadDetails.setChannelCallbackResponse("");
        payloadDetails.setChannelStatusCheckReq("");
        payloadDetails.setChannelStatusCheckRes("");
        payloadDetails.setTelcoRequest("");
        payloadDetails.setTelcoResponse("");
        payloadDetails.setTelcoStatusCheckReq("");
        payloadDetails.setTelcoStatusCheckRes("");
        transactionDetails.setPayloadDetails(payloadDetails);

        // Create and set StatusDetails
        StatusDetails statusDetails = new StatusDetails();
        statusDetails.setRrn(rrn);
        statusDetails.setStatus(TransactionStatus.INITIALIZED.toString());
        statusDetails.setTranId("");
        statusDetails.setStatusCode("");
        statusDetails.setStatusMessage(TransactionStatus.INITIALIZED.getDescription());
        transactionDetails.setStatusDetails(statusDetails);

        // Create and set Cbs details
        CbsTransactionDetails cbsTransactionDetails = new CbsTransactionDetails();
        cbsTransactionDetails.setRrn(rrn);
        cbsTransactionDetails.setCbsStatus(PENDING);
        cbsTransactionDetails.setCbsStatusCode(PENDING_CODE);
        cbsTransactionDetails.setCbsStatusMessage("");
        cbsTransactionDetails.setReversalStatus(null);
        cbsTransactionDetails.setCbsTranId("");
        cbsTransactionDetails.setRetryCount(0);
        cbsTransactionDetails.setFinIsoRequest(null);
        cbsTransactionDetails.setFinIsoResponse(null);
        transactionDetails.setCbsTransactionDetails(cbsTransactionDetails);

        // Create and set Callback
        Callback callback = new Callback();
        callback.setRrn(rrn);
        callback.setCallbackStatus("");
        callback.setCallbackStatusMsg("");
        transactionDetails.setCallback(callback);

//        log.info("{}: Json Initial Record Entity: \n{}", rrn, gson.toJson(transactionDetails));
        return transactionDetails;
    }

    @Override
    public TransactionDetails composeIsoRequestMessageEntity(ISOMsg isoMessage, String rrn, String type) {
        String tranType = type.toLowerCase().contains("moneygram") ? DEFAULT_IMT_REQUEST_TYPE : type;
        String finacleRrn = isoMessage.getString(37);

        Optional<TransactionDetails> optionalTransactionDetails = getTransactionDetails(rrn, tranType);
        if (optionalTransactionDetails.isPresent()) {
            TransactionDetails transactionDetails = optionalTransactionDetails.get();
            CbsTransactionDetails cbsTransactionDetails = transactionDetails.getCbsTransactionDetails();

            // Set iso request details in CbsTransactionDetails table
            byte[] serializedRequestMessage = isoMsgSerializerAndDeserializerService.serializeISOMsg(isoMessage);

            cbsTransactionDetails.setFinIsoRequest(serializedRequestMessage);
            cbsTransactionDetails.setCbsStatusMessage("Sending ISO message request to Finacle. Transaction in Pending status");
            transactionDetails.setCbsTransactionDetails(cbsTransactionDetails);

            // Set finacle rrn - field 37 is always truncated to 12 alphanumeric characters
            transactionDetails.setFinacleRrn(finacleRrn);
            transactionDetails.getCbsTransactionDetails().setFinacleRrn(finacleRrn);

            // Set iso request details in PayloadDetails table
//            String isoRequestString = isoMsgSerializerAndDeserializerService.convertIsoMessageToString(isoMessage, rrn);
//            transactionDetails.getPayloadDetails().setFinIsoRequest(isoRequestString);
            return transactionDetails;
        }
        return null;
    }

    @Override
    public TransactionDetails composeIsoResponseMessageEntity(ISOMsg isoMessage, String rrn, String type) {
        String tranType = type.toLowerCase().contains("moneygram") ? DEFAULT_IMT_REQUEST_TYPE : type;

        Optional<TransactionDetails> optionalTransactionDetails = getTransactionDetails(rrn, tranType);
        if (optionalTransactionDetails.isPresent()) {
            TransactionDetails transactionDetails = optionalTransactionDetails.get();
            CbsTransactionDetails cbsTransactionDetails = transactionDetails.getCbsTransactionDetails();

            // Set iso response details in CbsTransactionDetails table
            byte[] serializedResponseMessage = isoMsgSerializerAndDeserializerService.serializeISOMsg(isoMessage);

            cbsTransactionDetails.setFinIsoResponse(serializedResponseMessage);
            cbsTransactionDetails.setCbsStatusMessage("ISO message received from Finacle. Processing the response");
            transactionDetails.setCbsTransactionDetails(cbsTransactionDetails);

            // Set iso response details in PayloadDetails table
//            String isoResponseString = isoMsgSerializerAndDeserializerService.convertIsoMessageToString(isoMessage, rrn);
//            transactionDetails.getPayloadDetails().setFinIsoResponse(isoResponseString);
            return transactionDetails;
        }
        return null;
    }

    @Override
    public TransactionDetails composeFinacleStatusEntity(String rrn, String type, CbsStatus status, String errorDesc, String finacleResponseCode) {
        String tranType = type.toLowerCase().contains("moneygram") ? DEFAULT_IMT_REQUEST_TYPE : type;

        Optional<TransactionDetails> optionalTransactionDetails = getTransactionDetails(rrn, tranType);
        if (optionalTransactionDetails.isPresent()) {
            TransactionDetails transactionDetails = optionalTransactionDetails.get();
            CbsTransactionDetails cbsTransactionDetails = transactionDetails.getCbsTransactionDetails();
            StatusDetails statusDetails = transactionDetails.getStatusDetails();

            // Set iso response details in CbsTransactionDetails table
            cbsTransactionDetails.setCbsStatus(status);
            cbsTransactionDetails.setCbsStatusCode(finacleResponseCode);
            cbsTransactionDetails.setCbsStatusMessage(errorDesc);

            // Set final status for the transaction
            transactionDetails.setStatus(status.toString());
            transactionDetails.setStatusCode(finacleResponseCode);
            transactionDetails.setStatusMessage(errorDesc);

            statusDetails.setStatus(status.toString());
            statusDetails.setStatusCode(finacleResponseCode);
            statusDetails.setStatusMessage(errorDesc);

            transactionDetails.setStatusDetails(statusDetails);
            transactionDetails.setCbsTransactionDetails(cbsTransactionDetails);
            return transactionDetails;
        }
        return null;
    }

    @Override
    public TransactionDetails composeFinacleSuccessEntity(String rrn, String type, String cbsTranId) {
        String tranType = type.toLowerCase().contains("moneygram") ? DEFAULT_IMT_REQUEST_TYPE : type;

        Optional<TransactionDetails> optionalTransactionDetails = getTransactionDetails(rrn, tranType);
        if (optionalTransactionDetails.isPresent()) {
            TransactionDetails transactionDetails = optionalTransactionDetails.get();
            CbsTransactionDetails cbsTransactionDetails = transactionDetails.getCbsTransactionDetails();

            // Set iso response details in CbsTransactionDetails table
            cbsTransactionDetails.setCbsTranId(cbsTranId);
            cbsTransactionDetails.setCbsStatus(CbsStatus.COMPLETED);
            cbsTransactionDetails.setCbsStatusCode(SUCCESS_CODE);
            cbsTransactionDetails.setCbsStatusMessage(CbsStatus.COMPLETED.getDescription());

            transactionDetails.setCbsTransactionDetails(cbsTransactionDetails);
            return transactionDetails;
        }
        return null;
    }

    @Override
    public TransactionDetails composeReversalFailureEntity(String rrn, String type, String reversalStatusMsg) {
        String tranType = type.toLowerCase().contains("moneygram") ? DEFAULT_IMT_REQUEST_TYPE : type;

        Optional<TransactionDetails> optionalTransactionDetails = getTransactionDetails(rrn, tranType);
        if (optionalTransactionDetails.isPresent()) {
            TransactionDetails transactionDetails = optionalTransactionDetails.get();
            CbsTransactionDetails cbsTransactionDetails = transactionDetails.getCbsTransactionDetails();

            // Set iso response details in CbsTransactionDetails table
            cbsTransactionDetails.setReversalStatus(CbsStatus.REVERSAL_FAILURE);
            cbsTransactionDetails.setReversalStatusMessage(reversalStatusMsg);

            transactionDetails.setCbsTransactionDetails(cbsTransactionDetails);
            return transactionDetails;
        }
        return null;
    }

    @Override
    public TransactionDetails composeFinacleReversalSuccessEntity(String rrn, String type) {
        String tranType = type.toLowerCase().contains("moneygram") ? DEFAULT_IMT_REQUEST_TYPE : type;

        Optional<TransactionDetails> optionalTransactionDetails = getTransactionDetails(rrn, tranType);
        if (optionalTransactionDetails.isPresent()) {
            TransactionDetails transactionDetails = optionalTransactionDetails.get();
            CbsTransactionDetails cbsTransactionDetails = transactionDetails.getCbsTransactionDetails();

            // Set iso response details in CbsTransactionDetails table
            cbsTransactionDetails.setCbsStatus(CbsStatus.REVERSED);
            cbsTransactionDetails.setCbsStatusCode(CBS_REVERSED_SUCCESS_CODE);
            cbsTransactionDetails.setReversalStatus(CbsStatus.REVERSAL_COMPLETED);
            cbsTransactionDetails.setReversalStatusMessage(CbsStatus.REVERSAL_COMPLETED.getDescription());

            transactionDetails.setCbsTransactionDetails(cbsTransactionDetails);
            return transactionDetails;
        }
        return null;
    }

    @Override
    public TransactionDetails composeInitialMGFeeLookupToEntity(String requestXml, Map<String, String> xmlStringMap, String rrn, String type) {
//        // Get the amount
//        BigDecimal amountB = getAmount(xmlStringMap);

        // Create TransactionDetails transactionDetails
        TransactionDetails transactionDetails = new TransactionDetails();
        transactionDetails.setRrn(rrn);
        transactionDetails.setChannel(xmlStringMap.get("channelId"));
        transactionDetails.setBankId(xmlStringMap.get("bankId"));
        transactionDetails.setRequestType(DEFAULT_IMT_REQUEST_TYPE);
        transactionDetails.setOperationType(IMT_OUTWARD);
        transactionDetails.setImtOperation(type);
        transactionDetails.setAmount(BigDecimal.ZERO);
        transactionDetails.setImtTotalFeeAndTaxes(BigDecimal.ZERO);
        transactionDetails.setImtTotalAmountToCollect(BigDecimal.ZERO);
        transactionDetails.setSenderAccount("");
        transactionDetails.setSenderMsisdn("");
        transactionDetails.setSenderName("");
        transactionDetails.setCountryCode(xmlStringMap.get("bankId"));
        transactionDetails.setReceiveCountry(xmlStringMap.get("receiveCountry"));
        transactionDetails.setTransactionCurrency("");
        transactionDetails.setSenderCurrency("");
        transactionDetails.setReceiveCurrency("");
        transactionDetails.setReceiverMsisdn("");
        transactionDetails.setTelcoName(MONEY_GRAM);
        transactionDetails.setOptIn(false);
        transactionDetails.setClientType(ApplicationConstants.DEFAULT_CLIENT_TYPE);
        transactionDetails.setStatus(TransactionStatus.INITIALIZED.toString());
        transactionDetails.setTranId("");
        transactionDetails.setStatusCode("");
        transactionDetails.setStatusMessage(TransactionStatus.INITIALIZED.getDescription());

        // Set Payload values
        PayloadDetails payloadDetails = new PayloadDetails();
        payloadDetails.setRrn(rrn);
        payloadDetails.setChannelRequest(requestXml);
        payloadDetails.setChannelResponse("");
        payloadDetails.setChannelCallbackResponse("");
        payloadDetails.setChannelStatusCheckReq("");
        payloadDetails.setChannelStatusCheckRes("");
        payloadDetails.setTelcoRequest("");
        payloadDetails.setTelcoResponse("");
        payloadDetails.setTelcoStatusCheckReq("");
        payloadDetails.setTelcoStatusCheckRes("");
        transactionDetails.setPayloadDetails(payloadDetails);

        // Create and set StatusDetails
        StatusDetails statusDetails = new StatusDetails();
        statusDetails.setRrn(rrn);
        statusDetails.setStatus(TransactionStatus.INITIALIZED.toString());
        statusDetails.setTranId("");
        statusDetails.setStatusCode("");
        statusDetails.setStatusMessage(TransactionStatus.INITIALIZED.getDescription());
        transactionDetails.setStatusDetails(statusDetails);

        // Create and set Cbs details
        CbsTransactionDetails cbsTransactionDetails = new CbsTransactionDetails();
        cbsTransactionDetails.setRrn(rrn);
        cbsTransactionDetails.setCbsStatus(PENDING);
        cbsTransactionDetails.setCbsStatusCode(PENDING_CODE);
        cbsTransactionDetails.setCbsStatusMessage("");
        cbsTransactionDetails.setReversalStatus(null);
        cbsTransactionDetails.setCbsTranId("");
        cbsTransactionDetails.setRetryCount(0);
        cbsTransactionDetails.setFinIsoRequest(null);
        cbsTransactionDetails.setFinIsoResponse(null);
        transactionDetails.setCbsTransactionDetails(cbsTransactionDetails);

        // Create and set Callback
        Callback callback = new Callback();
        callback.setRrn(rrn);
        callback.setCallbackStatus("");
        callback.setCallbackStatusMsg("");
        callback.setCallbackUrl("");
        transactionDetails.setCallback(callback);

//        log.info("{}: Json Initial Record Entity: \n{}", rrn, gson.toJson(transactionDetails));
        return transactionDetails;
    }

    @Override
    public TransactionDetails composeInitialFloatPurchaseToEntity(request request, String type) {
        String rrn = request.getEazzycash().getRrn();
        String currency = request.getEazzycash().getCurrency();
        String bankId = request.getEazzycash().getBankId().isEmpty() ? DEFAULT_BANK_ID : request.getEazzycash().getBankId();

        // Create TransactionDetails transactionDetails
        TransactionDetails transactionDetails = new TransactionDetails();
        transactionDetails.setRrn(rrn);
        transactionDetails.setChannel(request.getEazzycash().getChannel() == null ? DEFAULT_CHANNEL_ID : request.getEazzycash().getChannel());
        transactionDetails.setBankId(bankId);
        transactionDetails.setCountryCode(bankId);
        transactionDetails.setReceiveCountry(bankId);
        transactionDetails.setRequestType(type);
        transactionDetails.setOperationType(BUY_FLOAT);
        transactionDetails.setAmount(request.getEazzycash().getAmount());
        transactionDetails.setChargeFlag(request.getEazzycash().getChargeFlag() == null ? DEFAULT_CHARGE_FLAG : request.getEazzycash().getChargeFlag());
        transactionDetails.setSenderAccount("");
        transactionDetails.setSenderMsisdn(request.getEazzycash().getSender());
        transactionDetails.setSenderName(request.getEazzycash().getName());
        transactionDetails.setTransactionCurrency(currency);
        transactionDetails.setSenderCurrency(currency);
        transactionDetails.setReceiveCurrency(currency);
        transactionDetails.setReceiverMsisdn(request.getEazzycash().getNumber());
        transactionDetails.setTelcoName(request.getEazzycash().getTelco());
        transactionDetails.setOptIn(false);
        transactionDetails.setClientType(ApplicationConstants.DEFAULT_CLIENT_TYPE);
        transactionDetails.setNarration(request.getEazzycash().getNarration() == null ? request.getEazzycash().getTelco() + DEFAULT_FLOAT_PURCHASE_NARRATION : request.getEazzycash().getNarration());
        transactionDetails.setStatus(TransactionStatus.INITIALIZED.toString());
        transactionDetails.setTranId("");
        transactionDetails.setStatusCode("");
        transactionDetails.setStatusMessage(TransactionStatus.INITIALIZED.getDescription());

        // Set Payload values
        PayloadDetails payloadDetails = new PayloadDetails();
        payloadDetails.setRrn(rrn);
        payloadDetails.setChannelRequest(xmlJsonMapperService.b2cTransactionRequestToXml(request));
        payloadDetails.setChannelResponse("");
        payloadDetails.setChannelCallbackResponse("");
        payloadDetails.setChannelStatusCheckReq("");
        payloadDetails.setChannelStatusCheckRes("");
        payloadDetails.setTelcoRequest("");
        payloadDetails.setTelcoResponse("");
        payloadDetails.setTelcoStatusCheckReq("");
        payloadDetails.setTelcoStatusCheckRes("");
        transactionDetails.setPayloadDetails(payloadDetails);

        // Create and set StatusDetails
        StatusDetails statusDetails = new StatusDetails();
        statusDetails.setRrn(rrn);
        statusDetails.setStatus(TransactionStatus.INITIALIZED.toString());
        statusDetails.setTranId("");
        statusDetails.setStatusCode("");
        statusDetails.setStatusMessage(TransactionStatus.INITIALIZED.getDescription());
        transactionDetails.setStatusDetails(statusDetails);

        // Create and set Cbs details
        CbsTransactionDetails cbsTransactionDetails = new CbsTransactionDetails();
        cbsTransactionDetails.setRrn(rrn);
        cbsTransactionDetails.setCbsStatus(PENDING);
        cbsTransactionDetails.setCbsStatusCode(PENDING_CODE);
        cbsTransactionDetails.setCbsStatusMessage("");
        cbsTransactionDetails.setReversalStatus(null);
        cbsTransactionDetails.setCbsTranId("");
        cbsTransactionDetails.setRetryCount(0);
        cbsTransactionDetails.setFinIsoRequest(null);
        cbsTransactionDetails.setFinIsoResponse(null);
        transactionDetails.setCbsTransactionDetails(cbsTransactionDetails);

        // Create and set Callback
        Callback callback = new Callback();
        callback.setRrn(rrn);
        callback.setCallbackStatus("");
        callback.setCallbackStatusMsg("");
        transactionDetails.setCallback(callback);

//        log.info("{}: Json Initial Record Entity: \n{}", rrn, gson.toJson(transactionDetails));
        return transactionDetails;
    }

    @Override
    public TransactionDetails composeInitialReferenceNumberReqToEntity(String requestXml, Map<String, String> xmlStringMap, String rrn, String type) {
        // Create TransactionDetails transactionDetails
        TransactionDetails transactionDetails = new TransactionDetails();
        transactionDetails.setRrn(rrn);
        transactionDetails.setChannel(xmlStringMap.get("channelId"));
        transactionDetails.setBankId(xmlStringMap.get("bankId"));
        transactionDetails.setImtTransactionDateTime("");
        transactionDetails.setImtReferenceNumber(xmlStringMap.get("referenceNumber"));
        transactionDetails.setRequestType(DEFAULT_IMT_REQUEST_TYPE);
        transactionDetails.setOperationType(IMT_INWARD);
        transactionDetails.setImtOperation(type);
        transactionDetails.setAmount(BigDecimal.ZERO);
        transactionDetails.setImtTotalFeeAndTaxes(BigDecimal.ZERO);
        transactionDetails.setTotalFees(BigDecimal.ZERO);
        transactionDetails.setSenderAccount("");
        transactionDetails.setSenderMsisdn("");
        transactionDetails.setSenderName("");
        transactionDetails.setSenderCurrency("");
        transactionDetails.setReceiverMsisdn("");
        transactionDetails.setTelcoName(MONEY_GRAM);
        transactionDetails.setOptIn(false);
        transactionDetails.setClientType(ApplicationConstants.DEFAULT_CLIENT_TYPE);
        transactionDetails.setStatus(TransactionStatus.INITIALIZED.toString());
        transactionDetails.setTranId("");
        transactionDetails.setStatusCode("");
        transactionDetails.setStatusMessage(TransactionStatus.INITIALIZED.getDescription());

        // Set Payload values
        PayloadDetails payloadDetails = new PayloadDetails();
        payloadDetails.setRrn(rrn);
        payloadDetails.setChannelRequest(requestXml);
        payloadDetails.setChannelResponse("");
        payloadDetails.setChannelCallbackResponse("");
        payloadDetails.setChannelStatusCheckReq("");
        payloadDetails.setChannelStatusCheckRes("");
        payloadDetails.setTelcoRequest("");
        payloadDetails.setTelcoResponse("");
        payloadDetails.setTelcoStatusCheckReq("");
        payloadDetails.setTelcoStatusCheckRes("");
        transactionDetails.setPayloadDetails(payloadDetails);

        // Create and set StatusDetails
        StatusDetails statusDetails = new StatusDetails();
        statusDetails.setRrn(rrn);
        statusDetails.setStatus(TransactionStatus.INITIALIZED.toString());
        statusDetails.setTranId("");
        statusDetails.setStatusCode("");
        statusDetails.setStatusMessage(TransactionStatus.INITIALIZED.getDescription());
        transactionDetails.setStatusDetails(statusDetails);

        // Create and set Cbs details
        CbsTransactionDetails cbsTransactionDetails = new CbsTransactionDetails();
        cbsTransactionDetails.setRrn(rrn);
        cbsTransactionDetails.setCbsStatus(PENDING);
        cbsTransactionDetails.setCbsStatusCode(PENDING_CODE);
        cbsTransactionDetails.setCbsStatusMessage("");
        cbsTransactionDetails.setReversalStatus(null);
        cbsTransactionDetails.setCbsTranId("");
        cbsTransactionDetails.setRetryCount(0);
        cbsTransactionDetails.setFinIsoRequest(null);
        cbsTransactionDetails.setFinIsoResponse(null);
        transactionDetails.setCbsTransactionDetails(cbsTransactionDetails);

        // Create and set Callback
        Callback callback = new Callback();
        callback.setRrn(rrn);
        callback.setCallbackStatus("");
        callback.setCallbackStatusMsg("");
        callback.setCallbackUrl("");
        transactionDetails.setCallback(callback);

//        log.info("{}: Json Initial Record Entity: \n{}", rrn, gson.toJson(transactionDetails));
        return transactionDetails;
    }

    @Override
    public TransactionDetails composeImtSuccessResponseEntity(TransactionDetails transactionDetails, Map<String, String> responseDetailsMap, String responseXml, String rrn, String type) {
        return switch (type) {
            case "moneygram-fee-lookup" ->
                    updateStatusDetails(rrn, FEE_LOOKUP_SUCCESS, responseDetailsMap, type, responseXml);
            case "moneygram-receive-reference-number-request" ->
                    updateStatusDetails(rrn, INBOUND_REFERENCE_NUMBER_REQUEST, responseDetailsMap, type, responseXml);
            case "moneygram-get-field-for-product", "moneygram-receive-get-field-for-product" ->
                    updateStatusDetails(rrn, FIELD_FOR_PRODUCT_SUCCESS, new HashMap<>(), type, responseXml);
            case "moneygram-send-validation-request" ->
                    updateStatusDetails(rrn, SEND_VALIDATION_REQUEST_SUCCESS, responseDetailsMap, type, responseXml);
            case "moneygram-receive-validation-request" ->
                    updateStatusDetails(rrn, RECEIVE_VALIDATION_REQUEST_SUCCESS, responseDetailsMap, type, responseXml);
            case "moneygram-commit-transaction", "moneygram-receive-commit-transaction", "moneygram-detail-lookup" ->
                    updateStatusDetails(rrn, OK, responseDetailsMap, type, responseXml);
            default -> {
                log.error("{}: Invalid money gram operation type: {}", rrn, type);
                yield null;
            }
        };
    }

    private TransactionDetails updateStatusDetails(String rrn, TransactionStatus statusType, Map<String, String> transactionDetailsMap, String type, String responseXml) {
        String tranType = type.toLowerCase().contains("moneygram") ? DEFAULT_IMT_REQUEST_TYPE : type;
        Optional<TransactionDetails> optionalTransactionDetails = getTransactionDetails(rrn, tranType);
        TransactionDetails transactionDetails = optionalTransactionDetails.orElse(null);
        if (transactionDetails == null) {
            return null;
        }

        StatusDetails statusDetails = transactionDetails.getStatusDetails();
        statusDetails.setStatus(statusType.toString());
        statusDetails.setStatusMessage(statusType.getDescription());
        transactionDetails.setStatus(statusType.toString());
        transactionDetails.setStatusMessage(statusType.getDescription());

        switch (type) {
            case "moneygram-send-validation-request" -> {
                transactionDetails.setImtReferenceNumber(transactionDetailsMap.get("referenceNumber"));
                transactionDetails.setSenderCurrency(transactionDetailsMap.get("sendCurrency"));
                transactionDetails.setAmount(new BigDecimal(transactionDetailsMap.get("sendAmount")));
                transactionDetails.setImtTotalFeeAndTaxes(new BigDecimal(transactionDetailsMap.get("totalFeeAndTaxes")));
                transactionDetails.setImtTotalAmountToCollect(new BigDecimal(transactionDetailsMap.get("totalAmountToCollect")));
            }
            case "moneygram-receive-validation-request" -> {
                statusDetails.setStatusCode(PENDING_CODE);
                transactionDetails.setStatusCode(PENDING_CODE);
                transactionDetails.getPayloadDetails().setChannelResponse(responseXml);
            }
            case "moneygram-fee-lookup" -> {
                statusDetails.setStatusCode(PENDING_CODE);
                transactionDetails.setStatusCode(PENDING_CODE);
                transactionDetails.setImtProductType("SEND");
                transactionDetails.getPayloadDetails().setChannelResponse(responseXml);
                transactionDetails.setSenderCurrency(transactionDetailsMap.get("sendCurrency"));
                transactionDetails.setAmount(new BigDecimal(transactionDetailsMap.get("sendAmount")));
                transactionDetails.setImtTotalFeeAndTaxes(new BigDecimal(transactionDetailsMap.get("totalFeeAndTaxes")));
                transactionDetails.setImtTotalAmountToCollect(new BigDecimal(transactionDetailsMap.get("totalAmountToCollect")));
            }
            case "moneygram-receive-reference-number-request" -> {
                String senderName = transactionDetailsMap.get("senderFirstName") + " " + transactionDetailsMap.get("senderMiddleName") + " " + transactionDetailsMap.get("senderLastName");
                String receiverName = transactionDetailsMap.get("receiverFirstName") + " " + transactionDetailsMap.get("receiverMiddleName") + " " + transactionDetailsMap.get("receiverLastName");

                statusDetails.setStatusCode(SUCCESS_CODE);
                transactionDetails.setStatusCode(SUCCESS_CODE);
                transactionDetails.setImtProductType("RCV");
                transactionDetails.setSenderName(senderName);
                transactionDetails.setReceiverName(receiverName);
                transactionDetails.getPayloadDetails().setChannelResponse(responseXml);
                transactionDetails.setSenderDob(transactionDetailsMap.get("senderDOB"));
                transactionDetails.setImtStatus(transactionDetailsMap.get("transactionStatus"));
                transactionDetails.setImtStatusDescription(getImtStatusDesc(transactionDetailsMap));
                statusDetails.setImtStatus(transactionDetailsMap.get("transactionStatus"));
                statusDetails.setImtStatusDescription(getImtStatusDesc(transactionDetailsMap));
                transactionDetails.setSenderIdType(transactionDetailsMap.get("senderPhotoIdType"));
                transactionDetails.setReceiveCurrency(transactionDetailsMap.get("receiveCurrency"));
                transactionDetails.setImtDeliveryOption(transactionDetailsMap.get("deliveryOption"));
                transactionDetails.setSenderIdNumber(transactionDetailsMap.get("senderPhotoIdNumber"));
                transactionDetails.setSenderCurrency(transactionDetailsMap.get("originalSendCurrency"));
                transactionDetails.setMgiTransactionSessionID(transactionDetailsMap.get("transactionId"));
                transactionDetails.setOriginatingCountry(transactionDetailsMap.get("originatingCountry"));
                transactionDetails.setTotalFees(new BigDecimal(transactionDetailsMap.get("originalSendFee")));
                transactionDetails.setAmount(new BigDecimal(transactionDetailsMap.get("receiveAmount")));
                transactionDetails.setImtTotalAmountToCollect(new BigDecimal(transactionDetailsMap.get("receiveAmount")));
            }
            case "moneygram-commit-transaction", "moneygram-receive-commit-transaction" -> {
                String imtStatus = "AVAIL";
                statusDetails.setImtStatus(imtStatus);
                statusDetails.setStatusCode(SUCCESS_CODE);
                statusDetails.setStatus(statusType.toString());
//                statusDetails.setStatusMessage(statusType.getDescription());
                statusDetails.setStatusMessage("Payment Accepted");

                transactionDetails.setImtStatus(imtStatus);
                transactionDetails.setStatusCode(SUCCESS_CODE);
                transactionDetails.setStatus(statusType.toString());
                transactionDetails.setStatusMessage("Payment Accepted");

                transactionDetails.setImtReferenceNumber(transactionDetailsMap.get("referenceNumber"));
                transactionDetails.setImtTransactionDateTime(transactionDetailsMap.get("transactionDateTime"));
                transactionDetails.setImtStatusDescription(getImtStatusDesc(Map.of("transactionStatus", imtStatus)));
                statusDetails.setImtStatusDescription(getImtStatusDesc(Map.of("transactionStatus", imtStatus)));
                transactionDetails.setImtExpectedDateOfDelivery(transactionDetailsMap.get("expectedDateOfDelivery"));
            }
            case "moneygram-detail-lookup" -> {
                transactionDetails.setImtStatus(transactionDetailsMap.get("transactionStatus"));
                transactionDetails.setImtStatusDescription(getImtStatusDesc(transactionDetailsMap));
                statusDetails.setImtStatus(transactionDetailsMap.get("transactionStatus"));
                statusDetails.setImtStatusDescription(getImtStatusDesc(transactionDetailsMap));
            }
        }
        transactionDetails.setStatusDetails(statusDetails);
        return transactionDetails;
    }

    @Override
    public TransactionDetails composeTransactionRecordEntity(TransactionDetails transactionDetails, Map<String, String> xmlTagsMap, String type) {
        String rrn = xmlTagsMap.get("rrn");
        String tranType = type.toLowerCase().contains("moneygram") ? DEFAULT_IMT_REQUEST_TYPE : type;
        Optional<TransactionDetails> optionalTransactionDetails = getTransactionDetails(rrn, tranType);
        transactionDetails = optionalTransactionDetails.orElse(null);
        if (transactionDetails == null) {
            return null;
        }

        switch (type) {
            case "moneygram-get-field-for-product" -> {
                transactionDetails.setReceiveCurrency(xmlTagsMap.get("receiveCurrency"));
                transactionDetails.setImtDeliveryOption(xmlTagsMap.get("deliveryOption"));
            }
            case "moneygram-receive-get-field-for-product" ->
                    transactionDetails.setReceiveCountry(xmlTagsMap.get("receiveCountry"));
            case "moneygram-send-validation-request" -> {
                String senderName = xmlTagsMap.get("senderFirstName") + " " + xmlTagsMap.get("senderLastName");
                String receiverName = xmlTagsMap.get("receiverFirstName") + " " + xmlTagsMap.get("receiverLastName");
                String senderPhone;
                if (xmlTagsMap.get("senderMobilePhone") == null || xmlTagsMap.get("senderMobilePhone").isEmpty()) {
                    senderPhone = xmlTagsMap.getOrDefault("senderHomePhone", "");
                } else {
                    senderPhone = xmlTagsMap.get("senderMobilePhone");
                }

                transactionDetails.setSenderName(senderName);
                transactionDetails.setSenderMsisdn(senderPhone);
                transactionDetails.setReceiverName(receiverName);
                transactionDetails.setSenderDob(xmlTagsMap.get("senderDOB"));
                transactionDetails.setSenderIdType(xmlTagsMap.get("senderPhotoIdType"));
                transactionDetails.setSenderIdNumber(xmlTagsMap.get("senderPhotoIdNumber"));
                transactionDetails.setMgiTransactionSessionID(xmlTagsMap.get("mgiTransactionSessionID"));
            }
            case "moneygram-receive-validation-request" -> {
                transactionDetails.setReceiverDob(xmlTagsMap.get("receiverDOB"));
                transactionDetails.setReceiverIdType(xmlTagsMap.get("receiverPhotoIdType"));
                transactionDetails.setNarration(xmlTagsMap.get("receivePurposeOfTransaction"));
                transactionDetails.setReceiverIdNumber(xmlTagsMap.get("receiverPhotoIdNumber"));
                transactionDetails.setReceiverMsisdn(xmlTagsMap.getOrDefault("receiverPhone", ""));
            }
            case "moneygram-commit-transaction" -> {
                Callback callbackDetails = transactionDetails.getCallback();
                transactionDetails.setSenderAccount(xmlTagsMap.get("senderAccountNumber"));
                transactionDetails.setTransactionCurrency(xmlTagsMap.get("transactionCurrency"));
                callbackDetails.setCallbackUrl(xmlTagsMap.get("callbackUrl"));
                transactionDetails.setCallback(callbackDetails);
            }
            case "moneygram-receive-commit-transaction" -> {
                Callback callbackDetails = transactionDetails.getCallback();
                callbackDetails.setCallbackUrl(xmlTagsMap.get("callbackUrl"));
                transactionDetails.setReceiverAccount(xmlTagsMap.get("receiverAccountNumber"));
                transactionDetails.setTransactionCurrency(xmlTagsMap.get("transactionCurrency"));
                transactionDetails.setCallback(callbackDetails);
            }
            case "moneygram-amend-transaction" -> {
                String receiverName = xmlTagsMap.get("receiverFirstName") + " " + xmlTagsMap.get("receiverLastName");
                transactionDetails.setTransactionAmended("true");
                transactionDetails.setReceiverName(receiverName);
            }
        }
        transactionDetails.setImtOperation(type);
        return transactionDetails;
    }

    @Override
    public TransactionDetails composeCallbackEntity(String rrn, String tranStatus, String statusMessage, String requestBodyString, String type) {
        String tranType = type.toLowerCase().contains("moneygram") ? DEFAULT_IMT_REQUEST_TYPE : type;
        Optional<TransactionDetails> optionalTransactionDetails = getTransactionDetails(rrn, tranType);
        if (optionalTransactionDetails.isPresent()) {
            TransactionDetails transactionDetails = optionalTransactionDetails.get();
            Callback callbackDetails = transactionDetails.getCallback();
            PayloadDetails payloadDetailsDetails = transactionDetails.getPayloadDetails();

            payloadDetailsDetails.setChannelCallbackResponse(requestBodyString);
            callbackDetails.setCallbackStatus(tranStatus);
            callbackDetails.setCallbackStatusMsg(statusMessage);

            transactionDetails.setCallback(callbackDetails);
            transactionDetails.setPayloadDetails(payloadDetailsDetails);

            return transactionDetails;
        }
        return null;
    }

    @Override
    public TransactionDetails composeTelcoPendingStatusEntity(String rrn, String responseXmlString, String type) {
        String tranType = type.toLowerCase().contains("moneygram") ? DEFAULT_IMT_REQUEST_TYPE : type;
        Optional<TransactionDetails> optionalTransactionDetails = getTransactionDetails(rrn, tranType);
        if (optionalTransactionDetails.isPresent()) {
            TransactionDetails transactionDetails = optionalTransactionDetails.get();
            StatusDetails statusDetails = transactionDetails.getStatusDetails();
            PayloadDetails payloadDetailsDetails = transactionDetails.getPayloadDetails();
            Callback callback = transactionDetails.getCallback();

            // The technical vodacom service is already updating the status with pending
            // Prevent overwriting final status with pending
            String callbackStatus = callback.getCallbackReceived();
            if ("true".equalsIgnoreCase(callbackStatus)) {
                statusDetails.setStatus(transactionDetails.getStatus());
                statusDetails.setStatusMessage(transactionDetails.getStatusMessage());
                statusDetails.setStatusCode(transactionDetails.getStatusCode());

                transactionDetails.setStatusDetails(statusDetails);
                return transactionDetails;
            }

            // Otherwise, proceed with pending status update
            statusDetails.setStatus(PENDING.toString());
            statusDetails.setStatusMessage("Pending. Request sent to the telco. Final status via callback");
            statusDetails.setStatusCode(PENDING_CODE);

            transactionDetails.setStatus(PENDING.toString());
            transactionDetails.setStatusMessage("Pending. Request sent to the telco. Final status via callback");
            transactionDetails.setStatusCode(PENDING_CODE);
            payloadDetailsDetails.setChannelResponse(responseXmlString);

            transactionDetails.setStatusDetails(statusDetails);
            transactionDetails.setPayloadDetails(payloadDetailsDetails);

            return transactionDetails;
        }
        return null;
    }

    @Override
    public TransactionDetails composeTelcoCallbackEntity(Map<String, String> xmlTagsMap, String rrn, String responseXmlString, String type) {
        Optional<TransactionDetails> optionalTransactionDetails = getTransactionDetails(rrn, type);
        if (optionalTransactionDetails.isPresent()) {
            TransactionDetails transactionDetails = optionalTransactionDetails.get();

            String status;
            String statusDesc;
            String statusCode;
            String tranId = "";

            String resultCode = xmlTagsMap.get("resultCode");
            if ("0".equals(resultCode)) {
                statusCode = "00";
                status = OK.toString();
                statusDesc = OK.getDescription();
                tranId = xmlTagsMap.get("transactionId");
            } else {
                statusCode = "01";
                status = ERROR.toString();
                statusDesc = xmlTagsMap.get("resultDesc");
            }

            transactionDetails.getPayloadDetails().setChannelResponse(responseXmlString);

            transactionDetails.getCallback().setCallbackReceived("true");
            transactionDetails.getCallback().setCallbackStatus("RECEIVED");
            transactionDetails.getCallback().setCallbackStatusMsg("Callback Received and Processed");

            transactionDetails.getStatusDetails().setTranId(tranId);
            transactionDetails.getStatusDetails().setStatus(status);
            transactionDetails.getStatusDetails().setStatusMessage(statusDesc);
            transactionDetails.getStatusDetails().setStatusCode(statusCode);

            transactionDetails.setTranId(tranId);
            transactionDetails.setStatus(status);
            transactionDetails.setStatusMessage(statusDesc);
            transactionDetails.setStatusCode(statusCode);

            return transactionDetails;
        }
        return null;
    }

    @Override
    public TransactionDetails composeDbStatus(String rrn, Map<String, String> receivedValuesMap, String responseXmlString, String type) {
        String tranType = type.toLowerCase().contains("moneygram") ? DEFAULT_IMT_REQUEST_TYPE : type;
        Optional<TransactionDetails> optionalTransactionDetails = getTransactionDetails(rrn, tranType);
        if (optionalTransactionDetails.isPresent()) {
            TransactionDetails transactionDetails = optionalTransactionDetails.get();

            String tranID = "";
            TransactionStatus tranStatus;
            String status = receivedValuesMap.get("status");
            String responseCode = receivedValuesMap.get("responseCode");
            String responseDesc = receivedValuesMap.get("responseDesc");
            Map<String, String> statusValues = getStatusValues(status);

            if ("OK".equals(statusValues.get("status")) || "00".equals(responseCode)) {
                if ("airtime".equals(type)){
                    tranID = responseCode;
                    responseCode = "00";
                } else {
                    tranID = statusValues.get("tranId");
                }
                tranStatus = OK;
                responseDesc = OK.getDescription();
            } else {
                if ("airtime".equals(type)) {
                    tranStatus = ERROR;
                    responseDesc = ERROR.getDescription();
                } else {
                    tranStatus = TransactionStatus.valueOf(statusValues.get("status"));
                }
            }

            StatusDetails statusDetails = transactionDetails.getStatusDetails();
            PayloadDetails payloadDetailsDetails = transactionDetails.getPayloadDetails();

            transactionDetails.setStatus(String.valueOf(tranStatus));
            transactionDetails.setStatusMessage(responseDesc);
            transactionDetails.setStatusCode(responseCode);
            transactionDetails.setTranId(tranID);

            statusDetails.setStatus(String.valueOf(tranStatus));
            statusDetails.setStatusMessage(responseDesc);
            statusDetails.setStatusCode(responseCode);
            statusDetails.setTranId(tranID);

            payloadDetailsDetails.setChannelResponse(responseXmlString);

            transactionDetails.setStatusDetails(statusDetails);
            transactionDetails.setPayloadDetails(payloadDetailsDetails);

            return transactionDetails;
        }
        return null;
    }

    @Override
    public TransactionDetails composeInitialThunesTransactionEntity(TransactionRequestDto req, String type) {

        String rrn = req.getChannelInfo().getRrn();
        String bankId = req.getChannelInfo().getBankId();
        String channelId = req.getChannelInfo().getChannelId();
        String senderCurrency = req.getAmount().getSenderCurrency();
        String receiverCurrency = req.getAmount().getReceiverCurrency();
        TransactionDetails transactionDetails = new TransactionDetails();

        // =========================================================
        // Core identity
        // =========================================================
        transactionDetails.setRrn(rrn);
        transactionDetails.setChannel(channelId);
        transactionDetails.setBankId(bankId);
        transactionDetails.setRequestType(type);
        transactionDetails.setOperationType(IMT_OUTWARD);

        // =========================================================
        // Status (initial)
        // =========================================================
        transactionDetails.setStatus(TransactionStatus.INITIALIZED.toString());
        transactionDetails.setStatusCode("");
        transactionDetails.setStatusMessage(TransactionStatus.INITIALIZED.getDescription());
        transactionDetails.setTranId("");

        // =========================================================
        // Amounts & currencies
        // =========================================================
        transactionDetails.setAmount(new BigDecimal(req.getAmount().getSenderAmount()));
        transactionDetails.setTransactionCurrency(senderCurrency);
        transactionDetails.setSenderCurrency(senderCurrency);
        transactionDetails.setReceiveCurrency(receiverCurrency);

        // =========================================================
        // Parties – sender
        // =========================================================
        transactionDetails.setSenderMsisdn(resolveSenderMsisdn(req));
        transactionDetails.setSenderAccount("");
        transactionDetails.setSenderName(resolveSenderName(req));

        // =========================================================
        // Parties – receiver
        // =========================================================
        transactionDetails.setReceiverMsisdn(resolveReceiverMsisdn(req));

        // =========================================================
        // Geography
        // =========================================================
        transactionDetails.setCountryCode(req.getParties().getSender().getContactDetails().getCountryCode());
        transactionDetails.setReceiveCountry(req.getParties().getReceiver().getContactDetails().getCountryCode());

        // =========================================================
        // Narration
        // =========================================================
        transactionDetails.setNarration(req.getRemittance() != null && req.getRemittance().getReference() != null
                        ? req.getRemittance().getReference()
                        : "THUNES " + req.getTransactionType());

        // =========================================================
        // Client / channel flags
        // =========================================================
        transactionDetails.setOptIn(false);
        transactionDetails.setClientType(ApplicationConstants.DEFAULT_CLIENT_TYPE);
        transactionDetails.setTelcoName(req.getImtProvider());

        // =========================================================
        // Payload storage
        // =========================================================
        PayloadDetails payloadDetails = new PayloadDetails();
        payloadDetails.setRrn(rrn);
        payloadDetails.setChannelRequest(gson.toJson(req));
        payloadDetails.setChannelResponse("");
        payloadDetails.setChannelCallbackResponse("");
        payloadDetails.setChannelStatusCheckReq("");
        payloadDetails.setChannelStatusCheckRes("");
        payloadDetails.setTelcoRequest("");
        payloadDetails.setTelcoResponse("");
        payloadDetails.setTelcoStatusCheckReq("");
        payloadDetails.setTelcoStatusCheckRes("");

        transactionDetails.setPayloadDetails(payloadDetails);

        // =========================================================
        // Status history
        // =========================================================
        StatusDetails statusDetails = new StatusDetails();
        statusDetails.setRrn(rrn);
        statusDetails.setStatus(TransactionStatus.INITIALIZED.toString());
        statusDetails.setTranId("");
        statusDetails.setStatusCode("");
        statusDetails.setStatusMessage(TransactionStatus.INITIALIZED.getDescription());

        transactionDetails.setStatusDetails(statusDetails);

        // =========================================================
        // CBS placeholder (Thunes = async)
        // =========================================================
        CbsTransactionDetails cbsTransactionDetails = new CbsTransactionDetails();
        cbsTransactionDetails.setRrn(rrn);
        cbsTransactionDetails.setCbsStatus(PENDING);
        cbsTransactionDetails.setCbsStatusCode(PENDING_CODE);
        cbsTransactionDetails.setCbsStatusMessage("");
        cbsTransactionDetails.setReversalStatus(null);
        cbsTransactionDetails.setCbsTranId("");
        cbsTransactionDetails.setRetryCount(0);
        cbsTransactionDetails.setFinIsoRequest(null);
        cbsTransactionDetails.setFinIsoResponse(null);

        transactionDetails.setCbsTransactionDetails(cbsTransactionDetails);

        // =========================================================
        // Callback
        // =========================================================
        Callback callback = new Callback();
        callback.setRrn(rrn);
        callback.setCallbackStatus("");
        callback.setCallbackStatusMsg("");
        callback.setCallbackUrl(req.getChannelInfo().getCallbackURL() != null
                        ? req.getChannelInfo().getCallbackURL()
                        : "");

        transactionDetails.setCallback(callback);

        return transactionDetails;
    }

    private String resolveSenderMsisdn(TransactionRequestDto req) {

        if ("PERSON".equals(req.getParties().getSender().getPartyType())) {
            return req.getParties()
                    .getSender()
                    .getContactDetails()
                    .getMsisdn();
        }

        return "";
    }

    private String resolveReceiverMsisdn(TransactionRequestDto req) {

        if ("PERSON".equals(req.getParties().getReceiver().getPartyType())) {
            return req.getParties()
                    .getReceiver()
                    .getContactDetails()
                    .getMsisdn();
        }

        return "";
    }

    private String resolveSenderName(TransactionRequestDto req) {

        if ("PERSON".equals(req.getParties().getSender().getPartyType())
                && req.getParties().getSender().getPersonalDetails() != null) {

            return req.getParties().getSender().getPersonalDetails().getFirstname()
                    + " "
                    + req.getParties().getSender().getPersonalDetails().getLastname();
        }

        if ("BUSINESS".equals(req.getParties().getSender().getPartyType())
                && req.getParties().getSender().getBusinessDetails() != null) {

            return req.getParties().getSender().getBusinessDetails().getRegisteredName();
        }

        return "";
    }

    private String resolveOperationType(ImtTransactionType type) throws CustomException {

        return switch (type) {
            case C2C -> "C2C";
            case C2B -> "C2B";
            case B2B -> "B2B";
            default -> throw new CustomException("Unsupported transaction type: " + type);
        };
    }

    private Map<String, String> getStatusValues(String status) {
        Map<String, String> result = new HashMap<>();

        if (status == null || status.isBlank()) {
            result.put("status", "INITIALIZED");
            result.put("tranId", "");
            return result;
        }

        String[] parts = status.split("\\|", 2); // split only on the first '|'
        result.put("status", parts[0]);

        if (parts.length > 1) {
            result.put("tranId", parts[1]);
        } else {
            result.put("tranId", "");
        }

        return result;
    }

    @Override
    public TransactionDetails composeChargeEntity(String charge, String rrn, String type) {
        String tranType = type.toLowerCase().contains("moneygram") ? DEFAULT_IMT_REQUEST_TYPE : type;

        Optional<TransactionDetails> optionalTransactionDetails = getTransactionDetails(rrn, tranType);
        if (optionalTransactionDetails.isPresent()) {
            TransactionDetails transactionDetails = optionalTransactionDetails.get();

            // Set total charges
            transactionDetails.setTotalFees(new BigDecimal(charge));
            return transactionDetails;
        }
        return null;
    }

    private Optional<TransactionDetails> getTransactionDetails(String rrn, String type) {
        String tranType = type.toLowerCase().contains("moneygram") ? DEFAULT_IMT_REQUEST_TYPE : type;

        Optional<TransactionDetails> optionalTransactionDetails = databaseService.getTransactionRecord(rrn, tranType);
        if (optionalTransactionDetails.isEmpty()) {
            log.warn("No transaction record found with RRN: {}", rrn);
        }
        return optionalTransactionDetails;
    }

    private String getImtStatusDesc(Map<String, String> transactionDetailsMap) {
        String imtStatus = transactionDetailsMap.get("transactionStatus");
        return switch (imtStatus) {
            case "AVAIL" -> "Transaction is available";
            case "CANCL" -> "Transaction is canceled";
            case "RECVD" -> "Transaction is received";
            case "REFND" -> "Transaction is refunded";
            case "AFR" -> "Transaction is available for refund";
            case "PRCSS" -> "Transaction is in processing";
            default -> "Unknown transaction status";
        };
    }

//    private BigDecimal getAmount(Map<String, String> xmlStringMap) {
//        // Retrieve the amount values from the map, defaulting to null if they are absent
//        String amountExcludingFee = xmlStringMap.get("amountExcludingFee");
//        String amountIncludingFee = xmlStringMap.get("amountIncludingFee");
//        String receiveAmount = xmlStringMap.get("receiveAmount");
//
//        // Determine the amount to save based on the first non-null value
//        String amount;
//        if (amountExcludingFee != null) {
//            amount = amountExcludingFee;
//        } else if (amountIncludingFee != null) {
//            amount = amountIncludingFee;
//        } else if (receiveAmount != null) {
//            amount = receiveAmount;
//        } else {
//            amount = "0";
//        }
//        return new BigDecimal(amount);
//    }
}
