package com.equitybank.gag.telco_b2c.security;

import io.jsonwebtoken.Claims;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Set;

@Component
public class TokenValidationFilter extends OncePerRequestFilter {

    private final TokenService tokenService;

    public TokenValidationFilter(TokenService tokenService) {
        this.tokenService = tokenService;
    }

    // Endpoints to secure
    private static final Set<String> SECURED_ENDPOINTS = Set.of(
            "/api/airtimetopup",
            "/api/airtimestatus"
    );

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {

        // Check if the request URI matches any of the secured endpoints
        if (isSecuredEndpoint(request.getRequestURI())) {
            // Extract the Authorization header
            String authorizationHeader = request.getHeader("Authorization");

            if (authorizationHeader != null && authorizationHeader.startsWith("Bearer ")) {
                String token = authorizationHeader.substring(7); // Get token from "Bearer <token>"

                try {
                    // Validate the token
                    Claims claims = tokenService.validateToken(token);

                    // If token is valid, set authentication in the security context
                    if (claims != null) {
                        String username = claims.getSubject(); // Extract username from claims
                        Authentication authentication = new UsernamePasswordAuthenticationToken(username, null, new ArrayList<>());
                        SecurityContextHolder.getContext().setAuthentication(authentication);
                    } else {
                        // Token is invalid or expired
                        sendUnauthorizedResponse(request, response);
                        return; // Don't continue the filter chain
                    }
                } catch (Exception e) {
                    // If the token is invalid or expired, send 401 Unauthorized response
                    sendUnauthorizedResponse(request, response);
                    return; // Don't continue the filter chain
                }
            } else {
                sendUnauthorizedResponse(request, response);
                return;
            }
        }

        // Continue with the filter chain (proceed to the next filter)
        filterChain.doFilter(request, response);
    }

    private boolean isSecuredEndpoint(String requestUri) {
        for (String endpoint : SECURED_ENDPOINTS) {
            if (requestUri.startsWith(endpoint)) {
                return true;
            }
        }
        return false;
    }

    private void sendUnauthorizedResponse(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        response.setContentType("application/json"); // Set content type to JSON

        // Common JSON response
        String jsonResponse = "{\n" +
                "  \"Envelope\": {\n" +
                "    \"Body\": {\n" +
                "      \"topupResponse\": {\n" +
                "        \"return\": \"ERROR|401\"\n" +
                "      }\n" +
                "    }\n" +
                "  }\n" +
                "}";

        response.getWriter().write(jsonResponse);
    }
}