package com.equitybank.drplatform.audit;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/**
 * Request-scoped store for audit correlation data.
 *
 * <p>Values are kept as HTTP request attributes so they survive the full
 * call stack without explicit parameter threading.
 *
 * <p>Two sources populate this context:
 * <ol>
 *   <li><strong>Auth endpoints</strong> (OTP request/verify, logout) — the service
 *       method sets session_id and actor_email directly via
 *       {@link #setSessionId} / {@link #setActorEmail}.</li>
 *   <li><strong>All authenticated endpoints</strong> — {@code JwtAuthFilter}
 *       extracts the {@code jti} (session_id) and {@code email} claims from
 *       the JWT and calls the same setters before the request reaches any
 *       controller or service.</li>
 * </ol>
 *
 * <p>{@link AuditLogAspect} then reads these values when writing the
 * {@code audit_log} row, ensuring every event in a session shares the
 * same {@code session_id} and a human-readable {@code actor_email}.
 */
public final class AuditContext {

    /** Request attribute key for the session correlation UUID string. */
    public static final String KEY_SESSION_ID   = "AUDIT_SESSION_ID";

    /** Request attribute key for the actor's email address. */
    public static final String KEY_ACTOR_EMAIL  = "AUDIT_ACTOR_EMAIL";

    private AuditContext() {}

    // ── Setters ───────────────────────────────────────────────────────────────

    public static void setSessionId(String sessionId) {
        setAttribute(KEY_SESSION_ID, sessionId);
    }

    public static void setActorEmail(String email) {
        setAttribute(KEY_ACTOR_EMAIL, email);
    }

    // ── Getters ───────────────────────────────────────────────────────────────

    public static String getSessionId() {
        return (String) getAttribute(KEY_SESSION_ID);
    }

    public static String getActorEmail() {
        return (String) getAttribute(KEY_ACTOR_EMAIL);
    }

    // ── Internals ─────────────────────────────────────────────────────────────

    private static void setAttribute(String key, Object value) {
        try {
            ServletRequestAttributes attrs =
                (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
            if (attrs != null) {
                attrs.getRequest().setAttribute(key, value);
            }
        } catch (Exception ignored) {
            // No active request context (e.g. scheduled tasks) — silently skip.
        }
    }

    private static Object getAttribute(String key) {
        try {
            ServletRequestAttributes attrs =
                (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
            return attrs != null ? attrs.getRequest().getAttribute(key) : null;
        } catch (Exception ignored) {
            return null;
        }
    }
}
