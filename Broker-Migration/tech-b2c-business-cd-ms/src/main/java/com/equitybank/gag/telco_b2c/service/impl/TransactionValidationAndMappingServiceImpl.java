package com.equitybank.gag.telco_b2c.service.impl;

import com.equitybank.gag.telco_b2c.dto.airtime.request.Envelope;
import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.mapper.CustomMapperService;
import com.equitybank.gag.telco_b2c.service.DatabaseService;
import com.equitybank.gag.telco_b2c.service.TransactionValidationAndMappingService;
import com.equitybank.gag.telco_b2c.service.SignatureVerificationService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;
import java.util.Optional;

import static com.equitybank.gag.telco_b2c.config.ApplicationConstants.DEFAULT_IMT_REQUEST_TYPE;
import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.*;

import java.security.SignatureException;

@Service
public class TransactionValidationAndMappingServiceImpl implements TransactionValidationAndMappingService {
    private static final Logger log = LoggerFactory.getLogger(TransactionValidationAndMappingServiceImpl.class);

    // Environment configs
    private final boolean isSignatureValidationEnabled;

    // Other configs
    private final SignatureVerificationService signatureVerificationService;
    private final CustomMapperService customMapperService;
    private final DatabaseService databaseService;

    @Autowired
    public TransactionValidationAndMappingServiceImpl(@Value("${signature.validation.enabled}") boolean isSignatureValidationEnabled,
                                                      SignatureVerificationService signatureVerificationService,
                                                      CustomMapperService customMapperService,
                                                      DatabaseService databaseService) {
        this.isSignatureValidationEnabled = isSignatureValidationEnabled;
        this.signatureVerificationService = signatureVerificationService;
        this.customMapperService = customMapperService;
        this.databaseService = databaseService;
    }

    @Override
    @Transactional(readOnly = true)
    public void checkForDatabaseRecord(String rrn, String type, String operation) throws CustomException {
        try {
            switch (operation) {
                case "duplicate-check", "record-exist-check" ->
                        databaseService.checkTransactionRecord(rrn, type, operation);
                default -> {
                    log.error("{}, Invalid operation type: {}", rrn, operation);
                    throw new CustomException(String.format("%sInvalid operation type, %s", DEFAULT_PROCESSING_FAILURE, operation));
                }
            }
        } catch (CustomException e) {
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public TransactionDetails getDatabaseRecord(String rrn, String type) throws CustomException {
        if ("status-check-floatpurchase".equalsIgnoreCase(type)) {
            type="floatPurchase";
        }
        String tranType = type.toLowerCase().contains("moneygram") ? DEFAULT_IMT_REQUEST_TYPE : type;

        try {
            Optional<TransactionDetails> optionalTransactionDetails = databaseService.getTransactionRecord(rrn, tranType);
            if (optionalTransactionDetails.isPresent()) {
                return optionalTransactionDetails.get();
            }
            throw new CustomException(NOT_FOUND);
        } catch (CustomException e) {
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public TransactionDetails getEntity(String requestXml, request request, Envelope airtimeRequest, Map<String, String> xmlStringMap, String type, String rrn) {
        return switch (type) {
            case "transaction" -> customMapperService.composeInitialTransactionEntity(request, type);
            case "floatPurchase" -> customMapperService.composeInitialFloatPurchaseToEntity(request, type);
            case "moneygram-fee-lookup" ->
                    customMapperService.composeInitialMGFeeLookupToEntity(requestXml, xmlStringMap, rrn, type);
            case "moneygram-receive-reference-number-request" ->
                    customMapperService.composeInitialReferenceNumberReqToEntity(requestXml, xmlStringMap, rrn, type);
            default -> customMapperService.composeInitialAirtimeTopUpEntity(airtimeRequest, type);
        };
    }

    @Override
    public void validateSignature(boolean isInternal, Map<String, String> xmlTagsMap, request request, Envelope airtimeRequest, String rrn, String type) throws CustomException, SignatureException {
        try {
            if (isInternal) {
                log.info("{}: Internal request, signature verification skipped!", rrn);
                return;
            }

            if (!isSignatureValidationEnabled) {
                log.info("{}: Signature Validation Disabled!", rrn);
                return;
            }

            boolean isSignatureValid = switch (type) {
                case "bank-to-wallet-namecheck", "airtime-topup-namecheck", "float-purchase-namecheck" ->
                        signatureVerificationService.verifyNamecheckRequestSignature(xmlTagsMap);
                case "status-check-banktowallet", "status-check-airtime", "status-check-floatpurchase" ->
                        signatureVerificationService.verifyStatusCheckRequestSignature(xmlTagsMap);
                case "transaction" -> signatureVerificationService.verifyTransactionRequestSignature(request);
                case "floatPurchase" -> signatureVerificationService.verifyFloatPurchaseRequestSignature(request);
                case "moneygram-fee-lookup" ->
                        signatureVerificationService.verifyMGFeeLookupRequestSignature(xmlTagsMap);
                case "moneygram-receive-reference-number-request" ->
                        signatureVerificationService.verifyReferenceNumberRequestSignature(xmlTagsMap);
                case "moneygram-get-field-for-product" ->
                        signatureVerificationService.verifyGetFieldForProductRequestSignature(xmlTagsMap);
                case "moneygram-receive-get-field-for-product" ->
                        signatureVerificationService.verifyReceiveGetFieldForProductRequestSignature(xmlTagsMap);
                case "moneygram-send-validation-request" ->
                        signatureVerificationService.verifySendValidationRequestSignature(xmlTagsMap);
                case "moneygram-receive-validation-request" ->
                        signatureVerificationService.verifyReceiveValidationRequestSignature(xmlTagsMap);
                case "moneygram-commit-transaction" ->
                        signatureVerificationService.verifyCommitTransactionRequestSignature(xmlTagsMap);
                case "moneygram-receive-commit-transaction" ->
                        signatureVerificationService.verifyReceiveCommitTransactionRequestSignature(xmlTagsMap);
                case "moneygram-detail-lookup" ->
                        signatureVerificationService.verifyDetailLookupRequestSignature(xmlTagsMap);
                case "moneygram-send-reversal" ->
                        signatureVerificationService.verifySendReversalRequestSignature(xmlTagsMap);
                case "moneygram-amend-transaction" ->
                        signatureVerificationService.verifyAmendTransactionRequestSignature(xmlTagsMap);
                case "moneygram-receive-reversal" ->
                        signatureVerificationService.verifyReceiveReversalRequestSignature(xmlTagsMap);
                case "moneygram-code-table-service" ->
                        signatureVerificationService.verifyCodeTableRequestSignature(xmlTagsMap);
                default -> signatureVerificationService.verifyAirtimeRequestSignature(airtimeRequest);
            };

            if (!isSignatureValid) {
                throw new SignatureException(SIGNATURE_VALIDATION_ERROR);
            }
            log.info("{}: Signature Validation Successful!", rrn);
        } catch (CustomException e) {
            throw new SignatureException(e.getMessage());
        }
    }
}
