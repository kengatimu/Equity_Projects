package com.papss.middleware.controller;

import com.papss.middleware.config.ParticipantsConfig;
import com.papss.middleware.dto.nameinquiry.response.NameInquiryResponse;
import com.papss.middleware.models.Participant;
import com.papss.middleware.service.outbound.NameEnquiryService;
import com.papss.middleware.service.outbound.domains.nameenquiry.NameInquiryRequest;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.security.SignatureException;

import static com.papss.middleware.utils.ConstantUtils.NAME_INQUIRY_API;

@RestController
@RequestMapping(NAME_INQUIRY_API)
@RequiredArgsConstructor
@Tag(name = "Name Enquiry", description = "Name enquiry operations")
public class NameEnquiryController {
    private final ParticipantsConfig participantsConfig;
    private final NameEnquiryService nameInquiryService;

    @Operation(summary = "Name Inquiry", description = "Send a name inquiry message to the participant")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Successfully retrieved message")
    })
    @PostMapping
    public NameInquiryResponse nameInquiry(@RequestHeader(value = "PAPSS-ID") final String papssId,
                                           @RequestHeader(value = "PAPSS-API-KEY") final String authorization,
                                           @RequestBody @Validated NameInquiryRequest dto) throws SignatureException {
        Participant participant = participantsConfig.getParticipantConfig(papssId);
        participantsConfig.validateParticipantByApiKey(authorization, participant);
        return nameInquiryService.sendNameInquiryMessage(dto, participant.getInstId(), participant);
    }
}
