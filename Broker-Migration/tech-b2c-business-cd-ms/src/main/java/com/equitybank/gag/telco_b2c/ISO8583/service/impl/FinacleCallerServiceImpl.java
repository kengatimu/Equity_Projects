package com.equitybank.gag.telco_b2c.ISO8583.service.impl;

import com.equitybank.gag.telco_b2c.ISO8583.configs.AppQBean;
import com.equitybank.gag.telco_b2c.ISO8583.service.FinacleCallerService;
import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.enums.CbsStatus;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.mapper.CustomMapperService;
import com.equitybank.gag.telco_b2c.service.DatabaseService;
import org.jpos.iso.ISOException;
import org.jpos.iso.ISOMsg;
import org.jpos.iso.MUX;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.task.TaskExecutor;
import org.springframework.stereotype.Service;

import static com.equitybank.gag.telco_b2c.ISO8583.configs.Constants.*;
import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.*;

@Service
public class FinacleCallerServiceImpl implements FinacleCallerService {
    private static final Logger log = LoggerFactory.getLogger(FinacleCallerServiceImpl.class);

    private final CustomMapperService customMapperService;
    private final DatabaseService databaseService;

    @Autowired
    public FinacleCallerServiceImpl(CustomMapperService customMapperService,
                                    DatabaseService databaseService) {
        this.customMapperService = customMapperService;
        this.databaseService = databaseService;
    }

    @Override
    public ISOMsg sendFinacleISORequest(ISOMsg finacleIsoRequest, String bankId, String rrn, String type, String leg) throws CustomException {
        // Validate required input parameters
        validateISORequest(finacleIsoRequest, bankId, rrn);

        // Resolve MUX for the bank and check if connected
        MUX mux = resolveMux(bankId, rrn);

        try {
            // Send ISO request to Finacle via the resolved MUX
            ISOMsg response = mux.request(finacleIsoRequest, FINACLE_TRANSACTION_REQUEST_TIMEOUT);

            // If no response received, treat as timeout
            if (response == null) {
                handleTimeout(rrn, type, leg, finacleIsoRequest);
            }

            // Log and return the valid response
            log.info("{}: Received response from Finacle: \n{}", rrn, response);
            return response;

        } catch (ISOException e) {
            // Log and handle ISO-level error
            handleISOException(e, rrn, type, finacleIsoRequest);
            throw new CustomException(String.format("%sFailed to send ISO request to Finacle. %s", DEFAULT_PROCESSING_FAILURE, e.getMessage()));
        }
    }

    @Override
    public ISOMsg sendFinacleInquireISORequest(ISOMsg statusReq, String bankId, String rrn) throws CustomException {
        // Ensure the inquiry request is not null
        if (statusReq == null) {
            log.error("{}: Status request message is null.", rrn);
            throw new CustomException(String.format("%sFinacle get status ISO request message cannot be null.", DEFAULT_PROCESSING_FAILURE));
        }

        // Resolve the correct MUX based on bank ID
        MUX mux = resolveMux(bankId, rrn);

        try {
            // Send the inquiry request and return the response
            ISOMsg response = mux.request(statusReq, FINACLE_STATUS_CHECK_INQUIRE_TIMEOUT);
            log.info("{}: Received inquiry response from Finacle: \n{}", rrn, response);
            return response;

        } catch (ISOException e) {
            // Handle ISO errors during inquiry
            log.error("{}: ISOException occurred while sending Finacle inquiry ISO request: {}", rrn, e.getMessage());
            throw new CustomException(String.format("%sFailed to send inquiry ISO request to Finacle. %s", DEFAULT_PROCESSING_FAILURE, e.getMessage()));
        }
    }

