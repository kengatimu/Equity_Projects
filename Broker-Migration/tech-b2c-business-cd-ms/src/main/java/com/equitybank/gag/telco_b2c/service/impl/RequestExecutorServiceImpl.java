package com.equitybank.gag.telco_b2c.service.impl;

import com.equitybank.gag.telco_b2c.dto.airtime.request.Envelope;
import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.dto.thunes.creditParties.creditPartyInfo.CreditPartyInformation;
import com.equitybank.gag.telco_b2c.dto.thunes.creditParties.creditPartyVerify.CreditPartyVerify;
import com.equitybank.gag.telco_b2c.dto.thunes.discovery.bic.BicLookup;
import com.equitybank.gag.telco_b2c.dto.thunes.discovery.countries.ListOfThunesCountries;
import com.equitybank.gag.telco_b2c.dto.thunes.discovery.details.PayerDetails;
import com.equitybank.gag.telco_b2c.dto.thunes.discovery.payers.ThunesPayers;
import com.equitybank.gag.telco_b2c.dto.thunes.discovery.rates.PayerRates;
import com.equitybank.gag.telco_b2c.dto.thunes.discovery.services.ListOfThunesServices;
import com.equitybank.gag.telco_b2c.dto.thunes.response.ChannelResponse;
import com.equitybank.gag.telco_b2c.dto.thunes.staticData.StaticDataRequest;
import com.equitybank.gag.telco_b2c.dto.thunes.transfer.quotation.CreateQuoteDto;
import com.equitybank.gag.telco_b2c.dto.thunes.transfer.transaction.TransactionRequestDto;
import com.equitybank.gag.telco_b2c.dto.wendi.namecheck.NamecheckRequest;
import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.mapper.CustomMapperService;
import com.equitybank.gag.telco_b2c.service.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;

import java.security.SignatureException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.*;

@Service
public class RequestExecutorServiceImpl implements RequestExecutorService {

    private final DatabaseService databaseService;
    private final ImtHttpService imtHttpService;
    private final DebitCreditService debitCreditService;
    private final CustomMapperService customMapperService;
    private final SignatureVerificationService signatureVerificationService;
    private final ThunesStaticDataProcessorService thunesStaticDataProcessorService;
    private final ThunesChannelResponseWrapperService wrapperService;

    public RequestExecutorServiceImpl(DatabaseService databaseService,
                                      ImtHttpService imtHttpService,
                                      DebitCreditService debitCreditService,
                                      CustomMapperService customMapperService,
                                      SignatureVerificationService signatureVerificationService,
                                      ThunesStaticDataProcessorService thunesStaticDataProcessorService,
                                      ThunesChannelResponseWrapperService wrapperService) {
        this.databaseService = databaseService;
        this.imtHttpService = imtHttpService;
        this.debitCreditService = debitCreditService;
        this.customMapperService = customMapperService;
        this.signatureVerificationService = signatureVerificationService;
        this.thunesStaticDataProcessorService = thunesStaticDataProcessorService;
        this.wrapperService = wrapperService;
    }

    @Override
    public ChannelResponse executeThunesListOfServices(String rrn, ListOfThunesServices req, BindingResult result, String type) throws CustomException, SignatureException {
        validate(result);
        verify(signatureVerificationService.verifyThunesGetListOfServices(req, type));
        return wrap(imtHttpService.thunesServicesHttpCall(rrn, req, type));
    }

    @Override
    public ChannelResponse executeThunesGetPayers(String rrn, ThunesPayers req, BindingResult result, String type) throws CustomException, SignatureException {
        validate(result);
        verify(signatureVerificationService.verifyGetThunesPayers(req, type));
        return wrap(imtHttpService.thunesPayersHttpCall(rrn, req, type));
    }

    @Override
    public ChannelResponse executeThunesPayerRates(String rrn, PayerRates req, BindingResult result, String type) throws CustomException, SignatureException {
        validate(result);
        verify(signatureVerificationService.verifyThunesPayerRates(req, type));
        return wrap(imtHttpService.thunesPayerRatesHttpCall(rrn, req, type));
    }

    @Override
    public ChannelResponse executeThunesPayerDetails(String rrn, PayerDetails req, BindingResult result, String type) throws CustomException, SignatureException {
        validate(result);
        verify(signatureVerificationService.verifyThunesPayerDetails(req, type));
        return wrap(imtHttpService.thunesPayerDetailsHttpCall(rrn, req, type));
    }

    @Override
    public ChannelResponse executeThunesListOfCountries(String rrn, ListOfThunesCountries req, BindingResult result, String type) throws CustomException, SignatureException {
        validate(result);
        verify(signatureVerificationService.verifyThunesListOfCountries(req, type));
        return wrap(imtHttpService.thunesListOfCountriesHttpCall(rrn, req, type));
    }

