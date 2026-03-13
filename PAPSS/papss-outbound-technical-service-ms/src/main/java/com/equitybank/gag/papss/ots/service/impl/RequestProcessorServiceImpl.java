package com.equitybank.gag.papss.ots.service.impl;

import com.equitybank.gag.papss.ots.dto.channelRequest.fxRate.GetFxRateReq;
import com.equitybank.gag.papss.ots.dto.channelRequest.getParticipants.GetPapssParticipantsReq;
import com.equitybank.gag.papss.ots.jpos.jposService.TransactionDispatcherService;
import com.equitybank.gag.papss.ots.dto.channelRequest.namecheck.ChannelNamecheckDetailsReq;
import com.equitybank.gag.papss.ots.dto.channelRequest.statusCheck.ChannelStatusCheckDetailsReq;
import com.equitybank.gag.papss.ots.dto.channelRequest.transaction.ChannelCreditTransferDetailsReq;
import com.equitybank.gag.papss.ots.dto.channelResponse.ChannelResponse;
import com.equitybank.gag.papss.ots.entity.TransactionMaster;
import com.equitybank.gag.papss.ots.enums.TransactionStatus;
import com.equitybank.gag.papss.ots.enums.TransactionType;
import com.equitybank.gag.papss.ots.exception.CustomException;
import com.equitybank.gag.papss.ots.service.*;
import com.google.gson.Gson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;

import java.util.List;
import java.util.Map;
import java.util.Set;

import static com.equitybank.gag.papss.ots.config.ApplicationConstants.*;
import static com.equitybank.gag.papss.ots.enums.TransactionStatus.PENDING;
import static com.equitybank.gag.papss.ots.enums.TransactionStatus.TIMEOUT;

/**
 * Service responsible for processing incoming requests from the channel.
 * It handles initial synchronous validation, delegates asynchronous
 * credit transfer processing to the TransactionDispatcherService (jPOS),
 * and directly manages synchronous name check and status check flows,
 * as well as inbound callback responses.
 */
@Service
public class RequestProcessorServiceImpl implements RequestProcessorService {
    private static final Logger log = LoggerFactory.getLogger(RequestProcessorServiceImpl.class);

    private final Gson gson;
    private final String papssId;
    private final DatabaseService databaseService;
    private final HttpAdapterService httpAdapterService;
    private final EntityMapperService entityMapperService;
    private final FinacleReversalService finacleReversalService;
    private final XmlResponseReaderService xmlResponseReaderService;
    private final HttpResponseProcessorService httpResponseProcessorService;
    private final ISOPayloadXmlComposerService ISOPayloadXmlComposerService;
    private final SignatureValidationService signatureValidationService;
    private final ISOSignatureGenerationService ISOSignatureGenerationService;
    private final PayloadChannelResponseComposerService payloadChannelResponseComposerService;
    private final TransactionDispatcherService transactionDispatcherService;

    @Autowired
    public RequestProcessorServiceImpl(@Qualifier("gson") Gson gson,
                                       @Value("${papss.equity-bank-id}") String papssId,
                                       DatabaseService databaseService,
                                       HttpAdapterService httpAdapterService,
                                       EntityMapperService entityMapperService,
                                       FinacleReversalService finacleReversalService,
                                       XmlResponseReaderService xmlResponseReaderService,
                                       HttpResponseProcessorService httpResponseProcessorService,
                                       ISOPayloadXmlComposerService ISOPayloadXmlComposerService,
                                       SignatureValidationService signatureValidationService,
                                       ISOSignatureGenerationService ISOSignatureGenerationService,
                                       PayloadChannelResponseComposerService payloadChannelResponseComposerService,
                                       TransactionDispatcherService transactionDispatcherService) {
        this.gson = gson;
        this.papssId = papssId;
        this.databaseService = databaseService;
        this.httpAdapterService = httpAdapterService;
        this.entityMapperService = entityMapperService;
        this.finacleReversalService = finacleReversalService;
        this.xmlResponseReaderService = xmlResponseReaderService;
        this.httpResponseProcessorService = httpResponseProcessorService;
        this.ISOPayloadXmlComposerService = ISOPayloadXmlComposerService;
        this.signatureValidationService = signatureValidationService;
        this.ISOSignatureGenerationService = ISOSignatureGenerationService;
        this.payloadChannelResponseComposerService = payloadChannelResponseComposerService;
        this.transactionDispatcherService = transactionDispatcherService;
    }

