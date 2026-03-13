package com.papss.middleware.config;

import com.papss.middleware.exception.GenericExceptionHandler;
import com.papss.middleware.models.Participant;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

public class ParticipantsConfigTest {

    @Test
    void getParticipantConfig_returnsMatch_orThrows() {
        ParticipantsConfig cfg = new ParticipantsConfig();
        List<Participant> list = new ArrayList<>();
        Participant p1 = new Participant();
        p1.setInstId("ID1");
        p1.setApiKey("key1");
        list.add(p1);
        cfg.setParticipants(list);

        assertEquals(p1, cfg.getParticipantConfig("ID1"));
        assertThrows(IllegalArgumentException.class, () -> cfg.getParticipantConfig("UNKNOWN"));
    }

    @Test
    void pollingWorkerCount_ignoresPlaceholders() {
        ParticipantsConfig cfg = new ParticipantsConfig();
        List<Participant> list = new ArrayList<>();
        Participant p1 = new Participant(); p1.setInstId("ID1");
        Participant p2 = new Participant(); p2.setInstId("${PAPSS_X}");
        list.add(p1); list.add(p2);
        cfg.setParticipants(list);

        assertEquals(1L, cfg.pollingWorkerCount());
    }

    @Test
    void validateParticipantByApiKey_checksEquality() {
        ParticipantsConfig cfg = new ParticipantsConfig();
        Participant p = new Participant(); p.setApiKey("abc");
        assertDoesNotThrow(() -> cfg.validateParticipantByApiKey("abc", p));
        assertThrows(GenericExceptionHandler.class, () -> cfg.validateParticipantByApiKey("wrong", p));
    }
}
