package com.equitybank.gag.papss.ots.web.controller.callback;

import com.equitybank.gag.papss.ots.enums.TransactionType;
import com.equitybank.gag.papss.ots.service.RequestProcessorService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.task.TaskExecutor;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path = "/api/v1/outbound")
public class CreditTransferCallbackController {
    private static final Logger log = LoggerFactory.getLogger(CreditTransferCallbackController.class);

    private final TaskExecutor taskExecutor;
    private final RequestProcessorService requestProcessorService;

    @Autowired
    public CreditTransferCallbackController(@Qualifier("taskExecutor") TaskExecutor taskExecutor,
                                            RequestProcessorService requestProcessorService) {
        this.taskExecutor = taskExecutor;
        this.requestProcessorService = requestProcessorService;
    }

    @PostMapping(value = "/credit-transfer/callback",
            consumes = {MediaType.APPLICATION_XML_VALUE},
            produces = {MediaType.APPLICATION_XML_VALUE})
    ResponseEntity<?> creditTransferCallback(@RequestBody String creditTransferCallbackXml) {
        TransactionType type = TransactionType.CREDIT_TRANSFER_CALLBACK;

        String rrn = extractOrgnlInstrId(creditTransferCallbackXml);
        log.info("{}: Received Callback Response From PAPSS: {}", rrn, creditTransferCallbackXml);

        taskExecutor.execute(() -> {
            try {
                requestProcessorService.processCallbackResponse(rrn, creditTransferCallbackXml, type);
            } catch (Exception e) {
                log.error("{}: Failed to process the callback response asynchronously. Exception: {}", rrn, e.getMessage());
            }
        });

        // Respond with HTTP 200 and empty body
        log.info("Responding To PAPSS Callback With Http Status 200 and Empty Body");
        return ResponseEntity.ok().build();
    }

    public String extractOrgnlInstrId(String xml) {
        try {
            int start = xml.indexOf("<OrgnlInstrId>") + "<OrgnlInstrId>".length();
            int end = xml.indexOf("</OrgnlInstrId>");
            return xml.substring(start, end).trim();
        } catch (Exception e) {
            return "";
        }
    }

}
