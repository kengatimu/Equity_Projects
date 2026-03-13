package com.equitybank.gag.orange_money_ms.mapper;

import com.equitybank.gag.orange_money_ms.dto.b2c.status.request.StatusEnvelope;
import com.equitybank.gag.orange_money_ms.dto.b2c.tran.request.*;
import com.equitybank.gag.orange_money_ms.dto.channel.response.request;
import com.equitybank.gag.orange_money_ms.entity.TransactionDetails;
import com.equitybank.gag.orange_money_ms.exception.CustomException;
import com.equitybank.gag.orange_money_ms.service.DatabaseService;
import com.equitybank.gag.orange_money_ms.service.JaxBMarshallerService;
import com.equitybank.gag.orange_money_ms.service.TokenGenerateService;
import com.google.gson.Gson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Optional;

import static com.equitybank.gag.orange_money_ms.config.ApplicationConstants.*;
import static com.equitybank.gag.orange_money_ms.config.StatusCodeMessages.*;
import static com.equitybank.gag.orange_money_ms.enums.TransactionStatus.*;

@Service
public class CustomMapperServiceImpl implements CustomMapperService {
    private static final Logger log = LoggerFactory.getLogger(CustomMapperServiceImpl.class);

    // Environment variables
    private final String accountAlias;

    // Other variables
    private final JaxBMarshallerService jaxBMarshallerService;
    private final TokenGenerateService tokenGenerateService;
    private final DatabaseService databaseService;
    private final Gson gson;

    @Autowired
    public CustomMapperServiceImpl(@Value("${equity-orange.account.alias}") String accountAlias,
                                   JaxBMarshallerService jaxBMarshallerService,
                                   TokenGenerateService tokenGenerateService,
                                   DatabaseService databaseService,
                                   Gson gson) {
        this.accountAlias = accountAlias;
        this.jaxBMarshallerService = jaxBMarshallerService;
        this.tokenGenerateService = tokenGenerateService;
        this.databaseService = databaseService;
        this.gson = gson;
    }

    @Override
    public TransactionDetails composeEntityForErrorResponseUpdate(String xmlResponse, String rrn, String errorCode, String errorDescription) {
        Optional<TransactionDetails> optionalTransactionDetails = databaseService.getTransactionRecord(rrn);
        if (optionalTransactionDetails.isPresent()) {
            TransactionDetails transactionDetails = optionalTransactionDetails.get();

            // Set status details
            transactionDetails.getStatusDetails().setStatusCode(errorCode);
            transactionDetails.getStatusDetails().setStatusMessage(errorDescription);
            transactionDetails.getStatusDetails().setStatus(ERROR.toString());

            // Set payload details
            transactionDetails.getPayloadDetails().setChannelResponse(xmlResponse);
            return transactionDetails;
        } else {
            log.warn("No transaction record found with RRN: {}", rrn);
        }
        return null;
    }

