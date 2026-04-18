package com.equitybank.payments.imt.b2c.drcbroker.web.rest;

import com.equitybank.payments.imt.b2c.drcbroker.service.AsyncResponseService;
import com.equitybank.payments.imt.b2c.drcbroker.service.CallBackHTTPService;
import com.equitybank.payments.imt.b2c.drcbroker.service.DataPersistenceService;
import com.equitybank.payments.imt.b2c.drcbroker.service.dto.BrokerServiceSendToWalletDTO;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.error.status.ErrorStatus;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.response.FinalResponse;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.response.BusinessServiceFinalResponse;
import com.google.gson.Gson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.concurrent.Executor;

@RestController
@RequestMapping(path = "/api/gag")
public class SendToWalletAsyncResource {
    private static final Logger log = LoggerFactory.getLogger(SendToWalletAsyncResource.class);

    private final DataPersistenceService dataPersistenceService;
    private final AsyncResponseService asyncResponseService;
    private final CallBackHTTPService callBackHTTPService;
    private final Executor taskExecutor;
    private final Gson gson;

    @Autowired
    public SendToWalletAsyncResource(DataPersistenceService dataPersistenceService, AsyncResponseService asyncResponseService, CallBackHTTPService callBackHTTPService, Executor taskExecutor, Gson gson) {
        this.dataPersistenceService = dataPersistenceService;
        this.asyncResponseService = asyncResponseService;
        this.callBackHTTPService = callBackHTTPService;
        this.taskExecutor = taskExecutor;
        this.gson = gson;
    }

    @PostMapping(path = "/callback/banktowallet",
            consumes = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE},
            produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE})
    public ResponseEntity<?> receiveAsyncResponse(@RequestBody FinalResponse asyncResponse) {
        log.info("Received Async Response From PCES Broker Service::: " + gson.toJson(asyncResponse));
        ErrorStatus errorStatus = new ErrorStatus();
        String type = "AsyncBankToWallet";
        BusinessServiceFinalResponse finalResponse = new BusinessServiceFinalResponse();
        BrokerServiceSendToWalletDTO response = (BrokerServiceSendToWalletDTO) asyncResponseService.processAsyncResponse(asyncResponse, type, errorStatus);
        if (response == null) {
            finalResponse.setRequestID(asyncResponse.getOriginTransactionID());
            finalResponse.setResultStatus(errorStatus.getStatus().toUpperCase());
            finalResponse.setBenficiaryName(null);
            finalResponse.setWalletTXCode(null);
            log.info("Received Error Message: " + gson.toJson(errorStatus));

            //update db with failure response
            type = "SendToWalletAsyncFailure";
            updateTransactionDetailsTable(asyncResponse, finalResponse, type, errorStatus);

            //call channel callback
            String url = "";
            type = "AsyncBankToWallet";
            callBackHTTPService.sendCallback(url, gson.toJson(finalResponse), type);
            return ResponseEntity.status(HttpStatus.NOT_ACCEPTABLE).body(finalResponse);
        }
        //update db with Success response
        type = "SendToWalletAsyncSuccess";
        updateTransactionDetailsTable(asyncResponse, response, type, errorStatus);

        //call channel callback
        String url = "";
        type = "AsyncBankToWallet";
        String jsonRes = response.getEazzycash().getBusinessServiceFinalResponse();
        BusinessServiceFinalResponse callbackRes = gson.fromJson(jsonRes, BusinessServiceFinalResponse.class);
        callBackHTTPService.sendCallback(url, gson.toJson(callbackRes), type);
        return ResponseEntity.status(HttpStatus.OK).body(jsonRes);
    }

    private void updateTransactionDetailsTable(Object res, Object response, String type, ErrorStatus errorStatus) {
        taskExecutor.execute(() ->
                dataPersistenceService.persistData(res, response, type, errorStatus));
    }
}
