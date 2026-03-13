package com.equitybank.gag.papss.ots.jpos.jposService.impl;

import com.equitybank.gag.papss.ots.jpos.space.configs.AppQBean;
import com.equitybank.gag.papss.ots.jpos.jposService.SendToFinacleService;
import com.equitybank.gag.papss.ots.enums.TransactionType;
import com.equitybank.gag.papss.ots.exception.CustomException;
import org.jpos.iso.ISOException;
import org.jpos.iso.ISOMsg;
import org.jpos.iso.MUX;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import static com.equitybank.gag.papss.ots.config.ApplicationConstants.*;

@Service
public class SendToFinacleServiceImpl implements SendToFinacleService {
    private static final Logger log = LoggerFactory.getLogger(SendToFinacleServiceImpl.class);

    private final long socketTimeout;

    public SendToFinacleServiceImpl(@Value("${finacle.iso.timeout.socketTimeout}") long socketTimeout) {
        this.socketTimeout = socketTimeout;
    }

    @Override
    public ISOMsg sendTransaction(String rrn, ISOMsg isoMsg, String bankId, TransactionType type, String leg) throws CustomException {
        return sendViaMux(rrn, isoMsg, bankId, type, leg);
    }

    @Override
    public ISOMsg sendStatusCheck(String rrn, ISOMsg isoMsg, String bankId, TransactionType type) throws CustomException {
        return sendViaMux(rrn, isoMsg, bankId, type, "statusCheckLeg");
    }

    @Override
    public ISOMsg sendAccountInquiry(String rrn, ISOMsg isoMsg, String bankId, TransactionType type) throws CustomException {
        return sendViaMux(rrn, isoMsg, bankId, type, "inquiryLeg");
    }

    @Override
    public ISOMsg sendReversalRequest(String rrn, ISOMsg isoMsg, String bankId, TransactionType type, String leg) throws CustomException {
        return sendViaMux(rrn, isoMsg, bankId, type, leg);
    }

    // Unified method to send ISO 8583 message via appropriate MUX
    private ISOMsg sendViaMux(String rrn, ISOMsg isoMsg, String bankId, TransactionType type, String leg) throws CustomException {
        if (isoMsg == null) {
            throw new CustomException(DEFAULT_ERROR + "ISO message is null.");
        }

        MUX mux = resolveMux(bankId);

        try {
//            ISOMessageLogger.logRequest(isoMsg, bankId, 0, null);
            log.info("{}: Sending {} Request ISO Message to Finacle", rrn, leg);
            ISOMsg response = mux.request(isoMsg, socketTimeout);

            if (response == null) {
                handleTimeout(rrn, type, leg);
            }

//            ISOMessageLogger.logResponse(response, bankId, 0, null, 0L);
            return response;

        } catch (ISOException e) {
            handleISOException(e, rrn, type);
            throw new CustomException(ISO_DEFAULT_ERROR + e.getMessage());
        }
    }

    // Resolve the correct MUX based on bank ID
    private MUX resolveMux(String bankId) throws CustomException {
        MUX mux;
        String muxName;

        switch (bankId) {
            case "54", "KE" -> {
                mux = AppQBean.keMux;
                muxName = "ke-mux";
            }
            case "43", "CD" -> {
                mux = AppQBean.drcMux;
                muxName = "drc-mux";
            }
            case "11", "SS" -> {
                mux = AppQBean.suMux;
                muxName = "su-mux";
            }
            default -> throw new CustomException(DEFAULT_ERROR + "Unsupported bank ID: " + bankId);
        }

        if (mux == null || !mux.isConnected()) {
            throw new CustomException(ISO_DEFAULT_ERROR + muxName + " is not connected.");
        }

        log.info("{} MUX resolved and connected for bankId {}", muxName, bankId);
        return mux;
    }

    // Handles timeout case for any ISO leg
    private void handleTimeout(String rrn, TransactionType type, String leg) throws CustomException {
        String messageDesc = switch (leg) {
            case "transactionLeg" -> "Did not receive response from Finacle. Possible timeout occurred.";
            case "reversalLeg" -> "Timeout occurred during reversal leg.";
            case "statusCheckLeg" -> "Status check timed out with no response.";
            case "inquiryLeg" -> "Account inquiry to Finacle timed out.";
            default -> "Finacle timeout occurred.";
        };

        log.error("{}: {}", rrn, messageDesc);
        updateDbWithFinacleStatus(rrn, type, messageDesc);
        throw new CustomException(FINACLE_TIMEOUT_ERROR + messageDesc);
    }

    // Handles ISO-related exceptions during communication
    private void handleISOException(ISOException e, String rrn, TransactionType type) {
        String messageDesc = "ISOException while sending ISO request: " + e.getMessage();
        log.error("{}: {}", rrn, messageDesc, e);
        updateDbWithFinacleStatus(rrn, type, messageDesc);
    }

    // Placeholder to update DB after ISO failure/timeout
    private void updateDbWithFinacleStatus(String rrn, TransactionType type, String messageDesc) {
        // Example:
        // CbsStatus status = CbsStatus.TIMEOUT;
        // TransactionDetails entity = customMapperService.composeFinacleStatusEntity(rrn, type, status, messageDesc, "999");
        // databaseService.updateTransactionRecord(entity);
    }
}
