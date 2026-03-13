package com.equitybank.gag.telco_b2c.web.rest.controller.databaseOperations;

import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.service.ImtGetReferenceNumberService;
import com.equitybank.gag.telco_b2c.util.EnabledServicesChecker;
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
public class GetImtCommitResponseByRrnController {
    private static final Logger log = LoggerFactory.getLogger(GetImtCommitResponseByRrnController.class);

    private final EnabledServicesChecker enabledServicesChecker;
    private final ImtGetReferenceNumberService imtGetReferenceNumberService;

    @Autowired
    public GetImtCommitResponseByRrnController(EnabledServicesChecker enabledServicesChecker,
                                               ImtGetReferenceNumberService imtGetReferenceNumberService) {
        this.enabledServicesChecker = enabledServicesChecker;
        this.imtGetReferenceNumberService = imtGetReferenceNumberService;
    }

    @GetMapping(value = "/getImtReferenceNumber", produces = {MediaType.APPLICATION_XML_VALUE})
    public ResponseEntity<?> getRecordByRRN(@RequestParam String rrn) {
        try {
            // Check if service is enabled
            enabledServicesChecker.checkServiceStatus(enabledServicesChecker.isDatabaseOperationEnabled(), "DB Operation");
        } catch (CustomException e) {
            log.error(e.getMessage());
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }

        log.info("Received Request To Get IMT Reference Number. Received RRN: " + rrn);
        String imtResponseXml = imtGetReferenceNumberService.getImtCommitResponse(rrn);

        log.info("{}: Returned Get IMT Reference Number Response By RRN: \n{}", rrn, (imtResponseXml));
        return new ResponseEntity<>(imtResponseXml, HttpStatus.OK);
    }
}
