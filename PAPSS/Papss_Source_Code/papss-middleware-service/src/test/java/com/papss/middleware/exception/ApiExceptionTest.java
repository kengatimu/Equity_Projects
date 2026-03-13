package com.papss.middleware.exception;

import org.junit.jupiter.api.Test;
import org.springframework.http.HttpStatus;

import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class ApiExceptionTest {

    @Test
    void constructor_withStatusAndMessage_setsFields_andOverridesGetMessage() {
        ApiException ex = new ApiException(HttpStatus.BAD_REQUEST, "Invalid input");

        assertEquals(HttpStatus.BAD_REQUEST, ex.getHttpStatus());
        assertEquals("BAD_REQUEST", ex.getError());
        assertEquals("Invalid input", ex.getMessage()); // Lombok overrides Throwable#getMessage
        assertNull(ex.getErrors());
        assertTrue(ex instanceof RuntimeException);
    }

    @Test
    void constructor_withCause_setsCause_andFields() {
        Throwable cause = new IllegalStateException("root cause");
        ApiException ex = new ApiException(HttpStatus.INTERNAL_SERVER_ERROR, "Something went wrong", cause);

        assertEquals(HttpStatus.INTERNAL_SERVER_ERROR, ex.getHttpStatus());
        assertEquals("INTERNAL_SERVER_ERROR", ex.getError());
        assertEquals("Something went wrong", ex.getMessage());
        assertSame(cause, ex.getCause());
    }

    @Test
    void constructor_withErrors_populatesErrorsList() {
        List<String> errs = Arrays.asList("field1 is required", "field2 too long");
        ApiException ex = new ApiException(HttpStatus.UNPROCESSABLE_ENTITY, "Validation failed", errs);

        assertEquals(HttpStatus.UNPROCESSABLE_ENTITY, ex.getHttpStatus());
        assertEquals("UNPROCESSABLE_ENTITY", ex.getError());
        assertEquals("Validation failed", ex.getMessage());
        assertNotNull(ex.getErrors());
        assertEquals(errs, ex.getErrors());

        // Ensure setter for errors (from @Setter) can update the list
        ex.setErrors(List.of("only one"));
        assertEquals(List.of("only one"), ex.getErrors());
    }
}
