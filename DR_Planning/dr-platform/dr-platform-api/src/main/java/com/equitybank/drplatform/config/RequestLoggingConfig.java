package com.equitybank.drplatform.config;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Logs every inbound HTTP request and its result in plain business language.
 *
 * <pre>
 *   → [bishop@equitybank.co.ke]  List applications (page 0, 20 per page)
 *   ← 200 OK  List applications (page 0, 20 per page)  [189 ms]
 *
 *   → [bishop@equitybank.co.ke]  Register dependency for application 019d62ac…
 *   ← 201 Created  Register dependency for application 019d62ac…  [43 ms]
 *
 *   → [bishop@equitybank.co.ke]  Archive application 019d62ac… → history
 *   ← 403 Forbidden  Archive application 019d62ac… → history  [12 ms]
 * </pre>
 */
@Configuration
public class RequestLoggingConfig {

    @Bean
    public OncePerRequestFilter httpRequestLogger() {
        return new HttpRequestLogger();
    }

    @Slf4j
    static class HttpRequestLogger extends OncePerRequestFilter {

        private static final String[] SUPPRESS_PREFIXES = {
            "/actuator/health", "/actuator/info", "/favicon"
        };

        /**
         * Throttle repeated identical GET calls from the same user.
         * Key: "user::action"  →  Value: last-logged timestamp (ms).
         * If the same (user, action) pair is seen again within THROTTLE_MS,
         * the request is still processed but logged at DEBUG instead of INFO,
         * keeping the INFO log clean.
         */
        private static final long THROTTLE_MS = 30_000; // 30 seconds
        private static final ConcurrentHashMap<String, Long> lastLoggedAt = new ConcurrentHashMap<>();

        @Override
        protected boolean shouldNotFilter(HttpServletRequest request) {
            String path = request.getServletPath();
            for (String prefix : SUPPRESS_PREFIXES) {
                if (path.startsWith(prefix)) return true;
            }
            return false;
        }

        @Override
        protected void doFilterInternal(HttpServletRequest request,
                                        HttpServletResponse response,
                                        FilterChain chain) throws ServletException, IOException {

            String method = request.getMethod();
            String path   = request.getRequestURI();
            String query  = request.getQueryString();
            String action = describe(method, path, query);
            String user   = currentUser();

            // Throttle: repeated identical GET calls from the same user within
            // THROTTLE_MS are demoted to DEBUG so INFO stays clean.
            // All writes (POST/PUT/PATCH/DELETE) are always logged at INFO.
            boolean throttled = false;
            if ("GET".equalsIgnoreCase(method)) {
                String key = user + "::" + action;
                long   now = System.currentTimeMillis();
                Long   prev = lastLoggedAt.get(key);
                if (prev != null && (now - prev) < THROTTLE_MS) {
                    throttled = true;
                } else {
                    lastLoggedAt.put(key, now);
                    // Prevent unbounded map growth
                    if (lastLoggedAt.size() > 500) {
                        lastLoggedAt.entrySet().removeIf(e -> (now - e.getValue()) > THROTTLE_MS * 10);
                    }
                }
            }

            long start = System.currentTimeMillis();
            if (throttled) {
                log.debug("→ {}{}", user, action);
            } else {
                log.info("→ {}{}", user, action);
            }

            try {
                chain.doFilter(request, response);
            } finally {
                long   ms         = System.currentTimeMillis() - start;
                int    status     = response.getStatus();
                String statusText = statusLabel(status);

                if (status >= 500) {
                    // Errors always surface at ERROR regardless of throttle
                    log.error("← {} {}  {}  [{} ms]", status, statusText, action, ms);
                } else if (status >= 400) {
                    log.warn("← {} {}  {}  [{} ms]", status, statusText, action, ms);
                } else if (throttled) {
                    log.debug("← {} {}  {}  [{} ms]", status, statusText, action, ms);
                } else {
                    log.info("← {} {}  {}  [{} ms]", status, statusText, action, ms);
                }
            }
        }

