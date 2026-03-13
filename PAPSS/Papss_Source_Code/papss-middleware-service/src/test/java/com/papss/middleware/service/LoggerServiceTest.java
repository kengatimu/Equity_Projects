package com.papss.middleware.service;

import com.papss.middleware.dto.rtpmessage.RtpMessageDto;
import com.papss.middleware.dto.txnconfirmation.TxConfirmationDto;
import com.papss.middleware.dto.txnconfirmation.response.TxStatusResponseDto;
import com.papss.middleware.entities.PapssMessage;
import com.papss.middleware.entities.Transaction;
import com.papss.middleware.enums.Direction;
import com.papss.middleware.enums.ErrorCodes;
import com.papss.middleware.repositories.PapssMessageRepository;
import com.papss.middleware.repositories.TransactionRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

public class LoggerServiceTest {

    private PapssMessageRepository papssMessageRepository;
    private TransactionRepository transactionRepository;
    private LoggerService loggerService;

    @BeforeEach
    void setUp() {
        papssMessageRepository = mock(PapssMessageRepository.class);
        transactionRepository = mock(TransactionRepository.class);
        loggerService = new LoggerService(papssMessageRepository, transactionRepository);
    }

    @Test
    void logMessage_updatesExistingEntity() {
        PapssMessage existing = new PapssMessage();
        when(papssMessageRepository.findBySequenceNumber(100L)).thenReturn(Optional.of(existing));

        RtpMessageDto dto = RtpMessageDto.builder()
                .sequence(100L)
                .messageType("pacs.008")
                .statusCode("000")
                .build();

        loggerService.logMessage(dto, true, true, "resp");

        verify(papssMessageRepository).save(existing);
        assertTrue(existing.isConfirmed());
        assertTrue(existing.isProcessed());
        assertEquals("resp", existing.getResponsePayload());
    }

    @Test
    void logMessage_createsNewWhenMissing() {
        when(papssMessageRepository.findBySequenceNumber(200L)).thenReturn(Optional.empty());

        RtpMessageDto dto = RtpMessageDto.builder()
                .sequence(200L)
                .messageType("pacs.008")
                .countryCode("GH")
                .papssId("P01")
                .statusCode(ErrorCodes.UNKNOWN.getValue())
                .isCleared(false)
                .bic("BIC1")
                .content("<xml/>")
                .build();

        loggerService.logMessage(dto, false, false, "");

        verify(papssMessageRepository).save(any(PapssMessage.class));
    }

    @Test
    void logTransaction_updateExisting() {
        Transaction existing = new Transaction();
        existing.setEndToEndId("E2E");
        when(transactionRepository.findByEndToEndId(any())).thenReturn(Optional.of(existing));

        RtpMessageDto rtp = RtpMessageDto.builder()
                .statusCode("000")
                .description("desc")
                .errorMapping("ACCP")
                .build();

        loggerService.logTransaction("<pacs008/>", rtp, Direction.IN);

        verify(transactionRepository).save(existing);
        assertEquals("000", existing.getError());
        assertEquals("desc", existing.getErrorDescription());
        assertEquals("ACCP", existing.getStatus());
    }

    @Test
    void logTransaction_withTxConfirmation_createsWhenMissing() {
        when(transactionRepository.findByEndToEndId("REF1")).thenReturn(Optional.empty());
        RtpMessageDto rtp = RtpMessageDto.builder()
                .content("<xml/>")
                .build();
        TxConfirmationDto txc = new TxConfirmationDto();
        com.papss.middleware.service.outbound.domains.credittransfer.Status status =
                new com.papss.middleware.service.outbound.domains.credittransfer.Status("ACCP","000","ok");
        txc.setTransRef("REF1");
        txc.setStatus(status);

        loggerService.logTransaction(rtp, txc, Direction.OUT);

        verify(transactionRepository).save(any(Transaction.class));
    }
}
