package com.equitybank.gag.dummy_telco_b2c_ms.controller;

import com.equitybank.gag.dummy_telco_b2c_ms.dto.namecheck.vodacom.request.TransactionData;
import com.equitybank.gag.dummy_telco_b2c_ms.service.NamecheckService;
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
@RequestMapping(path = "/")
public class VodacomNameCheckController<T> {
    private static final Logger log = LoggerFactory.getLogger(VodacomNameCheckController.class);

    private final NamecheckService<T> namecheckService;
    private final Gson gson;

    @Autowired
    public VodacomNameCheckController(NamecheckService<T> namecheckService,
                                      Gson gson) {
        this.namecheckService = namecheckService;
        this.gson = gson;
    }


    @PostMapping(path = "api/v1",
            consumes = { MediaType.APPLICATION_JSON_VALUE },
            produces = { MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<?> postTransaction(@RequestBody TransactionData transactionData) {
        log.info("Received Telco Transaction Request: {}", gson.toJson(transactionData));

        return new ResponseEntity<>(namecheckService.processNamecheckRequest(transactionData), HttpStatus.OK);
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
