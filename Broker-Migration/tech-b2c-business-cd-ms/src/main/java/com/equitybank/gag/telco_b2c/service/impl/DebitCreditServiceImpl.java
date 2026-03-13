package com.equitybank.gag.telco_b2c.service.impl;

import com.equitybank.gag.telco_b2c.ISO8583.service.FinacleCallerService;
import com.equitybank.gag.telco_b2c.ISO8583.service.ISOMessageCreatorService;
import com.equitybank.gag.telco_b2c.ISO8583.service.ISOMsgSerializerAndDeserializerService;
import com.equitybank.gag.telco_b2c.dto.airtime.request.Envelope;
import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.enums.CbsStatus;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.mapper.CustomMapperService;
import com.equitybank.gag.telco_b2c.service.DatabaseService;
import com.equitybank.gag.telco_b2c.service.DebitCreditService;
import org.jpos.iso.ISOException;
import org.jpos.iso.ISOMsg;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.task.TaskExecutor;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.util.Optional;
import java.util.Set;

import static com.equitybank.gag.telco_b2c.ISO8583.configs.Constants.*;
import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.ISO8583_FINACLE_TIMEOUT;

import java.util.Arrays;
import java.util.HashSet;

@Service
public class DebitCreditServiceImpl implements DebitCreditService {
    private static final Logger log = LoggerFactory.getLogger(DebitCreditServiceImpl.class);

    // Environment configs
    private final boolean isAirtimeTopUpDebitCreditEnabled;
    private final boolean isTransactionDebitCreditEnabled;
    private final boolean isImtDebitCreditEnabled;
    private final boolean isFloatDebitCreditEnabled;
    private final Set<String> floatDrCrEnabledCountries = new HashSet<>();

    // Other configs
    private final TaskExecutor taskExecutor;
    private final Map<String, String> finErrorDescMap;
    private final ISOMsgSerializerAndDeserializerService isoMsgSerializerAndDeserializerService;
    private final ISOMessageCreatorService isoMessageCreatorService;
    private final FinacleCallerService finacleCallerService;
    private final CustomMapperService customMapperService;
    private final DatabaseService databaseService;

    @Autowired
    public DebitCreditServiceImpl(@Value("${finacle.debit-credit.enabled.airtime-topup}") boolean isAirtimeTopUpDebitCreditEnabled,
                                  @Value("${finacle.debit-credit.enabled.b2c-transaction}") boolean isTransactionDebitCreditEnabled,
                                  @Value("${finacle.debit-credit.enabled.imt}") boolean isImtDebitCreditEnabled,
                                  @Value("${finacle.debit-credit.enabled.float}") boolean isFloatDebitCreditEnabled,
                                  @Value("${finacle.debit-credit.countries.float}") String floatDrCrEnabledCountriesStr,
                                  @Qualifier("taskExecutor") TaskExecutor taskExecutor,
                                  @Qualifier("finacleErrorMapping") Map<String, String> finErrorDescMap,
                                  ISOMsgSerializerAndDeserializerService isoMsgSerializerAndDeserializerService,
                                  ISOMessageCreatorService isoMessageCreatorService,
                                  FinacleCallerService finacleCallerService,
                                  CustomMapperService customMapperService,
                                  DatabaseService databaseService) {
        this.isAirtimeTopUpDebitCreditEnabled = isAirtimeTopUpDebitCreditEnabled;
        this.isTransactionDebitCreditEnabled = isTransactionDebitCreditEnabled;
        this.isImtDebitCreditEnabled = isImtDebitCreditEnabled;
        this.isFloatDebitCreditEnabled = isFloatDebitCreditEnabled;
        this.taskExecutor = taskExecutor;
        this.finErrorDescMap = finErrorDescMap;
        this.isoMsgSerializerAndDeserializerService = isoMsgSerializerAndDeserializerService;
        this.isoMessageCreatorService = isoMessageCreatorService;
        this.finacleCallerService = finacleCallerService;
        this.customMapperService = customMapperService;
        this.databaseService = databaseService;
        this.floatDrCrEnabledCountries.addAll(Arrays.asList(floatDrCrEnabledCountriesStr.split(",")));
    }

