package com.papss.middleware.entities;

import org.junit.jupiter.api.Test;

import java.lang.annotation.Annotation;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Lob;

import static org.junit.jupiter.api.Assertions.*;

class PapssMessageTest {

    @Test
    void defaultConstructor_initializesWithDefaults() {
        PapssMessage m = new PapssMessage();
        // Wrapper Long should be null by default
        assertNull(m.getId());
        // primitives default values
        assertEquals(0L, m.getSequenceNumber());
        assertFalse(m.isCleared());
        assertFalse(m.isConfirmed());
        assertFalse(m.isProcessed());
        assertEquals(0L, m.getProcessingDuration());
        // other nullable fields
        assertNull(m.getRequestPayload());
        assertNull(m.getResponsePayload());
        assertNull(m.getErrorCode());
        assertNull(m.getStatus());
        assertNull(m.getMessageType());
        assertNull(m.getPapssId());
        assertNull(m.getCountryCode());
        assertNull(m.getParticipantBic());
        assertNull(m.getSystemDate());
    }

    @Test
    void gettersAndSetters_workAndEqualsHashCode_consistent() {
        PapssMessage a = new PapssMessage();
        PapssMessage b = new PapssMessage();

        OffsetDateTime now = OffsetDateTime.of(2025, 1, 2, 3, 4, 5, 0, ZoneOffset.UTC);

        a.setRequestPayload("req");
        a.setResponsePayload("res");
        a.setErrorCode(400);
        a.setSequenceNumber(123L);
        a.setStatus("OK");
        a.setCleared(true);
        a.setProcessingDuration(42L);
        a.setConfirmed(true);
        a.setProcessed(true);
        a.setMessageType("TYPE");
        a.setPapssId("P123");
        a.setCountryCode("GH");
        a.setParticipantBic("BICCODE");
        a.setSystemDate(now);

        // mirror into b
        b.setRequestPayload("req");
        b.setResponsePayload("res");
        b.setErrorCode(400);
        b.setSequenceNumber(123L);
        b.setStatus("OK");
        b.setCleared(true);
        b.setProcessingDuration(42L);
        b.setConfirmed(true);
        b.setProcessed(true);
        b.setMessageType("TYPE");
        b.setPapssId("P123");
        b.setCountryCode("GH");
        b.setParticipantBic("BICCODE");
        b.setSystemDate(now);

        assertEquals("req", a.getRequestPayload());
        assertEquals("res", a.getResponsePayload());
        assertEquals(400, a.getErrorCode());
        assertEquals(123L, a.getSequenceNumber());
        assertEquals("OK", a.getStatus());
        assertTrue(a.isCleared());
        assertEquals(42L, a.getProcessingDuration());
        assertTrue(a.isConfirmed());
        assertTrue(a.isProcessed());
        assertEquals("TYPE", a.getMessageType());
        assertEquals("P123", a.getPapssId());
        assertEquals("GH", a.getCountryCode());
        assertEquals("BICCODE", a.getParticipantBic());
        assertEquals(now, a.getSystemDate());

        // Lombok @Data should implement equals/hashCode across fields
        assertEquals(a, b);
        assertEquals(a.hashCode(), b.hashCode());

        // Changing a field should break equality
        b.setStatus("DIFF");
        assertNotEquals(a, b);
    }

    @Test
    void jpaAnnotations_presentOnFields() throws NoSuchFieldException {
        // id annotations
        assertNotNull(PapssMessage.class.getDeclaredField("id").getAnnotation(Id.class));
        GeneratedValue gv = PapssMessage.class.getDeclaredField("id").getAnnotation(GeneratedValue.class);
        assertNotNull(gv);
        assertEquals(GenerationType.IDENTITY, gv.strategy());

        // LOBs on payloads
        assertNotNull(PapssMessage.class.getDeclaredField("requestPayload").getAnnotation(Lob.class));
        assertNotNull(PapssMessage.class.getDeclaredField("responsePayload").getAnnotation(Lob.class));

        // unique constraint on sequenceNumber
        Column col = PapssMessage.class.getDeclaredField("sequenceNumber").getAnnotation(Column.class);
        assertNotNull(col);
        assertTrue(col.unique());

        // Entity annotation present
        Annotation entity = PapssMessage.class.getAnnotation(Entity.class);
        assertNotNull(entity);
    }

    @Test
    void toString_isNonNull() {
        PapssMessage m = new PapssMessage();
        assertNotNull(m.toString());
    }
}
