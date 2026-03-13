package com.papss.middleware.config;

import com.papss.middleware.security.ApiKeyAuthFilter;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import jakarta.servlet.Filter;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

class SecurityConfigTest {

    @Test
    void securityFilterChain_addsApiKeyFilter_andBuilds() throws Exception {
        ParticipantsConfig participants = mock(ParticipantsConfig.class);
        SecurityConfig config = new SecurityConfig(participants);

        HttpSecurity http = mock(HttpSecurity.class, RETURNS_SELF);

        // Invoke configuration method
        config.securityFilterChain(http);

        ArgumentCaptor<Filter> filterCaptor = ArgumentCaptor.forClass(Filter.class);
        verify(http, atLeastOnce()).addFilterBefore(filterCaptor.capture(), eq(UsernamePasswordAuthenticationFilter.class));
        Filter addedFilter = filterCaptor.getValue();
        assertTrue(addedFilter instanceof ApiKeyAuthFilter, "ApiKeyAuthFilter should be added before UsernamePasswordAuthenticationFilter");

        verify(http, atLeastOnce()).sessionManagement(any());
        verify(http, atLeastOnce()).headers(any());
        verify(http, atLeastOnce()).authorizeHttpRequests(any());
        verify(http, atLeastOnce()).httpBasic(any());
        verify(http).build();
    }
}
