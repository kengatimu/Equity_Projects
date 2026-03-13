package com.equitybank.gag.telco_b2c.web.rest.controller;

import com.equitybank.gag.telco_b2c.dto.airtime.request.Envelope;
import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.exception.GlobalExceptionHandler;
import com.equitybank.gag.telco_b2c.service.SignatureGenerationService;
import com.equitybank.gag.telco_b2c.web.rest.controller.b2c.BankToWalletXmlController;
import jakarta.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.WebRequest;

@RestController
@RequestMapping(path = "/api/omnichannel/generate/signature")
public class SignatureController {
    private static final Logger log = LoggerFactory.getLogger(BankToWalletXmlController.class);

    private final SignatureGenerationService signatureGenerationService;
    private final GlobalExceptionHandler globalExceptionHandler;

    @Autowired
    public SignatureController(SignatureGenerationService signatureGenerationService, GlobalExceptionHandler globalExceptionHandler) {
        this.signatureGenerationService = signatureGenerationService;
        this.globalExceptionHandler = globalExceptionHandler;
    }
    @PostMapping(value = "/transaction",
            consumes = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE},
            produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE})
    public ResponseEntity<?> generateTransactionSignature(@Valid @RequestBody request req, WebRequest webRequest){
        try {
            // Generate Signature
            String signature = signatureGenerationService.generateTransactionSignature(req);
            log.info("Generated Signature: {}", signature);
            return new ResponseEntity<>(signature, HttpStatus.OK);
        } catch (CustomException e) {
            log.error(e.getMessage());
            return globalExceptionHandler.handleCustomException(e, webRequest);
        }
    }

    @PostMapping(value = "/airtime",
            consumes = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE},
            produces = {MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE})
    public ResponseEntity<?> generateAirtimeSignature(@Valid @RequestBody Envelope airtimeRequest, WebRequest webRequest){
        try {
            // Generate Signature
            String signature = signatureGenerationService.generateAirtimeSignature(airtimeRequest);
            log.info("Generated Signature: {}", signature);
            return new ResponseEntity<>(signature, HttpStatus.OK);
        } catch (CustomException e) {
            log.error(e.getMessage());
            return globalExceptionHandler.handleCustomException(e, webRequest);
        }
    }
}
