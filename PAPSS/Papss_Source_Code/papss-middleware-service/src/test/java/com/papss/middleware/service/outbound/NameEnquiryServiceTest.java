package com.papss.middleware.service.outbound;

import com.papss.middleware.dto.nameinquiry.response.NameInquiryResponse;
import com.papss.middleware.dto.rtpmessage.RtpMessageDto;
import com.papss.middleware.models.Participant;
import com.papss.middleware.service.PapssService;
import com.papss.middleware.service.PapssSignature;
import com.papss.middleware.service.outbound.domains.nameenquiry.NameInquiryRequest;
import com.papss.middleware.utils.RequestUtils;
import com.papss.middleware.utils.ResponseUtils;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.security.SignatureException;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

public class NameEnquiryServiceTest {

    private RequestUtils requestUtils;
    private ResponseUtils responseUtils;
    private PapssSignature papssSignature;
    private PapssService papssService;

    private NameEnquiryService service;

    @BeforeEach
    void setUp() {
        requestUtils = mock(RequestUtils.class);
        responseUtils = mock(ResponseUtils.class);
        papssSignature = mock(PapssSignature.class);
        papssService = mock(PapssService.class);
        service = new NameEnquiryService(requestUtils, responseUtils, papssSignature, papssService);
    }

    private Participant participant() {
        Participant p = new Participant();
        p.setSslKeyAlias("alias");
        p.setKeyPass("secure");
        return p;
    }

    @Test
    void sendNameInquiryMessage_happyPath() throws SignatureException {
        NameInquiryRequest req = new NameInquiryRequest();
                req.setEndToEndRef("E2E");
        when(requestUtils.generateMessage(any(NameInquiryRequest.class))).thenReturn("<acmt023/>");
        when(papssSignature.generateSignature(anyString(), anyString(), anyString())).thenReturn("<signed/>");
        RtpMessageDto rtp = RtpMessageDto.builder().build();
        when(papssService.sendMessage(anyString(), anyString(), anyString())).thenReturn(rtp);
        NameInquiryResponse expected = mock(NameInquiryResponse.class);
        when(responseUtils.generateResponse(eq(rtp), anyString())).thenReturn(expected);

        NameInquiryResponse actual = service.sendNameInquiryMessage(req, "P01", participant());
        assertSame(expected, actual);
        verify(requestUtils).generateMessage(eq(req));
        verify(papssService).sendMessage(eq("P01"), anyString(), eq("alias"));
        verify(responseUtils).generateResponse(eq(rtp), anyString());
    }
}