    @Override
    public boolean isDrCrEnabledForCountry(String type, String countryCode) {
        if (type.equalsIgnoreCase("floatPurchase")) {
            return floatDrCrEnabledCountries.contains(countryCode);
        }
        return true;
    }

    @Override
    public boolean checkDebitCreditEnable(String type) {
        return switch (type) {
            case "moneygram-commit-transaction", "moneygram-receive-commit-transaction" -> isImtDebitCreditEnabled;
            case "floatPurchase" -> isFloatDebitCreditEnabled;
            case "airtime" -> isAirtimeTopUpDebitCreditEnabled;
            case "transaction" -> isTransactionDebitCreditEnabled;
            default -> false;
        };
    }

    @Override
    public void doDebitCredit(TransactionDetails transactionDetails, String bankId, request request, Envelope airtimeRequest, Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException {
        try {
            // Create Finacle ISO request
            ISOMsg isoTransactionRequest = isoMessageCreatorService.createMainTransactionIsoMsg(transactionDetails, request, airtimeRequest, xmlTagsMap, type);

            // Update the database with the ISO request
            updateDbWithIsoMessage(isoTransactionRequest, new ISOMsg(), rrn, type, "requestMessage");

            // Call Finacle for debit/credit operation
            ISOMsg isoTransactionResponse = finacleCallerService.sendFinacleISORequest(isoTransactionRequest, bankId, rrn, type, "transactionLeg");

            // Update the database with the ISO response
            updateDbWithIsoMessage(new ISOMsg(), isoTransactionResponse, rrn, type, "responseMessage");

            // Process received response
            processResponse(isoTransactionResponse, rrn, type);

        } catch (CustomException e) {
            log.error("{}: CustomException occurred during debit/credit operation: {}", rrn, e.getMessage());
            throw new CustomException(e.getMessage());
        } catch (Exception e) {
            log.error("{}: Unexpected exception occurred: {}", rrn, e.getMessage());
            throw new CustomException("Unexpected error during debit/credit operation");
        }
    }

    private void updateDbWithIsoMessage(ISOMsg isoTransactionRequest, ISOMsg isoTransactionResponse, String rrn, String type, String messageType) {
        TransactionDetails entity = null;
        if ("requestMessage".equalsIgnoreCase(messageType) && isoTransactionRequest != null) {
            entity = customMapperService.composeIsoRequestMessageEntity(isoTransactionRequest, rrn, type);
        } else if ("responseMessage".equalsIgnoreCase(messageType) && isoTransactionResponse != null) {
            entity = customMapperService.composeIsoResponseMessageEntity(isoTransactionResponse, rrn, type);
        }
        updateDatabase(entity, rrn, CbsStatus.valueOf(messageType), type);
    }

    private void processResponse(ISOMsg isoMessage, String rrn, String type) throws CustomException {
        String finacleResponseCode = isoMessage.getString(39);
        log.info("{}: Finacle Response Code: {}", rrn, finacleResponseCode);

        CbsStatus status;
        if ("000".equals(finacleResponseCode)) {
            // Successful transaction
            String cbsTranId = isoMessage.getString(37);
            TransactionDetails entity = customMapperService.composeFinacleSuccessEntity(rrn, type, cbsTranId);

            // Update the database with the composed entity
            updateDatabase(entity, rrn, CbsStatus.COMPLETED, type);
            return; // Exit after successful processing
        }

        // Get error description from map or default to a generic timeout message
        String errorDesc = finErrorDescMap.getOrDefault(finacleResponseCode, finErrorDescMap.get("999"));

        // Read error desc from field 127 if response code is 119
        if ("119".equals(finacleResponseCode) && isoMessage.hasField(127)) {
            String field127Value = isoMessage.getString(127);
            if (!field127Value.isBlank()) {
                errorDesc = field127Value;
            }
        }

        // Determine status based on response code
        status = determineStatus(finacleResponseCode);

        // compose entity for the finacle error
        TransactionDetails entity = customMapperService.composeFinacleStatusEntity(rrn, type, status, errorDesc, finacleResponseCode);

        // Update the database with the composed entity and status
        updateDatabase(entity, rrn, status, type);

        // Throw exception with detailed error message
        throw new CustomException(status == CbsStatus.TIMEOUT
                ? ISO8583_FINACLE_TIMEOUT + errorDesc
                : finacleResponseCode + "|" + errorDesc);
    }

    private CbsStatus determineStatus(String responseCode) {
        Set<String> timeoutCodesSet = Set.of("907", "909", "911", "999");

        if (timeoutCodesSet.contains(responseCode)) {
            return CbsStatus.TIMEOUT;
        } else if (finErrorDescMap.containsKey(responseCode)) {
            return CbsStatus.ERROR;
        } else {
            return CbsStatus.TIMEOUT; // Default to TIMEOUT if unknown response code
        }
    }

    @Override
    public void doReversal(String rrn, String type, String bankId) {
        log.info("Reversal Initiated For Transaction With RRN: {}", rrn);
        try {
            // Get the saved original Iso request from the database
            ISOMsg originalIsoRequest = getOriginalIsoRequestMessage(rrn, type);

            // Create reversal iso message
            ISOMsg reversalIsoMessage = createReversalMessage(originalIsoRequest, rrn);

            // Do reversal
            ISOMsg reversalResponse = finacleCallerService.sendFinacleISORequest(reversalIsoMessage, bankId, rrn, type, "reversalLeg");

            // Process the response
            processReversalResponse(reversalResponse, rrn, type);

        } catch (CustomException e) {
            String reversalStatusMsg = String.format("Error occurred during reversal process: %s", e.getMessage());
            log.error("{}: Error occurred during reversal process: {} ", rrn, e.getMessage());

            // Update database with Reversal failure status
            updateDatabaseWithReversalFailureStatus(rrn, type, reversalStatusMsg);
        }

    }

    private ISOMsg createReversalMessage(ISOMsg originalIsoRequest, String rrn) throws CustomException {
        try {
            // Clone the original ISOMsg
            ISOMsg isoMsg = (ISOMsg) originalIsoRequest.clone();

            // Construct the field 56 value for reversal
            String f56 = isoMsg.getMTI()
                    + PADDING
                    + isoMsg.getValue(11)
                    + isoMsg.getValue(12)
                    + REVERSAL_INDICATOR
                    + isoMsg.getValue(32);

            // Update charges field (field 46) by replacing D with C
            String charges = isoMsg.getString(46);
            if (charges != null) {
                // Check if Field 49 contains USD or CDF.
                // If it does, temporarily substitutes it with "TEMP" to avoid modifying it during the replacement of D to C.
                String currencyCode = isoMsg.getString(49);
                if ("USD".equals(currencyCode) || "CDF".equals(currencyCode)) {
                    charges = charges.replace(currencyCode, "TEMP"); // Temporarily use 'TEMP'
                    charges = charges.replace("D", "C");      // Replace 'D' with 'C'
                    charges = charges.replace("TEMP", currencyCode); // Restore currency code
                } else {
                    charges = charges.replace("D", "C");      // Replace 'D' with 'C'
                }
                isoMsg.set(46, charges);
            }

            // Set reversal iso message fields
            isoMsg.setMTI(REVERSAL_DEFAULT_MESSAGE_TYPE_INDICATOR_MTI);
            isoMsg.set(24, REVERSAL_TRANSACTION_TYPE_CODE);
            isoMsg.set(56, f56);
            return isoMsg;
        } catch (ISOException e) {
            throw new CustomException(e.getMessage());
        }
    }

    private void processReversalResponse(ISOMsg reversalResponse, String rrn, String type) {
        String responseCode = reversalResponse.getString(39);
        log.info("{}: Finacle Reversal Response Code: {}", rrn, responseCode);

        CbsStatus status;
        if ("000".equals(responseCode)) {
            log.info("Reversal Successfully Completed For Transaction With RRN: {}", rrn);

            // Successful reversal
            TransactionDetails entity = customMapperService.composeFinacleReversalSuccessEntity(rrn, type);

            // Update the database with the composed entity
            updateDatabase(entity, rrn, CbsStatus.REVERSAL_COMPLETED, type);
            return; // Exit after successful processing
        }
        log.info("Reversing Transaction With RRN: {} Failed at Finacle. Finacle Response Code: {}", rrn, responseCode);

        // Update db with reversal failed status
        String reversalStatusMsg = String.format("Error occurred during reversal process. Finacle response code: %s", responseCode);
        updateDatabaseWithReversalFailureStatus(rrn, type, reversalStatusMsg);
    }

    private ISOMsg getOriginalIsoRequestMessage(String rrn, String type) throws CustomException {
        Optional<TransactionDetails> optionalTransactionDetails = databaseService.getTransactionRecord(rrn, type);
        if (optionalTransactionDetails.isEmpty()) {
            throw new CustomException(String.format("Transaction record with RRN, %s does not exist", rrn));
        }
        TransactionDetails record = optionalTransactionDetails.get();

        // Get the iso message in binary
        byte[] isoByteMessage = record.getCbsTransactionDetails().getFinIsoRequest();

        // Deserialize the binary to ISOMsg format
        ISOMsg isoRequest = isoMsgSerializerAndDeserializerService.deserializeISOMsg(isoByteMessage);

        // Check if isoRequest is empty
        if (isoRequest.getMaxField() == 0) {
            throw new CustomException(String.format("%s: Deserialized ISOMsg is empty.", rrn));
        }
        return isoRequest;
    }

    private void updateDatabaseWithReversalFailureStatus(String rrn, String type, String reversalStatusMsg) {
        TransactionDetails entity = customMapperService.composeReversalFailureEntity(rrn, type, reversalStatusMsg);
        updateDatabase(entity, rrn, CbsStatus.REVERSAL_FAILURE, type);
    }

    // This will update the database in async (background thread). Therefore, not need for @Transaction annotation
    private void updateDatabase(TransactionDetails entity, String rrn, CbsStatus status, String type) {
        if (entity != null) {
            log.info("{}: Saving Finacle {} status in database", rrn, status);
            databaseService.updateTransactionRecord(entity);
        } else {
            log.warn("{}: Could not save Finacle {} status in database. Entity is null", rrn, status);
        }
    }


//    // This will update the database in async (background thread). Therefore, not need for @Transaction annotation
//    private void updateDatabase(TransactionDetails entity, String rrn, CbsStatus status, String type) {
//        // Both send and receive commit are already in a new thread, so no need to create another thread their db update
//        if (type.equalsIgnoreCase("moneygram-commit-transaction") || type.equalsIgnoreCase("moneygram-receive-commit-transaction")) {
//            if (entity != null) {
//                log.info("{}: Saving Finacle {} status in database", rrn, status);
//                databaseService.updateTransactionRecord(entity);
//            } else {
//                log.warn("{}: Could not save Finacle {} status in database. Entity is null", rrn, status);
//            }
//        } else {
//            // Run in background thread for the others
//            taskExecutor.execute(() -> {
//                if (entity != null) {
//                    log.info("{}: Saving Finacle {} status in database", rrn, status);
//                    databaseService.updateTransactionRecord(entity);
//                } else {
//                    log.warn("{}: Could not save Finacle {} status in database. Entity is null", rrn, status);
//                }
//            });
//        }
//    }

}
