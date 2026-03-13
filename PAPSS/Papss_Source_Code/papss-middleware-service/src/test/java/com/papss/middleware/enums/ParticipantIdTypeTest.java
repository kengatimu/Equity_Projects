package com.papss.middleware.enums;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class ParticipantIdTypeTest {

    @Test
    void values_and_valueOf_work() {
        ParticipantIdType[] vals = ParticipantIdType.values();
        assertArrayEquals(new ParticipantIdType[]{ParticipantIdType.PAPSS_ID, ParticipantIdType.BIC}, vals);
        assertEquals(ParticipantIdType.PAPSS_ID, ParticipantIdType.valueOf("PAPSS_ID"));
        assertEquals(ParticipantIdType.BIC, ParticipantIdType.valueOf("BIC"));
    }
}
