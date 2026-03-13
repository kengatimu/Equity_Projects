package com.equitybank.gag.mtn_money_ms.web.controller.status;

import com.equitybank.gag.mtn_money_ms.exception.CustomException;
import com.equitybank.gag.mtn_money_ms.exception.GlobalExceptionHandler;
import com.equitybank.gag.mtn_money_ms.service.ProcessRequestService;
import com.equitybank.gag.mtn_money_ms.service.XmlReaderService;
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

import java.util.Map;

@RestController
@RequestMapping(path = "/api/v1/")
public class FloatPurchaseStatusCheckController {
    private static final Logger log = LoggerFactory.getLogger(FloatPurchaseStatusCheckController.class);

    private final XmlReaderService xmlReaderService;
    private final ProcessRequestService processRequestService;
    private final GlobalExceptionHandler globalExceptionHandler;

    @Autowired
    public FloatPurchaseStatusCheckController(XmlReaderService xmlReaderService,
                                              GlobalExceptionHandler globalExceptionHandler,
                                              ProcessRequestService processRequestService) {
        this.xmlReaderService = xmlReaderService;
        this.globalExceptionHandler = globalExceptionHandler;
        this.processRequestService = processRequestService;
    }


    @PostMapping(value = "/buyfloat/status",
            consumes = {MediaType.APPLICATION_XML_VALUE},
            produces = {MediaType.APPLICATION_XML_VALUE})
    public ResponseEntity<?> processFloatPurchaseStatusCheck(@RequestBody String channelXmlRequest, BindingResult result, WebRequest webRequest) {
        String type = "floatPurchase-status";
        String rrn = "";
        try {
            // Get xml tag values in a map
            Map<String, String> xmlTagsMap = xmlReaderService.parseXmlString(channelXmlRequest, "status-check-request");
            rrn = xmlTagsMap.getOrDefault("rrn", "");

            // Log request on console
            log.info("{}: Received {} Request XML: \n{}", rrn, type, channelXmlRequest);

            // Store request details in WebRequest attributes
            setWebRequestAttributes(webRequest, xmlTagsMap, type);

            // Process the request
            String responseXml = processRequestService.processFloatPurchaseStatusRequest(channelXmlRequest, xmlTagsMap, rrn, type);

            log.info("{}: Returned {} Response To Channel: \n{}", rrn, type, responseXml);
            return new ResponseEntity<>(responseXml, HttpStatus.OK);
        } catch (CustomException customException) {
            log.error(rrn + ": " + customException.getMessage());
            return globalExceptionHandler.handleCustomException(customException, webRequest);
        }
    }

    // Helper method to set WebRequest attributes
    private void setWebRequestAttributes(WebRequest webRequest, Map<String, String> xmlTagsMap, String type) {
        webRequest.setAttribute("rrn", xmlTagsMap.get("rrn"), WebRequest.SCOPE_REQUEST);
        webRequest.setAttribute("type", type, WebRequest.SCOPE_REQUEST);
    }
}
