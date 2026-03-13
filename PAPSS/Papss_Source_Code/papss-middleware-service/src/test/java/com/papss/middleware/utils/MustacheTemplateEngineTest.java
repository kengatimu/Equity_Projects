package com.papss.middleware.utils;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.HashMap;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

public class MustacheTemplateEngineTest {

    private MustacheTemplateEngine engine;

    @BeforeEach
    void setUp() {
        engine = new MustacheTemplateEngine();
    }

    @Test
    void render_postFxRate_templateProducesOutput() {
        Map<String, Object> data = new HashMap<>();
        data.put("messageId", "20250101P01000001");
        data.put("toClearingSystemId", "TOCS");
        data.put("creationDateTime", "2025-01-01T00:00:00Z");
        data.put("creationDateSimple", "2025-01-01");
        data.put("senderPapssId", "P01");
        data.put("accountType", "ACC");
        data.put("buyRate", "1.2");
        data.put("countryCode", "GH");
        data.put("localCurrency", "GHS");
        data.put("fxRateName", "USDGHS");
        data.put("sellRate", "1.3");

        String out = engine.render(MessageTypeConstants.POST_FX_RATE_XML, data);
        assertNotNull(out);
        assertFalse(out.isBlank());
        assertTrue(out.contains("USDGHS"));
        assertTrue(out.contains("P01"));
    }
}
