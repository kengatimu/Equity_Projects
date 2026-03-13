package com.papss.middleware.enums;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class LocalInstrumentTest {

    @Test
    void values_valueOf_and_description() {
        LocalInstrument[] vals = LocalInstrument.values();
        assertArrayEquals(new LocalInstrument[]{LocalInstrument.ET, LocalInstrument.SSA3, LocalInstrument.USDP}, vals);

        assertEquals(LocalInstrument.ET, LocalInstrument.valueOf("ET"));
        assertEquals("Central Bank Settlement Model for Eligible Transactions", LocalInstrument.ET.getDescription());
        assertEquals("Commercial Bank Settlement Model for Local Currency Transactions", LocalInstrument.SSA3.getDescription());
        assertEquals("Commercial Bank Settlement Model for USD Currency Transactions", LocalInstrument.USDP.getDescription());
    }
}
