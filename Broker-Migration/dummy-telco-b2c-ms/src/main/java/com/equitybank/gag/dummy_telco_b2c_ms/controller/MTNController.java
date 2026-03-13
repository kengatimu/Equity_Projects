package com.equitybank.gag.dummy_telco_b2c_ms.controller;

import com.equitybank.gag.dummy_telco_b2c_ms.service.MtnPayloadService;
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
@RequestMapping(path = "/api/v1/mtn")
public class MTNController {
    private static final Logger log = LoggerFactory.getLogger(VodacomNameCheckController.class);

    private final MtnPayloadService mtnPayloadService;

    @Autowired
    public MTNController(MtnPayloadService mtnPayloadService) {
        this.mtnPayloadService = mtnPayloadService;
    }

    @PostMapping(path = "/floatpurchase/namecheck",
            consumes = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE },
            produces = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
    public ResponseEntity<?> postTransaction(@RequestBody String requestXml) {
        log.info("Received Float Purchase NameCheck Request: {}", requestXml);

        String responseString = mtnPayloadService.floatNamecheckSuccessResponse();
        log.info("Returned Response: " + responseString);

        return new ResponseEntity<>(responseString, HttpStatus.OK);
    }

    @PostMapping(path = "/floatpurchase",
            consumes = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE },
            produces = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
    public ResponseEntity<?> postTransaction1(@RequestBody String requestXml) {
        log.info("Received Float Purchase Request: {}", requestXml);

//        String responseString = mtnPayloadService.floatPurchaseSuccessResponse();
        String responseString = mtnPayloadService.mtnGenericFailureResponse3()  ;
        log.info("Returned Response: " + responseString);

        return new ResponseEntity<>(responseString, HttpStatus.OK);
    }

    @PostMapping(path = "/floatpurchase/status",
            consumes = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE },
            produces = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
    public ResponseEntity<?> postTransaction2(@RequestBody String requestXml) {
        log.info("Received Float Purchase Request: {}", requestXml);

//        String responseString = mtnPayloadService.floatPurchaseSuccessResponse();
        String responseString = mtnPayloadService.floatPurchaseStatusSuccessResponse()  ;
        log.info("Returned Response: " + responseString);

        return new ResponseEntity<>(responseString, HttpStatus.OK);
    }
}
