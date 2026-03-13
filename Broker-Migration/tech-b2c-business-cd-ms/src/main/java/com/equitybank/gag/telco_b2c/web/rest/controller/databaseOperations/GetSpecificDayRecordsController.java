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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.time.temporal.ChronoUnit;
import java.util.List;

@RestController
@RequestMapping(path = "/api/v1")
public class GetSpecificDayRecordsController {
    private static final Logger log = LoggerFactory.getLogger(GetSpecificDayRecordsController.class);

    // Define the expected date format for yyyy-MM-dd
    private static final String DATE_FORMAT = "yyyy-MM-dd";
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern(DATE_FORMAT);

    private final EnabledServicesChecker enabledServicesChecker;
    private final DatabaseOperationService databaseOperationService;

    @Autowired
    public GetSpecificDayRecordsController(EnabledServicesChecker enabledServicesChecker,
                                           DatabaseOperationService databaseOperationService) {
        this.enabledServicesChecker = enabledServicesChecker;
        this.databaseOperationService = databaseOperationService;
    }


    @GetMapping(value = "/getRecordsByDate")
    public ResponseEntity<?> getRecordsByDate(@RequestParam String date) {
        try {
            // Check if service is enabled
            enabledServicesChecker.checkServiceStatus(enabledServicesChecker.isDatabaseOperationEnabled(), "DB Operation");
        } catch (CustomException e) {
            log.error(e.getMessage());
            return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_ACCEPTABLE);
        }

        log.info("Received Request To Get Record By Specific Date");

        try {
            // Parse the date string without the time
            LocalDateTime startOfDay = LocalDate.parse(date, DATE_FORMATTER).atStartOfDay().truncatedTo(ChronoUnit.SECONDS);
            LocalDateTime endOfDay = startOfDay.with(LocalTime.MAX).truncatedTo(ChronoUnit.SECONDS);

            // Retrieve records between start and end of the day
            List<TransactionDetails> records = databaseOperationService.getRecordsBySpecificDate(startOfDay, endOfDay);

            log.info("Returned Get Record By Specific Date Response: \n{}", (records));
            return new ResponseEntity<>(records, HttpStatus.OK);
        } catch (DateTimeParseException e) {
            // Return a JSON string error if the date format is incorrect
            String errorJson = String.format("{\"error\":\"Invalid date format. Expected format: %s\"}", DATE_FORMAT);
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(errorJson);
        }
    }


}
