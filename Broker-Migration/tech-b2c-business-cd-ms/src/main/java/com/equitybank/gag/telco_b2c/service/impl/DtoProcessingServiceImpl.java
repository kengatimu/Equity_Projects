package com.equitybank.gag.telco_b2c.service.impl;

import com.equitybank.gag.telco_b2c.dto.airtime.request.Envelope;
import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.exception.CustomExceptionForReversal;
import com.equitybank.gag.telco_b2c.service.*;
import com.equitybank.gag.telco_b2c.web.rest.controller.util.TelcoResolver;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.equitybank.gag.telco_b2c.config.ApplicationConstants.*;
import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.*;

import java.security.SignatureException;

@Service
public class DtoProcessingServiceImpl implements DtoProcessingService {
    private static final Logger log = LoggerFactory.getLogger(DtoProcessingServiceImpl.class);

    private final TransactionValidationAndMappingService transactionValidationAndMappingService;
    private final XmlJsonMapperService xmlJsonMapperService;
    private final DebitCreditService debitCreditService;
    private final DatabaseService databaseService;
    private final PayloadService payloadService;
    private final TelcoResolver telcoResolver;
    private final HttpService httpService;

    public DtoProcessingServiceImpl(TransactionValidationAndMappingService transactionValidationAndMappingService,
                                    XmlJsonMapperService xmlJsonMapperService,
                                    DebitCreditService debitCreditService,
                                    DatabaseService databaseService,
                                    PayloadService payloadService,
                                    TelcoResolver telcoResolver,
                                    HttpService httpService) {
        this.transactionValidationAndMappingService = transactionValidationAndMappingService;
        this.xmlJsonMapperService = xmlJsonMapperService;
        this.debitCreditService = debitCreditService;
        this.databaseService = databaseService;
        this.payloadService = payloadService;
        this.telcoResolver = telcoResolver;
        this.httpService = httpService;
    }

