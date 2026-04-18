package com.equitybank.drplatform;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.core.env.Environment;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;

import java.net.InetAddress;

@SpringBootApplication
@EnableAsync
@EnableScheduling
public class DrPlatformApplication {

    private static final Logger log = LoggerFactory.getLogger(DrPlatformApplication.class);

    private final Environment env;

    public DrPlatformApplication(Environment env) {
        this.env = env;
    }

    public static void main(String[] args) {
        SpringApplication.run(DrPlatformApplication.class, args);
    }

    @EventListener(ApplicationReadyEvent.class)
    public void onReady() {
        try {
            String appName   = env.getProperty("spring.application.name", "dr-platform-api").toUpperCase();
            String port      = env.getProperty("server.port", "8080");
            String ctx       = env.getProperty("server.servlet.context-path", "/");
            String host      = InetAddress.getLocalHost().getHostAddress();
            String profiles  = String.join(", ", env.getActiveProfiles().length > 0
                                ? env.getActiveProfiles() : new String[]{"default"});

            log.info("""
                \n
                ============================================================
                \tApplication '{}' is running! Access URLs:
                \tLocal:    \t\thttp://localhost:{}{}
                \tExternal: \t\thttp://{}:{}{}
                \tProfile(s):\t\t[{}]
                ============================================================ \n""",
                appName, port, ctx, host, port, ctx, profiles);
        } catch (Exception e) {
            log.warn("Could not determine host address for startup banner");
        }
    }
}
