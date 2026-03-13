package com.equitybankgroup.payments.b2c.controller;

import com.equitybankgroup.payments.b2c.dto.vodacom.namecheck.response.ResponseData;
import com.equitybankgroup.payments.b2c.error.CustomException;
import com.equitybankgroup.payments.b2c.service.NamecheckService;
import com.equitybankgroup.payments.b2c.service.ProcessResponseService;
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
@RequestMapping(path = "/api/v1")
public class VodacomNameCheckController<T> {
    private static final Logger log = LoggerFactory.getLogger(VodacomNameCheckController.class);

    private final ProcessResponseService<T> processResponseService;
    private final NamecheckService<T> namecheckService;

    @Autowired
    public VodacomNameCheckController(ProcessResponseService<T> processResponseService,
                                      NamecheckService<T> namecheckService) {
        this.processResponseService = processResponseService;
        this.namecheckService = namecheckService;
    }

    @PostMapping(path = "/namecheck",
            consumes = {MediaType.APPLICATION_XML_VALUE},
            produces = {MediaType.APPLICATION_XML_VALUE})
    public ResponseEntity<?> postTransaction(@RequestBody String nameCheckXmlRequest) {
        log.info("Received Namecheck Request: {}", nameCheckXmlRequest);
        String responseData;
        Map<String, String> xmlMapValues = new HashMap<>();
        try {
            // Read the request xml values
            xmlMapValues = namecheckService.parseXML(nameCheckXmlRequest);

            // Process namecheck request
            responseData = namecheckService.processNamecheckRequest(nameCheckXmlRequest, xmlMapValues);

            // Generate xml response for business service
            String xmlResponse = processResponseService.generateXmlResponse(responseData, nameCheckXmlRequest, xmlMapValues);

            log.info("Success Response To Business Service: " + xmlResponse);
            return new ResponseEntity<>(xmlResponse, HttpStatus.OK);
        } catch (CustomException e) {
            log.error("CustomException Occurred: " + e.getMessage());

            String xmlResponse = composeNameCheckErrorResponse(xmlMapValues);
            log.info("Failure Response To Business Service: \n" + xmlResponse);
            return new ResponseEntity<>(xmlResponse, HttpStatus.OK);
        }
    }

    private String composeNameCheckErrorResponse(Map<String, String> xmlMapValues) {
        // Namecheck for float purchase is breaking. We should return error response code of 01
        String tillNumber = xmlMapValues.get("tillNumber");
        if (tillNumber != null && !tillNumber.isEmpty()) {
            return "<MobileNumberInquireRes>\n" +
                    "    <msgId>" + xmlMapValues.get("msgId") + "</msgId>\n" +
                    "    <channel>" + xmlMapValues.get("channel") + "</channel>\n" +
                    "    <telcom>" + xmlMapValues.get("telcom") + "</telcom>\n" +
                    "    <mobileNumber>" + xmlMapValues.get("mobileNumber") + "</mobileNumber>\n" +
                    "    <responseCode>01</responseCode>\n" +
                    "    <customerNames></customerNames>\n" +
                    "</MobileNumberInquireRes>";
        }
        return "<MobileNumberInquireRes>\n" +
                "    <msgId>" + xmlMapValues.get("msgId") + "</msgId>\n" +
                "    <channel>" + xmlMapValues.get("channel") + "</channel>\n" +
                "    <telcom>" + xmlMapValues.get("telcom") + "</telcom>\n" +
                "    <mobileNumber>" + xmlMapValues.get("mobileNumber") + "</mobileNumber>\n" +
                "    <responseCode>00</responseCode>\n" +
                "    <customerNames>" + xmlMapValues.get("mobileNumber") + "</customerNames>\n" +
                "</MobileNumberInquireRes>";
    }
}