        // ─────────────────────────────────────────────────────────────────────
        // URL → plain-English action description
        // ─────────────────────────────────────────────────────────────────────

        private static String describe(String m, String rawPath, String query) {
            // Strip /api context prefix
            String p = rawPath.replaceFirst("^/api", "");

            // ── Applications ──────────────────────────────────────────────────
            if (is(m,"GET")    && p.equals("/applications"))
                return "List applications" + pageInfo(query);
            if (is(m,"POST")   && p.equals("/applications"))
                return "Create new application";
            if (is(m,"GET")    && p.equals("/applications/export"))
                return "Export applications to Excel";
            if (is(m,"POST")   && p.equals("/applications/import"))
                return "Import applications from Excel";
            if (is(m,"GET")    && p.equals("/applications/history"))
                return "Load application archive history";
            if (is(m,"GET")    && p.matches("/applications/[^/]+"))
                return "Load application details — " + shortId(p);
            if (is(m,"PUT")    && p.matches("/applications/[^/]+"))
                return "Update application — " + shortId(p);
            if (is(m,"DELETE") && p.matches("/applications/[^/]+"))
                return "Archive application " + shortId(p) + " (move to history)";
            if (is(m,"PATCH")  && p.matches("/applications/[^/]+/deactivate"))
                return "Deactivate application — " + shortId(p);

            // ── Dependencies ──────────────────────────────────────────────────
            if (is(m,"GET")    && p.matches("/applications/[^/]+/dependencies"))
                return "Load dependencies for application " + shortId(p);
            if (is(m,"POST")   && p.matches("/applications/[^/]+/dependencies"))
                return "Register new dependency for application " + shortId(p);
            if (is(m,"DELETE") && p.matches("/dependencies/[^/]+"))
                return "Remove dependency " + shortId(p);
            if (is(m,"PATCH")  && p.matches("/dependencies/[^/]+/deactivate"))
                return "Deactivate dependency " + shortId(p);
            if (is(m,"GET")    && p.equals("/dependencies/shared"))
                return "Load shared infrastructure resources summary";

            // ── Shared Resource Registry ──────────────────────────────────────
            if (is(m,"GET")    && p.startsWith("/shared-resources") && !p.matches("/shared-resources/[^/]+"))
                return "Search shared resource registry" + (query != null ? " [" + query + "]" : "");
            if (is(m,"POST")   && p.equals("/shared-resources"))
                return "Register new shared resource in registry";
            if (is(m,"DELETE") && p.matches("/shared-resources/[^/]+"))
                return "Deactivate shared resource " + shortId(p);

            // ── Auth ──────────────────────────────────────────────────────────
            if (is(m,"POST")   && p.equals("/auth/login"))
                return "User login attempt";
            if (is(m,"POST")   && p.contains("/auth/refresh"))
                return "Refresh access token";
            if (is(m,"POST")   && p.contains("/auth/logout"))
                return "User logout";
            if (is(m,"POST")   && p.contains("/otp"))
                return "Verify MFA / OTP code";

            // ── Users ─────────────────────────────────────────────────────────
            if (is(m,"GET")    && p.equals("/users"))
                return "List users" + pageInfo(query);
            if (is(m,"POST")   && p.equals("/users"))
                return "Create user account";
            if (is(m,"PUT")    && p.matches("/users/[^/]+"))
                return "Update user account — " + shortId(p);
            if (is(m,"PATCH")  && p.matches("/users/[^/]+/role"))
                return "Change role for user — " + shortId(p);
            if (is(m,"DELETE") && p.matches("/users/[^/]+"))
                return "Deactivate user — " + shortId(p);

            // ── DR Campaigns ──────────────────────────────────────────────────
            if (is(m,"GET")    && p.equals("/campaigns"))
                return "List DR campaigns";
            if (is(m,"POST")   && p.equals("/campaigns"))
                return "Create DR campaign";
            if (is(m,"GET")    && p.matches("/campaigns/[^/]+"))
                return "Load campaign details — " + shortId(p);
            if (is(m,"PUT")    && p.matches("/campaigns/[^/]+"))
                return "Update campaign — " + shortId(p);
            if (is(m,"PATCH")  && p.matches("/campaigns/[^/]+/status"))
                return "Advance campaign status — " + shortId(p);
            if (p.matches("/campaigns/[^/]+/applications.*"))
                return "Campaign application entry — " + m + " " + shortPath(p);
            if (p.matches("/campaigns/[^/]+/conflicts.*"))
                return "Campaign conflict scan / resolution — " + shortId(p);
            if (p.matches("/conflicts/[^/]+/resolve"))
                return "Resolve conflict — " + shortId(p);

            // ── Pre-DR Readiness & Checklist ──────────────────────────────────
            if (p.contains("/checklist"))
                return "Checklist item update — " + shortPath(p);
            if (p.contains("/pre-dr") || p.contains("/signoff"))
                return "Pre-DR sign-off — " + shortPath(p);

            // ── Runbooks ──────────────────────────────────────────────────────
            if (p.contains("/runbook"))
                return "Runbook — " + m + " " + shortPath(p);

            // ── Dashboard ─────────────────────────────────────────────────────
            if (is(m,"GET")    && p.startsWith("/dashboard"))
                return "Load dashboard summary";

            // ── Reports ───────────────────────────────────────────────────────
            if (p.startsWith("/reports"))
                return "Generate report — " + shortPath(p);

            // ── Audit Log ─────────────────────────────────────────────────────
            if (p.startsWith("/audit"))
                return "Load audit log" + pageInfo(query);

            // Fallback — still show something intelligible
            return m + " " + p + (query != null ? "?" + query : "");
        }

