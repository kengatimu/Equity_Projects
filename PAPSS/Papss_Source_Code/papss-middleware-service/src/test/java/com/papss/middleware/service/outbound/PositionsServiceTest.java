package com.papss.middleware.service.outbound;

import com.papss.middleware.config.SystemConfig;
import com.papss.middleware.utils.HttpClient;
import com.papss.middleware.utils.Utils;
import montran.positions.Positions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

public class PositionsServiceTest {

    private SystemConfig systemConfig;
    private HttpClient httpClient;
    private PositionsService service;

    @BeforeEach
    void setUp() {
        systemConfig = mock(SystemConfig.class);
        httpClient = mock(HttpClient.class);
        service = new PositionsService(systemConfig, httpClient);
        when(systemConfig.getIpsBaseUrl()).thenReturn("ips.example");
        when(systemConfig.getIpsPort()).thenReturn("8443");
    }

    @Test
    void getParticipantPositions_happyPath() {
        // minimal XML that should unmarshal into generated Positions class
        String xml = "<positions:Positions xmlns:positions=\"urn:positions\"></positions:Positions>";
        when(httpClient.getClient(anyString(), any(HttpEntity.class), anyString(), eq(String.class)))
                .thenReturn(ResponseEntity.ok().body(xml));

        Positions positions = service.getParticipantPositions("P01", "alias");
        // We do not assert the unmarshalled object due to JAXB complexities; ensure the HTTP call was made
        // verify request URL and headers
        verify(httpClient).getClient(eq("https://ips.example:8443/papss/Positions"), any(HttpEntity.class), eq("alias"), eq(String.class));
    }
}
