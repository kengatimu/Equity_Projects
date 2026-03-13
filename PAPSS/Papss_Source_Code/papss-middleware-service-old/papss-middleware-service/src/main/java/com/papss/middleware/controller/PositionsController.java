package com.papss.middleware.controller;


import com.papss.middleware.config.ParticipantsConfig;
import com.papss.middleware.models.Participant;
import com.papss.middleware.service.outbound.PositionsService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import montran.positions.Positions;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import static com.papss.middleware.utils.ConstantUtils.POSITION_API;

@RequestMapping(POSITION_API)
@RestController
@Slf4j
@RequiredArgsConstructor
@Tag(name = "Positions", description = "Position management operations")
public class PositionsController {

    private final PositionsService positionsService;
    private final ParticipantsConfig participantsConfig;

    @Operation(summary = "Get Positions", description = "Get position information for a participant")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "SUCCESS OK")
    })
    @GetMapping
    public Positions getPosition(@RequestHeader(value = "PAPSS-ID") final String papssId, @RequestHeader(value = "PAPSS-API-Key") final String authorization) {
        Participant participant = participantsConfig.getParticipantConfig(papssId);
        participantsConfig.validateParticipantByApiKey(authorization, participant);
        return positionsService.getParticipantPositions(participant.getInstId(), participant.getSslKeyAlias());
    }

}
