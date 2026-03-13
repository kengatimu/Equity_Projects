package com.papss.middleware.service;

import com.papss.middleware.config.SystemConfig;
import com.papss.middleware.dto.rtpmessage.RtpMessageDto;
import com.papss.middleware.enums.ErrorCodes;
import com.papss.middleware.utils.HttpClient;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

public class PapssServiceTest {

    private SystemConfig systemConfig;
    private HttpClient httpClient;
    private PapssService papssService;

    @BeforeEach
    void setUp() {
        systemConfig = mock(SystemConfig.class);
        when(systemConfig.getIpsBaseUrl()).thenReturn("ips.example");
        when(systemConfig.getIpsPort()).thenReturn("8443");
        httpClient = mock(HttpClient.class);
        papssService = new PapssService(systemConfig, httpClient);
    }

    @Test
    void confirmReceivedMessage_returnsTrueWhenStored() {
        // given
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_XML);
        when(httpClient.postClient(anyString(), any(HttpEntity.class), anyString(), eq(String.class)))
                .thenReturn(ResponseEntity.ok().headers(headers).body("Stored"));

        // when
        boolean confirmed = papssService.confirmReceivedMessage(123L, "PAPSS01", "alias1");

        // then
        assertTrue(confirmed);

        // verify URL built correctly and headers contain required values
        ArgumentCaptor<String> urlCaptor = ArgumentCaptor.forClass(String.class);
        ArgumentCaptor<HttpEntity> entityCaptor = ArgumentCaptor.forClass(HttpEntity.class);
        verify(httpClient).postClient(urlCaptor.capture(), entityCaptor.capture(), eq("alias1"), eq(String.class));
        assertEquals("https://ips.example:8443/papss/MessageAck", urlCaptor.getValue());
        HttpHeaders sentHeaders = (HttpHeaders) entityCaptor.getValue().getHeaders();
        assertEquals(MediaType.APPLICATION_XML, sentHeaders.getContentType());
        assertEquals("PAPSS01", sentHeaders.getFirst("X-PAPSSRTP-Channel"));
        assertEquals("123", sentHeaders.getFirst("X-PAPSSRTP-MessageSeq"));
    }

    @Test
    void sendMessage_parsesHeadersAndBody_intoDto() {
        // given
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.add("X-PAPSSRTP-MessageType", "pacs.008");
        responseHeaders.add("X-PAPSSRTP-MessageSeq", "999");
        responseHeaders.add("X-PAPSSRTP-ReqSts", ErrorCodes.UNKNOWN.getMapping()); // ACCP

        when(httpClient.postClient(anyString(), any(HttpEntity.class), anyString(), eq(String.class)))
                .thenReturn(ResponseEntity.ok().headers(responseHeaders).body("<ok/>"));

        // when
        RtpMessageDto dto = papssService.sendMessage("P01", "<xml/>", "aliasX");

        // then
        assertNotNull(dto);
        assertEquals("pacs.008", dto.getMessageType());
        assertEquals(999L, dto.getSequence());
        assertEquals(ErrorCodes.UNKNOWN.getMapping(), dto.getErrorMapping());
        assertEquals(ErrorCodes.UNKNOWN.getValue(), dto.getStatusCode());
        assertEquals("<ok/>", dto.getContent());

        // verify URL and headers
        ArgumentCaptor<String> urlCaptor = ArgumentCaptor.forClass(String.class);
        ArgumentCaptor<HttpEntity> entityCaptor = ArgumentCaptor.forClass(HttpEntity.class);
        verify(httpClient).postClient(urlCaptor.capture(), entityCaptor.capture(), eq("aliasX"), eq(String.class));
        assertEquals("https://ips.example:8443/papss/Message", urlCaptor.getValue());
        HttpHeaders sentHeaders = (HttpHeaders) entityCaptor.getValue().getHeaders();
        assertEquals(MediaType.APPLICATION_XML, sentHeaders.getContentType());
        assertEquals("P01", sentHeaders.getFirst("X-PAPSSRTP-Channel"));
        assertEquals("1", sentHeaders.getFirst("X-PAPSS-RTP-Version"));
        assertEquals("ips.example:8443", sentHeaders.getFirst("Host"));
        assertEquals("*/*", sentHeaders.getFirst("Accept"));
        assertEquals("gzip", sentHeaders.getFirst("Accept-Encoding"));
    }
}
