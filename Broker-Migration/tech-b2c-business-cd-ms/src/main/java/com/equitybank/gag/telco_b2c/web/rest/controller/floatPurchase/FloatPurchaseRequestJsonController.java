package com.equitybank.gag.telco_b2c.web.rest.controller.floatPurchase;

import com.equitybank.gag.telco_b2c.dto.Eazzycash;
import com.equitybank.gag.telco_b2c.dto.airtime.request.Envelope;
import com.equitybank.gag.telco_b2c.dto.json.CashAllocationRequest;
import com.equitybank.gag.telco_b2c.dto.json.StatusResponse;
import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.entity.StatusDetails;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.exception.GlobalExceptionHandler;
import com.equitybank.gag.telco_b2c.repository.StatusDetailsRepository;
import com.equitybank.gag.telco_b2c.service.DtoProcessingService;
import com.equitybank.gag.telco_b2c.service.XmlJsonMapperService;
import com.equitybank.gag.telco_b2c.util.EnabledServicesChecker;
import com.google.gson.Gson;
import jakarta.validation.Valid;

import java.security.SignatureException;
import java.util.Optional;

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
@RequestMapping(path = "/api/v2")
public class FloatPurchaseRequestJsonController {
    private static final Logger log = LoggerFactory.getLogger(FloatPurchaseRequestJsonController.class);

    private final boolean isInternal;
    private final GlobalExceptionHandler globalExceptionHandler;
    private final EnabledServicesChecker enabledServicesChecker;
    private final XmlJsonMapperService xmlJsonMapperService;
    private final DtoProcessingService dtoProcessingService;
    private final StatusDetailsRepository statusDetailsRepository;

    @Autowired
    public FloatPurchaseRequestJsonController(@Value("${signature.validation.isInternal}") boolean isInternal,
                                              GlobalExceptionHandler globalExceptionHandler,
                                              EnabledServicesChecker enabledServicesChecker,
                                              XmlJsonMapperService xmlJsonMapperService,
                                              DtoProcessingService dtoProcessingService,
                                              StatusDetailsRepository statusDetailsRepository) {
        this.isInternal = isInternal;
        this.globalExceptionHandler = globalExceptionHandler;
        this.enabledServicesChecker = enabledServicesChecker;
        this.xmlJsonMapperService = xmlJsonMapperService;
        this.dtoProcessingService = dtoProcessingService;
        this.statusDetailsRepository = statusDetailsRepository;
    }

    @PostMapping(value = "/cashallocation",
            consumes = {MediaType.APPLICATION_JSON_VALUE},
            produces = {MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<?> handleOmniRequest(@Valid @RequestBody String channelRequest, BindingResult result, WebRequest webRequest) {

        StatusResponse response = new StatusResponse();

        String type = "floatPurchase";

        log.info("CURRENCY CONTROLLER:: {}", channelRequest);

        CashAllocationRequest request = (new Gson()).fromJson(channelRequest, CashAllocationRequest.class);

        String rrn = request.getTransactionId();

        response.setOriginatingTransactionID(rrn);

        try {
            // Store the rrn and type in the WebRequest to be used in the GlobalExceptionHandler class
            webRequest.setAttribute("rrn", rrn, WebRequest.SCOPE_REQUEST);
            webRequest.setAttribute("type", type, WebRequest.SCOPE_REQUEST);

            // Check if service is enabled
            enabledServicesChecker.checkServiceStatus(enabledServicesChecker.isFloatPurchaseEnabled(), "Float Purchase Service");

            // Log request on console
            log.info("Received Channel Transaction Request XML: \n{}", channelRequest);

            // Process the request
            String responseXml = dtoProcessingService.processChannelRequest(isInternal, getGenericXMLString(request), new Envelope(), result, type);

            response = getTranId(response);

            log.info("{}: Returned Response To Channel: \n{}", rrn, (new Gson()).toJson(response));
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (CustomException customException) {
            log.error(rrn + ": " + customException.getMessage());
            response.setStatus("FAILED");
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (SignatureException ex) {
            log.error(rrn + ": " + ex.getMessage());
            return globalExceptionHandler.handleCustomException(new CustomException("Signature validation failed!"), webRequest);
        }
    }

    private request getGenericXMLString(CashAllocationRequest request) {
        request req = new request();
        Eazzycash eazyCash = new Eazzycash();
        eazyCash.setRrn(request.getTransactionId());
        eazyCash.setAmount(request.getAmount());
        eazyCash.setSender("0743000000");
        eazyCash.setCurrency(request.getCurrency());
        eazyCash.setName("EQUITY CHANNEL");
        eazyCash.setNumber(request.getAgentNumber());
        eazyCash.setTelco(request.getProviderName());
        eazyCash.setSignature("jZzbRrd8Ycwg8xClrOdddkZcHjXHnUtgf6FA9gMFtCMF720S8rZPiVgtc0nPBuNXa4WlYvK+elzapEDbxUvA+oiyWtPZYM+fqI/UAxMjCtJifvr8z7ztjOx0Tq7La63Yvju06g6AWjhs3LrZa8ECBqQkQNdK9DBTcBT/oSP0Nla3IHq/WREA40ttMPtgbQoCmp/ZCL7Rmw8ulm/A2VEUvM14LEfn2jMzij1DWPzidsCkA6q7CYPPHLFIBVpevEpTNp9WTm80RWYr8oZx5jT8i4FAFMnN58kXd1/QHfjgMxvfkP+T3XmFg2Kv5PdF7rOF0XvsaY9u6hfy2NbnQwaSMg==");
        eazyCash.setOptIn("0");
        req.setEazzycash(eazyCash);
        return req;
    }

    private StatusResponse getTranId(StatusResponse response) {
        Optional<StatusDetails> detailsOpt = statusDetailsRepository.findByRrn(response.getOriginatingTransactionID());
        if (detailsOpt.isPresent()) {
            StatusDetails details = detailsOpt.get();
            String statusCode = details.getStatusCode();
            response.setTransactionID(details.getTranId());
            if ((statusCode != null) && statusCode.equalsIgnoreCase("00")) {
                response.setStatus("OK");
                return response;
            }
        }
        response.setStatus("FAILED");
        return response;
    }
    /**
     * <response>
     <eazzycashres>
     <msgId>0</msgId>
     <status>OK</status>
     <responseCode>0</responseCode>
     </eazzycashres>
     </response>
     */

}
