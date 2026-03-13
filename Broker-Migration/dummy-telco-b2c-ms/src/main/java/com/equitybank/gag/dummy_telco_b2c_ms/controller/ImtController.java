package com.equitybank.gag.dummy_telco_b2c_ms.controller;

import com.equitybank.gag.dummy_telco_b2c_ms.service.ImtTransactionProcessService;
import com.equitybank.gag.dummy_telco_b2c_ms.service.TelcoTransactionProcessService;
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

@RestController
@RequestMapping(path = "/api/v1")
public class ImtController {
    private static final Logger log = LoggerFactory.getLogger(ImtController.class);

    private final ImtTransactionProcessService imtTransactionProcessService;
    private final Gson gson;

    @Autowired
    public ImtController(ImtTransactionProcessService imtTransactionProcessService,
                         Gson gson) {
        this.imtTransactionProcessService = imtTransactionProcessService;
        this.gson = gson;
    }

    @PostMapping(path = "/feeLookup",
            consumes = {MediaType.APPLICATION_XML_VALUE},
            produces = {MediaType.APPLICATION_XML_VALUE})
    public ResponseEntity<?> postTransaction(@RequestBody String transactionXmlReq) {
        // timeout simulation
//        sleepBeforeNextTask();

        log.info("Received Imt Fee Lookup Request: {}", transactionXmlReq);

        return new ResponseEntity<>(imtTransactionProcessService.feeLookupSuccess(), HttpStatus.OK);
//        return new ResponseEntity<>(imtTransactionProcessService.feeLookupFailure(), HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PostMapping(path = "/commitTransaction",
            consumes = {MediaType.APPLICATION_XML_VALUE},
            produces = {MediaType.APPLICATION_XML_VALUE})
    public ResponseEntity<?> postCommitTransaction(@RequestBody String transactionXmlReq) {
        // timeout simulation
//        sleepBeforeNextTask();

        log.info("Received Imt Commit Request: {}", transactionXmlReq);

        return new ResponseEntity<>(imtTransactionProcessService.commitRequestSuccess(), HttpStatus.OK);
//        return new ResponseEntity<>(imtTransactionProcessService.commitRequestFailure(), HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PostMapping(path = "/receive/referenceNumber",
            consumes = {MediaType.APPLICATION_XML_VALUE},
            produces = {MediaType.APPLICATION_XML_VALUE})
    public ResponseEntity<?> postReferenceNumberTransaction(@RequestBody String transactionXmlReq) {
        // timeout simulation
//        sleepBeforeNextTask();

        log.info("Received Imt Receive ReferenceNumber Request: {}", transactionXmlReq);

        return new ResponseEntity<>(imtTransactionProcessService.referenceNumberRequestSuccess(), HttpStatus.OK);
//        return new ResponseEntity<>(imtTransactionProcessService.commitRequestFailure(), HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PostMapping(path = "/receive/getFieldsForProduct",
            consumes = {MediaType.APPLICATION_XML_VALUE},
            produces = {MediaType.APPLICATION_XML_VALUE})
    public ResponseEntity<?> postGffpRequest(@RequestBody String transactionXmlReq) {
        // timeout simulation
//        sleepBeforeNextTask();

        log.info("Received Imt Gffp Request: {}", transactionXmlReq);

        return new ResponseEntity<>(imtTransactionProcessService.receiveGFFPSuccess(), HttpStatus.OK);
//        return new ResponseEntity<>(imtTransactionProcessService.commitRequestFailure(), HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PostMapping(path = "/receive/receiveValidation",
            consumes = {MediaType.APPLICATION_XML_VALUE},
            produces = {MediaType.APPLICATION_XML_VALUE})
    public ResponseEntity<?> receiveValidationTransaction(@RequestBody String transactionXmlReq) {
        // timeout simulation
//        sleepBeforeNextTask();

        log.info("Received Imt Validation Request: {}", transactionXmlReq);

        return new ResponseEntity<>(imtTransactionProcessService.receiveValidationSuccess(), HttpStatus.OK);
//        return new ResponseEntity<>(imtTransactionProcessService.commitRequestFailure(), HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PostMapping(path = "/receive/commitTransaction",
            consumes = {MediaType.APPLICATION_XML_VALUE},
            produces = {MediaType.APPLICATION_XML_VALUE})
    public ResponseEntity<?> receiveCommitTransaction(@RequestBody String transactionXmlReq) {
        // timeout simulation
//        sleepBeforeNextTask();

        log.info("Received Imt Receive Commit Request: {}", transactionXmlReq);

        return new ResponseEntity<>(imtTransactionProcessService.receiveCommitSuccess(), HttpStatus.OK);
//        return new ResponseEntity<>(imtTransactionProcessService.commitRequestFailure(), HttpStatus.INTERNAL_SERVER_ERROR);
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
