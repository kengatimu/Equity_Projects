package com.equitybank.payments.imt.b2c.drcbroker.service.impl;

import com.equitybank.payments.imt.b2c.drcbroker.domain.AtmCodeDetails;
import com.equitybank.payments.imt.b2c.drcbroker.domain.SendToWalletDetails;
import com.equitybank.payments.imt.b2c.drcbroker.repository.impl.AtmCodeRepositoryImpl;
import com.equitybank.payments.imt.b2c.drcbroker.repository.impl.SendToWalletRepositoryImpl;
import com.equitybank.payments.imt.b2c.drcbroker.service.DataPersistenceService;
import com.equitybank.payments.imt.b2c.drcbroker.service.dto.BrokerServiceAtmCodeDTO;
import com.equitybank.payments.imt.b2c.drcbroker.service.dto.BrokerServiceSendToWalletDTO;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.error.status.ErrorStatus;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.response.AtmCodeAsyncFinalResponse;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.response.FinalResponse;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.response.BusinessServiceResponseModel;
import com.google.gson.Gson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class DataPersistenceServiceImpl implements DataPersistenceService {
    private static final Logger log = LoggerFactory.getLogger(DataPersistenceServiceImpl.class);

    private final SendToWalletRepositoryImpl sendToWalletRepositoryImpl;
    private final AtmCodeRepositoryImpl atmCodeRepositoryImpl;
    private final ErrorCodes errorCodes;
    private final Gson gson;

    @Autowired
    public DataPersistenceServiceImpl(SendToWalletRepositoryImpl sendToWalletRepositoryImpl, AtmCodeRepositoryImpl atmCodeRepositoryImpl, ErrorCodes errorCodes, Gson gson) {
        this.sendToWalletRepositoryImpl = sendToWalletRepositoryImpl;
        this.atmCodeRepositoryImpl = atmCodeRepositoryImpl;
        this.errorCodes = errorCodes;
        this.gson = gson;
    }

    @Override
    public String persistData(Object input, Object res, String type, ErrorStatus errorStatus) {
        String rrn = "";
        try {
            if (type.equalsIgnoreCase("BrokerServiceDetails")) {
                SendToWalletDetails sendToWalletDetails = (SendToWalletDetails) input;
                rrn = sendToWalletDetails.getRrn();
                String beneficiaryAccount = sendToWalletDetails.getReceiverNumber();
                Optional<SendToWalletDetails> optionalInput = sendToWalletRepositoryImpl.findInputByRrn(rrn);
                if (optionalInput.isPresent()) {
                    errorStatus.setStatus("Failed");
                    errorStatus.setStatusCode("900");
                    errorStatus.setStatusDesc(" Record Already Exists.");
                    errorStatus.setStatusMessage(rrn);
                    log.error(beneficiaryAccount + " DUPLICATE TRANSACTION: RRN: " + rrn + " Already Exists In The BrokerServiceSendToWalletDetails Table");
                    return null;
                }
                log.info("Persisting Initial Send To Wallet Input Details In BrokerServiceSendToWalletDetails Table");
                sendToWalletRepositoryImpl.save(sendToWalletDetails);
            } else if (type.equalsIgnoreCase("AtmCodeDetailsInitial")) {
                AtmCodeDetails atmCodeDetails = (AtmCodeDetails) input;
                rrn = atmCodeDetails.getRrn();
                String beneficiaryAccount = atmCodeDetails.getAccountNumber();
                Optional<AtmCodeDetails> optionalInput = atmCodeRepositoryImpl.findInputByRrn(rrn);
                if (optionalInput.isPresent()) {
                    errorStatus.setStatus("Failed");
                    errorStatus.setStatusCode("900");
                    errorStatus.setStatusDesc(" Record Already Exists.");
                    errorStatus.setStatusMessage(rrn);
                    log.error(beneficiaryAccount + " DUPLICATE TRANSACTION: RRN: " + rrn + " Already Exists In The BrokerServiceAtmCodeDetails Table");
                    return null;
                }
                log.info("Persisting Initial Get Atm Code Details In BrokerServiceAtmCodeDetails Table");
                atmCodeRepositoryImpl.save(atmCodeDetails);
            } else if (type.equalsIgnoreCase("SendToWalletFailure")) {
                BusinessServiceResponseModel businessServiceResponseModel = (BusinessServiceResponseModel) res;
                rrn = businessServiceResponseModel.getMsgId();
                Optional<SendToWalletDetails> optionalInput = sendToWalletRepositoryImpl.findInputByRrn(rrn);
                if (optionalInput.isPresent()) {
                    SendToWalletDetails transactionDetails = optionalInput.get();
                    transactionDetails.setStatus(errorStatus.getStatus().toUpperCase());
                    transactionDetails.setStatusCode(errorStatus.getStatusCode());
                    transactionDetails.setInitialStatusCode(errorStatus.getStatusCode());
                    transactionDetails.setTelcoInitialResponse(gson.toJson(res));
                    transactionDetails.setStatusDesc(errorStatus.getStatusDesc());
                    transactionDetails.setStatusMessage(errorCodes.getErrorMsg(errorStatus.getStatusCode()) + errorStatus.getStatusDesc());
                    transactionDetails.setBusinessServiceInitialResponse(String.valueOf(input));

                    log.info("Updating BrokerServiceSendToWalletDetails Table With SendToWalletFailure Status");
                    sendToWalletRepositoryImpl.save(transactionDetails);
                } else
                    log.error("Data Error: RRN: " + rrn + " Does Not Exists In The BrokerServiceSendToWalletDetails Table");
            } else if (type.equalsIgnoreCase("GetAtmCodeFailure")) {
                BusinessServiceResponseModel businessServiceResponseModel = (BusinessServiceResponseModel) res;
                rrn = businessServiceResponseModel.getMsgId();
                Optional<AtmCodeDetails> optionalInput = atmCodeRepositoryImpl.findInputByRrn(rrn);
                if (optionalInput.isPresent()) {
                    AtmCodeDetails transactionDetails = optionalInput.get();
                    transactionDetails.setStatus(errorStatus.getStatus().toUpperCase());
                    transactionDetails.setStatusCode(errorStatus.getStatusCode());
                    transactionDetails.setInitialStatusCode(errorStatus.getStatusCode());
                    transactionDetails.setTelcoInitialResponse(gson.toJson(res));
                    transactionDetails.setStatusDesc(errorStatus.getStatusDesc());
                    transactionDetails.setStatusMessage(errorCodes.getErrorMsg(errorStatus.getStatusCode()) + errorStatus.getStatusDesc());
                    transactionDetails.setBusinessServiceInitialResponse(String.valueOf(input));

                    log.info("Updating BrokerServiceAtmCodeDetails Table With GetAtmCodeFailure Status");
                    atmCodeRepositoryImpl.save(transactionDetails);
                } else
                    log.error("Data Error: RRN: " + rrn + " Does Not Exists In The BrokerServiceAtmCodeDetails Table");
            } else if (type.equalsIgnoreCase("SendToWalletSuccess")) {
                BrokerServiceSendToWalletDTO brokerServiceSendToWalletDTO = (BrokerServiceSendToWalletDTO) res;
                rrn = brokerServiceSendToWalletDTO.getEazzycash().getRrn();
                Optional<SendToWalletDetails> optionalInput = sendToWalletRepositoryImpl.findInputByRrn(rrn);
                if (optionalInput.isPresent()) {
                    SendToWalletDetails transactionDetails = optionalInput.get();
                    transactionDetails.setStatus("Accepted".toUpperCase());
                    transactionDetails.setStatusCode("200");
                    transactionDetails.setInitialStatusCode("200");
                    transactionDetails.setTelcoInitialResponse(((BrokerServiceSendToWalletDTO) res).getEazzycash().getBusinessServiceInitialResponse());
                    transactionDetails.setStatusDesc("Sync Response Okay. Request Received And Is Processing Status");
                    transactionDetails.setBusinessServiceInitialResponse(String.valueOf(input));
                    transactionDetails.setTransactionId(brokerServiceSendToWalletDTO.getEazzycash().getTransactionId());

                    log.info("Updating BrokerServiceSendToWalletDetails Table With SendToWalletSuccess Status");
                    sendToWalletRepositoryImpl.save(transactionDetails);
                } else
                    log.error("Data Error: RRN: " + rrn + " Does Not Exists In The BrokerServiceSendToWalletDetails Table");
            } else if (type.equalsIgnoreCase("GetAtmCodeSuccess")) {
                BrokerServiceAtmCodeDTO brokerServiceAtmCodeDTO = (BrokerServiceAtmCodeDTO) res;
                rrn = brokerServiceAtmCodeDTO.getRrn();
                Optional<AtmCodeDetails> optionalInput = atmCodeRepositoryImpl.findInputByRrn(rrn);
                if (optionalInput.isPresent()) {
                    AtmCodeDetails transactionDetails = optionalInput.get();
                    transactionDetails.setStatus("Accepted".toUpperCase());
                    transactionDetails.setStatusCode("200");
                    transactionDetails.setInitialStatusCode("200");
                    transactionDetails.setTelcoInitialResponse(((BrokerServiceAtmCodeDTO) res).getBusinessServiceInitialResponse());
                    transactionDetails.setStatusDesc("Sync Response Okay. Request Received And Is In Processing Status");
                    transactionDetails.setBusinessServiceInitialResponse(String.valueOf(input));
                    transactionDetails.setTransactionId(brokerServiceAtmCodeDTO.getTransactionId());

                    log.info("Updating BrokerServiceAtmCodeDetails Table With GetAtmCodeSuccess Status");
                    atmCodeRepositoryImpl.save(transactionDetails);
                } else
                    log.error("Data Error: RRN: " + rrn + " Does Not Exists In The BrokerServiceAtmCodeDetails Table");
            } else if (type.equalsIgnoreCase("SendToWalletAsyncFailure")) {
                FinalResponse asyncResponse = (FinalResponse) input;
                rrn = asyncResponse.getOriginTransactionID();
                Optional<SendToWalletDetails> optionalInput = sendToWalletRepositoryImpl.findInputByRrn(rrn);
                if (optionalInput.isPresent()) {
                    SendToWalletDetails transactionDetails = optionalInput.get();
                    transactionDetails.setStatus(errorStatus.getStatus().toUpperCase());
                    transactionDetails.setFinalStatusCode(errorStatus.getStatusCode());
                    transactionDetails.setStatusDesc(errorStatus.getStatusDesc());
                    transactionDetails.setStatusMessage(errorStatus.getStatusMessage());
                    transactionDetails.setTelcoFinalResponse(gson.toJson(asyncResponse));

                    log.info("Updating BrokerServiceSendToWalletDetails Table With SendToWalletAsyncFailure Status");
                    sendToWalletRepositoryImpl.save(transactionDetails);
                } else
                    log.error("Data Error: RRN: " + rrn + " Does Not Exists In The BrokerServiceSendToWalletDetails Table");
            } else if (type.equalsIgnoreCase("GetAtmCodeAsyncFailure")) {
                AtmCodeAsyncFinalResponse asyncResponse = (AtmCodeAsyncFinalResponse) input;
                rrn = asyncResponse.getOriginatingTransactionID();
                Optional<AtmCodeDetails> optionalInput = atmCodeRepositoryImpl.findInputByRrn(rrn);
                if (optionalInput.isPresent()) {
                    AtmCodeDetails transactionDetails = optionalInput.get();
                    transactionDetails.setStatus(errorStatus.getStatus().toUpperCase());
                    transactionDetails.setFinalStatusCode(errorStatus.getStatusCode());
                    transactionDetails.setStatusDesc(errorStatus.getStatusDesc());
                    transactionDetails.setStatusMessage(errorStatus.getStatusMessage());
                    transactionDetails.setTelcoFinalResponse(gson.toJson(asyncResponse));

                    log.info("Updating BrokerServiceAtmCodeDetails Table With GetAtmCodeAsyncFailure Status");
                    atmCodeRepositoryImpl.save(transactionDetails);
                } else
                    log.error("Data Error: RRN: " + rrn + " Does Not Exists In The BrokerServiceAtmCodeDetails Table");
            } else if (type.equalsIgnoreCase("SendToWalletAsyncSuccess")) {
                BrokerServiceSendToWalletDTO response = (BrokerServiceSendToWalletDTO) res;
                FinalResponse asyncResponse = (FinalResponse) input;
                rrn = asyncResponse.getOriginTransactionID();
                Optional<SendToWalletDetails> optionalInput = sendToWalletRepositoryImpl.findInputByRrn(rrn);
                if (optionalInput.isPresent()) {
                    SendToWalletDetails transactionDetails = optionalInput.get();
                    transactionDetails.setStatus("Success".toUpperCase());
                    transactionDetails.setFinalStatusCode(response.getEazzycash().getStatusCode());
                    transactionDetails.setStatusDesc(response.getEazzycash().getStatusDesc());
                    transactionDetails.setStatusMessage(response.getEazzycash().getStatusMessage());
                    transactionDetails.setTransactionId(response.getEazzycash().getTransactionId());
                    transactionDetails.setTelcoFinalResponse(response.getEazzycash().getTelcoFinalResponse());
                    transactionDetails.setBusinessServiceFinalResponse(response.getEazzycash().getBusinessServiceFinalResponse());

                    log.info("Updating BrokerServiceSendToWalletDetails Table With SendToWalletAsyncSuccess Status");
                    sendToWalletRepositoryImpl.save(transactionDetails);
                } else
                    log.error("Data Error: RRN: " + rrn + " Does Not Exists In The BrokerServiceSendToWalletDetails Table");
            } else if (type.equalsIgnoreCase("GetAtmCodeAsyncSuccess")) {
                BrokerServiceAtmCodeDTO response = (BrokerServiceAtmCodeDTO) res;
                AtmCodeAsyncFinalResponse asyncResponse = (AtmCodeAsyncFinalResponse) input;
                rrn = asyncResponse.getOriginatingTransactionID();
                Optional<AtmCodeDetails> optionalInput = atmCodeRepositoryImpl.findInputByRrn(rrn);
                if (optionalInput.isPresent()) {
                    AtmCodeDetails transactionDetails = optionalInput.get();
                    transactionDetails.setStatus("Success".toUpperCase());
                    transactionDetails.setFinalStatusCode(response.getStatusCode());
                    transactionDetails.setStatusDesc(response.getStatusDesc());
                    transactionDetails.setStatusMessage(response.getStatusMessage());
                    transactionDetails.setTransactionId(response.getTransactionId());
                    transactionDetails.setTelcoFinalResponse(response.getTelcoFinalResponse());
                    transactionDetails.setBusinessServiceFinalResponse(response.getBusinessServiceFinalResponse());

                    log.info("Updating BrokerServiceAtmCodeDetails Table With GetAtmCodeAsyncSuccess Status");
                    atmCodeRepositoryImpl.save(transactionDetails);
                } else
                    log.error("Data Error: RRN: " + rrn + " Does Not Exists In The BrokerServiceAtmCodeDetails Table");
            }
        } catch (Exception e) {
            errorStatus.setStatus("Failed");
            errorStatus.setStatusCode("1000");
            errorStatus.setStatusDesc(" Data Persistence Exception Occurred" + e.getMessage());
            errorStatus.setStatusMessage(rrn);
            log.error("Data Persistence Exception Occurred: Method DataPersistenceServiceImp.persistData::: " + e.getMessage());
            return null;
        }
        return "OK";
    }
}
