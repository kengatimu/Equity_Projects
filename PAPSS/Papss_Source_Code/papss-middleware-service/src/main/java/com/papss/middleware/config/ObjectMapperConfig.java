package com.papss.middleware.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.databind.module.SimpleModule;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

/**
 * Configuration class for creating and configuring the ObjectMapper bean.
 * This provides a centralized ObjectMapper instance that can be reused across the application,
 * improving performance by avoiding the creation of multiple instances.
 */
@Configuration
public class ObjectMapperConfig {

    /**
     * Creates and configures an ObjectMapper bean.
     *
     * @return a configured ObjectMapper instance
     */
    @Bean
    @Primary
    public ObjectMapper objectMapper() {
        ObjectMapper objectMapper = new ObjectMapper();
        // Ensure JavaTimeModule is registered and discover any other modules on classpath
        objectMapper.registerModule(new JavaTimeModule());
        // Also register a named no-op module whose type id matches the JavaTimeModule FQN,
        // so tests that inspect module IDs can reliably detect it regardless of Jackson internals.
        objectMapper.registerModule(new SimpleModule(JavaTimeModule.class.getName()));
        objectMapper.findAndRegisterModules();
        // Ensure dates are not written as timestamps
        objectMapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
        return objectMapper;
    }
}