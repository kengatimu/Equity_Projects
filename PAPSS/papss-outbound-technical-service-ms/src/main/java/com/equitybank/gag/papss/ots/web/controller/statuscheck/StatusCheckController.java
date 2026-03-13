package com.equitybank.gag.papss.ots.web.controller.statuscheck;

import com.equitybank.gag.papss.ots.dto.channelRequest.statusCheck.ChannelStatusCheckDetailsReq;
import com.equitybank.gag.papss.ots.dto.channelRequest.transaction.ChannelCreditTransferDetailsReq;
import com.equitybank.gag.papss.ots.dto.channelResponse.ChannelResponse;
import com.equitybank.gag.papss.ots.enums.TransactionType;
import com.equitybank.gag.papss.ots.exception.CustomException;
import com.equitybank.gag.papss.ots.service.RequestProcessorService;
import com.google.gson.Gson;
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
@RequestMapping(path = "/api/v1/outbound")
public class StatusCheckController {
    private static final Logger log = LoggerFactory.getLogger(StatusCheckController.class);

    private final Gson gson;
    private final RequestProcessorService requestProcessorService;

    @Autowired
    public StatusCheckController(Gson gson,
                                 RequestProcessorService requestProcessorService) {
        this.gson = gson;
        this.requestProcessorService = requestProcessorService;
    }

    @PostMapping(value = "/status-check",
            consumes = {MediaType.APPLICATION_JSON_VALUE},
            produces = {MediaType.APPLICATION_JSON_VALUE})
    ResponseEntity<?> statusCheck(@Valid @RequestBody ChannelStatusCheckDetailsReq statusCheckDetailsReq, BindingResult bindingResult, WebRequest webRequest) throws CustomException {
        String type = TransactionType.STATUS_CHECK.name();
        String rrn = statusCheckDetailsReq.getChannelInfo().getRrn();

        // Store the rrn and type in the WebRequest to be used in the GlobalExceptionHandler class
        webRequest.setAttribute("rrn", rrn, WebRequest.SCOPE_REQUEST);
        webRequest.setAttribute("type", type, WebRequest.SCOPE_REQUEST);

        try {
            log.info("{}: Received {} Request From Channel: {}", rrn, type, gson.toJson(statusCheckDetailsReq));
            ChannelResponse channelResponse = requestProcessorService.processStatusCheckRequest(statusCheckDetailsReq, bindingResult, type);

            log.info("{}: Returned {} Response To Channel: {}", rrn, type, gson.toJson(channelResponse));
            return new ResponseEntity<>(gson.toJson(channelResponse), HttpStatus.OK);
        } catch (Exception e) {
            log.error("{}: Exception Occurred During Processing: {}", rrn, e.getMessage());
            throw new CustomException(e.getMessage());
        }
    }
}
