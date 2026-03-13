package com.equitybank.gag.telco_b2c.web.rest.controller.b2c;

import com.equitybank.gag.telco_b2c.dto.airtime.request.Envelope;
import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.exception.GlobalExceptionHandler;
import com.equitybank.gag.telco_b2c.service.PayloadService;
import com.equitybank.gag.telco_b2c.service.DtoProcessingService;
import com.equitybank.gag.telco_b2c.service.XmlJsonMapperService;
import com.equitybank.gag.telco_b2c.util.EnabledServicesChecker;
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
public class BankToWalletXmlController {
    private static final Logger log = LoggerFactory.getLogger(BankToWalletXmlController.class);

    private final boolean isInternal;
    private final EnabledServicesChecker enabledServicesChecker;
    private final GlobalExceptionHandler globalExceptionHandler;
    private final XmlJsonMapperService xmlJsonMapperService;
    private final DtoProcessingService dtoProcessingService;
    private final PayloadService payloadService;

    @Autowired
    public BankToWalletXmlController(@Value("${signature.validation.isInternal}") boolean isInternal,
                                     EnabledServicesChecker enabledServicesChecker,
                                     GlobalExceptionHandler globalExceptionHandler,
                                     XmlJsonMapperService xmlJsonMapperService,
                                     DtoProcessingService dtoProcessingService,
                                     PayloadService payloadService) {
        this.isInternal = isInternal;
        this.enabledServicesChecker = enabledServicesChecker;
        this.globalExceptionHandler = globalExceptionHandler;
        this.xmlJsonMapperService = xmlJsonMapperService;
        this.dtoProcessingService = dtoProcessingService;
        this.payloadService = payloadService;
    }

    @PostMapping(value = "/banktowallet",
            consumes = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE, MediaType.TEXT_XML_VALUE},
            produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE, MediaType.TEXT_XML_VALUE})
    public ResponseEntity<?> handleOmniRequest(@Valid @RequestBody request channelRequest, BindingResult result, WebRequest webRequest) throws CustomException {
        String type = "transaction";
        String rrn = channelRequest.getEazzycash().getRrn();
        String telco = channelRequest.getEazzycash().getTelco();

        // Store the rrn and type in the WebRequest to be used in the GlobalExceptionHandler class
        webRequest.setAttribute("rrn", rrn, WebRequest.SCOPE_REQUEST);
        webRequest.setAttribute("type", type, WebRequest.SCOPE_REQUEST);

        try {
            // Check if service is enabled
            enabledServicesChecker.checkServiceStatus(enabledServicesChecker.isBankToWalletXmlEnabled(), "Bank To Wallet Service");

            // Log request on console
            log.info("Received Channel Transaction Request XML: \n{}", xmlJsonMapperService.b2cTransactionRequestToXml(channelRequest));

            // Process the request
            String responseXml = dtoProcessingService.processChannelRequest(isInternal, channelRequest, new Envelope(), result, type);

            log.info("{}: Returned Bank-to-Wallet Response To Channel: \n{}", rrn, responseXml);
            return new ResponseEntity<>(responseXml, HttpStatus.OK);
        } catch (Exception e) {
            log.error("{}: Exception Occurred During Process: {}", rrn, e.getMessage());
//            e.printStackTrace(System.out);
            throw new CustomException(e.getMessage());
        }
    }
}


