package com.equitybank.gag.orange_money_ms.web.controller;


import com.equitybank.gag.orange_money_ms.dto.channel.response.request;
import com.equitybank.gag.orange_money_ms.exception.CustomException;
import com.equitybank.gag.orange_money_ms.exception.GlobalExceptionHandler;
import com.equitybank.gag.orange_money_ms.service.TransactionService;
import com.equitybank.gag.orange_money_ms.service.XmlMapperService;
import jakarta.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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
public class TransactionRequestController {
    private static final Logger log = LoggerFactory.getLogger(TransactionRequestController.class);

    private final GlobalExceptionHandler globalExceptionHandler;
    private final XmlMapperService xmlMapperService;
    private final TransactionService transactionService;

    @Autowired
    public TransactionRequestController(GlobalExceptionHandler globalExceptionHandler,
                                        XmlMapperService xmlMapperService,
                                        TransactionService transactionService) {
        this.globalExceptionHandler = globalExceptionHandler;
        this.xmlMapperService = xmlMapperService;
        this.transactionService = transactionService;
    }

    @PostMapping(value = "/transaction",
            consumes = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE},
            produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE})
    public ResponseEntity<?> handleOmniRequest(@Valid @RequestBody request channelRequest, BindingResult result, WebRequest webRequest) {
        String rrn = channelRequest.getEazzycash().getRrn();

        // Store the rrn in the WebRequest to be used in the GlobalExceptionHandler class
        webRequest.setAttribute("rrn", rrn, WebRequest.SCOPE_REQUEST);

        try {
            // Log request on console
            log.info("{}: Received Business Service Transaction Request XML: \n{}", rrn, xmlMapperService.mapChannelRequestObjectToXml(channelRequest));

            // Process the request
            String responseXml = transactionService.processRequest(channelRequest, result);

            log.info("{} Returned Success Response To Channel: \n{}", rrn, responseXml);
            return new ResponseEntity<>(responseXml, HttpStatus.OK);
        } catch (CustomException customException) {
            log.error(rrn + " " + customException.getMessage());
            return globalExceptionHandler.handleCustomException(customException, webRequest);
        }
    }
}
