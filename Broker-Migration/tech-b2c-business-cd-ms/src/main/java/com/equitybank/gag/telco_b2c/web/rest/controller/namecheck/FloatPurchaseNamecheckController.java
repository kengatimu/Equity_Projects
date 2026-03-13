package com.equitybank.gag.telco_b2c.web.rest.controller.namecheck;

import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.service.XmlProcessingService;
import com.equitybank.gag.telco_b2c.service.XmlReaderService;
import com.equitybank.gag.telco_b2c.util.EnabledServicesChecker;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
@RequestMapping(path = "/api/v1")
public class FloatPurchaseNamecheckController {
    private static final Logger log = LoggerFactory.getLogger(FloatPurchaseNamecheckController.class);

    private final boolean isInternal;
    private final EnabledServicesChecker enabledServicesChecker;
    private final XmlProcessingService xmlProcessingService;
    private final XmlReaderService xmlReaderService;

    @Autowired
    public FloatPurchaseNamecheckController(@Value("${signature.validation.isInternal}") boolean isInternal,
                                            EnabledServicesChecker enabledServicesChecker,
                                            XmlProcessingService xmlProcessingService,
                                            XmlReaderService xmlReaderService) {
        this.isInternal = isInternal;
        this.enabledServicesChecker = enabledServicesChecker;
        this.xmlProcessingService = xmlProcessingService;
        this.xmlReaderService = xmlReaderService;
    }

    @PostMapping(value = "/floatpurchase/namecheck",
            consumes = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE},
            produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE})
    public ResponseEntity<?> handleChannelRequest(@RequestBody String requestXml, WebRequest webRequest) throws CustomException {
        String type = "float-purchase-namecheck";
        String rrn = "";
        try {
            // Get xml tag values in a map
            Map<String, String> xmlTagsMap = xmlReaderService.parseXml(requestXml, type, rrn);
            rrn = xmlTagsMap.getOrDefault("msgId", "");

            // Log request on console
            log.info("{}: Received {} Request XML: \n{}", rrn, type, requestXml);

            // Store request details in WebRequest attributes
            setWebRequestAttributes(webRequest, xmlTagsMap, type);

            // Check if service is enabled
            enabledServicesChecker.checkServiceStatus(enabledServicesChecker.isNameCheckFloatPurchaseEnabled(), type +" service");

            // Process the request
            String responseXml = xmlProcessingService.processXmlRequests(isInternal, requestXml, xmlTagsMap, rrn, type);

            log.info("{}: Returned {} Response To Channel: \n{}", rrn, type, responseXml);
            return new ResponseEntity<>(responseXml, HttpStatus.OK);
        } catch (Exception e) {
            log.error("{}: Exception Occurred During Process: {}", rrn, e.getMessage());
            throw new CustomException(e.getMessage());
        }
    }

    // Helper method to set WebRequest attributes
    private void setWebRequestAttributes(WebRequest webRequest, Map<String, String> xmlTagsMap, String type) {
        webRequest.setAttribute("rrn", xmlTagsMap.get("msgId"), WebRequest.SCOPE_REQUEST);
        webRequest.setAttribute("telcom", xmlTagsMap.get("telcom"), WebRequest.SCOPE_REQUEST);
        webRequest.setAttribute("channel", xmlTagsMap.get("channel"), WebRequest.SCOPE_REQUEST);
        webRequest.setAttribute("mobileNumber", xmlTagsMap.get("mobileNumber"), WebRequest.SCOPE_REQUEST);
        webRequest.setAttribute("type", type, WebRequest.SCOPE_REQUEST);
    }
}
