package com.equitybank.gag.papss.ots.web.controller.fxRate;

import com.equitybank.gag.papss.ots.dto.channelRequest.fxRate.GetFxRateReq;
import com.equitybank.gag.papss.ots.dto.channelResponse.ChannelResponse;
import com.equitybank.gag.papss.ots.enums.TransactionType;
import com.equitybank.gag.papss.ots.exception.CustomException;
import com.equitybank.gag.papss.ots.service.RequestProcessorService;
import com.google.gson.Gson;
import jakarta.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.WebRequest;

@RestController
@RequestMapping("/api/v1/outbound")
public class FXRateController {
    private static final Logger log = LoggerFactory.getLogger(FXRateController.class);

    private final Gson gson;
    private final RequestProcessorService requestProcessorService;

    public FXRateController(@Qualifier("gson") Gson gson,
                            RequestProcessorService requestProcessorService) {
        this.gson = gson;
        this.requestProcessorService = requestProcessorService;
    }

    @PostMapping(value = "/FXRate")
    public ResponseEntity<?> getFxRate(@Valid @RequestBody GetFxRateReq getFxRateReq, BindingResult bindingResult, WebRequest webRequest) throws CustomException {
        String type = TransactionType.GET_FX_RATE.name();
        String rrn = getFxRateReq.getChannelInfo().getRrn();

        // Store the rrn and type in the WebRequest to be used in the GlobalExceptionHandler class
        webRequest.setAttribute("rrn", rrn, WebRequest.SCOPE_REQUEST);
        webRequest.setAttribute("type", type, WebRequest.SCOPE_REQUEST);

        try {
            log.info("{}: Received {} Request From Channel: {}", rrn, type, gson.toJson(getFxRateReq));

            // Process the request
            ChannelResponse paymentFXRate = requestProcessorService.processGetFxRateRequest(rrn, getFxRateReq, bindingResult);

            log.info("{}: Returned {} response to channel: {}",rrn, type, gson.toJson(paymentFXRate));
            return new ResponseEntity<>(paymentFXRate, HttpStatus.OK);
        } catch (Exception e) {
            log.error("{}: Exception Occurred: {}",rrn, e.getMessage());
            throw new CustomException(e.getMessage());
        }
    }
}
