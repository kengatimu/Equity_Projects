package com.equitybank.gag.telco_b2c.web.rest.controller.b2c;

import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.mapper.CustomMapperService;
import com.equitybank.gag.telco_b2c.service.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.task.TaskExecutor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping(path = "/api/v1/")
public class BankToWalletCallbackController {
    private static final Logger log = LoggerFactory.getLogger(BankToWalletCallbackController.class);

    private final TransactionValidationAndMappingService transactionValidationAndMappingService;
    private final CustomMapperService customMapperService;
    private final DtoProcessingService dtoProcessingService;
    private final XmlReaderService xmlReaderService;
    private final DatabaseService databaseService;
    private final PayloadService payloadService;
    private final TaskExecutor taskExecutor;
    private final HttpService httpService;

    @Autowired
    public BankToWalletCallbackController(TransactionValidationAndMappingService transactionValidationAndMappingService,
                                          CustomMapperService customMapperService,
                                          DtoProcessingService dtoProcessingService,
                                          XmlReaderService xmlReaderService,
                                          DatabaseService databaseService,
                                          PayloadService payloadService,
                                          @Qualifier("taskExecutor") TaskExecutor taskExecutor,
                                          HttpService httpService) {
        this.transactionValidationAndMappingService = transactionValidationAndMappingService;
        this.customMapperService = customMapperService;
        this.dtoProcessingService = dtoProcessingService;
        this.xmlReaderService = xmlReaderService;
        this.databaseService = databaseService;
        this.payloadService = payloadService;
        this.taskExecutor = taskExecutor;
        this.httpService = httpService;
    }

    @PostMapping(value = "/b2c/callback",
            consumes = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE},
            produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE})
    public ResponseEntity<?> handleOmniRequest(@RequestBody String callbackResponseJson) {
        String rrn = "";
        String responseXmlString;
        String type = "transaction";
        Map<String, String> xmlTagsMap = new HashMap<>();
        try {
            // Get xml tag values in a map
            xmlTagsMap = xmlReaderService.parseCallbackXmlString(callbackResponseJson, type);
            rrn = xmlTagsMap.get("thirdPartyReference");

            // Log request on console
            log.info("{}: Received Callback Response From Technical Service: \n{}", rrn, callbackResponseJson);

            // Process the request
            responseXmlString = dtoProcessingService.processCallbackRequest(xmlTagsMap, rrn, type);

            // Call the channel with the response
            telcoCallbackToChannel(xmlTagsMap, rrn, responseXmlString, type);

        } catch (Exception e) {
            log.error(rrn + ": Exception Occurred During Callback: " + e.getMessage());
        }
        return new ResponseEntity<>(composeResponse(xmlTagsMap), getCspHeaders(), HttpStatus.OK);
    }

    private void telcoCallbackToChannel(Map<String, String> xmlTagsMap, String rrn, String responseXmlString, String type) {
        try {
            // Update the database tables
            updateDatabaseWithTelcoDetails(xmlTagsMap, rrn, responseXmlString, type);

            // Get channel details
            TransactionDetails transactionDetails = getSavedDbRecord(rrn, type);
            String callbackUrl = transactionDetails.getCallback().getCallbackUrl();

            if (callbackUrl == null || callbackUrl.isBlank()) {
                log.error("{}: Cannot send the callback response to channel. CallbackUrl is null or blank.", rrn);
                return;
            }

            // Log response xml to console and return it to channel
            log.info("{}: Sending Telco Callback To Channel: \n{}", rrn, responseXmlString);
            httpService.telcoCallbackHttpCall(xmlTagsMap, callbackUrl, responseXmlString, rrn, type);

        } catch (CustomException e) {
            log.error("{}: Exception Occurred: {}", rrn, e.getMessage());
        }
    }

    // This will update the database in async (background thread). Therefore, not need for @Transaction annotation
    private void updateDatabaseWithTelcoDetails(Map<String, String> xmlTagsMap, String rrn, String responseXmlString, String type) {
        taskExecutor.execute(() -> {
            log.info("{}: Processing async telco callback DB update", rrn);
            try {
                TransactionDetails entity = customMapperService.composeTelcoCallbackEntity(xmlTagsMap, rrn, responseXmlString, type);
                if (entity != null) {
                    log.info("{}: Saving async telco callback entity record to the db", rrn);
                    databaseService.updateTransactionRecord(entity);
                } else {
                    log.warn("{}: Skipping async telco callback entity record DB save — entity is null", rrn);
                }
            } catch (Exception e) {
                log.error("{}: Failed to process and update record from telco callback: {}. Process Async", rrn, e.getMessage());
            }
        });
    }

    private TransactionDetails getSavedDbRecord(String rrn, String type) throws CustomException {
        return transactionValidationAndMappingService.getDatabaseRecord(rrn, type);
    }

    private Object composeResponse(Map<String, String> xmlTagsMap) {
        return payloadService.composeCallbackResponse(xmlTagsMap);
    }

    private HttpHeaders getCspHeaders() {
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Security-Policy", "default-src 'none';");
        return headers;
    }
}
