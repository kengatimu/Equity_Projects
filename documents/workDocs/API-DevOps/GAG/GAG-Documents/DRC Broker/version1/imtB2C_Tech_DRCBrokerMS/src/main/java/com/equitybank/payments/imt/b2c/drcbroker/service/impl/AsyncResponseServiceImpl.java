package com.equitybank.payments.imt.b2c.drcbroker.service.impl;

import com.equitybank.payments.imt.b2c.drcbroker.service.AsyncResponseService;
import com.equitybank.payments.imt.b2c.drcbroker.service.dto.BrokerServiceAtmCodeDTO;
import com.equitybank.payments.imt.b2c.drcbroker.service.dto.BrokerServiceSendToWalletDTO;
import com.equitybank.payments.imt.b2c.drcbroker.service.dto.Eazzycash;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.error.status.ErrorStatus;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.response.AtmCodeAsyncFinalResponse;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.response.FinalResponse;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.response.BusinessServiceFinalResponse;
import com.google.gson.Gson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service
public class AsyncResponseServiceImpl implements AsyncResponseService {
    private static final Logger log = LoggerFactory.getLogger(AsyncResponseServiceImpl.class);

    private final ErrorCodes errorCodes;
    private final Gson gson;

    public AsyncResponseServiceImpl(ErrorCodes errorCodes, Gson gson) {
        this.errorCodes = errorCodes;
        this.gson = gson;
    }

    @Override
    public <T> Object processAsyncResponse(Object input, String type, ErrorStatus errorStatus) {

        String asyncResponseJson;
        String status;
        String rrn;

        if (type.equalsIgnoreCase("AsyncBankToWallet")) {
            FinalResponse asyncResponse = (FinalResponse) input;
            rrn = asyncResponse.getOriginTransactionID();
            asyncResponseJson = gson.toJson(asyncResponse);
            status = asyncResponse.getStatus();

            if (!status.equals("200")) {
                String reason = errorCodes.getErrorMsg(status);
                errorStatus.setStatus("Failed");
                errorStatus.setStatusCode(status);
                errorStatus.setStatusDesc(" Transaction Failed");
                errorStatus.setStatusMessage(reason + errorStatus.getStatusDesc());
                log.error(rrn + errorStatus.getStatusMessage());
                return null;
            }

            //get response object and string
            BusinessServiceFinalResponse response = getBusinessServiceResponse(asyncResponse, type);
            String responseString = gson.toJson(response);

            //update Dto
            BrokerServiceSendToWalletDTO brokerServiceSendToWalletDTO = new BrokerServiceSendToWalletDTO();
            Eazzycash eazzycash = new Eazzycash();
            eazzycash.setBusinessServiceFinalResponse(responseString);
            eazzycash.setStatus(response.getResultStatus().toUpperCase());
            eazzycash.setTelcoFinalResponse(asyncResponseJson);
            eazzycash.setStatusCode(asyncResponse.getStatus());
            eazzycash.setStatusDesc(" Transaction Processed Successfully");
            eazzycash.setStatusMessage(" Transaction Processed Successfully");
            eazzycash.setTransactionId(asyncResponse.getTransactionID());
            brokerServiceSendToWalletDTO.setEazzycash(eazzycash);
            return brokerServiceSendToWalletDTO;
        } else {
            AtmCodeAsyncFinalResponse asyncResponse = (AtmCodeAsyncFinalResponse) input;
            rrn = asyncResponse.getOriginatingTransactionID();
            asyncResponseJson = gson.toJson(asyncResponse);
            status = asyncResponse.getResultCode();

            if (!status.equals("200")) {
                String reason = errorCodes.getErrorMsg(status);
                errorStatus.setStatus("Failed");
                errorStatus.setStatusCode(status);
                errorStatus.setStatusDesc(" Transaction Failed");
                errorStatus.setStatusMessage(reason + errorStatus.getStatusDesc());
                log.error(rrn + errorStatus.getStatusMessage());
                return null;
            }
            //get response object and string
            BusinessServiceFinalResponse response = getBusinessServiceResponse(asyncResponse, type);
            String responseString = gson.toJson(response);

            //update Dto
            BrokerServiceAtmCodeDTO brokerServiceAtmCodeDTO = new BrokerServiceAtmCodeDTO();
            brokerServiceAtmCodeDTO.setBusinessServiceFinalResponse(responseString);
            brokerServiceAtmCodeDTO.setStatus(response.getResultStatus().toUpperCase());
            brokerServiceAtmCodeDTO.setTelcoFinalResponse(asyncResponseJson);
            brokerServiceAtmCodeDTO.setStatusCode(asyncResponse.getResultCode());
            brokerServiceAtmCodeDTO.setStatusDesc(" Transaction Processed Successfully");
            brokerServiceAtmCodeDTO.setStatusMessage(" Transaction Processed Successfully");
            brokerServiceAtmCodeDTO.setTransactionId(asyncResponse.getTransactionID());
            return brokerServiceAtmCodeDTO;
        }
    }

    private BusinessServiceFinalResponse getBusinessServiceResponse(Object input, String type) {
        FinalResponse asyncResponse;
        AtmCodeAsyncFinalResponse atmAsyncResponse;
        BusinessServiceFinalResponse finalResponse = new BusinessServiceFinalResponse();
        String originTransactionID;
        String transactionID;
        String status;
        if (type.equalsIgnoreCase("AsyncBankToWallet")) {
            asyncResponse = (FinalResponse) input;
            originTransactionID = asyncResponse.getOriginTransactionID();
            transactionID = asyncResponse.getTransactionID();
            status = asyncResponse.getStatus();

        } else {
            atmAsyncResponse = (AtmCodeAsyncFinalResponse) input;
            originTransactionID = atmAsyncResponse.getOriginatingTransactionID();
            transactionID = atmAsyncResponse.getTransactionID();
            status = atmAsyncResponse.getResultCode();
        }
        finalResponse.setRequestID(originTransactionID);
        finalResponse.setResultStatus(status);
        finalResponse.setBenficiaryName(null);
        finalResponse.setWalletTXCode(transactionID);
        return finalResponse;
    }
}