    @Override
    public String processChannelRequest(boolean isInternal, request request, Envelope airtimeRequest, BindingResult result, String type) throws CustomException, SignatureException {
        String rrn;
        String telecom;
        String countryCode;
        String channel = "";

        if ("floatPurchase".equalsIgnoreCase(type)) {
            telecom = request.getEazzycash().getTelco().toUpperCase();
            rrn = request.getEazzycash().getRrn();
            countryCode = request.getEazzycash().getBankId();
            channel = request.getEazzycash().getChannel();
        } else {
            telecom = "transaction".equals(type) ? request.getEazzycash().getTelco().toUpperCase() : airtimeRequest.getBody().getTopUp().getTelcom().toUpperCase();
            rrn = "transaction".equals(type) ? request.getEazzycash().getRrn() : airtimeRequest.getBody().getTopUp().getRrn();
            countryCode = "transaction".equals(type) ? request.getEazzycash().getBankId() : airtimeRequest.getBody().getTopUp().getCountry();
        }

        // Omni channel sometimes refer vodacom as mpesa for vodacom drc
        boolean isMpesa = telecom.contains("MPESA") || telecom.contains("M-PESA");
        String telco = switch (countryCode) {
            case "43" -> isMpesa ? DEFAULT_VODACOM_CD : telecom;
            case "54" -> isMpesa ? DEFAULT_SAFARICOM_KE : telecom;
            default -> telecom;
        };

        // Check if debit credit is enable
        boolean debitCreditEnabled = checkDebitCreditEnabled(type, countryCode, channel);

        // Get bank id
        String bankId = getBankId(request, airtimeRequest, type);
        try {
            // Validate fields
            checkForInputValidationErrors(result);

            // Validate signature
            validateSignature(isInternal, request, airtimeRequest, rrn, type);

            // Validate receiver number against telco
            validateReceiverNumber(telco, request, type);

            // Check for duplicate record
            checkForDuplicateRecord(rrn, type);

            // Update currency if null
            updateCurrency(request, airtimeRequest, type);

            // Map request to entity request
            TransactionDetails entity = getEntity(request, airtimeRequest, type, rrn);

            // Save the initial record to db
            persistInitialTransactionRecord(entity);

            // Call service for debit credit
            callDebitCreditService(new TransactionDetails(), bankId, debitCreditEnabled, request, airtimeRequest, new HashMap<>(), rrn, type);

            // Compose telco request
            String telcoServiceXmlReq = composeTelcoRequest(request, airtimeRequest, type);

            // Return received response
            return httpService.httpCall(telcoServiceXmlReq, telco, rrn, type, bankId, "");

        } catch (CustomExceptionForReversal e) {
            // If a CustomExceptionForReversal is caught, perform a reversal
            // But first check if debit credit is enabled
            if (debitCreditEnabled) {
                debitCreditService.doReversal(rrn, type, bankId);
            }

            // Then rethrow as CustomException
            throw new CustomException(e.getMessage());

        } catch (CustomException e) {
            // Handle regular CustomException
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public String processCallbackRequest(Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException {
        String statusCode = xmlTagsMap.get("resultCode");

        if ("0".equals(statusCode)) {
            return payloadService.composeChannelCallbackSuccessResponse(xmlTagsMap, rrn);
        }
        return payloadService.composeChannelCallbackFailureResponse(xmlTagsMap, rrn);
    }

    private void validateReceiverNumber(String telco, request request, String type) throws CustomException {
        String resolvedTelco = "";
        if ("transaction".equals(type)) {
            resolvedTelco = telcoResolver.resolveTelco(request.getEazzycash().getNumber());
            log.info("Resolved Telco: " + resolvedTelco);
        }
        if (!telco.contains(resolvedTelco.toUpperCase())) {
            throw new CustomException(INVALID_TELCO_ERROR);
        }
    }

    private String getBankId(request request, Envelope airtimeRequest, String type) {
        String bankId;
        if ("transaction".equals(type) || type.equals("floatPurchase")) {
            bankId = request.getEazzycash().getBankId() == null || request.getEazzycash().getBankId().isBlank()
                    ? DEFAULT_BANK_ID
                    : request.getEazzycash().getBankId();
        } else {
            bankId = airtimeRequest.getBody().getTopUp().getCountry() == null || airtimeRequest.getBody().getTopUp().getCountry().isBlank()
                    ? DEFAULT_COUNTRY_CODE
                    : airtimeRequest.getBody().getTopUp().getCountry().toUpperCase();
        }
        return bankId;
    }

    private void updateCurrency(request request, Envelope airtimeRequest, String type) {
        String currency = null;
        if (type.equals("floatPurchase")) {
            currency = request.getEazzycash().getCurrency();
        } else {
            currency = "transaction".equals(type)
                    ? request.getEazzycash().getCurrency()
                    : airtimeRequest.getBody().getTopUp().getCurrency();
        }

        // Check if currency is null or blank and set it to "CDF" if so
        if (currency == null || currency.trim().isBlank()) {
            switch (type) {
                case "transaction", "floatPurchase" -> request.getEazzycash().setCurrency(DEFAULT_CURRENCY);
                case "airtime" -> airtimeRequest.getBody().getTopUp().setCurrency(DEFAULT_CURRENCY);
            }
        }
        log.info("Transaction Currency {}", currency);
    }

    private void checkForDuplicateRecord(String rrn, String type) throws CustomException {
        try {
            transactionValidationAndMappingService.checkForDatabaseRecord(rrn, type, "duplicate-check");
        } catch (CustomException e) {
            throw new CustomException(e.getMessage());
        }
    }

    private TransactionDetails getEntity(request request, Envelope airtimeRequest, String type, String rrn) {
        return transactionValidationAndMappingService.getEntity("", request, airtimeRequest, new HashMap<>(), type, rrn);
    }

    @Transactional
    private void persistInitialTransactionRecord(TransactionDetails entity) {
        databaseService.persistInitialTransactionRecord(entity);
    }

    private void checkForInputValidationErrors(BindingResult result) throws CustomException {
        // Check if input request dto fields contains errors
        if (!result.hasErrors()) {
            return;
        }
        List<ObjectError> allErrors = result.getAllErrors();
        throw new CustomException(FIELD_VALIDATION_ERROR + allErrors.get(0).getDefaultMessage());
    }

    private void validateSignature(boolean isInternal, request request, Envelope airtimeRequest, String rrn, String type) throws CustomException, SignatureException {
        try {
            transactionValidationAndMappingService.validateSignature(isInternal, new HashMap<>(), request, airtimeRequest, rrn, type);
        } catch (CustomException e) {
            throw new CustomException(e.getMessage());
        }
    }

    private boolean checkDebitCreditEnabled(String type, String countryCode, String channel) {
        if (channel.equalsIgnoreCase(DEFAULT_FIN_CHANNEL)) {
            return false;
        }

        boolean isEnabled = debitCreditService.checkDebitCreditEnable(type);
        boolean isEnabledForCountry = debitCreditService.isDrCrEnabledForCountry(type, countryCode);
        return isEnabled && isEnabledForCountry;
    }

    private void callDebitCreditService(TransactionDetails transactionDetails, String bankId, boolean debitCreditEnabled, request request, Envelope airtimeRequest, Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException {
        log.info("{} debitCreditEnabled: {}", type, debitCreditEnabled);
        try {
            if (!debitCreditEnabled) {
                return;
            }
            debitCreditService.doDebitCredit(transactionDetails, bankId, request, airtimeRequest, xmlTagsMap, rrn, type);
        } catch (CustomException e) {
            throw new CustomException(e.getMessage());
        }
    }

    private String composeTelcoRequest(request request, Envelope airtimeRequest, String type) {
        String rrn;
        String telcoXmlReq;
        if ("transaction".equals(type) || "floatPurchase".equals(type)) {
            rrn = request.getEazzycash().getRrn();
            telcoXmlReq = xmlJsonMapperService.b2cTransactionRequestToXml(request);
        } else {
            rrn = airtimeRequest.getBody().getTopUp().getRrn();
            telcoXmlReq = xmlJsonMapperService.airtimeTopUpRequestToXml(airtimeRequest);
        }
        log.info("{}: Telco technical service composed xml Request: \n{}", rrn, telcoXmlReq);
        return telcoXmlReq;
    }
}
