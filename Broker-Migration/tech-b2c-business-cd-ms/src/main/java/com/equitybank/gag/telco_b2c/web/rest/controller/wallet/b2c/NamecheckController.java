package com.equitybank.gag.telco_b2c.web.rest.controller.wallet.b2c;

import com.equitybank.gag.telco_b2c.dto.thunes.response.ChannelResponse;
import com.equitybank.gag.telco_b2c.dto.wendi.namecheck.NamecheckRequest;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.service.RequestExecutorService;
import com.equitybank.gag.telco_b2c.util.EnabledServicesChecker;
import com.google.gson.Gson;
import jakarta.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
@RequestMapping(path = "/wendi/outbound/b2c")
public class NamecheckController {
    private static final Logger log = LoggerFactory.getLogger(NamecheckController.class);

    private final Gson gson;
    private final EnabledServicesChecker enabledServicesChecker;
    private final RequestExecutorService requestExecutorService;

    public NamecheckController(Gson gson,
                               EnabledServicesChecker enabledServicesChecker,
                               RequestExecutorService requestExecutorService) {
        this.gson = gson;
        this.enabledServicesChecker = enabledServicesChecker;
        this.requestExecutorService = requestExecutorService;
    }

    @PostMapping(value = "/namecheck", consumes = {MediaType.APPLICATION_JSON_VALUE}, produces = {MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<?> handleChannelRequest(@Valid @RequestBody NamecheckRequest namecheckRequest, BindingResult bindingResult, WebRequest webRequest) throws CustomException {
        String type = "wendi-b2c-namecheck";
        String rrn = namecheckRequest.getChannelInfo().getRrn();

        // Store the type and rrn in the WebRequest to be used in the GlobalExceptionHandler class
        webRequest.setAttribute("type", type, WebRequest.SCOPE_REQUEST);
        webRequest.setAttribute("rrn", rrn, WebRequest.SCOPE_REQUEST);

        try {
            // Check if service is enabled
            enabledServicesChecker.checkServiceStatus(enabledServicesChecker.isWendiOutboundEnabled(), type + " service");

            log.info("{}: Received {} Request From Channel: \n{}", rrn, type, gson.toJson(namecheckRequest));
            ChannelResponse channelResponse = requestExecutorService.executeWendiB2CNamecheck(rrn, namecheckRequest, bindingResult, type);

            log.info("{}: Returned {} Response To Channel: \n{}", rrn, type, gson.toJson(channelResponse));
            return new ResponseEntity<>(gson.toJson(channelResponse), HttpStatus.OK);
        } catch (Exception e) {
            log.error("{}: Exception Occurred: {}", rrn, e.getMessage());
            throw new CustomException(e.getMessage());
        }
    }
}
