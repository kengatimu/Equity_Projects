package com.equitybank.gag.telco_b2c.web.rest.controller.statusCheck;

import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.exception.GlobalExceptionHandler;
import com.equitybank.gag.telco_b2c.service.XmlProcessingService;
import com.equitybank.gag.telco_b2c.service.XmlReaderService;
import jakarta.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.WebRequest;

import java.security.SignatureException;
import java.util.Map;

@RestController
@RequestMapping(path = "/api/v1")
public class TransactionStatusCheckController {
    private static final Logger log = LoggerFactory.getLogger(TransactionStatusCheckController.class);

    private final boolean isInternal;
    private final XmlReaderService xmlReaderService;
    private final XmlProcessingService xmlProcessingService;
    private final GlobalExceptionHandler globalExceptionHandler;

    @Autowired
    public TransactionStatusCheckController(@Value("${signature.validation.isInternal}") boolean isInternal,
                                            XmlReaderService xmlReaderService,
                                            XmlProcessingService xmlProcessingService,
                                            GlobalExceptionHandler globalExceptionHandler) {
        this.isInternal = isInternal;
        this.xmlReaderService = xmlReaderService;
        this.xmlProcessingService = xmlProcessingService;
        this.globalExceptionHandler = globalExceptionHandler;
    }

    @PostMapping(value = "/banktowallet/status",
            consumes = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE, MediaType.TEXT_XML_VALUE},
            produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE, MediaType.TEXT_XML_VALUE})
    public ResponseEntity<?> handleBankToWalletStatusCheckRequest(@Valid @RequestBody String statusCheckXmlRequest, BindingResult result, WebRequest webRequest) throws CustomException {
        String type = "status-check-banktowallet";
        String rrn = "";
        try {
            // Get xml tag values in a map
            Map<String, String> xmlTagsMap = xmlReaderService.parseXml(statusCheckXmlRequest, type, rrn);
            rrn = xmlTagsMap.getOrDefault("rrn", "");

            // Log request on console
            log.info("{}: Received {} Request XML: \n{}", rrn, type, statusCheckXmlRequest);

            // Store request details in WebRequest attributes
            setWebRequestAttributes(webRequest, xmlTagsMap, type);

            // Process the request
            String responseXml = xmlProcessingService.processXmlRequests(isInternal, statusCheckXmlRequest, xmlTagsMap, rrn, type);

            log.info("{}: Returned {} Response To Channel: \n{}", rrn, type, responseXml);
            return new ResponseEntity<>(responseXml, HttpStatus.OK);
        } catch (Exception e) {
            log.error("{}: Exception Occurred During Process: {}", rrn, e.getMessage());
            throw new CustomException(e.getMessage());
        }
    }

    @PostMapping(value = "/airtime/status",
            consumes = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE, MediaType.TEXT_XML_VALUE},
            produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE, MediaType.TEXT_XML_VALUE})
    public ResponseEntity<?> handleAirtimeStatusCheckRequest(@Valid @RequestBody String statusCheckXmlRequest, BindingResult result, WebRequest webRequest) {
        String type = "status-check-airtime";
        String rrn = "";
        try {
            // Get xml tag values in a map
            Map<String, String> xmlTagsMap = xmlReaderService.parseXml(statusCheckXmlRequest, type, rrn);
            rrn = xmlTagsMap.getOrDefault("rrn", "");

            // Log request on console
            log.info("{}: Received {} Request XML: \n{}", rrn, type, statusCheckXmlRequest);

            // Store request details in WebRequest attributes
            setWebRequestAttributes(webRequest, xmlTagsMap, type);

            // Process the request
            String responseXml = xmlProcessingService.processXmlRequests(isInternal, statusCheckXmlRequest, xmlTagsMap, rrn, type);

            log.info("{}: Returned {} Response To Channel: \n{}", rrn, type, responseXml);
            return new ResponseEntity<>(responseXml, HttpStatus.OK);
        } catch (CustomException customException) {
            log.error(rrn + ": " + customException.getMessage());
            return globalExceptionHandler.handleCustomException(customException, webRequest);
        } catch(SignatureException ex) {
            log.error(rrn + ": " + ex.getMessage());
            return globalExceptionHandler.handleCustomException(new CustomException("401|Signature validation failed!"), webRequest);
        }
    }

    @PostMapping(value = "/floatpurchase/status",
            consumes = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE, MediaType.TEXT_XML_VALUE},
            produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE, MediaType.TEXT_XML_VALUE})
    public ResponseEntity<?> handleFloatPurchaseStatusCheckRequest(@Valid @RequestBody String statusCheckXmlRequest, BindingResult result, WebRequest webRequest) {
        String type = "status-check-floatpurchase";
        String rrn = "";
        try {
            // Get xml tag values in a map
            Map<String, String> xmlTagsMap = xmlReaderService.parseXml(statusCheckXmlRequest, type, rrn);
            rrn = xmlTagsMap.getOrDefault("rrn", "");

            // Log request on console
            log.info("{}: Received {} Request XML: \n{}", rrn, type, statusCheckXmlRequest);

            // Store request details in WebRequest attributes
            setWebRequestAttributes(webRequest, xmlTagsMap, type);

            // Process the request
            String responseXml = xmlProcessingService.processXmlRequests(isInternal, statusCheckXmlRequest, xmlTagsMap, rrn, type);

            log.info("{}: Returned {} Response To Channel: \n{}", rrn, type, responseXml);
            return new ResponseEntity<>(responseXml, HttpStatus.OK);
        } catch (CustomException customException) {
            log.error(rrn + ": " + customException.getMessage());
            return globalExceptionHandler.handleCustomException(customException, webRequest);
        } catch(SignatureException ex) {
            log.error(rrn + ": " + ex.getMessage());
            return globalExceptionHandler.handleCustomException(new CustomException("401|Signature validation failed!"), webRequest);
        }
    }

    // Helper method to set WebRequest attributes
    private void setWebRequestAttributes(WebRequest webRequest, Map<String, String> xmlTagsMap, String type) {
        webRequest.setAttribute("rrn", xmlTagsMap.get("rrn"), WebRequest.SCOPE_REQUEST);
        webRequest.setAttribute("type", type, WebRequest.SCOPE_REQUEST);
    }
}
