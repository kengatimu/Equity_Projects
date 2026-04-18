package com.equitybank.drplatform.audit;

import com.equitybank.drplatform.security.DrPlatformUserDetails;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import org.postgresql.util.PGobject;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.support.TransactionTemplate;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.sql.Types;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

/**
 * AOP aspect that writes immutable audit log entries for all @Auditable service calls.
 *
 * <p>Design rules:
 * <ul>
 *   <li>Runs the audit INSERT in a dedicated REQUIRES_NEW transaction so a failure
 *       never aborts the caller's business transaction.</li>
 *   <li>Reads {@code session_id} and {@code actor_email} from {@link AuditContext}
 *       which is populated by:
 *       <ul>
 *         <li>{@code JwtAuthFilter} — for every authenticated request (from JWT jti / email claims)</li>
 *         <li>{@code AuthService} — for auth-route methods that JwtAuthFilter skips</li>
 *       </ul>
 *   </li>
 *   <li>Uses named method parameters (-parameters compiler flag) for before_state.</li>
 *   <li>Redacts any argument / response field whose name matches a sensitive pattern.</li>
 *   <li>Void/null returns write {"outcome":"SUCCESS"} instead of null.</li>
 * </ul>
 */
@Aspect
@Component
@RequiredArgsConstructor
@Slf4j
public class AuditLogAspect {

    private static final Set<String> SENSITIVE_TERMS = Set.of(
        "password", "otp", "code", "pin", "token", "secret",
        "hash", "credential", "key", "passcode"
    );

    private final JdbcTemplate               jdbcTemplate;
    private final ObjectMapper               objectMapper;
    private final PlatformTransactionManager transactionManager;

    // ── Advice ────────────────────────────────────────────────────────────────

    @Around("@annotation(auditable)")
    public Object logAudit(ProceedingJoinPoint joinPoint, Auditable auditable) throws Throwable {

        // ── Pre-invocation capture ──────────────────────────────────────────
        UUID   capturedActorId   = null;
        String capturedActorRole = null;
        final  String capturedIp = extractClientIp();
        String capturedBefore    = null;

        try {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            if (auth != null && auth.getPrincipal() instanceof DrPlatformUserDetails ud) {
                capturedActorId   = ud.getUser().getId();
                capturedActorRole = ud.getRole().name();
            }
            capturedBefore = buildBeforeState(joinPoint);
        } catch (Exception e) {
            log.debug("Audit pre-capture error (non-fatal): {}", e.getMessage());
        }

        final UUID   actorId   = capturedActorId;
        final String actorRole = capturedActorRole;
        final String before    = capturedBefore;

        // ── Proceed ─────────────────────────────────────────────────────────
        Object    result   = null;
        Throwable caughtEx = null;
        try {
            result = joinPoint.proceed();
        } catch (Throwable ex) {
            caughtEx = ex;
        }

        // ── Post-invocation: read AuditContext (populated during proceed) ───
        // AuditContext is set by the service method itself (for auth routes) or
        // by JwtAuthFilter (for all other authenticated requests).
        final String sessionId  = AuditContext.getSessionId();
        final String actorEmail = resolveActorEmail(capturedActorId);

        // ── Write audit in REQUIRES_NEW transaction ─────────────────────────
        try {
            final String after        = buildAfterState(result, caughtEx);
            final String action       = auditable.action();
            final String resourceType = auditable.resourceType().isBlank()
                                        ? null : auditable.resourceType();

            final TransactionTemplate auditTx = new TransactionTemplate(transactionManager);
            auditTx.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRES_NEW);
            auditTx.execute(status -> {
                jdbcTemplate.update(con -> {
                    var ps = con.prepareStatement(
                        "INSERT INTO audit_log " +
                        "(actor_id, actor_email, actor_ip, actor_role, action, resource_type, " +
                        " before_state, after_state, session_id) " +
                        "VALUES (?,?,?,?,?,?,?,?,?)"
                    );
                    // 1. actor_id (UUID / null)
                    if (actorId != null) ps.setObject(1, actorId, Types.OTHER);
                    else                 ps.setNull(1, Types.OTHER);
                    // 2. actor_email (String / null)
                    ps.setString(2, actorEmail);
                    // 3. actor_ip
                    ps.setString(3, capturedIp);
                    // 4. actor_role
                    ps.setString(4, actorRole);
                    // 5. action
                    ps.setString(5, action);
                    // 6. resource_type
                    ps.setString(6, resourceType);
                    // 7. before_state (jsonb)
                    ps.setObject(7, toJsonb(before));
                    // 8. after_state (jsonb)
                    ps.setObject(8, toJsonb(after));
                    // 9. session_id (VARCHAR)
                    ps.setString(9, sessionId);
                    return ps;
                });
                return null;
            });

        } catch (Exception e) {
            log.error("AUDIT LOG WRITE FAILED (non-fatal): {}", e.getMessage());
        }

