package com.papss.middleware.controller;

import com.papss.middleware.config.ParticipantsConfig;
import com.papss.middleware.dto.paymentreturn.PaymentRecallDto;
import com.papss.middleware.dto.txnconfirmation.response.TxStatusResponseDto;
import com.papss.middleware.enums.TransactionChannel;
import com.papss.middleware.models.Participant;
import com.papss.middleware.service.outbound.CreditTransferService;
import com.papss.middleware.service.outbound.domains.creditreturn.CreditReturnRequest;
import com.papss.middleware.service.outbound.domains.creditreturn.PaymentRecallRejectionDto;
import com.papss.middleware.service.outbound.domains.credittransfer.CreditTransferRequest;
import com.papss.middleware.service.outbound.domains.credittransfer.FTResponse;
import com.papss.middleware.service.outbound.domains.credittransfer.Status;
import com.papss.middleware.service.outbound.domains.pending.PendingRequest;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.io.IOException;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class CreditTransferControllerTest {

    @Mock private ParticipantsConfig participantsConfig;
    @Mock private CreditTransferService creditTransferService;

    @InjectMocks private CreditTransferController controller;

    private Participant participant;

    @BeforeEach
    void setUp() {
        participant = new Participant();
        participant.setInstId("INST1");
        participant.setSslKeyAlias("alias");
        participant.setKeyPass("pass");
    }

    @Test
    void ft_shouldDelegateToServiceAndReturnResponse() throws Exception {
        // arrange
        String papssId = "PAPSS123";
        String apiKey = "APIKEY";
        CreditTransferRequest req = CreditTransferRequest.builder()
                .endToEndRef("e2e")
                .tranDateTime("2025-01-01T00:00:00Z")
                .narration("Test")
                .isInvoice(false)
                .categoryPurpose("CP")
                .localInstrumentType("ET")
                .amount(new java.math.BigDecimal("10.00"))
                .sender(new com.papss.middleware.service.outbound.domains.credittransfer.TransferDetails())
                .receiver(new com.papss.middleware.service.outbound.domains.credittransfer.TransferDetails())
                .transactionChannel(TransactionChannel.API)
                .build();

        FTResponse expected = FTResponse.builder().instId("INST1").status(new Status("SUCCESS","200","OK")).build();

        when(participantsConfig.getParticipantConfig(papssId)).thenReturn(participant);
        doNothing().when(participantsConfig).validateParticipantByApiKey(apiKey, participant);
        when(creditTransferService.sendFTMessage(eq(req), eq("INST1"), eq(participant))).thenReturn(expected);

        // act
        FTResponse resp = controller.ft(papssId, apiKey, req);

        // assert
        assertThat(resp).isEqualTo(expected);
        verify(creditTransferService).sendFTMessage(eq(req), eq("INST1"), eq(participant));
        verify(participantsConfig).validateParticipantByApiKey(apiKey, participant);
    }

    @Test
    void sendCreditReturn_shouldDelegateAndReturn() throws Exception {
        String papssId = "PAPSS123";
        String apiKey = "APIKEY";
        CreditReturnRequest request = new CreditReturnRequest();
        TxStatusResponseDto expected = TxStatusResponseDto.builder().instId("INST1").status(new Status("SUCCESS","200","OK")).build();

        when(participantsConfig.getParticipantConfig(papssId)).thenReturn(participant);
        doNothing().when(participantsConfig).validateParticipantByApiKey(apiKey, participant);
        when(creditTransferService.returnCreditReturnMessage(eq(request), eq(papssId), eq("alias"), eq("pass")))
                .thenReturn(expected);

        TxStatusResponseDto resp = controller.sendPayment(papssId, apiKey, request);

        assertThat(resp).isEqualTo(expected);
        verify(creditTransferService).returnCreditReturnMessage(eq(request), eq(papssId), eq("alias"), eq("pass"));
    }

    @Test
    void getTxStatus_shouldDelegateAndReturn() throws Exception {
        String papssId = "PAPSS123";
        String apiKey = "APIKEY";
        String ref = "REF1";
        String dt = "2025-01-01T00:00:00Z";
        TxStatusResponseDto expected = TxStatusResponseDto.builder().transRef("T1").status(new Status("SUCCESS","200","OK")).build();

        when(participantsConfig.getParticipantConfig(papssId)).thenReturn(participant);
        doNothing().when(participantsConfig).validateParticipantByApiKey(apiKey, participant);
        when(creditTransferService.getTransactionStatus(eq(ref), eq(dt), eq(papssId), eq("alias"), eq("pass")))
                .thenReturn(expected);

        TxStatusResponseDto resp = controller.getTxStatus(papssId, apiKey, ref, dt);

        assertThat(resp).isEqualTo(expected);
        verify(creditTransferService).getTransactionStatus(eq(ref), eq(dt), eq(papssId), eq("alias"), eq("pass"));
    }

    @Test
    void requestModification_shouldDelegateAndReturn() throws Exception {
        String papssId = "PAPSS123";
        String apiKey = "APIKEY";
        PendingRequest pendingRequest = new PendingRequest();
        FTResponse expected = FTResponse.builder().instId("INST1").status(new Status("SUCCESS","200","OK")).build();

        when(participantsConfig.getParticipantConfig(papssId)).thenReturn(participant);
        doNothing().when(participantsConfig).validateParticipantByApiKey(apiKey, participant);
        when(creditTransferService.requestModification(eq(pendingRequest), eq("INST1"), eq(participant)))
                .thenReturn(expected);

        FTResponse resp = controller.ftControl(papssId, apiKey, pendingRequest);

        assertThat(resp).isEqualTo(expected);
        verify(creditTransferService).requestModification(eq(pendingRequest), eq("INST1"), eq(participant));
    }

    @Test
    void paymentRecallRequest_shouldDelegateAndReturn() throws Exception {
        String papssId = "PAPSS123";
        String apiKey = "APIKEY";
        PaymentRecallDto dto = new PaymentRecallDto();
        TxStatusResponseDto expected = TxStatusResponseDto.builder().instId("INST1").status(new Status("SUCCESS","200","OK")).build();

        when(participantsConfig.getParticipantConfig(papssId)).thenReturn(participant);
        doNothing().when(participantsConfig).validateParticipantByApiKey(apiKey, participant);
        when(creditTransferService.paymentCancellationRequest(eq(dto), eq(papssId), eq("alias"), eq("pass")))
                .thenReturn(expected);

        TxStatusResponseDto resp = controller.sendPaymentRecallRequest(papssId, apiKey, dto);
        assertThat(resp).isEqualTo(expected);
        verify(creditTransferService).paymentCancellationRequest(eq(dto), eq(papssId), eq("alias"), eq("pass"));
    }

    @Test
    void paymentRecallReject_shouldDelegateAndReturn() throws Exception {
        String papssId = "PAPSS123";
        String apiKey = "APIKEY";
        PaymentRecallRejectionDto dto = new PaymentRecallRejectionDto();
        TxStatusResponseDto expected = TxStatusResponseDto.builder().instId("INST1").status(new Status("SUCCESS","200","OK")).build();

        when(participantsConfig.getParticipantConfig(papssId)).thenReturn(participant);
        doNothing().when(participantsConfig).validateParticipantByApiKey(apiKey, participant);
        when(creditTransferService.paymentCancellationStatus(eq(dto), eq("INST1"), eq("alias"), eq("pass")))
                .thenReturn(expected);

        TxStatusResponseDto resp = controller.sendPaymentReject(papssId, apiKey, dto);
        assertThat(resp).isEqualTo(expected);
        verify(creditTransferService).paymentCancellationStatus(eq(dto), eq("INST1"), eq("alias"), eq("pass"));
    }
}
