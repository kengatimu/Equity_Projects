package com.papss.middleware.controller;

import com.papss.middleware.config.ParticipantsConfig;
import com.papss.middleware.dto.fxrate.PostFxRateDto;
import com.papss.middleware.dto.fxrate.response.FxRateData;
import com.papss.middleware.dto.fxrate.response.FxRateResponse;
import com.papss.middleware.dto.fxrate.response.PostFxRateResponse;
import com.papss.middleware.models.Participant;
import com.papss.middleware.service.outbound.FxRateService;
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

import static com.papss.middleware.utils.ConstantUtils.RATE_API;

@RestController
@RequestMapping(RATE_API)
@RequiredArgsConstructor
@Tag(name = "FX Rate", description = "Foreign exchange rate operations")
public class FxRateController {

    private final FxRateService fxRateService;
    private final ParticipantsConfig participantsConfig;

    @Operation(summary = "Get FX Rate", description = "Get foreign exchange rate for a transaction")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "SUCCESS OK")
    })
    @GetMapping
    public FxRateResponse getFxRate(@RequestHeader(value = "PAPSS-ID") final String papssId,
                                    @RequestHeader(value = "PAPSS-API-KEY") final String authorization,
                                    @RequestParam("senderCountry") String senderCountry,
                                    @RequestParam("senderCurrency") String senderCurrency,
                                    @RequestParam("receiverCountry") String receiverCountry,
                                    @RequestParam("receiverCurrency") String receiverCurrency,
                                    @RequestParam("receiverPapssId") String receiverPapssId,
                                    @RequestParam("localInstrument") String localInstrument,
                                    @RequestParam("amount") String amount,
                                    @RequestParam(value = "isInvoice", defaultValue = "false") boolean isInvoice) throws IOException, JAXBException {
        Participant participant = participantsConfig.getParticipantConfig(papssId);
        participantsConfig.validateParticipantByApiKey(authorization, participant);
        return fxRateService.getFxRate(senderCountry, senderCurrency, receiverCountry, receiverCurrency, receiverPapssId, localInstrument, amount, isInvoice, participant.getInstId(), participant.getSslKeyAlias());
    }

    @Operation(summary = "Get FX Rate Details", description = "Get detailed information about a specific foreign exchange rate")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "SUCCESS OK")
    })
    @GetMapping("/details")
    public FxRateData getFxRate(@RequestHeader(value = "PAPSS-ID") final String papssId,
                                @RequestHeader(value = "PAPSS-API-KEY") final String authorization,
                                @RequestParam(value = "fxRateName", defaultValue = "") String fxRateName) throws IOException, JAXBException {
        Participant participant = participantsConfig.getParticipantConfig(papssId);
        participantsConfig.validateParticipantByApiKey(authorization, participant);
        return fxRateService.getFxRate(papssId, fxRateName, participant.getSslKeyAlias());
    }

    @Operation(summary = "Update FX Rate", description = "Update a foreign exchange rate")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "SUCCESS OK")
    })
    @PutMapping
    public PostFxRateResponse updateFxRate(@RequestHeader(value = "PAPSS-ID") final String papssId,
                                           @RequestHeader(value = "PAPSS-API-KEY") final String authorization,
                                           @RequestBody @Validated PostFxRateDto fxRateDto) throws SignatureException {
        Participant participant = participantsConfig.getParticipantConfig(papssId);
        participantsConfig.validateParticipantByApiKey(authorization, participant);
        return fxRateService.updateFxRate(fxRateDto, participant.getInstId(), participant.getSslKeyAlias(), participant.getKeyPass());
    }
}
