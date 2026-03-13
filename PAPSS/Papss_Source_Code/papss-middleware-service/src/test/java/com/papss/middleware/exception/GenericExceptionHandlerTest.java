package com.papss.middleware.exception;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class GenericExceptionHandlerTest {

    @Test
    void constructor_setsMessage_andIsRuntimeException() {
        GenericExceptionHandler ex = new GenericExceptionHandler("Oops");
        assertTrue(ex instanceof RuntimeException);
        assertEquals("Oops", ex.getMessage());
        assertNull(ex.getCause());
    }
}
