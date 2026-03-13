package com.equitybank.gag.telco_b2c.config;

import com.equitybank.gag.telco_b2c.exception.CustomException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class HttpRedirectFilterConfig {
    private static final Logger log = LoggerFactory.getLogger(HttpRedirectFilterConfig.class);

    @Bean
    public Filter httpRedirectFilter() {
        return (ServletRequest request, ServletResponse response, FilterChain chain) -> {
            HttpServletRequest req = (HttpServletRequest) request;
            HttpServletResponse res = (HttpServletResponse) response;

            boolean isHttp = "http".equalsIgnoreCase(req.getScheme());
            String path = req.getRequestURI();

            try {
                // If HTTP and not /api/v1/fin/** - block it
                if (isHttp && !path.startsWith("/api/v1/fin")) {
                    String rrn = "";
                    String errorCode = "403";
                    String errorDescription = "Insecure HTTP access is not allowed for path: " + path;

                    throw new CustomException(buildXmlError(rrn, errorCode, errorDescription));
                }

                // Otherwise continue normally
                chain.doFilter(request, response);

            } catch (CustomException ex) {
                log.error(ex.getMessage());

                // Return XML response
                res.setStatus(HttpServletResponse.SC_FORBIDDEN);
                res.setContentType("application/xml");
                res.getWriter().write(ex.getMessage());
                res.getWriter().flush();
            }
        };
    }

    private String buildXmlError(String rrn, String errorCode, String errorDescription) {
        return "<response>\n" +
                "    <msgId>" + rrn + "</msgId>\n" +
                "    <eazzycashres>\n" +
                "        <rrn>" + rrn + "</rrn>\n" +
                "        <status>ERROR|" + errorCode + "</status>\n" +
                "        <responseCode>" + errorCode + "</responseCode>\n" +
                "        <responseDesc>" + errorDescription + "</responseDesc>\n" +
                "    </eazzycashres>\n" +
                "</response>";
    }
}
