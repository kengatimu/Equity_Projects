/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybank.gag.telco_b2c.web.rest.controller.airtimeToupup;

import com.equitybank.gag.telco_b2c.dto.airtime.request.Body;
import com.equitybank.gag.telco_b2c.dto.airtime.request.Envelope;
import com.equitybank.gag.telco_b2c.dto.airtime.request.TopUp;
import com.equitybank.gag.telco_b2c.dto.json.AirtimeRequest;
import com.equitybank.gag.telco_b2c.dto.json.StatusRequest;
import com.equitybank.gag.telco_b2c.dto.json.StatusResponse;
import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.entity.StatusDetails;
import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.enums.TransactionStatus;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.repository.TransactionDetailsRepository;
import com.equitybank.gag.telco_b2c.service.DtoProcessingService;
import com.equitybank.gag.telco_b2c.service.XmlReaderService;
import com.equitybank.gag.telco_b2c.util.EnabledServicesChecker;
import com.equitybank.gag.telco_b2c.web.rest.controller.util.MiscUtil;
import com.equitybank.gag.telco_b2c.web.rest.controller.util.TelcoResolver;
import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import jakarta.validation.Valid;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.WebRequest;

import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.*;

/**
 * @author ronaldcheruiyot
 */
@RestController
public class AirtimeJsonController {
    private static final Logger log = LoggerFactory.getLogger(AirtimePurchaseController.class);

    private final boolean isInternal;
    private final TelcoResolver telcoResolver;
    private final DtoProcessingService dtoProcessingService;
    private final XmlReaderService xmlReaderService;
    private final EnabledServicesChecker enabledServicesChecker;
    private final TransactionDetailsRepository transactionDetailsRepository;

    @Autowired
    public AirtimeJsonController(@Value("${signature.validation.isInternal}") boolean isInternal,
                                 TelcoResolver telcoResolver,
                                 DtoProcessingService dtoProcessingService,
                                 XmlReaderService xmlReaderService,
                                 EnabledServicesChecker enabledServicesChecker,
                                 TransactionDetailsRepository transactionDetailsRepository) {
        this.isInternal = isInternal;
        this.telcoResolver = telcoResolver;
        this.dtoProcessingService = dtoProcessingService;
        this.xmlReaderService = xmlReaderService;
        this.enabledServicesChecker = enabledServicesChecker;
        this.transactionDetailsRepository = transactionDetailsRepository;
    }

