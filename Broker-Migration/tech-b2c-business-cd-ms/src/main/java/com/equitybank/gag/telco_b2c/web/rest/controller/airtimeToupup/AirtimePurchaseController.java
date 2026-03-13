package com.equitybank.gag.telco_b2c.web.rest.controller.airtimeToupup;

import com.equitybank.gag.telco_b2c.util.EnabledServicesChecker;
import com.equitybank.gag.telco_b2c.dto.airtime.request.Envelope;
import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.exception.GlobalExceptionHandler;
import com.equitybank.gag.telco_b2c.service.DtoProcessingService;
import com.equitybank.gag.telco_b2c.service.XmlJsonMapperService;
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

@RestController
@RequestMapping(path = "/api/v1")
public class AirtimePurchaseController {
    private static final Logger log = LoggerFactory.getLogger(AirtimePurchaseController.class);

    private final boolean isInternal;
    private final EnabledServicesChecker enabledServicesChecker;
    private final GlobalExceptionHandler globalExceptionHandler;
    private final XmlJsonMapperService xmlJsonMapperService;
    private final DtoProcessingService dtoProcessingService;

    @Autowired
    public AirtimePurchaseController(@Value("${signature.validation.isInternal}") boolean isInternal,
                                     EnabledServicesChecker enabledServicesChecker,
                                     GlobalExceptionHandler globalExceptionHandler,
                                     XmlJsonMapperService xmlJsonMapperService,
                                     DtoProcessingService dtoProcessingService) {
        this.isInternal = isInternal;
        this.enabledServicesChecker = enabledServicesChecker;
        this.globalExceptionHandler = globalExceptionHandler;
        this.xmlJsonMapperService = xmlJsonMapperService;
        this.dtoProcessingService = dtoProcessingService;
    }

    @PostMapping(value = "/airtimetopup", consumes = MediaType.APPLICATION_XML_VALUE, produces = MediaType.APPLICATION_XML_VALUE)
    public ResponseEntity<?> handleAirtimeTopUpRequest(@Valid @RequestBody Envelope airtimeRequest, BindingResult result, WebRequest webRequest) throws CustomException {
        String rrn = airtimeRequest.getBody().getTopUp().getRrn();
        String type = "airtime";

        // Store the rrn and type in the WebRequest to be used in the GlobalExceptionHandler class
        webRequest.setAttribute("rrn", rrn, WebRequest.SCOPE_REQUEST);
        webRequest.setAttribute("type", type, WebRequest.SCOPE_REQUEST);

        try {
            // Check if service is enabled
            enabledServicesChecker.checkServiceStatus(enabledServicesChecker.isAirtimeTopupXmlEnabled(), "Airtime Topup Service");

            // Log request on console
            log.info("Received Channel Airtime Topup Request XML: \n{}", xmlJsonMapperService.airtimeTopUpRequestToXml(airtimeRequest));

            // Process the request
            String responseXml = dtoProcessingService.processChannelRequest(isInternal, new request(), airtimeRequest, result, type);

            log.info("{}: Returned Success Airtime Top Up Response To Channel: \n{}", rrn, responseXml);
            return new ResponseEntity<>(responseXml, HttpStatus.OK);
        } catch (Exception e) {
            log.error("{}: Exception Occurred During Process: {}", rrn, e.getMessage());
            throw new CustomException(e.getMessage());
        }
    }
}
