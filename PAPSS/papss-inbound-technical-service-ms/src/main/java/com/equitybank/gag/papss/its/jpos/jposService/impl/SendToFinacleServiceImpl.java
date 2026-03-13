package com.equitybank.gag.papss.its.jpos.jposService.impl;

import com.equitybank.gag.papss.its.enums.TransactionType;
import com.equitybank.gag.papss.its.exception.CustomException;
import com.equitybank.gag.papss.its.jpos.jposService.SendToFinacleService;
import com.equitybank.gag.papss.its.jpos.space.configs.AppQBean;
import org.jpos.iso.ISOException;
import org.jpos.iso.ISOMsg;
import org.jpos.iso.MUX;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import static com.equitybank.gag.papss.its.config.StatusCodeMessages.*;


@Service
public class SendToFinacleServiceImpl implements SendToFinacleService {
    private static final Logger log = LoggerFactory.getLogger(SendToFinacleServiceImpl.class);

    private final long socketTimeout;

    public SendToFinacleServiceImpl(@Value("${finacle.iso.timeout.socketTimeout}") long socketTimeout) {
        this.socketTimeout = socketTimeout;
    }

    @Override
    public ISOMsg sendTransaction(String rrn, ISOMsg isoMsg, String bankId, TransactionType type) throws CustomException {
        return sendViaMux(rrn, isoMsg, bankId, type, "transactionLeg");
    }

    @Override
    public ISOMsg sendStatusCheck(String rrn, ISOMsg isoMsg, String bankId, TransactionType type) throws CustomException {
        return sendViaMux(rrn, isoMsg, bankId, type, "statusCheckLeg");
    }

    @Override
    public ISOMsg sendAccountEnquiry(String rrn, ISOMsg isoMsg, String bankId, TransactionType type) throws CustomException {
        return sendViaMux(rrn, isoMsg, bankId, type, "enquiryLeg");
    }

    @Override
    public ISOMsg sendReversalRequest(String rrn, ISOMsg isoMsg, String bankId, TransactionType type) throws CustomException {
        return sendViaMux(rrn, isoMsg, bankId, type, "reversalLeg");
    }

    // Unified method to send ISO 8583 message via appropriate MUX
    private ISOMsg sendViaMux(String rrn, ISOMsg isoMsg, String bankId, TransactionType type, String leg) throws CustomException {
        if (isoMsg == null) {
            throw new CustomException(DEFAULT_ERROR + "ISO message is null.");
        }

        MUX mux = resolveMux(bankId);
        try {
            ISOMsg response = mux.request(isoMsg, socketTimeout);
            if (response == null) {
                handleTimeout(rrn, type, leg);
            }
            return response;

        } catch (ISOException e) {
            handleISOException(e, rrn, type);
            throw new CustomException(ISO_DEFAULT_ERROR + e.getMessage());
        } catch (Exception e) {
            // Handle timeouts
            String messageDesc = e.getMessage();
            if (messageDesc != null && (messageDesc.contains("timeout")
                    || messageDesc.contains("time out")
                    || messageDesc.contains("timed out"))) {

                log.error("{}: {}", rrn, messageDesc);
                throw new CustomException(FINACLE_TIMEOUT_ERROR);
            }
            throw new CustomException(DEFAULT_ERROR + e.getMessage());
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
            case "enquiryLeg" -> "Account enquiry to Finacle timed out.";
            default -> "Finacle timeout occurred.";
        };

        log.error("{}: {}", rrn, messageDesc);
        throw new CustomException(FINACLE_TIMEOUT_ERROR);
    }

    // Handles ISO-related exceptions during communication
    private void handleISOException(ISOException e, String rrn, TransactionType type) {
        String messageDesc = "ISOException while sending ISO request: " + e.getMessage();
        log.error("{}: {}", rrn, messageDesc, e);
    }
}
