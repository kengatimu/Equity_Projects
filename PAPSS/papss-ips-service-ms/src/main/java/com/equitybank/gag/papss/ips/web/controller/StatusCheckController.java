package com.equitybank.gag.papss.ips.web.controller;

import com.equitybank.gag.papss.ips.service.ProcessRequestService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.WebRequest;

@RestController
@RequestMapping(path = "/papss/api/v1/outbound")
public class StatusCheckController {
    private static final Logger log = LoggerFactory.getLogger(StatusCheckController.class);

    private final ProcessRequestService processRequest;

    @Autowired
    public StatusCheckController(ProcessRequestService processRequest) {
        this.processRequest = processRequest;
    }

    @PostMapping(value = "/txnstatusquery",
            consumes = {MediaType.APPLICATION_XML_VALUE},
            produces = {MediaType.APPLICATION_XML_VALUE})
    ResponseEntity<?> nameCheck( @RequestBody String creditTransferXmlRequest, BindingResult bindingResult, WebRequest webRequest) {
        log.info("Received Status Check Request: " + creditTransferXmlRequest);

        // Simulate timeouts
//        sleepFor90Seconds();

//        String state = "Success-ACK";
        String state = "Failure-ACK";
//        String finalState = "Final-Success";
        String finalState = "Final-Failure";

        // Process the request
        String responseXml = processRequest.processStatusCheckRequest(creditTransferXmlRequest, state, finalState);

        log.info("Returned Namecheck Response: " + responseXml);
        return new ResponseEntity<>(responseXml, HttpStatus.OK);
    }

    public void sleepFor90Seconds() {
        try {
            Thread.sleep(90_000); // 90 seconds = 90,000 milliseconds
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt(); // restore interrupt status
            System.err.println("Thread was interrupted during sleep: " + e.getMessage());
        }
    }
}