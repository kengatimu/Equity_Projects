package com.equitybank.gag.papss.ots.web.controller.creditTransfer;

import com.equitybank.gag.papss.ots.dto.channelRequest.transaction.ChannelCreditTransferDetailsReq;
import com.equitybank.gag.papss.ots.dto.channelResponse.ChannelResponse;
import com.equitybank.gag.papss.ots.enums.TransactionType;
import com.equitybank.gag.papss.ots.exception.CustomException;
import com.equitybank.gag.papss.ots.service.DatabaseService;
import com.equitybank.gag.papss.ots.service.RequestProcessorService;
import com.google.gson.Gson;
import jakarta.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.WebRequest;

@RestController
@RequestMapping("/api/v1/outbound")
public class CreditTransferController {
    private static final Logger log = LoggerFactory.getLogger(CreditTransferController.class);

    private final Gson gson;
    private final RequestProcessorService requestProcessorService;

    @Autowired
    public CreditTransferController(Gson gson,
                                    RequestProcessorService requestProcessorService) {
        this.gson = gson;
        this.requestProcessorService = requestProcessorService;
    }

    @PostMapping(value = "/credit-transfer",
            consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<?> creditTransfer(@Valid @RequestBody ChannelCreditTransferDetailsReq creditTransferReq, BindingResult bindingResult, WebRequest webRequest) throws CustomException {
        String type = TransactionType.CREDIT_TRANSFER.name();
        String rrn = creditTransferReq.getChannelInfo().getRrn();

        try {
            // Store metadata in WebRequest for use by GlobalExceptionHandler
            webRequest.setAttribute("rrn", rrn, WebRequest.SCOPE_REQUEST);
            webRequest.setAttribute("type", type, WebRequest.SCOPE_REQUEST);

            // Log the incoming request
            log.info("{}: Received {} Request From Channel: {}", rrn, type, gson.toJson(creditTransferReq));

            // Process the transaction via service layer
            ChannelResponse channelResponse = requestProcessorService.processTransactionRequest(creditTransferReq, bindingResult, type);

            // Log the response to channel
            log.info("{}: Returned {} Response To Channel: {}", rrn, type, gson.toJson(channelResponse));
            return ResponseEntity.ok(channelResponse);
        } catch (Exception e) {
            log.error("{}: Exception Occurred During Processing: {}", rrn, e.getMessage());
            throw new CustomException(e.getMessage());
        }
    }
}
