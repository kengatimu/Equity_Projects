package com.equitybank.gag.mtn_money_ms.web.controller.namecheck;

import com.equitybank.gag.mtn_money_ms.exception.CustomException;
import com.equitybank.gag.mtn_money_ms.service.ProcessRequestService;
import com.equitybank.gag.mtn_money_ms.service.PayloadService;
import com.equitybank.gag.mtn_money_ms.service.XmlReaderService;
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

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping(path = "/api/v1/")
public class FloatPurchaseNamecheckController {
    private static final Logger log = LoggerFactory.getLogger(FloatPurchaseNamecheckController.class);

    private final PayloadService payloadService;
    private final XmlReaderService xmlReaderService;
    private final ProcessRequestService processRequestService;

    @Autowired
    public FloatPurchaseNamecheckController(PayloadService payloadService,
                                            XmlReaderService xmlReaderService, ProcessRequestService processRequestService) {
        this.payloadService = payloadService;
        this.xmlReaderService = xmlReaderService;
        this.processRequestService = processRequestService;
    }

    @PostMapping(path = "/floatpurchase/namecheck",
            consumes = {MediaType.APPLICATION_XML_VALUE},
            produces = {MediaType.APPLICATION_XML_VALUE})
    public ResponseEntity<?> processNamecheckRequest(@RequestBody String nameCheckXmlRequest) {
        log.info("Received Float Purchase Namecheck Request: {}", nameCheckXmlRequest);
        Map<String, String> xmlMapValues = new HashMap<>();
        String type = "float-purchase-namecheck";
        try {
            // Read the request xml values
            xmlMapValues = xmlReaderService.parseXmlString(nameCheckXmlRequest, "mobile-number-inquire-request");

            // Process namecheck request
            String telcoResponseXml = processRequestService.processNamecheckRequest(nameCheckXmlRequest, xmlMapValues, type);

            log.info("Success Response To Business Service: " + telcoResponseXml);
            return new ResponseEntity<>(telcoResponseXml, HttpStatus.OK);
        } catch (CustomException e) {
            log.error("CustomException Occurred: " + e.getMessage());

            String xmlResponse = payloadService.composeNameCheckErrorResponse(xmlMapValues);
            log.info("Failure Response To Business Service: \n" + xmlResponse);
            return new ResponseEntity<>(xmlResponse, HttpStatus.OK);
        }
    }
}
