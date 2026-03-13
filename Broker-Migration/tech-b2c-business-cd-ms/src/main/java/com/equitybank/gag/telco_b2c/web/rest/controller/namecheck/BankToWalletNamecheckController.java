package com.equitybank.gag.telco_b2c.web.rest.controller.namecheck;

import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.exception.GlobalExceptionHandler;
import com.equitybank.gag.telco_b2c.service.XmlProcessingService;
import com.equitybank.gag.telco_b2c.service.XmlReaderService;

import java.util.HashMap;

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
public class BankToWalletNamecheckController {
    private static final Logger log = LoggerFactory.getLogger(BankToWalletNamecheckController.class);

    private final boolean isInternal;
    private final GlobalExceptionHandler globalExceptionHandler;
    private final EnabledServicesChecker enabledServicesChecker;
    private final XmlProcessingService xmlProcessingService;
    private final XmlReaderService xmlReaderService;

    @Autowired
    public BankToWalletNamecheckController(@Value("${signature.validation.isInternal}") boolean isInternal,
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

    @PostMapping(value = "/banktowallet/namecheck",
            consumes = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE, MediaType.TEXT_XML_VALUE},
            produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE, MediaType.TEXT_XML_VALUE})
    public ResponseEntity<?> handleChannelRequest(@RequestBody String requestXml, WebRequest webRequest) throws CustomException {
        String type = "bank-to-wallet-namecheck";
        String rrn = "";
        Map<String, String> xmlTagsMap = new HashMap<>();
        try {
            // Check if service is enabled
            enabledServicesChecker.checkServiceStatus(enabledServicesChecker.isNameCheckBankToWalletEnabled(), type +" service");

            // Get xml tag values in a map
            xmlTagsMap = xmlReaderService.parseXml(requestXml, type, rrn);
            rrn = xmlTagsMap.getOrDefault("msgId", "");

            // Log request on console
            log.info("{}: Received {} Request XML: \n{}", rrn, type, requestXml);

            // Store request details in WebRequest attributes
            setWebRequestAttributes(webRequest, xmlTagsMap, type);

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
    
    private String getErrorResponse(Map<String, String> xmlTagsMap, String responseCode, String responseMessage)
    {
        return "<MobileNumberInquireRes>\n" +
"    <msgId>" + xmlTagsMap.get("msgId") + "</msgId>\n" +
"    <channel>" + xmlTagsMap.get("channel") + "</channel>\n" +
"    <telcom>" + xmlTagsMap.get("telcom") + "</telcom>\n" +
"    <mobileNumber>" + xmlTagsMap.get("mobileNumber") + "</mobileNumber>\n" +
"    <responseCode>" + responseCode + "</responseCode>\n" +
"    <responseMessage>" + responseMessage + "</responseMessage>\n" +
"</MobileNumberInquireRes>";
    }
}
