package com.equitybank.gag.dummy_telco_b2c_ms.controller;

import com.equitybank.gag.dummy_telco_b2c_ms.service.TelcoTransactionProcessService;
import com.google.gson.Gson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(path = "/api/v1")
public class TelcoController {
    private static final Logger log = LoggerFactory.getLogger(TelcoController.class);

    private final TelcoTransactionProcessService transactionProcessService;
    private final Gson gson;

    @Autowired
    public TelcoController(TelcoTransactionProcessService transactionProcessService,
                           Gson gson) {
        this.transactionProcessService = transactionProcessService;
        this.gson = gson;
    }
    @PostMapping(path = "/bank/transactions",
            consumes = { MediaType.APPLICATION_XML_VALUE },
            produces = { MediaType.APPLICATION_XML_VALUE})
    public ResponseEntity<?> postTransaction(@RequestBody String transactionXmlReq) {
        // timeout simulation
//        sleepBeforeNextTask();

        log.info("Received Telco Transaction Request: {}", transactionXmlReq);

//        return new ResponseEntity<>(transactionProcessService.responsePendingStatusOk(), HttpStatus.OK);
        return new ResponseEntity<>(transactionProcessService.feeLookupSuccess(), HttpStatus.OK);
//        return new ResponseEntity<>(transactionProcessService.responsePendingStatusFailure(), HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PostMapping(path = "/bank/transactions/status",
            consumes = { MediaType.APPLICATION_XML_VALUE },
            produces = { MediaType.APPLICATION_XML_VALUE})
    public ResponseEntity<?> getTransactionStatus(@RequestBody String statusXmlReq) {
        log.info("Received Telco Status Request: {}", statusXmlReq);

        // timeout simulation
//        sleepBeforeNextTask();
//

//        return new ResponseEntity<>(null, HttpStatus.NOT_FOUND);
//        return new ResponseEntity<>(transactionProcessService.responsePendingStatusSuccess(), HttpStatus.OK);
//        return new ResponseEntity<>(transactionProcessService.responseKOStatusSuccess(), HttpStatus.OK);
//        return new ResponseEntity<>(transactionProcessService.responseFinalStatusSuccess(), HttpStatus.OK);
//        return new ResponseEntity<>(transactionProcessService.responseFinalStatusFailure(), HttpStatus.INTERNAL_SERVER_ERROR);
        return new ResponseEntity<>(transactionProcessService.responseFinalStatusFailure(), HttpStatus.OK);

    }

    private void sleepBeforeNextTask() {
        try {
            Thread.sleep(30000); // Sleep for 30 second
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            log.error(String.format("%sThread was interrupted while waiting for status check: ", e.getMessage()));
        }
    }

}
