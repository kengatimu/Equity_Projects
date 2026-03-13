package com.papss.middleware.security;

import com.papss.middleware.config.ParticipantsConfig;
import com.papss.middleware.models.Participant;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.Collections;
import java.util.Optional;

public class ApiKeyAuthFilter extends OncePerRequestFilter {

    private final ParticipantsConfig participantsConfig;
    private static final String PAPSS_ID_HEADER = "PAPSS-ID";
    private static final String PAPSS_API_KEY_HEADER = "PAPSS-API-KEY";

    public ApiKeyAuthFilter(ParticipantsConfig participantsConfig) {
        this.participantsConfig = participantsConfig;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {
        
        // Skip authentication for permitted paths
        String path = request.getRequestURI();
        if (path.startsWith("/api-docs") || path.startsWith("/swagger-ui")) {
            filterChain.doFilter(request, response);
            return;
        }
        
        String papssId = request.getHeader(PAPSS_ID_HEADER);
        String apiKey = request.getHeader(PAPSS_API_KEY_HEADER);
        
        if (papssId != null && apiKey != null) {
            try {
                Participant participant = participantsConfig.getParticipantConfig(papssId);
                
                if (apiKey.equals(participant.getApiKey())) {
                    // Create authentication token with ROLE_USER authority
                    UsernamePasswordAuthenticationToken authentication = 
                        new UsernamePasswordAuthenticationToken(
                            papssId, 
                            null, 
                            Collections.singletonList(new SimpleGrantedAuthority("ROLE_USER"))
                        );
                    
                    SecurityContextHolder.getContext().setAuthentication(authentication);
                }
            } catch (Exception e) {
                // Log authentication failure but don't expose details
                logger.warn("Authentication failed for PAPSS-ID: " + papssId);
            }
        }
        
        filterChain.doFilter(request, response);
    }
}