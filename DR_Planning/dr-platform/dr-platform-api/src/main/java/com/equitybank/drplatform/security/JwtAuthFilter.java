package com.equitybank.drplatform.security;

import com.equitybank.drplatform.audit.AuditContext;
import com.equitybank.drplatform.entity.UserEntity;
import com.equitybank.drplatform.repository.UserRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

@Component
@RequiredArgsConstructor
@Slf4j
public class JwtAuthFilter extends OncePerRequestFilter {

    private final JwtService     jwtService;
    private final UserRepository userRepository;
    private final ObjectMapper   objectMapper;

    @Override
    protected boolean shouldNotFilter(HttpServletRequest request) {
        String path = request.getServletPath();
        return path.startsWith("/api/auth/") || path.startsWith("/actuator/health");
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain) throws ServletException, IOException {
        final String authHeader = request.getHeader("Authorization");

        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            sendUnauthorized(response);
            return;
        }

        final String token = authHeader.substring(7);

        try {
            if (!jwtService.validateToken(token)) {
                sendUnauthorized(response);
                return;
            }

            String userIdStr = jwtService.extractUserId(token);
            UUID   userId    = UUID.fromString(userIdStr);

            Optional<UserEntity> userOpt = userRepository.findById(userId);
            if (userOpt.isEmpty() || !userOpt.get().isActive()) {
                sendUnauthorized(response);
                return;
            }

            UserEntity user = userOpt.get();

            // ── Stamp AuditContext so every @Auditable call in this request
            //    automatically picks up the session_id and actor_email. ──────
            String sessionId = jwtService.extractSessionId(token);
            String email     = jwtService.extractEmail(token);
            if (sessionId != null) AuditContext.setSessionId(sessionId);
            if (email     != null) AuditContext.setActorEmail(email);

            DrPlatformUserDetails userDetails = new DrPlatformUserDetails(user);
            UsernamePasswordAuthenticationToken authToken =
                    new UsernamePasswordAuthenticationToken(
                            userDetails, null, userDetails.getAuthorities());
            authToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
            SecurityContextHolder.getContext().setAuthentication(authToken);

        } catch (Exception e) {
            log.debug("JWT auth failed: {}", e.getMessage());
            sendUnauthorized(response);
            return;
        }

        filterChain.doFilter(request, response);
    }

    private void sendUnauthorized(HttpServletResponse response) throws IOException {
        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        response.setContentType(MediaType.APPLICATION_JSON_VALUE);
        objectMapper.writeValue(response.getWriter(),
                Map.of("error", "Unauthorized", "status", 401));
    }
}
