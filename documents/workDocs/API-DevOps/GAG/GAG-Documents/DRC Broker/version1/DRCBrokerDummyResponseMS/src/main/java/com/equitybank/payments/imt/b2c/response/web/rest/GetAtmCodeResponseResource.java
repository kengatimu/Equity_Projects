package com.equitybank.payments.imt.b2c.response.web.rest;

import com.equitybank.payments.imt.b2c.response.service.CallBackHTTPService;
import com.equitybank.payments.imt.b2c.response.service.model.request.BrokerServiceAtmCodeRequest;
import com.equitybank.payments.imt.b2c.response.service.model.response.BusinessServiceFinalResponse;
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
@RequestMapping(path = "/api")
public class GetAtmCodeResponseResource {
    private static final Logger log = LoggerFactory.getLogger(GetAtmCodeResponseResource.class);
    private final String CALL_BACK_URL = "http://localhost:8284/api/gag/callback/getatmcode";

    private final CallBackHTTPService callBackHTTPService;
    private final Executor taskExecutor;

    @Autowired
    public GetAtmCodeResponseResource(CallBackHTTPService callBackHTTPService, Executor taskExecutor) {
        this.callBackHTTPService = callBackHTTPService;
        this.taskExecutor = taskExecutor;
    }

    @PostMapping(path = "/gag/getatmcode",
            consumes = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE},
            produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE})
    public ResponseEntity<?> getAtmCodePost(@RequestBody BrokerServiceAtmCodeRequest request) {
        log.info("Received Request From Technical Service::: " + request);
        String ackResponse = getAckResponse(request);
        String finalResponse = getFinalResponse(request);

        taskExecutor.execute(() ->
                callBackHTTPService.sendCallback(CALL_BACK_URL.trim(), finalResponse));

        return ResponseEntity.status(HttpStatus.OK).body(ackResponse);
    }

    private String getAckResponse(BrokerServiceAtmCodeRequest request) {
        String tranId = request.getTransactionID() + "0001";
        String status = "200";
        int tranStatus = 200;

        return "{\n" +
                "    \"OriginatingTransactionID\": \"" + request.getTransactionID() + "\",\n" +
                "    \"TransactionID\": \"" + tranId + "\",\n" +
                "    \"Status\": \"" + status + "\",\n" +
                "    \"TransactionStatus\": \"" + tranStatus + "\"\n" +
                "}";
    }

    private String getFinalResponse(BrokerServiceAtmCodeRequest request) {
        String tranId = request.getTransactionID() + "0001";
        String status = "200";
        String tranStatus = "Redemption";
//        String tranStatus = "Failed";

        return "{\n" +
                "    \"OriginatingTransactionID\": \"" + request.getTransactionID() + "\",\n" +
                "    \"TransactionID\": \"" + tranId + "\",\n" +
                "    \"ResultCode\": \"" + status + "\",\n" +
                "    \"ResultDescription\": \"" + tranStatus + "\"\n" +
                "}\n";
    }
}