    // Resolves the correct MUX instance based on bank ID
    private MUX resolveMux(String bankId, String rrn) throws CustomException {
        MUX mux = null;
        String muxName = null;

        // Map bankId or country code to the correct MUX
        if ("43".equalsIgnoreCase(bankId) || "CD".equalsIgnoreCase(bankId)) {
            mux = AppQBean.drcMux;
            muxName = "drc-mux";
        } else if ("54".equalsIgnoreCase(bankId) || "KE".equalsIgnoreCase(bankId)) {
            mux = AppQBean.keMux;
            muxName = "ke-mux";
        } else if ("11".equalsIgnoreCase(bankId) || "SS".equalsIgnoreCase(bankId)) {
            mux = AppQBean.suMux;
            muxName = "su-mux";
        }

        // Fail if MUX is not resolved or disconnected
        if (mux == null || !mux.isConnected()) {
            log.warn("{}: MUX is not connected or unsupported bank ID '{}'.", rrn, bankId);
            throw new CustomException(String.format("%sMUX is not connected or Invalid bank ID.", DEFAULT_PROCESSING_FAILURE));
        }
        log.info("{}: {} Selected For BankId: {}", rrn, muxName, bankId);
        return mux;
    }

    // Validates basic input arguments
    private void validateISORequest(ISOMsg finacleIsoRequest, String bankId, String rrn) throws CustomException {
        if (finacleIsoRequest == null) {
            log.error("{}: Finacle ISO request is null.", rrn);
            throw new CustomException(String.format("%sFinacle ISO request cannot be null.", DEFAULT_PROCESSING_FAILURE));
        }
        if (bankId == null) {
            log.error("{}: Bank ID cannot be null.", rrn);
            throw new CustomException(String.format("%sInvalid BankId.", DEFAULT_PROCESSING_FAILURE));
        }
    }

    // Handles timeout logic and database update
    private void handleTimeout(String rrn, String type, String leg, ISOMsg request) throws CustomException {
        String messageDesc = switch (leg) {
            case "transactionLeg" -> "Did not receive response from Finacle. Possible timeout occurred.";
            case "reversalLeg" -> "Timeout occurred during reversal leg.";
            default -> "Finacle timeout occurred.";
        };

        log.error("{}: {}", rrn, messageDesc);
        updateDbWithFinacleStatus(rrn, type, messageDesc);
        throw new CustomException(String.format("%s%s", ISO8583_FINACLE_TIMEOUT, messageDesc));
    }

    // Handles exceptions during ISO communication
    private void handleISOException(ISOException e, String rrn, String type, ISOMsg request) {
        String messageDesc = "ISOException while sending ISO request: " + e.getMessage();
        log.error("{}: {}", rrn, messageDesc, e);
        updateDbWithFinacleStatus(rrn, type, messageDesc);
    }

    // Updates transaction record with Finacle response status
    private void updateDbWithFinacleStatus(String rrn, String type, String messageDesc) {
        CbsStatus status = CbsStatus.TIMEOUT;
        String responseCode = "999";
        TransactionDetails entity = customMapperService.composeFinacleStatusEntity(rrn, type, status, messageDesc, responseCode);
        updateDatabase(entity, rrn, status);
    }

    // Saves transaction details to DB using async task executor
    private void updateDatabase(TransactionDetails entity, String rrn, CbsStatus status) {
        if (entity != null) {
            log.info("{}: Saving Finacle {} status in database", rrn, status);
            databaseService.updateTransactionRecord(entity);
        } else {
            log.warn("{}: Could not save Finacle {} status. Entity is null", rrn, status);
        }
    }

//    // Saves transaction details to DB using async task executor
//    private void updateDatabase(TransactionDetails entity, String rrn, CbsStatus status) {
//        taskExecutor.execute(() -> {
//            if (entity != null) {
//                log.info("{}: Saving Finacle {} status in database", rrn, status);
//                databaseService.updateTransactionRecord(entity);
//            } else {
//                log.warn("{}: Could not save Finacle {} status. Entity is null", rrn, status);
//            }
//        });
//    }
}
