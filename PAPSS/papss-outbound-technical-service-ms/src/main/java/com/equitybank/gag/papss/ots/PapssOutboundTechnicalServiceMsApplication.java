package com.equitybank.gag.papss.ots;

import com.equitybank.gag.papss.ots.jpos.space.configs.SpringBeanLoader;
import com.equitybank.gag.papss.ots.config.formatter.CRLFLogConverter;
import com.equitybank.gag.papss.ots.config.formatter.DefaultProfileUtil;
import io.micrometer.common.util.StringUtils;
import org.jpos.q2.Q2;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.core.env.Environment;
import org.springframework.scheduling.annotation.EnableScheduling;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Optional;

@SpringBootApplication
@EnableConfigurationProperties
@EnableScheduling
public class PapssOutboundTechnicalServiceMsApplication {
    private static final Logger log = LoggerFactory.getLogger(PapssOutboundTechnicalServiceMsApplication.class);
    private static Q2 q2;

    public static void main(String[] args) {
        SpringApplication app = new SpringApplication(PapssOutboundTechnicalServiceMsApplication.class);
        DefaultProfileUtil.addDefaultProfile(app);

        // Run Spring Boot and capture the context
        ConfigurableApplicationContext context = app.run(args);
        Environment env = context.getEnvironment();

        // Register Spring context into Q2 loader
        SpringBeanLoader.setApplicationContext(context);
        log.info("Spring context registered into SpringBeanLoader.");

        // Retrieve the property directly from the Environment
        String deployDir = env.getProperty("jpos.tm.q2-tm-dir");
        if (deployDir == null || deployDir.isEmpty()) {
            log.error("jpos.tm.q2-tm-dir property not found or is empty in application.yaml. Exiting.");
            System.exit(1); // Exit if critical property is missing
        }
        log.info("jPOS Q2 deploy directory from config: {}", deployDir);

        // Start Q2 engine
        try {
            log.info("Initializing jPOS Q2 engine for ISO8583 MUX/Channel layer...");
            q2 = new Q2(deployDir);
            q2.start();
            log.info("Q2 engine started successfully.");
        } catch (Exception e) {
            log.error("Failed to start Q2 engine: {}", e.getMessage(), e);
            System.exit(1);
        }
        logApplicationStartup(env);
    }

    private static void logApplicationStartup(Environment env) {
        String protocol = Optional.ofNullable(env.getProperty("server.ssl.key-store")).map(key -> "https").orElse("http");
        String serverPort = env.getProperty("server.port");
        String contextPath = Optional.ofNullable(env.getProperty("server.servlet.context-path"))
                .filter(StringUtils::isNotBlank)
                .orElse("/");

        String hostAddress = "localhost";
        try {
            hostAddress = InetAddress.getLocalHost().getHostAddress();
        } catch (UnknownHostException e) {
            log.warn("The host name could not be determined, using `localhost` as fallback");
        }

        log.info(CRLFLogConverter.CRLF_SAFE_MARKER,
                "\n----------------------------------------------------------\n\t" +
                        "Application '{}' is running! Access URLs:\n\t" +
                        "Local: \t\t{}://localhost:{}{}\n\t" +
                        "External: \t{}://{}:{}{}\n\t" +
                        "Profile(s): \t{}\n----------------------------------------------------------",
                env.getProperty("spring.application.name"),
                protocol,
                serverPort,
                contextPath,
                protocol,
                hostAddress,
                serverPort,
                contextPath,
                env.getActiveProfiles().length == 0 ? env.getDefaultProfiles() : env.getActiveProfiles());

        String configServerStatus = env.getProperty("configserver.status");
        if (configServerStatus == null) {
            configServerStatus = "Not found or not setup for this application";
        }
        log.info(CRLFLogConverter.CRLF_SAFE_MARKER,
                "\n----------------------------------------------------------\n\t" +
                        "Config Server: \t{}\n----------------------------------------------------------",
                configServerStatus);
    }
}