    @Override
    public ChannelResponse processGetParticipants(String rrn, GetPapssParticipantsReq getPapssParticipantsReq, BindingResult bindingResult) throws CustomException {
        try {
            // Validate request inputs
            checkForInputValidationErrors(bindingResult);

            //Validate signature
            signatureValidationService.validateGetParticipantsSignature(getPapssParticipantsReq);

            // Call the remote endpoint
            String xmlResponse = httpAdapterService.sendHttpGetParticipants(rrn, getPapssParticipantsReq);

            // Convert to ChannelResponse via composer
            return payloadChannelResponseComposerService.composeGetParticipantsResponse(xmlResponse);

        } catch (Exception e) {
            log.error("{}: Exception in processGetParticipants: {}", rrn, e.getMessage());
            throw new CustomException(e.getMessage());
        }
    }


    @Override
    public ChannelResponse processGetFxRateRequest(String rrn, GetFxRateReq getFxRateReq, BindingResult bindingResult) throws CustomException {
        try {
            // Validate request inputs
            checkForInputValidationErrors(bindingResult);

            // Validate currencies
            validateCurrenciesForFxApi(getFxRateReq);

            //Validate signature
            signatureValidationService.validateGetFxRateSignature(getFxRateReq);

            // Call http fx rate API
            String xmlResponse = httpAdapterService.sendHttpFxRateRequest(rrn, getFxRateReq);

            // Return channel response
            return payloadChannelResponseComposerService.composeGetFxRateResponse(xmlResponse);

        } catch (Exception e) {
            log.error("{}: Failed to process FXRate request: {}", rrn, e.getMessage());
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public ChannelResponse processNamecheckRequest(ChannelNamecheckDetailsReq channelNamecheckDetailsReq, BindingResult bindingResult, String type) throws CustomException {
        String rrn = channelNamecheckDetailsReq.getChannelInfo().getRrn();

        // Validate request inputs
        checkForInputValidationErrors(bindingResult);

        // Validate sender institution id
        validateSenderInstId(channelNamecheckDetailsReq, type);

        //Validate signature
        signatureValidationService.validateNamecheckSignature(channelNamecheckDetailsReq);

        // Compose iso20022 acmt023 namecheck request
        String acmt023NamecheckXmlReq = ISOPayloadXmlComposerService.composeAcmt023NamecheckRequest(channelNamecheckDetailsReq);

        // Sign the generated request
        String signedAcmt023XmlReq = ISOSignatureGenerationService.generateXMLDigitalSignature(rrn, acmt023NamecheckXmlReq, type);

        // Send the namecheck request to papss
        String httpResponseString = httpAdapterService.sendHttpNamecheckRequest(rrn, signedAcmt023XmlReq, type);

        // Process the returned response
        return httpResponseProcessorService.processNamecheckResponse(rrn, httpResponseString, type);
    }

    @Override
    public ChannelResponse processTransactionRequest(ChannelCreditTransferDetailsReq channelCreditTransferDetailsReq, BindingResult bindingResult, String type) throws CustomException {
        String rrn = channelCreditTransferDetailsReq.getChannelInfo().getRrn();

        // Perform DTO field validation (Spring's BindingResult)
        checkForInputValidationErrors(bindingResult);

        // Validate sender institution id
        validateSenderInstId(channelCreditTransferDetailsReq, type);

        // Check for valid currencies - KES or USD
        checkForValidCurrencies(channelCreditTransferDetailsReq);

        // Perform synchronous security validation (signature)
        signatureValidationService.validateTransactionSignature(channelCreditTransferDetailsReq);

        // Perform synchronous duplicate check to prevent immediate duplicates
        checkTransactionExists(rrn, TransactionType.valueOf(type));

        // Delegate credit transfer request to jPOS TransactionManager for async processing via TM participants.
        transactionDispatcherService.dispatch(channelCreditTransferDetailsReq);

        // Return PENDING response to channel immediately as processing is asynchronous
        return payloadChannelResponseComposerService.composePendingResponse(rrn, Map.of("ipsStatus", "ACCP"));
    }

    @Override
    public ChannelResponse processStatusCheckRequest(ChannelStatusCheckDetailsReq statusCheckDetailsReq, BindingResult bindingResult, String type) throws CustomException {
        String rrn = "";
        String originalRrn = statusCheckDetailsReq.getOriginalTxnInfo().getOriginalRrn();

        boolean isInternalTrigger = INTERNAL_STATUS_CHECK_TYPE.equalsIgnoreCase(type);
        try {
            // Get the rrn
            rrn = statusCheckDetailsReq.getOriginalTxnInfo().getOriginalRrn();

            // By-pass field and signature validations for internal status checks
            if (!isInternalTrigger) {
                checkForInputValidationErrors(bindingResult);
                signatureValidationService.validateStatusCheckSignature(statusCheckDetailsReq);
            }

            // Get the existing db record
            TransactionMaster existingRecord = databaseService.getSavedRecord(rrn, TransactionType.CREDIT_TRANSFER);
            TransactionStatus existingStatus = existingRecord.getStatus();
            log.info("{}: Existing Record Status: {}", rrn, existingStatus);

            // Only send a status check request to papss if status is PENDING or TIMEOUT
            Set<TransactionStatus> inProgressStatuses = Set.of(PENDING, TIMEOUT);
            if (inProgressStatuses.contains(existingStatus)) {
                log.info("{}: Existing Record Status is: {}. Initiating PACS.028 status check", rrn, existingRecord.getStatus());

                // Compose and sign ISO20022 pacs028 request
                String pacs028StatusCheckRequestXml = ISOPayloadXmlComposerService.composePacs028StatusCheckRequest(statusCheckDetailsReq, existingRecord);
                String signedPacs028XmlReq = ISOSignatureGenerationService.generateXMLDigitalSignature(rrn, pacs028StatusCheckRequestXml, String.valueOf(type));

                // Send the signed request to papss
                String httpResponseString = httpAdapterService.sendHttpStatusCheckRequest(rrn, signedPacs028XmlReq, String.valueOf(type));

                // Composed channel response from the returned response string
                ChannelResponse channelResponse = httpResponseProcessorService.processStatusCheckResponse(rrn, originalRrn, httpResponseString, String.valueOf(type));

                // Update db with the final status
                updateDbStatus(rrn, channelResponse, existingRecord);

                // Perform finacle reversal if papss returned failure and finacle debit had occurred
                finacleReversalService.performConditionalStatusCheckReversal(rrn, existingRecord, channelResponse);

                // Return the latest final status
                return channelResponse;
            }
            // Return the latest known status from the database
            log.info("{}: Existing Record Status is: {}. Returning the existing status to channel", rrn, existingRecord.getStatus());
            return payloadChannelResponseComposerService.composeStatusCheckDbResponse(originalRrn, existingRecord);
        } catch (Exception e) {
            log.error("{}: Exception occurred during status check processing: {}", rrn, e.getMessage());
            throw new CustomException(DEFAULT_ERROR + e.getMessage());
        }
    }

    @Override
    public void processCallbackResponse(String rrn, String creditTransferCallbackXml, TransactionType type) {
//        try {
//            Map<String, String> resultMap = xmlResponseReaderService.processXmlResponse(new Context(), rrn, "", creditTransferCallbackXml, String.valueOf(type));
//            log.info("{}: Callback Response Map: {}", rrn, resultMap);
//
//            // TODO: Handle Finacle reversals if not success status (requires new dedicated reversal logic)
//            // TODO: Update database also with finacle reversal status
//
//            ChannelResponse channelResponse = payloadChannelResponseComposerService.composeTransactionResponse(rrn, resultMap, String.valueOf(type));
//
//            TransactionMaster existingRecord = databaseService.getSavedRecord(rrn, TransactionType.CREDIT_TRANSFER);
//            String channelCallbackUrl = existingRecord.getChannelInfo().getCallbackUrl();
//
//            // Update DB with final status based on callback response
//            updateDbFinalStatus(rrn, channelResponse, type);
//
//            // Send callback response to originating channel
//            httpAdapterService.sendHttpChannelCallbackResponse(rrn, channelCallbackUrl, channelResponse);
//
//        } catch (Exception e) {
//            log.error("{}: Exception Occurred When Processing Callback Asynchronously for RRN: {}. Error: {}", rrn, rrn, e.getMessage());
//        }
    }

    @Transactional
    private void updateDbStatus(String rrn, ChannelResponse channelResponse, TransactionMaster existingRecord) {
        try {
            TransactionMaster entity = entityMapperService.composeDbStatusDetailsEntity(rrn, channelResponse, existingRecord);

            log.info("{}: Updating Database Status For Record With RRN: {}", rrn, rrn);
            databaseService.updateDbRecord(entity);
        } catch (Exception e) {
            log.error("{}: Failed to update database record asynchronously for RRN: {}. Error: {}", rrn, rrn, e.getMessage());
        }
    }

    @Transactional
    private void updateDbFinalStatus(String rrn, ChannelResponse channelResponse, TransactionType type) throws CustomException {
        try {
            TransactionMaster existingRecord = databaseService.getSavedRecord(rrn, TransactionType.CREDIT_TRANSFER);
            TransactionMaster entity = entityMapperService.composeDbFinalStatusDetailsEntity(rrn, channelResponse, existingRecord);

            log.info("{}: Updating Database With Final Transaction Status For Record With RRN: {}", rrn, rrn);
            databaseService.updateDbRecord(entity);
        } catch (Exception e) {
            log.error("{}: Failed to update database with final status for RRN: {}. Error: {}", rrn, rrn, e.getMessage());
            throw new CustomException(DEFAULT_ERROR + "Failed to update final status: " + e.getMessage());
        }
    }

    @Transactional(readOnly = true)
    private void checkTransactionExists(String rrn, TransactionType type) throws CustomException {
        log.info("{}: Checking transaction by RRN: {} and type: {}", rrn, rrn, type);
        databaseService.checkTransactionExists(rrn, type);
    }

    private void checkForInputValidationErrors(BindingResult bindingResult) throws CustomException {
        if (bindingResult.hasErrors()) {
            List<ObjectError> allErrors = bindingResult.getAllErrors();
            throw new CustomException(FIELD_VALIDATION_ERROR + allErrors.get(0).getDefaultMessage());
        }
    }

    private void validateSenderInstId(Object request, String type) throws CustomException {
        String bankId;
        String senderInstId;

        if (TransactionType.NAMECHECK.name().equalsIgnoreCase(type)) {
            ChannelNamecheckDetailsReq namecheckReq = (ChannelNamecheckDetailsReq) request;
            bankId = namecheckReq.getChannelInfo().getBankId();
            senderInstId = namecheckReq.getSender().getInstitutionId();
        } else if (TransactionType.CREDIT_TRANSFER.name().equalsIgnoreCase(type)) {
            ChannelCreditTransferDetailsReq creditReq = (ChannelCreditTransferDetailsReq) request;
            bankId = creditReq.getChannelInfo().getBankId();
            senderInstId = creditReq.getSender().getInstitutionId();
        } else {
            throw new CustomException(DEFAULT_ERROR + "Unsupported transaction type: " + type);
        }

        if ("54".equals(bankId) && !papssId.equalsIgnoreCase(senderInstId)) {
            throw new CustomException(FIELD_VALIDATION_ERROR + "Invalid sender institution id for bank id: " + bankId);
        }
    }

    private void validateCurrenciesForFxApi(GetFxRateReq getFxRateReq) throws CustomException {
        String senderCurrency = getFxRateReq.getSender().getCurrency().toUpperCase();
        String receiverCurrency = getFxRateReq.getReceiver().getCurrency().toUpperCase();

        // Ensure that if sender is USD, receiver must also be USD
        if ("USD".equals(senderCurrency) && !"USD".equals(receiverCurrency)) {
            throw new CustomException(FIELD_VALIDATION_ERROR + "Invalid currency combination: When sender currency is USD, receiver currency must also be USD.");
        }

        // Ensure that if receiver is USD, sender must also be USD
        if ("USD".equals(receiverCurrency) && !"USD".equals(senderCurrency)) {
            throw new CustomException(FIELD_VALIDATION_ERROR + "Invalid currency combination: When receiver currency is USD, sender currency must also be USD.");
        }
    }


    private void checkForValidCurrencies(ChannelCreditTransferDetailsReq channelCreditTransferDetailsReq) throws CustomException {
        String transactionCurrency = channelCreditTransferDetailsReq.getTransactionInfo().getTransactionCurrency();
        String senderCurrency = channelCreditTransferDetailsReq.getSender().getCurrency();
        String receiverCurrency = channelCreditTransferDetailsReq.getReceiver().getCurrency();

        // Sender currency should be the same as transaction currency
        if (!senderCurrency.equalsIgnoreCase(transactionCurrency)) {
            throw new CustomException(FIELD_VALIDATION_ERROR + "Sender currency should be the same as transaction currency");
        }

        // Allow only KES or USD
        if (!"KES".equals(transactionCurrency) && !"USD".equals(transactionCurrency)) {
            throw new CustomException(FIELD_VALIDATION_ERROR + "Only KES or USD currencies allowed");
        }

        // If sender = USD : receiver must be USD
        if ("USD".equals(senderCurrency) && !"USD".equals(receiverCurrency)) {
            throw new CustomException(FIELD_VALIDATION_ERROR + "Invalid currency combination: Sender is USD so receiver must also be USD.");
        }

        // If sender = KES : receiver must NOT be USD
        if ("KES".equals(senderCurrency) && "USD".equals(receiverCurrency)) {
            throw new CustomException(FIELD_VALIDATION_ERROR + "Invalid currency combination: Sender is KES so receiver cannot be USD.");
        }

        // If receiver = USD : sender must be USD
        if ("USD".equals(receiverCurrency) && !"USD".equals(senderCurrency)) {
            throw new CustomException(FIELD_VALIDATION_ERROR + "Invalid currency combination: Receiver is USD so sender must also be USD.");
        }

        // If receiver ≠ USD : sender must be KES
        if (!"USD".equals(receiverCurrency) && !"KES".equals(senderCurrency)) {
            throw new CustomException(FIELD_VALIDATION_ERROR + "Invalid currency combination: Receiver is not USD so sender must be KES.");
        }
    }

}