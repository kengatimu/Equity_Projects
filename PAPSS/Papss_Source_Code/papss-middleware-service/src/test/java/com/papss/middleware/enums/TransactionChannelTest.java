package com.papss.middleware.enums;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class TransactionChannelTest {

    @Test
    void values_valueOf_and_findByValue() {
        // ensure at least a handful are defined and ordering starts as expected
        TransactionChannel[] vals = TransactionChannel.values();
        assertTrue(vals.length >= 10);
        assertEquals(TransactionChannel.CORE_BANKING, vals[0]);
        assertEquals(TransactionChannel.PAYMENT_LINK, vals[vals.length - 1]);

        assertEquals(TransactionChannel.API, TransactionChannel.valueOf("API"));

        // findByValue is case-insensitive
        assertEquals(TransactionChannel.INTERNET_BANKING, TransactionChannel.findByValue("internet_banking"));
        assertNull(TransactionChannel.findByValue("unknown"));

        // descriptions
        assertNotNull(TransactionChannel.API.getDescription());
        assertTrue(TransactionChannel.QR_CODE.getDescription().toLowerCase().contains("qr"));
    }
}
