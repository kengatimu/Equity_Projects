package com.papss.middleware.enums;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class TransactionStatusTest {

    @Test
    void values_valueOf_and_valueField() {
        TransactionStatus[] vals = TransactionStatus.values();
        assertArrayEquals(new TransactionStatus[]{
                TransactionStatus.RJCT,
                TransactionStatus.PDNG,
                TransactionStatus.ACCP,
                TransactionStatus.ACSP,
                TransactionStatus.ACSC
        }, vals);

        assertEquals(TransactionStatus.RJCT, TransactionStatus.valueOf("RJCT"));
        assertTrue(TransactionStatus.ACCP.value.contains("ACCEPT"));
        assertTrue(TransactionStatus.ACSP.value.contains("POSTPONED"));
        assertTrue(TransactionStatus.ACSC.value.contains("COMPLETE"));
    }
}
