package com.papss.middleware.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class OpenApiConfigTest {

    @Test
    void customOpenAPI_hasExpectedInfoAndTags() {
        OpenApiConfig cfg = new OpenApiConfig();
        OpenAPI api = cfg.customOpenAPI();

        Info info = api.getInfo();
        assertNotNull(info);
        assertEquals("PAPSS Middleware API", info.getTitle());
        assertEquals("1.0", info.getVersion());
        assertNotNull(info.getDescription());
        assertNotNull(info.getLicense());

        assertNotNull(api.getTags());
        assertTrue(api.getTags().size() >= 5);
        assertTrue(api.getTags().stream().anyMatch(t -> "Credit Transfer".equals(t.getName())));
        assertTrue(api.getTags().stream().anyMatch(t -> "Participant Info".equals(t.getName())));
    }
}
