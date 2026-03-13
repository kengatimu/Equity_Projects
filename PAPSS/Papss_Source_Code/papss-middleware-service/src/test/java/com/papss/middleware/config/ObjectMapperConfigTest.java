package com.papss.middleware.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class ObjectMapperConfigTest {

    @Test
    void objectMapper_isConfiguredWithJavaTimeModule_andNoTimestamps() {
        ObjectMapperConfig config = new ObjectMapperConfig();
        ObjectMapper mapper = config.objectMapper();

        // JavaTimeModule registered
        boolean hasJavaTime = mapper.getRegisteredModuleIds().stream()
                .map(Object::toString)
                .anyMatch(id -> id.contains(JavaTimeModule.class.getName()));
        assertTrue(hasJavaTime, "ObjectMapper should register JavaTimeModule");

        // WRITE_DATES_AS_TIMESTAMPS is disabled
        assertFalse(mapper.isEnabled(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS),
                "ObjectMapper should have WRITE_DATES_AS_TIMESTAMPS disabled");
    }
}
