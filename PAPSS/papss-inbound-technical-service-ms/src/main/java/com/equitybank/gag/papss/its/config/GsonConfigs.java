package com.equitybank.gag.papss.its.config;

import com.google.gson.*;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.lang.reflect.Type;
import java.time.LocalDateTime;
import java.time.OffsetDateTime;

@Configuration
public class GsonConfigs {

    // Converts LocalDateTime to ISO-8601 string (no timezone)
    static class LocalDateTimeToString implements JsonSerializer<LocalDateTime> {
        @Override
        public JsonElement serialize(LocalDateTime value, Type type, JsonSerializationContext context) {
            return new JsonPrimitive(value.toString()); // e.g., "2025-05-17T15:30:00"
        }
    }

    // Converts OffsetDateTime to full ISO-8601 string with offset
    static class OffsetDateTimeToString implements JsonSerializer<OffsetDateTime> {
        @Override
        public JsonElement serialize(OffsetDateTime value, Type type, JsonSerializationContext context) {
            return new JsonPrimitive(value.toString()); // e.g., "2025-05-17T15:30:00+03:00"
        }
    }

    @Bean
    public Gson gson() {
        return new GsonBuilder()
                .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeToString()) // Handles LocalDateTime
                .registerTypeAdapter(OffsetDateTime.class, new OffsetDateTimeToString()) // Handles OffsetDateTime
                .disableHtmlEscaping() // Needed for Base64: avoids escaping '=' and '+' which would corrupt encoded strings
                .setPrettyPrinting()   // Makes the JSON easier to read
                .create();
    }
}
