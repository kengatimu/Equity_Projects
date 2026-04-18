package com.equitybank.payments.imt.b2c.response.web.rest;

import com.equitybank.payments.imt.b2c.response.service.model.response.BusinessServiceFinalResponse;
import com.google.gson.Gson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path = "/api")
public class CallbackResource {
    private static final Logger log = LoggerFactory.getLogger(CallbackResource.class);

    @PostMapping(path = "/gag/callback",
            consumes = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE},
            produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE})
    public ResponseEntity<?> receiveCallback(@RequestBody BusinessServiceFinalResponse request) {
        log.info("REQUEST RECEIVED FROM TECHNICAL SERVICE::: " + new Gson().toJson(request));

        return ResponseEntity.status(HttpStatus.OK).body(new Gson().toJson(request));
    }

}
