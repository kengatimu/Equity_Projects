package com.papss.middleware.service.inbound;

import com.papss.middleware.config.ParticipantsConfig;
import com.papss.middleware.config.SystemConfig;
import com.papss.middleware.models.Participant;
import com.papss.middleware.repositories.PapssMessageRepository;
import com.papss.middleware.repositories.TransactionRepository;
import com.papss.middleware.service.KeyStoreService;
import com.papss.middleware.service.LoggerService;
import com.papss.middleware.service.PapssService;
import com.papss.middleware.utils.HttpClient;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.springframework.context.ApplicationContext;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

public class ParticipantProcessorServiceTest {

    private ParticipantsConfig participantsConfig;
    private SystemConfig systemConfig;
    private HttpClient httpClient;
    private KeyStoreService keyStoreService;
    private ApplicationContext applicationContext;
    private LoggerService loggerService;
    private PapssService papssService;
    private PapssMessageRepository papssMessageRepository;
    private TransactionRepository transactionRepository;

    private ParticipantProcessorService service;

    @BeforeEach
    void setUp() {
        participantsConfig = mock(ParticipantsConfig.class);
        systemConfig = mock(SystemConfig.class);
        httpClient = mock(HttpClient.class);
        keyStoreService = mock(KeyStoreService.class);
        applicationContext = mock(ApplicationContext.class);
        loggerService = mock(LoggerService.class);
        papssService = mock(PapssService.class);
        papssMessageRepository = mock(PapssMessageRepository.class);
        transactionRepository = mock(TransactionRepository.class);

        service = new ParticipantProcessorService(
                participantsConfig, systemConfig, httpClient, keyStoreService,
                applicationContext, loggerService, papssService, papssMessageRepository, transactionRepository
        );
    }

    private Participant buildParticipant() {
        Participant p = new Participant();
        p.setInstId("P01");
        p.setInstBic("BIC01");
        p.setCountry("GH");
        p.setSslKeyAlias("alias1");
        p.setKeyPass("secure");
        p.setKeyStorePath("src/main/resources/keystore/client.jks");
        p.setKeyStoreType("JKS");
        p.setProvider("SunJCE");
        return p;
    }

    @Test
    void processParticipant_invokesHttpClientPerConfiguredConcurrency_andSkipsOnEmpty() {
        // given
        when(systemConfig.getIpsBaseUrl()).thenReturn("ips.example");
        when(systemConfig.getIpsPort()).thenReturn("8443");
        when(systemConfig.getPollingExecutorsPerParticipant()).thenReturn(3);

        when(participantsConfig.getParticipants()).thenReturn(List.of(buildParticipant()));

        // Response with EMPTY header to short-circuit processing
        HttpHeaders headers = new HttpHeaders();
        headers.add("X-PAPSSRTP-ReqSts", "EMPTY");
        ResponseEntity<String> empty = ResponseEntity.ok().headers(headers).body("");
        when(httpClient.getClient(anyString(), any(HttpEntity.class), anyString(), eq(String.class))).thenReturn(empty);

        // when
        service.processParticipant();

        // then
        ArgumentCaptor<String> urlCaptor = ArgumentCaptor.forClass(String.class);
        verify(httpClient, atLeast(3)).getClient(urlCaptor.capture(), any(HttpEntity.class), eq("alias1"), eq(String.class));
        // Verify URL constructed correctly
        assertTrue(urlCaptor.getAllValues().stream().allMatch(u -> u.equals("https://ips.example:8443/papss/Message")));

        // verify headers content type and PAPSS channel header present
        ArgumentCaptor<HttpEntity> entityCaptor = ArgumentCaptor.forClass(HttpEntity.class);
        verify(httpClient, atLeastOnce()).getClient(anyString(), entityCaptor.capture(), anyString(), eq(String.class));
        HttpHeaders sent = entityCaptor.getValue().getHeaders();
        assertEquals(MediaType.APPLICATION_XML, sent.getContentType());
        assertEquals("P01", sent.getFirst("X-PAPSSRTP-Channel"));
        assertEquals("1", sent.getFirst("X-PAPSS-RTP-Version"));
    }
}
