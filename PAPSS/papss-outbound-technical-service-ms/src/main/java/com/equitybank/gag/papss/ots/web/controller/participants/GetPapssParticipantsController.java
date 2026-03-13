package com.equitybank.gag.papss.ots.web.controller.participants;

import com.equitybank.gag.papss.ots.dto.channelRequest.getParticipants.GetPapssParticipantsReq;
import com.equitybank.gag.papss.ots.dto.channelRequest.namecheck.ChannelNamecheckDetailsReq;
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
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.WebRequest;

import java.util.Map;

@RestController
@RequestMapping("/api/v1/outbound")
public class GetPapssParticipantsController {
    private static final Logger log = LoggerFactory.getLogger(GetPapssParticipantsController.class);

    private final Gson gson;
    private final RequestProcessorService requestProcessorService;

    public GetPapssParticipantsController(@Qualifier("gson") Gson gson,
                                          RequestProcessorService requestProcessorService) {
        this.gson = gson;
        this.requestProcessorService = requestProcessorService;
    }

    @PostMapping(value = "/participants")
    public ResponseEntity<?> getParticipants(@Valid @RequestBody GetPapssParticipantsReq getPapssParticipantsReq, BindingResult bindingResult, WebRequest webRequest) throws CustomException {
        String type = TransactionType.GET_PARTICIPANT.name();
        String rrn = getPapssParticipantsReq.getChannelInfo().getRrn();

        // Store the rrn and type in the WebRequest to be used in the GlobalExceptionHandler class
        webRequest.setAttribute("rrn", rrn, WebRequest.SCOPE_REQUEST);
        webRequest.setAttribute("type", type, WebRequest.SCOPE_REQUEST);

        try {
            log.info("{}: Received {} Request From Channel: {}", rrn, type, gson.toJson(getPapssParticipantsReq));

            // Process the request
            ChannelResponse participants = requestProcessorService.processGetParticipants(rrn, getPapssParticipantsReq, bindingResult);

            log.info("Returned {} response to channel: {}", type, gson.toJson(participants));
            return new ResponseEntity<>(participants, HttpStatus.OK);
        } catch (Exception e) {
            log.error("Exception Occurred: {}", e.getMessage());
            throw new CustomException(e.getMessage());
        }
    }
}