    @PostMapping(value = "/api/airtimestatus", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<?> handleAirtimeStatusRequest(@Valid @RequestBody StatusRequest statusRequest, BindingResult result, WebRequest webRequest) {
        String type = "airtime";
        StatusResponse response = new StatusResponse();

        try {
            // Check if service is enabled
            enabledServicesChecker.checkServiceStatus(enabledServicesChecker.isAirtimeStatusEnabled(), "Airtime Check Status Service");

            log.info("Received Channel Transaction Request JSON: \n{}", (new Gson()).toJson(statusRequest));
            response.setOriginatingTransactionID(statusRequest.getOriginatingTransactionID());
            Optional<TransactionDetails> tranDetailsOpt = transactionDetailsRepository.findByRrnAndRequestType(statusRequest.getOriginatingTransactionID(), type);

            if (tranDetailsOpt.isEmpty()) {
                response.setStatus("NOT_FOUND");
                return new ResponseEntity<>(response, HttpStatus.OK);
            }

            TransactionDetails tranDetails = tranDetailsOpt.get();
            StatusDetails details = tranDetails.getStatusDetails();

            if (details == null) {
                response.setStatus("NOT_FOUND");
                return new ResponseEntity<>(response, HttpStatus.OK);
            }
            response.setTransactionID(details.getTranId());
            String status = details.getStatus();

            if (status.equalsIgnoreCase(TransactionStatus.OK.name())
                    || status.equalsIgnoreCase(TransactionStatus.INITIALIZED.name())
                    || status.equalsIgnoreCase(TransactionStatus.PENDING.name())
                    || status.equalsIgnoreCase(TransactionStatus.TIMEOUT.name())) {
                response.setStatus("200");
                response.setTransactionID(details.getTranId());
                response.setTransactionStatus("0");
                return new ResponseEntity<>(response, HttpStatus.OK);
            }

            response.setStatus(String.valueOf(DEFAULT_HTTP_STATUS_CODE));
            response.setTransactionStatus(details.getStatusCode());
            log.info("Returned Failed Response To Channel: \n{}", (new Gson()).toJson(response));
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (CustomException | JsonSyntaxException e) {
            log.error("Exception Occurred: " + e.getMessage());
        }
        response.setStatus("FAILED");
        return new ResponseEntity<>(response, HttpStatus.OK);

    }

    @PostMapping(value = "/api/airtimetopup", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<?> handleAirtimeRequest(@Valid @RequestBody AirtimeRequest airtimeRequest, BindingResult result, WebRequest webRequest) throws CustomException {
        String type = "airtime";
        String version = "json";
        String rrn = airtimeRequest.getTransactionReference();

        // Store the rrn and type in the WebRequest to be used in the GlobalExceptionHandler class
        webRequest.setAttribute("rrn", rrn, WebRequest.SCOPE_REQUEST);
        webRequest.setAttribute("type", type, WebRequest.SCOPE_REQUEST);
        webRequest.setAttribute("version", version, WebRequest.SCOPE_REQUEST);

        StatusResponse response = new StatusResponse();
        try {
            // Check if service is enabled
            enabledServicesChecker.checkServiceStatus(enabledServicesChecker.isAirtimeTopupEnabled(), "Airtime Topup Service");

            // Log request on console
            log.info("Received Channel Transaction Request JSON: \n{}", (new Gson()).toJson(airtimeRequest));

            // Validate fields
            checkForInputValidationErrors(result);

            // Resolve telco by checking prefix of the provided number
            String resolvedTelco = telcoResolver.resolveTelco(airtimeRequest.getBeneficiaryPhoneNumber());
            log.info("Resolved Telco: " + resolvedTelco);

            // The resolved telco has to be the same as the supplied telco in the request
            if (!resolvedTelco.toUpperCase().contains(airtimeRequest.getProviderName().toUpperCase())) {
                throw new CustomException(INVALID_NUMBER_ERROR);
            }
            rrn = airtimeRequest.getTransactionReference();
            response.setOriginatingTransactionID(rrn);

            // Process the request
            String responseXml = dtoProcessingService.processChannelRequest(isInternal, new request(), getGenericXMLString(airtimeRequest), result, type);

            // process response
            if (responseXml.toUpperCase().contains("ERROR|")) {
                Map<String, String> receivedValuesMap = xmlReaderService.parseXml(responseXml, type, rrn);
                String errorCode = receivedValuesMap.get("responseCode");

                response.setStatus(errorCode);
                response.setTransactionStatus("01");
                log.info("{}: Returned Airtime-Topup Response To Channel: \n{}", rrn, (new Gson()).toJson(response));
                return new ResponseEntity<>(response, HttpStatus.valueOf(400));
            }

            response.setStatus("200");
            response.setTransactionStatus("0");
            response.setTransactionID(getTranId(responseXml));
            log.info("{}: Returned Airtime-Topup Response To Channel: \n{}", rrn, (new Gson()).toJson(response));
            return new ResponseEntity<>(response, HttpStatus.OK);

        } catch (Exception e) {
            log.error("{}: Exception Occurred During Process: {}", rrn, e.getMessage());
            throw new CustomException(e.getMessage());
        }
    }

    private static String getTranId(String telcoResponseXML) {
        //<return>OK|172413749756</return>
        String returnVal = MiscUtil.extractTagValue(telcoResponseXML, "return");
        if (returnVal != null) {
            String[] parts = returnVal.split("\\|");
            if (parts.length > 1) {
                if (parts[0].equalsIgnoreCase("OK")) {
                    return parts[1];
                }
            }
        }
        return null;
    }

    private Envelope getGenericXMLString(AirtimeRequest request) {
        Envelope envelope = new Envelope();
        Body body = new Body();
        TopUp topUp = new TopUp();
        topUp.setAmount(request.getAmount());
        topUp.setChannel("INTERNAL");
        topUp.setCountry("CD");
        topUp.setCurrency(request.getCurrency());
        topUp.setMsisdnA(request.getBeneficiaryPhoneNumber());
        topUp.setRrn(request.getTransactionReference());
        topUp.setSignature("jZzbRrd8Ycwg8xClrOdddkZcHjXHnUtgf6FA9gMFtCMF720S8rZPiVgtc0nPBuNXa4WlYvK+elzapEDbxUvA+oiyWtPZYM+fqI/UAxMjCtJifvr8z7ztjOx0Tq7La63Yvju06g6AWjhs3LrZa8ECBqQkQNdK9DBTcBT/oSP0Nla3IHq/WREA40ttMPtgbQoCmp/ZCL7Rmw8ulm/A2VEUvM14LEfn2jMzij1DWPzidsCkA6q7CYPPHLFIBVpevEpTNp9WTm80RWYr8oZx5jT8i4FAFMnN58kXd1/QHfjgMxvfkP+T3XmFg2Kv5PdF7rOF0XvsaY9u6hfy2NbnQwaSMg==");
        topUp.setTelcom(request.getProviderName());
        body.setTopUp(topUp);
        envelope.setBody(body);
        return envelope;
    }

    private void checkForInputValidationErrors(BindingResult result) throws CustomException {
        // Check if input request dto fields contains errors
        if (!result.hasErrors()) {
            return;
        }
        List<ObjectError> allErrors = result.getAllErrors();
        throw new CustomException(FIELD_VALIDATION_ERROR + allErrors.get(0).getDefaultMessage());
    }


    public static void main(String[] args) {
        String response = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
                "<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" +
                "    <soap:Body>\n" +
                "        <ns2:topupResponse xmlns:ns2=\"http://business.airtime.telcos.equitybank.com/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:type=\"ns2:topupResponse\">\n" +
                "            <return>OK|172413749756</return>\n" +
                "        </ns2:topupResponse>\n" +
                "    </soap:Body>\n" +
                "</soap:Envelope>";
        System.out.println("TRAN ID: " + getTranId(response));

        String request = "{\n" +
                "    \"OriginatingTransactionID\": \"20240820991\"\n" +
                "}";
        StatusRequest req = (new Gson()).fromJson(request, StatusRequest.class);

        System.out.println("OriginatingTransactionID: " + req.getOriginatingTransactionID());
    }


}
