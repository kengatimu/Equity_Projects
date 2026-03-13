package com.papss.middleware.security;

import com.papss.middleware.config.ParticipantsConfig;
import com.papss.middleware.models.Participant;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;

import java.io.IOException;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

class ApiKeyAuthFilterTest {

    ParticipantsConfig participantsConfig;
    ApiKeyAuthFilter filter;

    @BeforeEach
    void setUp() {
        participantsConfig = mock(ParticipantsConfig.class);
        filter = new ApiKeyAuthFilter(participantsConfig);
        SecurityContextHolder.clearContext();
    }

    @AfterEach
    void tearDown() {
        SecurityContextHolder.clearContext();
    }

    private HttpServletRequest mockRequest(String uri, String papssId, String apiKey) {
        HttpServletRequest request = mock(HttpServletRequest.class);
        when(request.getRequestURI()).thenReturn(uri);
        when(request.getHeader("PAPSS-ID")).thenReturn(papssId);
        when(request.getHeader("PAPSS-API-KEY")).thenReturn(apiKey);
        return request;
    }

    @Test
    void skipsAuthenticationForApiDocsPaths() throws ServletException, IOException {
        HttpServletRequest request = mockRequest("/api-docs/index.html", null, null);
        HttpServletResponse response = mock(HttpServletResponse.class);
        FilterChain chain = mock(FilterChain.class);

        filter.doFilterInternal(request, response, chain);

        // Should not authenticate and must continue the chain
        assertNull(SecurityContextHolder.getContext().getAuthentication());
        verify(chain, times(1)).doFilter(request, response);
    }

    @Test
    void skipsAuthenticationForSwaggerUiPaths() throws ServletException, IOException {
        HttpServletRequest request = mockRequest("/swagger-ui/index.html", null, null);
        HttpServletResponse response = mock(HttpServletResponse.class);
        FilterChain chain = mock(FilterChain.class);

        filter.doFilterInternal(request, response, chain);

        assertNull(SecurityContextHolder.getContext().getAuthentication());
        verify(chain, times(1)).doFilter(request, response);
    }

    @Test
    void setsAuthenticationWhenHeadersValid() throws ServletException, IOException {
        String papssId = "BANK-123";
        String apiKey = "secret-key";
        HttpServletRequest request = mockRequest("/api/transfer", papssId, apiKey);
        HttpServletResponse response = mock(HttpServletResponse.class);
        FilterChain chain = mock(FilterChain.class);

        Participant participant = new Participant();
        participant.setInstId(papssId);
        participant.setApiKey(apiKey);
        when(participantsConfig.getParticipantConfig(papssId)).thenReturn(participant);

        filter.doFilterInternal(request, response, chain);

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        assertNotNull(auth, "Authentication should be set");
        assertEquals(papssId, auth.getPrincipal());
        List<? extends GrantedAuthority> authorities = (List<? extends GrantedAuthority>) auth.getAuthorities();
        assertEquals(1, authorities.size());
        assertEquals("ROLE_USER", authorities.get(0).getAuthority());
        verify(chain, times(1)).doFilter(request, response);
    }

    @Test
    void doesNotAuthenticateWhenHeadersMissing() throws ServletException, IOException {
        HttpServletRequest request = mockRequest("/api/transfer", null, null);
        HttpServletResponse response = mock(HttpServletResponse.class);
        FilterChain chain = mock(FilterChain.class);

        filter.doFilterInternal(request, response, chain);

        assertNull(SecurityContextHolder.getContext().getAuthentication());
        verify(chain, times(1)).doFilter(request, response);
    }

    @Test
    void doesNotAuthenticateWhenApiKeyInvalid() throws ServletException, IOException {
        String papssId = "BANK-123";
        HttpServletRequest request = mockRequest("/api/transfer", papssId, "wrong-key");
        HttpServletResponse response = mock(HttpServletResponse.class);
        FilterChain chain = mock(FilterChain.class);

        Participant participant = new Participant();
        participant.setInstId(papssId);
        participant.setApiKey("expected-key");
        when(participantsConfig.getParticipantConfig(papssId)).thenReturn(participant);

        filter.doFilterInternal(request, response, chain);

        assertNull(SecurityContextHolder.getContext().getAuthentication(), "Authentication should not be set for invalid api key");
        verify(chain, times(1)).doFilter(request, response);
    }

    @Test
    void continuesFilterChainWhenParticipantsConfigThrows() throws ServletException, IOException {
        String papssId = "UNKNOWN";
        HttpServletRequest request = mockRequest("/api/transfer", papssId, "some-key");
        HttpServletResponse response = mock(HttpServletResponse.class);
        FilterChain chain = mock(FilterChain.class);

        when(participantsConfig.getParticipantConfig(papssId)).thenThrow(new IllegalArgumentException("not found"));

        // Ensure no exception propagates and chain continues
        assertDoesNotThrow(() -> filter.doFilterInternal(request, response, chain));
        assertNull(SecurityContextHolder.getContext().getAuthentication());
        verify(chain, times(1)).doFilter(request, response);
    }
}
