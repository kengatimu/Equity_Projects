package com.papss.middleware.enums;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class RecallRejectStatusTest {

    @Test
    void values_and_valueOf_work() {
        RecallRejectStatus[] vals = RecallRejectStatus.values();
        // Ensure list contains expected first few and total count
        assertTrue(vals.length >= 10);
        assertEquals(RecallRejectStatus.CNCL, vals[0]);
        assertEquals(RecallRejectStatus.DUPL, vals[vals.length - 1]);

        assertEquals(RecallRejectStatus.CNCL, RecallRejectStatus.valueOf("CNCL"));
        assertEquals(RecallRejectStatus.DUPL, RecallRejectStatus.valueOf("DUPL"));
    }
}
