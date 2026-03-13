package com.equitybank.gag.telco_b2c.web.rest.controller.databaseOperations;

import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.service.DatabaseOperationService;
import com.equitybank.gag.telco_b2c.util.EnabledServicesChecker;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping(path = "/api/v1")
public class GetLast10RecordsController {
    private static final Logger log = LoggerFactory.getLogger(GetLast10RecordsController.class);

    private final EnabledServicesChecker enabledServicesChecker;
    private final DatabaseOperationService databaseOperationService;

    @Autowired
    public GetLast10RecordsController(EnabledServicesChecker enabledServicesChecker,
                                      DatabaseOperationService databaseOperationService) {
        this.enabledServicesChecker = enabledServicesChecker;
        this.databaseOperationService = databaseOperationService;
    }

    @GetMapping(value = "/getLastTen")
    public ResponseEntity<?> getLast10Records() {
        try {
            // Check if service is enabled
            enabledServicesChecker.checkServiceStatus(enabledServicesChecker.isDatabaseOperationEnabled(), "DB Operation");
        } catch (CustomException e) {
            log.error(e.getMessage());
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }

        log.info("Received Request To Get The Last 10 Records");
        List<TransactionDetails> lastTenRecords = databaseOperationService.getLastTenRecords();

        log.info("Returned Get The Last 10 Records Response: \n{}", (lastTenRecords));
        return new ResponseEntity<>(lastTenRecords, HttpStatus.OK);
    }
}