        if (caughtEx != null) throw caughtEx;
        return result;
    }

    // ── before_state builder ─────────────────────────────────────────────────

    private String buildBeforeState(ProceedingJoinPoint joinPoint) {
        try {
            MethodSignature sig        = (MethodSignature) joinPoint.getSignature();
            String[]        paramNames = sig.getParameterNames();
            Object[]        args       = joinPoint.getArgs();

            Map<String, Object> map = new LinkedHashMap<>();
            for (int i = 0; i < args.length; i++) {
                String name  = (paramNames != null && i < paramNames.length) ? paramNames[i] : "arg" + i;
                Object value = args[i];

                if (isSensitive(name)) {
                    map.put(name, "[REDACTED]");
                } else if (value == null || value instanceof String
                        || value instanceof Number || value instanceof Boolean) {
                    map.put(name, value);
                } else {
                    map.put(name, sanitiseJsonNode(objectMapper.valueToTree(value)));
                }
            }
            return objectMapper.writeValueAsString(map);
        } catch (Exception e) {
            log.debug("before_state build failed: {}", e.getMessage());
            return "{}";
        }
    }

    // ── after_state builder ──────────────────────────────────────────────────

    private String buildAfterState(Object result, Throwable ex) {
        try {
            Map<String, Object> map = new LinkedHashMap<>();

            if (ex != null) {
                map.put("outcome", "FAILURE");
                map.put("error",   ex.getClass().getSimpleName());
                map.put("message", ex.getMessage() != null ? ex.getMessage() : "");
            } else if (result instanceof Boolean b) {
                map.put("outcome", "SUCCESS");
                map.put("result",  b);
            } else if (result != null) {
                map.put("outcome", "SUCCESS");
                map.put("data",    sanitiseJsonNode(objectMapper.valueToTree(result)));
            } else {
                map.put("outcome", "SUCCESS");
            }

            return objectMapper.writeValueAsString(map);
        } catch (Exception e) {
            log.debug("after_state build failed: {}", e.getMessage());
            return ex != null ? "{\"outcome\":\"FAILURE\"}" : "{\"outcome\":\"SUCCESS\"}";
        }
    }

    // ── Actor email resolution ────────────────────────────────────────────────

    /**
     * Resolves the actor email for the current audit event.
     * Priority:
     *   1. AuditContext (set by JwtAuthFilter or the service method itself)
     *   2. SecurityContext authentication principal
     */
    private String resolveActorEmail(UUID knownActorId) {
        // 1. AuditContext — most specific, set by JwtAuthFilter / AuthService
        String fromContext = AuditContext.getActorEmail();
        if (fromContext != null && !fromContext.isBlank()) return fromContext;

        // 2. SecurityContext principal
        try {
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            if (auth != null && auth.getPrincipal() instanceof DrPlatformUserDetails ud) {
                return ud.getUser().getEmail();
            }
        } catch (Exception ignored) {}

        return null;
    }

    // ── Sensitive-data helpers ────────────────────────────────────────────────

    private boolean isSensitive(String name) {
        if (name == null) return false;
        String lower = name.toLowerCase();
        return SENSITIVE_TERMS.stream().anyMatch(lower::contains);
    }

    private JsonNode sanitiseJsonNode(JsonNode node) {
        if (node instanceof ObjectNode obj) {
            ObjectNode clean = objectMapper.createObjectNode();
            obj.fields().forEachRemaining(entry -> {
                if (isSensitive(entry.getKey())) {
                    clean.put(entry.getKey(), "[REDACTED]");
                } else {
                    clean.set(entry.getKey(), sanitiseJsonNode(entry.getValue()));
                }
            });
            return clean;
        }
        if (node instanceof ArrayNode arr) {
            ArrayNode clean = objectMapper.createArrayNode();
            arr.forEach(item -> clean.add(sanitiseJsonNode(item)));
            return clean;
        }
        return node;
    }

    // ── JDBC helpers ─────────────────────────────────────────────────────────

    private PGobject toJsonb(String json) {
        try {
            PGobject obj = new PGobject();
            obj.setType("jsonb");
            obj.setValue(json);
            return obj;
        } catch (Exception e) {
            log.debug("Could not create PGobject for jsonb: {}", e.getMessage());
            return null;
        }
    }

    private String extractClientIp() {
        try {
            ServletRequestAttributes attrs =
                (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
            if (attrs != null) {
                String xff = attrs.getRequest().getHeader("X-Forwarded-For");
                if (xff != null && !xff.isBlank()) return xff.split(",")[0].trim();
                return attrs.getRequest().getRemoteAddr();
            }
        } catch (Exception e) {
            log.debug("Could not extract IP: {}", e.getMessage());
        }
        return null;
    }
}