    @Override
    public ChannelResponse executeThunesBicLookup(String rrn, BicLookup req, BindingResult result, String type) throws CustomException, SignatureException {
        validate(result);
        verify(signatureVerificationService.verifyThunesBicLookup(req, type));
        return wrap(imtHttpService.thunesBicLookupHttpCall(rrn, req, type));
    }

    @Override
    public ChannelResponse executeThunesCreditPartyInfo(String rrn, CreditPartyInformation req, BindingResult result, String type) throws CustomException, SignatureException {
        validate(result);
        verify(signatureVerificationService.verifyThunesCreditPartyInfo(req, type));
        return wrap(imtHttpService.thunesCreditPartyInfoHttpCall(rrn, req, type));
    }

    @Override
    public ChannelResponse executeThunesCreditPartyVerify(String rrn, CreditPartyVerify req, BindingResult result, String type) throws CustomException, SignatureException {
        validate(result);
        verify(signatureVerificationService.verifyThunesCreditPartyVerify(req, type));
        return wrap(imtHttpService.thunesCreditPartyVerifyHttpCall(rrn, req, type));
    }

    @Override
    public ChannelResponse executeThunesStaticData(String rrn, StaticDataRequest staticDataRequest, BindingResult result, String type) throws CustomException, SignatureException {
        validate(result);
        verify(signatureVerificationService.verifyThunesStaticData(staticDataRequest, type));
        String staticDataString = thunesStaticDataProcessorService.getStaticData(staticDataRequest, type);
        return wrap(staticDataString);
    }

    @Override
    public ChannelResponse executeThunesCreateQuotation(String rrn, CreateQuoteDto req, BindingResult result, String type) throws CustomException, SignatureException {
        validate(result);
        verify(signatureVerificationService.verifyCreateQuoteRequest(req, type));
        return wrap(imtHttpService.thunesCreateQuoteHttpCall(rrn, req, type));
    }

    @Override
    public ChannelResponse executeWendiB2CNamecheck(String rrn, NamecheckRequest req, BindingResult result, String type) throws CustomException, SignatureException {
        validate(result);
        verify(signatureVerificationService.verifyWendiB2CNamecheck(req, type));
        return wrap(imtHttpService.wendiB2CNamecheckHttpCall(rrn, req, type));
    }

    @Override
    public ChannelResponse executeThunesSendTransaction(String rrn, TransactionRequestDto req, BindingResult result, String type) throws CustomException, SignatureException {
        // Validate inputs
        validate(result);

        // Signature verification check
        verify(signatureVerificationService.verifySendTransactionRequest(req, type));

        // Check for duplicates
        databaseService.checkTransactionRecord(rrn, type, "duplicate-check");

        // Compose the transaction entity
        TransactionDetails entity = customMapperService.composeInitialThunesTransactionEntity(req, type);

        // Save the initial record to db
        persistInitialTransactionRecord(entity);

        // Create hashmap with debit credit details
        Map <String, String> transactionDetailsMap = createMapForDebitCreditDetails(req);

        // Perform debit credit
        debitCreditService.doDebitCredit(entity, req.getChannelInfo().getBankId(), new request(), new Envelope(), transactionDetailsMap, rrn, type);


        // Send to thunes technical service




        return null;
    }

    private Map<String, String> createMapForDebitCreditDetails(TransactionRequestDto req) {
        Map<String, String> transactionDetailsMap = new HashMap<>();

        String rrn = req.getChannelInfo().getRrn();
        String bankId = req.getChannelInfo().getBankId();
        String senderAmount = req.getAmount().getSenderAmount();
        String senderCurrency = req.getAmount().getSenderCurrency();
        String receiverCurrency = req.getAmount().getReceiverCurrency();
        String partnerFee = req.getFees().getPartnerFee();
        String bankFee = req.getFees().getBankFee();
        String purpose = req.getRemittance().getPurpose();

        transactionDetailsMap.put("rrn", rrn);
        transactionDetailsMap.put("bankId", bankId);
        transactionDetailsMap.put("senderAmount", senderAmount);
        transactionDetailsMap.put("senderCurrency", senderCurrency);
        transactionDetailsMap.put("receiverCurrency", receiverCurrency);
        transactionDetailsMap.put("partnerFee", partnerFee);
        transactionDetailsMap.put("bankFee", bankFee);
        transactionDetailsMap.put("purpose", purpose);

        return transactionDetailsMap;
    }

    @Transactional
    private void persistInitialTransactionRecord(TransactionDetails entity) {
        databaseService.persistInitialTransactionRecord(entity);
    }

    // Common validator used by all methods
    private void validate(BindingResult result) throws CustomException {
        if (result.hasErrors()) {
            List<ObjectError> errors = result.getAllErrors();
            throw new CustomException(FIELD_VALIDATION_ERROR + errors.get(0).getDefaultMessage());
        }
    }

    private void verify(boolean isValid) throws SignatureException {
        if (!isValid) throw new SignatureException(SIGNATURE_VALIDATION_ERROR);
    }

    private ChannelResponse wrap(String responseString) {
        return wrapperService.wrapImtResponse(responseString);
    }
}