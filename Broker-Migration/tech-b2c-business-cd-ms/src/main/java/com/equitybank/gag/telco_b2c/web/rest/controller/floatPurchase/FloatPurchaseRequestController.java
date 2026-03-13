package com.equitybank.gag.telco_b2c.web.rest.controller.floatPurchase;

import com.equitybank.gag.telco_b2c.dto.airtime.request.Envelope;
import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.exception.GlobalExceptionHandler;
import com.equitybank.gag.telco_b2c.service.DtoProcessingService;
import com.equitybank.gag.telco_b2c.service.XmlJsonMapperService;
import com.equitybank.gag.telco_b2c.util.EnabledServicesChecker;
import com.google.gson.Gson;
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
public class FloatPurchaseRequestController {
    private static final Logger log = LoggerFactory.getLogger(FloatPurchaseRequestController.class);

    private final boolean isInternal;
    private final GlobalExceptionHandler globalExceptionHandler;
    private final EnabledServicesChecker enabledServicesChecker;
    private final XmlJsonMapperService xmlJsonMapperService;
    private final DtoProcessingService dtoProcessingService;
    private final Gson gson;

    @Autowired
    public FloatPurchaseRequestController(@Value("${signature.validation.isInternal}") boolean isInternal,
                                          GlobalExceptionHandler globalExceptionHandler,
                                          EnabledServicesChecker enabledServicesChecker,
                                          XmlJsonMapperService xmlJsonMapperService,
                                          DtoProcessingService dtoProcessingService,
                                          Gson gson) {
        this.isInternal = isInternal;
        this.globalExceptionHandler = globalExceptionHandler;
        this.enabledServicesChecker = enabledServicesChecker;
        this.xmlJsonMapperService = xmlJsonMapperService;
        this.dtoProcessingService = dtoProcessingService;
        this.gson = gson;
    }

    @PostMapping(value = "/cashallocation",
            consumes = {MediaType.APPLICATION_XML_VALUE},
            produces = {MediaType.APPLICATION_XML_VALUE})
    public ResponseEntity<?> handleOmniRequest(@Valid @RequestBody request channelRequest, BindingResult result, WebRequest webRequest) throws CustomException {
        log.info("Received Float Purchase Request From The Channel: \n{}", gson.toJson(channelRequest));

        String rrn = channelRequest.getEazzycash().getRrn();
        String type = "floatPurchase";

        // Store the rrn and type in the WebRequest to be used in the GlobalExceptionHandler class
        webRequest.setAttribute("rrn", rrn, WebRequest.SCOPE_REQUEST);
        webRequest.setAttribute("type", type, WebRequest.SCOPE_REQUEST);

        try {
            // Check if service is enabled
            enabledServicesChecker.checkServiceStatus(enabledServicesChecker.isFloatPurchaseXmlEnabled(), "Float Purchase Service");

            // Process the request
            String responseXml = dtoProcessingService.processChannelRequest(isInternal, channelRequest, new Envelope(), result, type);

            log.info("{}: Returned {} Response To Channel: \n{}", rrn, type, responseXml);
            return new ResponseEntity<>(responseXml, HttpStatus.OK);
        } catch (Exception e) {
            log.error("{}: Exception Occurred During Process: {}", rrn, e.getMessage());
            throw new CustomException(e.getMessage());
        }
    }
}
