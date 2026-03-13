package com.papss.middleware.utils;

import com.papss.middleware.service.KeyStoreService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

public class HttpClientTest {

    private KeyStoreService keyStoreService;
    private RestTemplate restTemplate;
    private HttpClient client;

    @BeforeEach
    void setUp() {
        keyStoreService = mock(KeyStoreService.class);
        restTemplate = mock(RestTemplate.class);
        client = new HttpClient(keyStoreService);
        when(keyStoreService.getRestTemplate("alias")).thenReturn(restTemplate);
    }

    @Test
    void getClient_delegatesToRestTemplateExchange() {
        ResponseEntity<String> resp = ResponseEntity.ok("OK");
        when(restTemplate.exchange(anyString(), eq(HttpMethod.GET), any(HttpEntity.class), eq(String.class)))
                .thenReturn(resp);

        ResponseEntity<String> actual = client.getClient("https://example", new HttpEntity<>(""), "alias", String.class);
        assertSame(resp, actual);
        verify(restTemplate).exchange(eq("https://example"), eq(HttpMethod.GET), any(HttpEntity.class), eq(String.class));
    }

    @Test
    void postClient_delegatesToRestTemplateExchange() {
        ResponseEntity<String> resp = ResponseEntity.ok("OK");
        when(restTemplate.exchange(anyString(), eq(HttpMethod.POST), any(HttpEntity.class), eq(String.class)))
                .thenReturn(resp);

        ResponseEntity<String> actual = client.postClient("https://example", new HttpEntity<>("body"), "alias", String.class);
        assertSame(resp, actual);
        verify(restTemplate).exchange(eq("https://example"), eq(HttpMethod.POST), any(HttpEntity.class), eq(String.class));
    }
}
