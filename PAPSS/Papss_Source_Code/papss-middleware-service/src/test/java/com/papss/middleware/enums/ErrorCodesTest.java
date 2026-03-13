package com.papss.middleware.enums;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class ErrorCodesTest {

    @Test
    void getters_and_values_work() {
        // Basic sanity: has many values and getters return non-null
        assertTrue(ErrorCodes.values().length >= 10);

        ErrorCodes e = ErrorCodes.CODE_100;
        assertEquals("100", e.getValue());
        assertEquals("MS03", e.getMapping());
        assertEquals("Internal processing error.", e.getDescription());

        // Spot check some boundary values exist
        assertNotNull(ErrorCodes.valueOf("UNKNOWN"));
        assertNotNull(ErrorCodes.valueOf("CODE_1040"));
    }
}
