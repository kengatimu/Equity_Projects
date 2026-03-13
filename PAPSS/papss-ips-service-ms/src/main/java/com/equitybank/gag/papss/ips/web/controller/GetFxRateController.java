package com.equitybank.gag.papss.ips.web.controller;

import com.equitybank.gag.papss.ips.service.ProcessRequestService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.WebRequest;

@RestController
@RequestMapping(path = "/papss")
public class GetFxRateController {
    private static final Logger log = LoggerFactory.getLogger(GetFxRateController.class);

    private final ProcessRequestService processRequest;

    @Autowired
    public GetFxRateController(ProcessRequestService processRequest) {
        this.processRequest = processRequest;
    }

    @GetMapping(value = "/FXRate")
    public ResponseEntity<?> getFxRate(@RequestParam String SenderCountry,
                                       @RequestParam String SenderCurrency,
                                       @RequestParam String ReceiverCountry,
                                       @RequestParam String ReceiverCurrency,
                                       @RequestParam String ReceiverBank,
                                       @RequestParam String LclInstrm,
                                       @RequestParam String amount,
                                       WebRequest webRequest)  {
        log.info("Received Fx Rate Request for {} to {} and amount {}", SenderCurrency, ReceiverCurrency, amount);
        boolean isError = false;

        // Process the request
        String responseXml = processRequest.processFxRateRequest(isError);

        if (responseXml == null) {
            return new ResponseEntity<>("Error", HttpStatus.BAD_REQUEST);
        }

        log.info("Returned FxRate Response: " + responseXml);
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