package com.papss.middleware.entities;

import com.papss.middleware.enums.Direction;
import org.junit.jupiter.api.Test;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Enumerated;
import jakarta.persistence.EnumType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

import java.lang.annotation.Annotation;
import java.math.BigDecimal;
import java.time.LocalDateTime;

import static org.junit.jupiter.api.Assertions.*;

class TransactionTest {

    @Test
    void defaultConstructor_initializesWithDefaults() {
        Transaction t = new Transaction();
        assertNull(t.getId());
        assertNull(t.getDirection());
        assertNull(t.getMsgType());
        assertNull(t.getReference());
        assertNull(t.getEndToEndId());
        assertNull(t.getSender());
        assertNull(t.getSenderName());
        assertNull(t.getSenderAccount());
        assertNull(t.getReceiverBank());
        assertNull(t.getReceiverName());
        assertNull(t.getReceiverAccount());
        assertNull(t.getReceiveTime());
        assertNull(t.getProcessCompletionTime());
        assertNull(t.getCurrency());
        assertNull(t.getAmount());
        assertNull(t.getSenderFxRate());
        assertNull(t.getReceiverCurrency());
        assertNull(t.getReceiverAmount());
        assertNull(t.getReceiverFxRate());
        assertNull(t.getUsdAmount());
        assertNull(t.getFee());
        assertNull(t.getSettlementFee());
        assertNull(t.getSenderModel());
        assertNull(t.getReceiverModel());
        assertNull(t.getError());
        assertNull(t.getErrorDescription());
        assertNull(t.getStatus());
    }

    @Test
    void gettersSetters_andEqualsHashCode_consistent() {
        Transaction a = new Transaction();
        Transaction b = new Transaction();

        LocalDateTime t1 = LocalDateTime.of(2025, 1, 2, 3, 4, 5);
        LocalDateTime t2 = LocalDateTime.of(2025, 2, 3, 4, 5, 6);

        a.setDirection(Direction.IN);
        a.setMsgType("pacs.008");
        a.setReference("ref");
        a.setEndToEndId("e2e");
        a.setSender("SND");
        a.setSenderName("Sender");
        a.setSenderAccount("S-ACC");
        a.setReceiverBank("RCV-BNK");
        a.setReceiverName("Receiver");
        a.setReceiverAccount("R-ACC");
        a.setReceiveTime(t1);
        a.setProcessCompletionTime(t2);
        a.setCurrency("GHS");
        a.setAmount(new BigDecimal("100.00"));
        a.setSenderFxRate(new BigDecimal("1.0000"));
        a.setReceiverCurrency("NGN");
        a.setReceiverAmount(new BigDecimal("75000.00"));
        a.setReceiverFxRate(new BigDecimal("750.00"));
        a.setUsdAmount(new BigDecimal("8.00"));
        a.setFee(new BigDecimal("0.50"));
        a.setSettlementFee(new BigDecimal("0.10"));
        a.setSenderModel("M1");
        a.setReceiverModel("M2");
        a.setError("NONE");
        a.setErrorDescription("");
        a.setStatus("PROCESSED");

        // mirror into b with identical values and scales
        b.setDirection(Direction.IN);
        b.setMsgType("pacs.008");
        b.setReference("ref");
        b.setEndToEndId("e2e");
        b.setSender("SND");
        b.setSenderName("Sender");
        b.setSenderAccount("S-ACC");
        b.setReceiverBank("RCV-BNK");
        b.setReceiverName("Receiver");
        b.setReceiverAccount("R-ACC");
        b.setReceiveTime(t1);
        b.setProcessCompletionTime(t2);
        b.setCurrency("GHS");
        b.setAmount(new BigDecimal("100.00"));
        b.setSenderFxRate(new BigDecimal("1.0000"));
        b.setReceiverCurrency("NGN");
        b.setReceiverAmount(new BigDecimal("75000.00"));
        b.setReceiverFxRate(new BigDecimal("750.00"));
        b.setUsdAmount(new BigDecimal("8.00"));
        b.setFee(new BigDecimal("0.50"));
        b.setSettlementFee(new BigDecimal("0.10"));
        b.setSenderModel("M1");
        b.setReceiverModel("M2");
        b.setError("NONE");
        b.setErrorDescription("");
        b.setStatus("PROCESSED");

        assertEquals(a, b);
        assertEquals(a.hashCode(), b.hashCode());

        b.setDirection(Direction.OUT);
        assertNotEquals(a, b);

        // spot-check some getters
        assertEquals("pacs.008", a.getMsgType());
        assertEquals(new BigDecimal("100.00"), a.getAmount());
        assertEquals("NGN", a.getReceiverCurrency());
        assertEquals(t1, a.getReceiveTime());
        assertEquals(t2, a.getProcessCompletionTime());
    }

    @Test
    void jpaAnnotations_presentAndConfigured() throws NoSuchFieldException {
        // Entity name set
        Entity entity = Transaction.class.getAnnotation(Entity.class);
        assertNotNull(entity);
        assertEquals("papss_transaction", entity.name());

        // id generation
        assertNotNull(Transaction.class.getDeclaredField("id").getAnnotation(Id.class));
        GeneratedValue gv = Transaction.class.getDeclaredField("id").getAnnotation(GeneratedValue.class);
        assertNotNull(gv);
        assertEquals(GenerationType.IDENTITY, gv.strategy());

        // endToEndId unique constraint
        Column col = Transaction.class.getDeclaredField("endToEndId").getAnnotation(Column.class);
        assertNotNull(col);
        assertTrue(col.unique());

        // direction uses STRING
        Enumerated enumerated = Transaction.class.getDeclaredField("direction").getAnnotation(Enumerated.class);
        assertNotNull(enumerated);
        assertEquals(EnumType.STRING, enumerated.value());
    }

    @Test
    void toString_isNonNull() {
        Transaction t = new Transaction();
        assertNotNull(t.toString());
    }
}
