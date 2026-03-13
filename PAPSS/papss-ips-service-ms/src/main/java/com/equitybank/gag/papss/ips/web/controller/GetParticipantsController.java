package com.equitybank.gag.papss.ips.web.controller;

import com.equitybank.gag.papss.ips.service.ProcessRequestService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.WebRequest;

import java.util.Map;

@RestController
@RequestMapping(path = "/papss/api")
public class GetParticipantsController {
    private static final Logger log = LoggerFactory.getLogger(GetParticipantsController.class);

    private final ProcessRequestService processRequest;

    @Autowired
    public GetParticipantsController(ProcessRequestService processRequest) {
        this.processRequest = processRequest;
    }

    @GetMapping(value = "/participants")
    public ResponseEntity<?> getParticipants(@RequestParam String online,
                                             @RequestParam String type,
                                             @RequestParam(required = false) String bic,
                                             @RequestParam(required = false) String countryCode) {
        // Prepare query params map
        Map<String, Object> queryParams = Map.of(
                "online", online,
                "type", type,
                "bic", bic == null ? "" : bic,
                "countryCode", countryCode == null ? "" : countryCode);

        // Log the received params
        log.info("Received Get Participants Params From gag: {}", queryParams);

        boolean isError = false;

        // Process the request
        String responseXml = processRequest.processGetParticipantsRequest(isError, queryParams);

        if (responseXml == null) {
            return new ResponseEntity<>("Error", HttpStatus.BAD_REQUEST);
        }

        log.info("Returned Participants Response: " + responseXml);
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