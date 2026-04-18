package com.equitybank.imt.worldremit.producer.resource;

import com.equitybank.imt.worldremit.producer.models.domain.Transaction;
import com.equitybank.imt.worldremit.producer.models.http.requests.WebHook;
import com.equitybank.imt.worldremit.producer.services.WRProcessorService;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.task.TaskExecutor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;
import java.util.Arrays;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@RestController
@RequestMapping("equity-bank/wr-processor/v1")
public class Notification {
    private static final Logger log = LoggerFactory.getLogger(Notification.class);

    private WRProcessorService wrProcessorService;

    @Autowired
    TaskExecutor taskExecutor;

    Notification(WRProcessorService wrProcessorService) {
        this.wrProcessorService = wrProcessorService;
    }

    /**
     * This is the initialization point for processing transactions
     *
     * @param worldremitaction of transaction is supplied to us by WR
     */
    @GetMapping("callback")
    ResponseEntity<Void> notificationFromWR(@RequestParam("worldremitaction")
                                            @Valid
                                            @Pattern(regexp = "^[a-zA-Z0-9.\\-\\/+=@_ ]*$")
                                            @NotEmpty(message = "worldremitaction is mandatory") String worldremitaction) {

        if (worldremitaction.length() != 1) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
        if (worldremitaction.equalsIgnoreCase("1") || worldremitaction.equalsIgnoreCase("0")) {


            taskExecutor.execute(() -> wrProcessorService.processTransactionAwaiting(worldremitaction));

            return new ResponseEntity<>(HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    @GetMapping("create-webhook")
    ResponseEntity<Void> createWebhook() {

        taskExecutor.execute(() -> {
            WebHook webHook = new WebHook();
            webHook.setType("TransactionStart");
            webHook.setEndpoint("https://api-omnichannel-dev.azure-api.net/imt-hub/callback/?worldremitaction=2");
            webHook.setHttpsIgnoreCertificateErrors(false);
            webHook.setHttpsMutualSSLSignOutgoingRequest(false);
            webHook.setEndpointAppendMode("AppendToUrl");
            webHook.setReferenceId("eaee13de-0db0-4cd1-adb0-68acb85002cf");
            webHook.setName("WebHook TransactionStart, TransactionGetStatus");
            webHook.setDebounceInMs(0);
            webHook.setBroadcast(true);
            webHook.setCorrespondentIds(Arrays.asList("0a1ad713-6364-44c4-9621-21ee2f3d8670", "1a6d32be-c3e6-445e-92c0-0f078757f196", "14443f01-f630-4326-a2f6-022f87c36eec", "ea2a5ed3-958e-455c-97ba-b2f3c38ba3c0", "28c33988-24be-448b-abab-81d6c9ec1c9f", "888090e0-bf23-4103-b5f7-a566eedb3a9d", "30ee9020-3d04-45ff-aebf-94a0158ba0af", "4dc8dcfd-cd21-4c72-a8c2-fc421c2d67c9", "d221331c-ee06-48d9-bcf3-24737312c034", "d91c4169-eb59-46f1-b5e9-093c1dce1d7e", "0ebaa7ff-ab4a-44ae-b02e-1afcf002ce27"));
            wrProcessorService.createWebHook(webHook);
        });

        return new ResponseEntity<>(HttpStatus.OK);
    }

    @GetMapping("heartbeat")
    ResponseEntity<?> urlCheck() {
        return new ResponseEntity<>(HttpStatus.OK);
    }
    
    //This is purely for UAT testing purposes
    @PostMapping(path = "/test-transaction-uat",
            consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<?> testingUAT(@RequestBody Transaction transaction) {
        Gson gson = new Gson();
        String tranJson = gson.toJson(transaction);
        log.info("Received Transaction Request: ".toUpperCase() + transaction); 
        wrProcessorService.processTransactionAwaiting(tranJson);
       
        return ResponseEntity.status(HttpStatus.OK).body(gson.toJson(null));
    }

}
