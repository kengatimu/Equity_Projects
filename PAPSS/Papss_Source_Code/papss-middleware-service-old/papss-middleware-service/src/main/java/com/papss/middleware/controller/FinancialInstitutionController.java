package com.papss.middleware.controller;

import com.papss.middleware.config.ParticipantsConfig;
import com.papss.middleware.models.Participant;
import com.papss.middleware.service.outbound.FinancialInstitutionService;
import com.papss.middleware.service.outbound.domains.credittransfer.FTResponse;
import com.papss.middleware.service.outbound.domains.financialinstitution.FinancialInstitutionRequest;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.xml.bind.JAXBException;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.security.SignatureException;

import static com.papss.middleware.utils.ConstantUtils.TRANSACTION_API;

@RestController
@RequestMapping(TRANSACTION_API)
@RequiredArgsConstructor
@Tag(name = "Financial Institution Transfer", description = "Financial institution transfer operations")
public class FinancialInstitutionController {
    private final ParticipantsConfig participantsConfig;
    private final FinancialInstitutionService financialInstitutionService;

    @Operation(summary = "Financial Institution Transfer", description = "Send a financial institution transfer to the participant")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "SUCCESS OK")
    })
    @PostMapping("/send-financial-institution-transfer")
    public FTResponse sendFinancialInstitutionTransfer(@RequestHeader(value = "PAPSS-ID") final String papssId,
                                                      @RequestHeader(value = "PAPSS-API-KEY") final String authorization,
                                                      @RequestBody @Validated FinancialInstitutionRequest dto) throws IOException, SignatureException, JAXBException {
        Participant participant = participantsConfig.getParticipantConfig(papssId);
        participantsConfig.validateParticipantByApiKey(authorization, participant);
        return financialInstitutionService.sendFinancialInstitutionMessage(dto, participant.getInstId(), participant);
    }
}