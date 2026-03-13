package com.papss.middleware.service.outbound;

import com.papss.middleware.dto.rtpmessage.RtpMessageDto;
import com.papss.middleware.models.Participant;
import com.papss.middleware.service.PapssService;
import com.papss.middleware.service.PapssSignature;
import com.papss.middleware.service.outbound.domains.credittransfer.FTResponse;
import com.papss.middleware.service.outbound.domains.financialinstitution.FinancialInstitutionRequest;
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

public class FinancialInstitutionServiceTest {

    private RequestUtils requestUtils;
    private ResponseUtils responseUtils;
    private PapssSignature papssSignature;
    private PapssService papssService;

    private FinancialInstitutionService service;

    @BeforeEach
    void setUp() {
        requestUtils = mock(RequestUtils.class);
        responseUtils = mock(ResponseUtils.class);
        papssSignature = mock(PapssSignature.class);
        papssService = mock(PapssService.class);
        service = new FinancialInstitutionService(requestUtils, responseUtils, papssSignature, papssService, null);
    }

    private Participant participant() {
        Participant p = new Participant();
        p.setSslKeyAlias("alias");
        p.setKeyPass("secure");
        return p;
    }

    @Test
    void sendFinancialInstitutionMessage_happyPath() throws SignatureException, JAXBException, IOException {
        FinancialInstitutionRequest req = new FinancialInstitutionRequest();
        when(requestUtils.generateFinancialInstitutionMessage(any(), any(), anyString(), anyString())).thenReturn("<xml/>");
        when(papssSignature.generateSignature(anyString(), anyString(), anyString())).thenReturn("<signed/>");
        RtpMessageDto dto = RtpMessageDto.builder().content("resp").build();
        when(papssService.sendMessage(anyString(), anyString(), anyString())).thenReturn(dto);
        FTResponse expected = new FTResponse();
        when(responseUtils.generateResponse(eq(dto), eq(req), any())).thenReturn(expected);

        FTResponse actual = service.sendFinancialInstitutionMessage(req, "P01", participant());

        assertSame(expected, actual);
        verify(requestUtils).generateFinancialInstitutionMessage(eq(req), any(), eq("P01"), eq("alias"));
        verify(papssSignature).generateSignature(anyString(), eq("alias"), eq("secure"));
        verify(papssService).sendMessage(eq("P01"), anyString(), eq("alias"));
        verify(responseUtils).generateResponse(eq(dto), eq(req), any());
    }
}
