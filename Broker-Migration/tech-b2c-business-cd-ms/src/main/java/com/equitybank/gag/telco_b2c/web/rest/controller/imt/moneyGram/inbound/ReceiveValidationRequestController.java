package com.equitybank.gag.telco_b2c.web.rest.controller.imt.moneyGram.inbound;

import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.exception.GlobalExceptionHandler;
import com.equitybank.gag.telco_b2c.service.XmlProcessingService;
import com.equitybank.gag.telco_b2c.service.XmlReaderService;

import com.equitybank.gag.telco_b2c.util.EnabledServicesChecker;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.WebRequest;

import java.util.Map;

@RestController
@RequestMapping(path = "/api/v1/moneygram/inbound")
public class ReceiveValidationRequestController {
    private static final Logger log = LoggerFactory.getLogger(ReceiveValidationRequestController.class);

    private final boolean isInternal;
    private final GlobalExceptionHandler globalExceptionHandler;
    private final EnabledServicesChecker enabledServicesChecker;
    private final XmlProcessingService xmlProcessingService;
    private final XmlReaderService xmlReaderService;

    @Autowired
    public ReceiveValidationRequestController(@Value("${signature.validation.isInternal}") boolean isInternal,
                                              GlobalExceptionHandler globalExceptionHandler,
                                              EnabledServicesChecker enabledServicesChecker,
                                              XmlProcessingService xmlProcessingService,
                                              XmlReaderService xmlReaderService) {
        this.isInternal = isInternal;
        this.globalExceptionHandler = globalExceptionHandler;
        this.enabledServicesChecker = enabledServicesChecker;
        this.xmlProcessingService = xmlProcessingService;
        this.xmlReaderService = xmlReaderService;
    }

    @PostMapping(value = "/receiveValidation",
            consumes = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE},
            produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE})
    public ResponseEntity<?> handleOmniRequest(@RequestBody String requestXml, WebRequest webRequest) throws CustomException {
        String type = "moneygram-receive-validation-request";
        String rrn = "";
        try {
            // Store the type in the WebRequest to be used in the GlobalExceptionHandler class
            webRequest.setAttribute("type", type, WebRequest.SCOPE_REQUEST);

            // Check if service is enabled
            enabledServicesChecker.checkServiceStatus(enabledServicesChecker.isMoneygramInboundEnabled(), type +" service");

            // Get xml tag values in a map
            Map<String, String> xmlTagsMap = xmlReaderService.parseXml(requestXml, type, rrn);
            rrn = xmlTagsMap.get("rrn");

            // Log request on console
            log.info("{}: Received {} Request XML: \n{}", rrn, type, requestXml);

            // Store the rrn in the WebRequest to be used in the GlobalExceptionHandler class
            webRequest.setAttribute("rrn", rrn, WebRequest.SCOPE_REQUEST);

            // Process the request
            String responseXml = xmlProcessingService.processXmlRequests(isInternal, requestXml, xmlTagsMap, rrn, type);

            log.info("{}: Returned {} Success/ Pending Response To Channel: \n{}", rrn, type, responseXml);
            return new ResponseEntity<>(responseXml, getCspHeaders(), HttpStatus.OK);
        } catch (Exception e) {
            log.error("{}: Exception Occurred During Process: {}", rrn, e.getMessage());
            throw new CustomException(e.getMessage());
        }
    }

    private HttpHeaders getCspHeaders() {
        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Security-Policy", "default-src 'none';");
        return headers;
    }
}
