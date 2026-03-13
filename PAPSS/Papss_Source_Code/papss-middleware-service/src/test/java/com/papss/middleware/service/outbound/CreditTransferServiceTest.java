package com.papss.middleware.service.outbound;

import com.papss.middleware.dto.paymentreturn.PaymentRecallDto;
import com.papss.middleware.dto.rtpmessage.RtpMessageDto;
import com.papss.middleware.dto.txnconfirmation.response.TxStatusResponseDto;
import com.papss.middleware.models.Participant;
import com.papss.middleware.service.PapssService;
import com.papss.middleware.service.PapssSignature;
import com.papss.middleware.service.outbound.domains.creditreturn.CreditReturnRequest;
import com.papss.middleware.service.outbound.domains.creditreturn.PaymentRecallRejectionDto;
import com.papss.middleware.service.outbound.domains.credittransfer.CreditTransferRequest;
import com.papss.middleware.service.outbound.domains.credittransfer.FTResponse;
import com.papss.middleware.service.outbound.domains.pending.PendingRequest;
import com.papss.middleware.utils.RequestUtils;
import com.papss.middleware.utils.ResponseUtils;
import com.papss.middleware.utils.Utils;
import jakarta.xml.bind.JAXBException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.io.IOException;
import java.security.SignatureException;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

public class CreditTransferServiceTest {

    private RequestUtils requestUtils;
    private ResponseUtils responseUtils;
    private PapssSignature papssSignature;
    private PapssService papssService;
    private CreditTransferService service;

    @BeforeEach
    void setUp() {
        requestUtils = mock(RequestUtils.class);
        responseUtils = mock(ResponseUtils.class);
        papssSignature = mock(PapssSignature.class);
        papssService = mock(PapssService.class);
        service = new CreditTransferService(requestUtils, responseUtils, papssSignature, papssService, null);
    }

    private Participant participant() {
        Participant p = new Participant();
        p.setSslKeyAlias("alias");
        p.setKeyPass("secure");
        return p;
    }

    @Test
    void requestModification_happyPath() throws SignatureException, JAXBException, IOException {
        PendingRequest dto = new PendingRequest();
        when(requestUtils.generateModifyPaymentMessage(any())).thenReturn("<camt007/>");
        when(papssSignature.generateSignature(anyString(), anyString(), anyString())).thenReturn("<signed/>");
        RtpMessageDto rtp = RtpMessageDto.builder().build();
        when(papssService.sendMessage(anyString(), anyString(), anyString())).thenReturn(rtp);
        FTResponse expected = new FTResponse();
        when(responseUtils.generateResponse(eq(rtp), eq(dto), any())).thenReturn(expected);

        FTResponse actual = service.requestModification(dto, "P01", participant());
        assertSame(expected, actual);
        verify(requestUtils).generateModifyPaymentMessage(eq(dto));
        verify(papssService).sendMessage(eq("P01"), anyString(), eq("alias"));
        verify(responseUtils).generateResponse(eq(rtp), eq(dto), any());
    }

    @Test
    void sendFTMessage_happyPath() throws SignatureException, JAXBException, IOException {
        CreditTransferRequest dto = new CreditTransferRequest();
        when(requestUtils.generateMessage(any(), any(), anyString(), anyString())).thenReturn("<pacs008/>");
        when(papssSignature.generateSignature(anyString(), anyString(), anyString())).thenReturn("<signed/>");
        RtpMessageDto rtp = RtpMessageDto.builder().build();
        when(papssService.sendMessage(anyString(), anyString(), anyString())).thenReturn(rtp);
        FTResponse expected = new FTResponse();
        when(responseUtils.generateResponse(eq(rtp), eq(dto), any())).thenReturn(expected);

        FTResponse actual = service.sendFTMessage(dto, "P01", participant());
        assertSame(expected, actual);
    }

    @Test
    void getTransactionStatus_happyPath() throws SignatureException {
        when(requestUtils.generateMessage(anyString(), anyString(), anyString())).thenReturn("<pacs028/>");
        when(papssSignature.generateSignature(anyString(), anyString(), anyString())).thenReturn("<signed/>");
        RtpMessageDto rtp = RtpMessageDto.builder().build();
        when(papssService.sendMessage(anyString(), anyString(), anyString())).thenReturn(rtp);
        TxStatusResponseDto expected = new TxStatusResponseDto();
        when(responseUtils.generateResponse(eq(rtp), any(javax.xml.datatype.XMLGregorianCalendar.class))).thenReturn(expected);

        TxStatusResponseDto actual = service.getTransactionStatus("ref1", "2024-01-01T00:00:00Z", "P01", "alias", "secure");
        assertSame(expected, actual);
    }

    @Test
    void paymentCancellationRequest_happyPath() throws Exception {
        PaymentRecallDto dto = new PaymentRecallDto();
        when(requestUtils.generateMessageForPaymentCancellation(any(), any(), any())).thenReturn("<camt056/>");
        when(papssSignature.generateSignature(anyString(), anyString(), anyString())).thenReturn("<signed/>");
        RtpMessageDto rtp = RtpMessageDto.builder().build();
        when(papssService.sendMessage(anyString(), anyString(), anyString())).thenReturn(rtp);
        TxStatusResponseDto expected = new TxStatusResponseDto();
        when(responseUtils.generateResponse(eq(rtp), any(), eq(dto))).thenReturn(expected);

        TxStatusResponseDto actual = service.paymentCancellationRequest(dto, "P01", "alias", "secure");
        assertSame(expected, actual);
    }

    @Test
    void returnCreditReturnMessage_happyPath() throws Exception {
        CreditReturnRequest dto = new CreditReturnRequest();
        when(requestUtils.generateMessage(any(CreditReturnRequest.class), anyString(),anyString(), any(), any())).thenReturn("<pacs004/>");
        when(papssSignature.generateSignature(anyString(), anyString(), anyString())).thenReturn("<signed/>");
        RtpMessageDto rtp = RtpMessageDto.builder().build();
        when(papssService.sendMessage(anyString(), anyString(), anyString())).thenReturn(rtp);
        TxStatusResponseDto expected = new TxStatusResponseDto();
        when(responseUtils.generateResponse(eq(rtp), any(), eq(dto))).thenReturn(expected);

        TxStatusResponseDto actual = service.returnCreditReturnMessage(dto, "P01", "alias", "secure");
        assertSame(expected, actual);
    }

    @Test
    void paymentCancellationStatus_happyPath() throws Exception {
        PaymentRecallRejectionDto dto = new PaymentRecallRejectionDto();
        when(requestUtils.generateMessageForPaymentCancellationStatus(any(), any(), any())).thenReturn("<camt029/>");
        when(papssSignature.generateSignature(anyString(), anyString(), anyString())).thenReturn("<signed/>");
        RtpMessageDto rtp = RtpMessageDto.builder().build();
        when(papssService.sendMessage(anyString(), anyString(), anyString())).thenReturn(rtp);
        TxStatusResponseDto expected = new TxStatusResponseDto();
        when(responseUtils.generateResponse(eq(rtp), any(), eq(dto))).thenReturn(expected);

        TxStatusResponseDto actual = service.paymentCancellationStatus(dto, "P01", "alias", "secure");
        assertSame(expected, actual);
    }
}
