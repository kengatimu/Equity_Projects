package com.papss.middleware.controller;

import com.papss.middleware.config.ParticipantsConfig;
import com.papss.middleware.dto.paymentreturn.PaymentRecallDto;
import com.papss.middleware.dto.txnconfirmation.response.TxStatusResponseDto;
import com.papss.middleware.models.Participant;
import com.papss.middleware.service.outbound.CreditTransferService;
import com.papss.middleware.service.outbound.domains.creditreturn.CreditReturnRequest;
import com.papss.middleware.service.outbound.domains.creditreturn.PaymentRecallRejectionDto;
import com.papss.middleware.service.outbound.domains.credittransfer.CreditTransferRequest;
import com.papss.middleware.service.outbound.domains.credittransfer.FTResponse;
import com.papss.middleware.service.outbound.domains.pending.PendingRequest;
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
@Tag(name = "Credit Transfer", description = "Credit transfer operations")
public class CreditTransferController {
    private final ParticipantsConfig participantsConfig;
    private final CreditTransferService creditTransferService;


    @Operation(summary = "Credit Transfer", description = "Send a credit transfer to the participant")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "SUCCESS OK")
    })
    @PostMapping("/send-credit-transfer")
    public FTResponse ft(@RequestHeader(value = "PAPSS-ID") final String papssId,
                         @RequestHeader(value = "PAPSS-API-KEY") final String authorization,
                         @RequestBody @Validated CreditTransferRequest dto) throws IOException, SignatureException, JAXBException {
        Participant participant = participantsConfig.getParticipantConfig(papssId);
        participantsConfig.validateParticipantByApiKey(authorization, participant);
        return creditTransferService.sendFTMessage(dto, participant.getInstId(), participant);
    }

    @Operation(summary = "Send Credit Return", description = "Send a credit return message to the participant")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "SUCCESS OK")
    })
    @PostMapping("/send-credit-return")
    public TxStatusResponseDto sendPayment(@RequestHeader(value = "PAPSS-ID") final String papssId,
                                           @RequestHeader(value = "PAPSS-API-KEY") final String authorization,
                                           @RequestBody @Validated CreditReturnRequest creditReturnDto) throws Exception {
        System.out.println("Sending Credit Return Message");
        try {
            Participant participant = participantsConfig.getParticipantConfig(papssId);
            participantsConfig.validateParticipantByApiKey(authorization, participant);
            return creditTransferService.returnCreditReturnMessage(creditReturnDto, papssId, participant.getSslKeyAlias(), participant.getKeyPass());
        }catch (Exception e) {
            e.printStackTrace();
            throw new Exception(e.getMessage(), e);
        }
    }



    @Operation(summary = "Credit Transfer Status", description = "Send a credit transfer to the participant")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "SUCCESS OK")
    })
    @GetMapping("/status")
    public TxStatusResponseDto getTxStatus(@RequestHeader(value = "PAPSS-ID") final String papssId,
                                           @RequestHeader(value = "PAPSS-API-KEY") final String authorization,
                                           @RequestParam("originalTransactionReference") String originalTransactionReference,
                                           @RequestParam("originalTransactionDateTime") String originalTransactionDateTime) throws SignatureException {
        Participant participant = participantsConfig.getParticipantConfig(papssId);
        participantsConfig.validateParticipantByApiKey(authorization, participant);
        return creditTransferService.getTransactionStatus(originalTransactionReference, originalTransactionDateTime, papssId, participant.getSslKeyAlias(), participant.getKeyPass());
    }

    @Operation(summary = "Request Modification Transfer", description = "API for Transaction Stop & Resume (CAM007)")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "SUCCESS OK")
    })
    @PostMapping("/request-modification")
    public FTResponse ftControl(@RequestHeader(value = "PAPSS-ID") final String papssId,
                                @RequestHeader(value = "PAPSS-API-KEY") final String authorization,
                                @RequestBody @Validated PendingRequest dto) throws IOException, SignatureException, JAXBException {
        Participant participant = participantsConfig.getParticipantConfig(papssId);
        participantsConfig.validateParticipantByApiKey(authorization, participant);
        return creditTransferService.requestModification(dto, participant.getInstId(), participant);
    }


    @Operation(summary = "Payment Recall Request", description = "Send a payment recall request to the participant")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "SUCCESS OK")
    })
    @PostMapping("/recall-request")
    public TxStatusResponseDto sendPaymentRecallRequest(
            @RequestHeader(value = "PAPSS-ID") final String papssId,
            @RequestHeader(value = "PAPSS-API-KEY") final String authorization,
            @RequestBody @Validated PaymentRecallDto recallDto) throws Exception {
        Participant participant = participantsConfig.getParticipantConfig(papssId);
        participantsConfig.validateParticipantByApiKey(authorization, participant);
        return creditTransferService.paymentCancellationRequest(recallDto, papssId, participant.getSslKeyAlias(), participant.getKeyPass());
    }

    @Operation(summary = "Payment Recall Rejection", description = "Send a payment recall rejection to the participant")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "SUCCESS OK")
    })
    @PostMapping("/recall-reject")
    public TxStatusResponseDto sendPaymentReject(@RequestHeader(value = "PAPSS-ID") final String papssId,
                                                 @RequestHeader(value = "PAPSS-API-KEY") final String authorization,
                                                 @RequestBody @Validated PaymentRecallRejectionDto paymentRecallDto) throws Exception {

        Participant participant = participantsConfig.getParticipantConfig(papssId);
        participantsConfig.validateParticipantByApiKey(authorization, participant);
        return creditTransferService.paymentCancellationStatus(paymentRecallDto, participant.getInstId(), participant.getSslKeyAlias(), participant.getKeyPass());
    }
}
