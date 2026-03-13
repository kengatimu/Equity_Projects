package com.papss.middleware.enums;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class ParticipantTypeTest {

    @Test
    void values_and_valueOf_work() {
        ParticipantType[] vals = ParticipantType.values();
        assertArrayEquals(new ParticipantType[]{
                ParticipantType.ADMINISTRATOR,
                ParticipantType.CENTRAL_BANK,
                ParticipantType.BANK,
                ParticipantType.MOBILE_NETWORK_OPERATOR,
                ParticipantType.VIRTUAL_ACCOUNT_OPERATOR,
                ParticipantType.CARD_OPERATOR
        }, vals);

        assertEquals(ParticipantType.BANK, ParticipantType.valueOf("BANK"));
        assertEquals(ParticipantType.CARD_OPERATOR, ParticipantType.valueOf("CARD_OPERATOR"));
    }
}
