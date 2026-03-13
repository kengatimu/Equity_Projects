package com.bishop.papss_channel_mock_service.web.controller;

import com.bishop.papss_channel_mock_service.dto.channelRequest.namecheck.ChannelNamecheckDetailsReq;
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
public class CredtTransferController {
    private static final Logger log = LoggerFactory.getLogger(CredtTransferController.class);

    private final Gson gson;
    private final ProcessRequestService processRequestService;

    public CredtTransferController(Gson gson,
                                   ProcessRequestService processRequestService) {
        this.gson = gson;
        this.processRequestService = processRequestService;
    }

    @PostMapping(path = "/outbound/credit-transfer",
            consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<?> processNamecheck(@Valid @RequestBody ChannelCreditTransferDetailsReq transactionReq) {
        TransactionType type = TransactionType.CREDIT_TRANSFER;
        String rrn = transactionReq.getChannelInfo().getRrn();

        try {
            // Log the received request
            log.info("{}: Received Namecheck Request: {}", rrn, gson.toJson(transactionReq));

            // Process the request
            ChannelResponse response = processRequestService.processTransaction(transactionReq, type);

            // Log the process response
            String responseJson = gson.toJson(response);
            log.info("{}: Returned Namecheck Response: {}", rrn, responseJson);

            // Return the response
            return new ResponseEntity<>(responseJson, HttpStatus.OK);
        } catch (Exception e) {
            log.error("{}: Exception Occurred During Processing: {}", rrn, e.getMessage());
            return new ResponseEntity<>(new ChannelResponse(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
