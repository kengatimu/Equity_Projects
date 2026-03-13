package com.equitybank.gag.papss.ots.mock;

import com.equitybank.gag.papss.ots.dto.channelRequest.transaction.ChannelCreditTransferDetailsReq;
import com.equitybank.gag.papss.ots.dto.channelResponse.ChannelResponse;
import com.equitybank.gag.papss.ots.dto.channelResponse.ChannelStatusInfo;
import com.equitybank.gag.papss.ots.enums.TransactionType;
import com.equitybank.gag.papss.ots.exception.CustomException;
import com.equitybank.gag.papss.ots.service.RequestProcessorService;
import com.google.gson.Gson;
import jakarta.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.WebRequest;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicLong;

@RestController
@RequestMapping("/api/v1/outbound")
public class MockCreditTransferController {
    private static final Logger log = LoggerFactory.getLogger(MockCreditTransferController.class);

    private final Gson gson;
    private final RequestProcessorService requestProcessorService;
    private static final AtomicLong rrnCounter = new AtomicLong(System.currentTimeMillis() / 1000);
    private static final int MAX_SIMULATION_LIMIT = 1000000;

    @Autowired
    public MockCreditTransferController(Gson gson, RequestProcessorService requestProcessorService) {
        this.gson = gson;
        this.requestProcessorService = requestProcessorService;
    }

    @PostMapping(value = "/credit-transfer/mock",
            consumes = MediaType.APPLICATION_JSON_VALUE,
            produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<ChannelResponse>> creditTransfer(
            @Valid @RequestBody ChannelCreditTransferDetailsReq creditTransferReq,
            BindingResult bindingResult,
            WebRequest webRequest) throws CustomException {

        String originalRrn = creditTransferReq.getChannelInfo().getRrn();
        String type = TransactionType.CREDIT_TRANSFER.name();

        int numberOfRequestsToSimulate;
        try {
            numberOfRequestsToSimulate = Integer.parseInt(creditTransferReq.getTransactionInfo().getSenderAmount());
            if (numberOfRequestsToSimulate <= 0) {
                throw new IllegalArgumentException("Amount must be a positive integer.");
            }
            if (numberOfRequestsToSimulate > MAX_SIMULATION_LIMIT) {
                throw new IllegalArgumentException("Simulation limit exceeded. Max allowed is " + MAX_SIMULATION_LIMIT);
            }
        } catch (IllegalArgumentException e) {
            String errorMsg = originalRrn + ": Invalid 'amount' for simulation. " + e.getMessage();
            log.error(errorMsg);
            throw new CustomException(errorMsg);
        }

        log.info("{}: Simulating {} credit transfer requests.", originalRrn, numberOfRequestsToSimulate);
        List<ChannelResponse> responses = new ArrayList<>();

        for (int i = 0; i < numberOfRequestsToSimulate; i++) {
            String newRrn = String.format("%012d", rrnCounter.incrementAndGet() % 1_000_000_000_000L);
            ChannelCreditTransferDetailsReq clonedReq = gson.fromJson(gson.toJson(creditTransferReq), ChannelCreditTransferDetailsReq.class);
            clonedReq.getChannelInfo().setRrn(newRrn);

            try {
                webRequest.setAttribute("rrn", newRrn, WebRequest.SCOPE_REQUEST);
                webRequest.setAttribute("type", type, WebRequest.SCOPE_REQUEST);

                log.info("{}: Dispatching simulated request {}/{}", newRrn, (i + 1), numberOfRequestsToSimulate);
                ChannelResponse response = requestProcessorService.processTransactionRequest(clonedReq, bindingResult, type);
                responses.add(response);
                log.info("{}: Response: {}", newRrn, gson.toJson(response));
            } catch (Exception e) {
                log.error("{}: Error processing simulated request {}/{}: {}", newRrn, (i + 1), numberOfRequestsToSimulate, e.getMessage());
                responses.add(createErrorResponse(newRrn, e.getMessage()));
            }
        }

        return ResponseEntity.ok(responses);
    }

    private ChannelResponse createErrorResponse(String rrn, String errorMessage) {
        ChannelResponse response = new ChannelResponse();
        response.setRrn(rrn);

        ChannelStatusInfo statusInfo = new ChannelStatusInfo();
        statusInfo.setStatus("FAILURE");
        statusInfo.setCode("99");
        statusInfo.setDescription(errorMessage);

        response.setChannelStatusInfo(statusInfo);
        return response;
    }
}
