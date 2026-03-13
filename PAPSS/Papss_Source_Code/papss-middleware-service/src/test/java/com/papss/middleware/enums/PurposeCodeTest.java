package com.papss.middleware.enums;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class PurposeCodeTest {

    @Test
    void values_valueOf_and_description() {
        PurposeCode[] vals = PurposeCode.values();
        assertArrayEquals(new PurposeCode[]{PurposeCode.RCPT, PurposeCode.ADVA}, vals);

        assertEquals(PurposeCode.RCPT, PurposeCode.valueOf("RCPT"));
        assertEquals("Receipt", PurposeCode.RCPT.getDescription());
        assertEquals("Advance Payment", PurposeCode.ADVA.getDescription());
    }
}
