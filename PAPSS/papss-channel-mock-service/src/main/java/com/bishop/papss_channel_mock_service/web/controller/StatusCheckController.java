package com.bishop.papss_channel_mock_service.web.controller;

import com.bishop.papss_channel_mock_service.dto.channelRequest.statusCheck.ChannelStatusCheckDetailsReq;
import com.bishop.papss_channel_mock_service.dto.channelRequest.transaction.ChannelCreditTransferDetailsReq;
import com.bishop.papss_channel_mock_service.dto.channelResponse.ChannelResponse;
import com.bishop.papss_channel_mock_service.enums.TransactionType;
import com.bishop.papss_channel_mock_service.service.ProcessRequestService;
import com.google.gson.Gson;
import jakarta.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1")
public class StatusCheckController {
    private static final Logger log = LoggerFactory.getLogger(StatusCheckController.class);

    private final Gson gson;
    private final ProcessRequestService processRequestService;

    public StatusCheckController(Gson gson,
                                 ProcessRequestService processRequestService) {
        this.gson = gson;
        this.processRequestService = processRequestService;
    }

    @PostMapping(path = "/outbound/status-check",
            consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<?> processStatusCheck(@Valid @RequestBody ChannelStatusCheckDetailsReq statusCheckDetailsReq) {
        TransactionType type = TransactionType.STATUS_CHECK;
        String rrn = statusCheckDetailsReq.getChannelInfo().getRrn();

        try {
            // Log the received request
            log.info("{}: Received StatusCheck Request: {}", rrn, gson.toJson(statusCheckDetailsReq));

            // Process the request
            ChannelResponse response = processRequestService.processStatusCheck(statusCheckDetailsReq, type);

            // Log the process response
            String responseJson = gson.toJson(response);
            log.info("{}: Returned StatusCheck Response: {}", rrn, responseJson);

            // Return the response
            return new ResponseEntity<>(responseJson, HttpStatus.OK);
        } catch (Exception e) {
            log.error("{}: Exception Occurred During Processing: {}", rrn, e.getMessage());
            return new ResponseEntity<>(new ChannelResponse(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
