package com.papss.middleware.controller;

import com.papss.middleware.config.ParticipantsConfig;
import com.papss.middleware.enums.ParticipantType;
import com.papss.middleware.models.Participant;
import com.papss.middleware.models.participantinfo.Participants;
import com.papss.middleware.service.ParticipantInfoService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

import static com.papss.middleware.utils.ConstantUtils.PARTICIPANTS_API;

@RequestMapping(PARTICIPANTS_API)
@RestController
@Slf4j
@RequiredArgsConstructor
@Tag(name = "Participant Info", description = "Participant information operations")
public class ParticipantInfoController {

    private final ParticipantInfoService participantInfoService;
    private final ParticipantsConfig participantsConfig;

    @Operation(summary = "Get All Participants Status", description = "Get status information for all participants")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "SUCCESS OK")
    })
    @GetMapping
    public Participants getAllParticipantStatus(@RequestHeader(value = "PAPSS-ID") final String papssId,
                                                @RequestHeader(value = "PAPSS-API-KEY") final String authorization,
                                                @RequestParam(value = "online", defaultValue = "false") boolean isOnline,
                                                @RequestParam(value = "type", defaultValue = "") ParticipantType type,
                                                @RequestParam(value = "countryCode", defaultValue = "") String countryCode) throws IOException {
        Participant participant = participantsConfig.getParticipantConfig(papssId);
        participantsConfig.validateParticipantByApiKey(authorization, participant);
        return participantInfoService.getAllParticipantsStatus(isOnline, type, countryCode,papssId, participant.getSslKeyAlias());
    }

    @Operation(summary = "Get Participant Status", description = "Get status information for a specific participant")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "SUCCESS OK")
    })
    @GetMapping("/{receivingPapssId}")
    public Participants getParticipantStatus(@RequestHeader(value = "PAPSS-ID") final String papssId,
                                             @RequestHeader(value = "PAPSS-API-KEY") final String authorization,
                                             @PathVariable String receivingPapssId) {
        Participant participant = participantsConfig.getParticipantConfig(papssId);
        participantsConfig.validateParticipantByApiKey(authorization, participant);
        return participantInfoService.getParticipantStatus(papssId, receivingPapssId, participant.getSslKeyAlias());
    }

}
