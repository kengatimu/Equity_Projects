package com.equitybank.gag.telco_b2c.web.rest.controller.databaseOperations;

import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.service.DatabaseOperationService;
import com.equitybank.gag.telco_b2c.util.EnabledServicesChecker;
import com.google.gson.Gson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path = "/api/v1")
public class GetRecordByRrnController {
    private static final Logger log = LoggerFactory.getLogger(GetRecordByRrnController.class);

    private final EnabledServicesChecker enabledServicesChecker;
    private final DatabaseOperationService databaseOperationService;
    private final Gson gson;

    @Autowired
    public GetRecordByRrnController(EnabledServicesChecker enabledServicesChecker,
                                    DatabaseOperationService databaseOperationService,
                                    Gson gson) {
        this.enabledServicesChecker = enabledServicesChecker;
        this.databaseOperationService = databaseOperationService;
        this.gson = gson;
    }

    @GetMapping(value = "/getRecordByRRN", produces = {MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<?> getRecordByRRN(@RequestParam String rrn) {
        try {
            // Check if service is enabled
            enabledServicesChecker.checkServiceStatus(enabledServicesChecker.isDatabaseOperationEnabled(), "DB Operation");
        } catch (CustomException e) {
            log.error(e.getMessage());
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }

        log.info("Received Request To Get Record By RRN");
        TransactionDetails response = databaseOperationService.getRecordByRRN(rrn);

        log.info("{}: Returned Get Record By RRN Response: \n{}", rrn, (response));
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
}
