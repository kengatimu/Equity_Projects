package com.equitybank.gag.telco_b2c.web.rest.controller.floatPurchase;

import com.equitybank.gag.telco_b2c.dto.airtime.request.Envelope;
import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.service.DtoProcessingService;
import com.equitybank.gag.telco_b2c.service.PayloadService;
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
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.WebRequest;

import java.security.SecureRandom;
import java.util.Map;

import static com.equitybank.gag.telco_b2c.config.ApplicationConstants.DEFAULT_FIN_CHANNEL;

@RestController
@RequestMapping(path = "/api/v1/fin")
public class FinacleFloatPurchaseUnifiedController {
    private static final Logger log = LoggerFactory.getLogger(FinacleFloatPurchaseUnifiedController.class);

    private final boolean isInternal;
    private final EnabledServicesChecker enabledServicesChecker;
    private final XmlProcessingService xmlProcessingService;
    private final DtoProcessingService dtoProcessingService;
    private final XmlReaderService xmlReaderService;
    private final PayloadService payloadService;

    @Autowired
    public FinacleFloatPurchaseUnifiedController(@Value("${signature.validation.isInternal}") boolean isInternal,
                                                 EnabledServicesChecker enabledServicesChecker,
                                                 XmlProcessingService xmlProcessingService,
                                                 DtoProcessingService dtoProcessingService,
                                                 XmlReaderService xmlReaderService,
                                                 PayloadService payloadService) {
        this.isInternal = isInternal;
        this.enabledServicesChecker = enabledServicesChecker;
        this.xmlProcessingService = xmlProcessingService;
        this.dtoProcessingService = dtoProcessingService;
        this.xmlReaderService = xmlReaderService;
        this.payloadService = payloadService;
    }

    @PostMapping(value = "/cashallocation")
    public ResponseEntity<String> handleFinacleRequest(@RequestBody String finRequestXml, BindingResult result, WebRequest webRequest) throws CustomException {
        String rrn = "";
        try {
            // Detect type based on root tag
            boolean isNamecheck = finRequestXml.contains("authRequest");
            String type = isNamecheck ? "float-purchase-namecheck" : "floatPurchase";

            if (isNamecheck) {
                log.info("Received Finacle Float Purchase Namecheck Request: {}", finRequestXml);

                // Check if service is enabled
                enabledServicesChecker.checkServiceStatus(enabledServicesChecker.isNameCheckFloatPurchaseEnabled(), type + " service");

                // Get finacle request xml tag values in a map
                Map<String, String> finXmlTagsMap = xmlReaderService.parseXml(finRequestXml, type, rrn);

                // Finacle is not supplying rrn on namecheck, generate one
                rrn = generateRrn();
                finXmlTagsMap.put("payRef", rrn);

                // Store request details in WebRequest attributes
                setWebRequestAttributes(webRequest, finXmlTagsMap, type);

                // Compose valid channel namecheck request from the xml map details
                String requestXml = payloadService.finReqToFloatPurchaseNamecheckReq(finXmlTagsMap);
                log.info("{}: Composed {} Request from the received Finacle Request: \n{}", rrn, type, requestXml);

                // Get composed channel request xml tag values in a map
                Map<String, String> xmlTagsMap = xmlReaderService.parseXml(requestXml, type, rrn);

                // Process the request
                String responseXml = xmlProcessingService.processXmlRequests(isInternal, requestXml, xmlTagsMap, rrn, type);

                // Generate finacle specific response
                String finResponseXml = payloadService.generateFinNamecheckResponse(responseXml, finXmlTagsMap);

                log.info("{}: Returned {} Response To Finacle: \n{}", rrn, type, finResponseXml);
                return new ResponseEntity<>(finResponseXml, HttpStatus.OK);

            } else {
                log.info("Received Finacle Float Purchase Request: {}", finRequestXml);

                // Check if service is enabled
                enabledServicesChecker.checkServiceStatus(enabledServicesChecker.isFloatPurchaseXmlEnabled(), "Float Purchase Service");

                // Get finacle request xml tag values in a map
                Map<String, String> finFloatXmlTagsMap = xmlReaderService.parseXml(finRequestXml, type, rrn);
                rrn = finFloatXmlTagsMap.get("payRef");

                // Store the type in the WebRequest to be used in the GlobalExceptionHandler class
                setWebRequestAttributes(webRequest, finFloatXmlTagsMap, type);

                // Compose valid channel request from the xml map details
                request channelRequest = payloadService.finReqToFloatPurchaseTranReq(finFloatXmlTagsMap);

                // Process the request
                String responseXml = dtoProcessingService.processChannelRequest(isInternal, channelRequest, new Envelope(), result, type);

                // Generate finacle specific response
                String finResponseXml = payloadService.generateFinFloatPurchaseResponse(responseXml, finFloatXmlTagsMap);

                log.info("{}: Returned {} Response To Finacle: \n{}", rrn, type, finResponseXml);
                return new ResponseEntity<>(finResponseXml, HttpStatus.OK);
            }
        } catch (Exception e) {
            log.error("{}: Exception Occurred During Processing: {}", rrn, e.getMessage());
            throw new CustomException(e.getMessage());
        }
    }

    private String generateRrn() {
        SecureRandom random = new SecureRandom();
        StringBuilder sb = new StringBuilder(12);
        for (int i = 0; i < 12; i++) {
            sb.append(random.nextInt(10));
        }
        return sb.toString();
    }

    private void setWebRequestAttributes(WebRequest webRequest, Map<String, String> xmlTagsMap, String type) {
        webRequest.setAttribute("rrn", xmlTagsMap.get("payRef"), WebRequest.SCOPE_REQUEST);
        webRequest.setAttribute("telcom", "", WebRequest.SCOPE_REQUEST);
        webRequest.setAttribute("channel", DEFAULT_FIN_CHANNEL, WebRequest.SCOPE_REQUEST);
        webRequest.setAttribute("mobileNumber", xmlTagsMap.get("dealerCode"), WebRequest.SCOPE_REQUEST);
        webRequest.setAttribute("type", type, WebRequest.SCOPE_REQUEST);
        webRequest.setAttribute("finXmlTagsMap", xmlTagsMap, WebRequest.SCOPE_REQUEST);
    }
}