    @Override
    public String composeTelcoTransactionRequestString(request channelRequest) throws CustomException {
        try {
            String rrn = (channelRequest.getEazzycash().getRrn() == null || channelRequest.getEazzycash().getRrn().isEmpty())
                    ? channelRequest.getEazzycash().getNumber()
                    : channelRequest.getEazzycash().getRrn();

            MmHeaderInfo mmHeaderInfo = new MmHeaderInfo();
            mmHeaderInfo.setOperatorCode(TELCO);
            mmHeaderInfo.setRequestId(rrn);
            mmHeaderInfo.setRequestToken(tokenGenerateService.generateToken());
            mmHeaderInfo.setRequestType(DEFAULT_TRANSACTION_TYPE);
            mmHeaderInfo.setAffiliateCode(DEFAULT_BANK_AFFILIATE_CODE);

            MobileTransferRequest mobileTransferRequest = new MobileTransferRequest();
            mobileTransferRequest.setMmHeaderInfo(mmHeaderInfo);
            mobileTransferRequest.setExternalRefNo(rrn);
            mobileTransferRequest.setMobileNo("");
            mobileTransferRequest.setMobileName("");
            mobileTransferRequest.setMobileAlias("");
            mobileTransferRequest.setAccountNo("");
            mobileTransferRequest.setAccountAlias(channelRequest.getEazzycash().getNumber());
            mobileTransferRequest.setAccountName("");
            mobileTransferRequest.setTransferDescription("");
            mobileTransferRequest.setCcy(DEFAULT_CURRENCY);
            mobileTransferRequest.setAmount(channelRequest.getEazzycash().getAmount().doubleValue());
            mobileTransferRequest.setCharge(0);
            mobileTransferRequest.setTranDate(getDate());
            mobileTransferRequest.setUdf1("");
            mobileTransferRequest.setUdf2("");
            mobileTransferRequest.setUdf3("");

            AccountToWalletTransfer accountToWalletTransfer = new AccountToWalletTransfer();
            accountToWalletTransfer.setMobileTransferRequest(mobileTransferRequest);

            Body soapBody = new Body();
            soapBody.setAccountToWalletTransfer(accountToWalletTransfer);

            Envelope soapEnvelope = new Envelope();
            soapEnvelope.setBody(soapBody);

            return jaxBMarshallerService.marshallTransactionRequestToXml(soapEnvelope, rrn);
        } catch (CustomException e) {
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public String composeTelcoStatusCheckRequestString(String rrn) throws CustomException {
        try {
            com.equitybank.gag.orange_money_ms.dto.b2c.status.request.MmHeaderInfo mmHeaderInfo = new com.equitybank.gag.orange_money_ms.dto.b2c.status.request.MmHeaderInfo();
            mmHeaderInfo.setOperatorCode(TELCO);
            mmHeaderInfo.setRequestId(rrn);
            mmHeaderInfo.setRequestToken("");
            mmHeaderInfo.setRequestType(DEFAULT_STATUS_CHECK_TYPE);
            mmHeaderInfo.setAffiliateCode(DEFAULT_BANK_AFFILIATE_CODE);

            com.equitybank.gag.orange_money_ms.dto.b2c.status.request.TranRequestInfo tranRequestInfo = new com.equitybank.gag.orange_money_ms.dto.b2c.status.request.TranRequestInfo();
            tranRequestInfo.setMmHeaderInfo(mmHeaderInfo);
            tranRequestInfo.setExternalRefNo(rrn);

            com.equitybank.gag.orange_money_ms.dto.b2c.status.request.TransferStatusInquiry transferStatusInquiry = new com.equitybank.gag.orange_money_ms.dto.b2c.status.request.TransferStatusInquiry();
            transferStatusInquiry.setTranRequestInfo(tranRequestInfo);

            com.equitybank.gag.orange_money_ms.dto.b2c.status.request.Body body = new com.equitybank.gag.orange_money_ms.dto.b2c.status.request.Body();
            body.setTransferStatusInquiry(transferStatusInquiry);

            StatusEnvelope envelope = new StatusEnvelope();
            envelope.setBody(body);

            return jaxBMarshallerService.marshallStatusCheckRequestToXml(envelope, rrn);
        } catch (CustomException e) {
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public TransactionDetails composeEntityForPendingResponseUpdate(String rrn) {
        Optional<TransactionDetails> optionalTransactionDetails = databaseService.getTransactionRecord(rrn);
        if (optionalTransactionDetails.isPresent()) {
            TransactionDetails transactionDetails = optionalTransactionDetails.get();

            // Set status details
            transactionDetails.getStatusDetails().setStatus(PENDING.toString());
            transactionDetails.getStatusDetails().setStatusCode(PENDING_STATUS_CODE);
            transactionDetails.getStatusDetails().setStatusMessage(PENDING.getDescription());
            return transactionDetails;
        } else {
            log.warn("No transaction record found with RRN: {}", rrn);
        }
        return null;
    }

    @Override
    public TransactionDetails composeEntityForTelcoRequestUpdate(String rrn, String telcoJsonReq) {
        Optional<TransactionDetails> optionalTransactionDetails = databaseService.getTransactionRecord(rrn);
        if (optionalTransactionDetails.isPresent()) {
            TransactionDetails transactionDetails = optionalTransactionDetails.get();
            transactionDetails.getPayloadDetails().setTelcoRequest(telcoJsonReq);
            return transactionDetails;
        } else {
            log.warn("No transaction record found with RRN: {}", rrn);
        }
        return null;
    }

    @Override
    public TransactionDetails composeEntityForTelcoResponseUpdate(String rrn, String telcoJsonRes) {
        Optional<TransactionDetails> optionalTransactionDetails = databaseService.getTransactionRecord(rrn);
        if (optionalTransactionDetails.isPresent()) {
            TransactionDetails transactionDetails = optionalTransactionDetails.get();
            transactionDetails.getPayloadDetails().setTelcoResponse(telcoJsonRes);
            return transactionDetails;
        } else {
            log.warn("No transaction record found with RRN: {}", rrn);
        }
        return null;
    }

    @Override
    public TransactionDetails composeEntityForTranIdUpdate(String tranId, String rrn) {

        Optional<TransactionDetails> optionalTransactionDetails = databaseService.getTransactionRecord(rrn);
        if (optionalTransactionDetails.isPresent()) {
            TransactionDetails transactionDetails = optionalTransactionDetails.get();

            // Set status details tran id
            transactionDetails.getStatusDetails().setTranId(tranId);
            return transactionDetails;
        } else {
            log.warn("No transaction record found with RRN: {}", rrn);
        }
        return null;
    }

    @Override
    public TransactionDetails composeEntityForFinalStatusSuccess(String telcoResponseString, String xmlResponseString, String rrn) {
        Optional<TransactionDetails> optionalTransactionDetails = databaseService.getTransactionRecord(rrn);
        if (optionalTransactionDetails.isPresent()) {
            TransactionDetails transactionDetails = optionalTransactionDetails.get();

            // Set status details
            transactionDetails.getStatusDetails().setStatus(OK.toString());
            transactionDetails.getStatusDetails().setStatusCode(SUCCESS_STATUS_CODE);
            transactionDetails.getStatusDetails().setStatusMessage(OK.getDescription());

            // Set status details tran id
            transactionDetails.getPayloadDetails().setChannelResponse(xmlResponseString);
            transactionDetails.getPayloadDetails().setTelcoResponse(telcoResponseString);
            return transactionDetails;
        } else {
            log.warn("No transaction record found with RRN: {}", rrn);
        }
        return null;
    }

    private Date getDate() {
        try {
            Date today = new Date();

            // Format the date as YYYY-MM-DD
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String formattedDate = sdf.format(today);

            // Parse the formatted date string back into a Date object
            return sdf.parse(formattedDate);

        } catch (ParseException e) {
            log.error("Date parsing failed: {}", e.getMessage());
            return null;
        }
    }
}
