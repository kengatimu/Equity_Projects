package com.papss.middleware.exception;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class SignatureValidationExceptionTest {

    @Test
    void constructor_message_setsMessage_andIsCheckedException() {
        SignatureValidationException ex = new SignatureValidationException("Bad signature");
        assertTrue(ex instanceof Exception);
        assertEquals("Bad signature", ex.getMessage());
        assertNull(ex.getCause());
    }

    @Test
    void constructor_messageAndCause_setsBoth() {
        Throwable cause = new IllegalArgumentException("invalid");
        SignatureValidationException ex = new SignatureValidationException("Bad signature", cause);
        assertEquals("Bad signature", ex.getMessage());
        assertSame(cause, ex.getCause());
    }
}