        // ── Helpers ───────────────────────────────────────────────────────────

        /** Case-insensitive HTTP method check. */
        private static boolean is(String actual, String expected) {
            return expected.equalsIgnoreCase(actual);
        }

        /**
         * Extract the first UUID from a path and shorten it to its first 8 hex chars,
         * so "019d62ac-83d1-7959-8bf8-104f57f541e2" becomes "019d62ac…"
         */
        private static String shortId(String path) {
            return path.replaceAll(
                ".*/([0-9a-f]{8})[0-9a-f\\-]{27,}.*",
                "$1…"
            );
        }

        /** Replace full UUIDs in a path with {id} for readability. */
        private static String shortPath(String path) {
            return path.replaceAll(
                "[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}",
                "{id}"
            );
        }

        /** Build a pagination note from the query string. */
        private static String pageInfo(String query) {
            if (query == null || query.isEmpty()) return "";
            int page = extractInt(query, "page", 0);
            int size = extractInt(query, "size", 20);
            return " (page " + page + ", " + size + " per page)";
        }

        private static int extractInt(String query, String param, int def) {
            for (String part : query.split("&")) {
                if (part.startsWith(param + "=")) {
                    try { return Integer.parseInt(part.substring(param.length() + 1)); }
                    catch (NumberFormatException ignored) { /* use default */ }
                }
            }
            return def;
        }

        /** Human-readable HTTP status labels. */
        private static String statusLabel(int status) {
            return switch (status) {
                case 200 -> "OK";
                case 201 -> "Created";
                case 204 -> "No Content";
                case 400 -> "Bad Request";
                case 401 -> "Unauthorised";
                case 403 -> "Forbidden";
                case 404 -> "Not Found";
                case 409 -> "Conflict";
                case 422 -> "Unprocessable";
                case 500 -> "Server Error";
                default  -> String.valueOf(status);
            };
        }

        /**
         * Get the currently authenticated user's name (email) from the Spring
         * Security context, prefixed and padded for alignment.
         * Returns an empty string for unauthenticated (login/refresh) calls.
         */
        private static String currentUser() {
            var auth = SecurityContextHolder.getContext().getAuthentication();
            if (auth != null && auth.isAuthenticated()
                    && !"anonymousUser".equals(auth.getPrincipal())) {
                return "[" + auth.getName() + "]  ";
            }
            return "";
        }
    }
}
