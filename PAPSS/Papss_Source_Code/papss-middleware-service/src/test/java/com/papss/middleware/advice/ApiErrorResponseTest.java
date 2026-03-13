package com.papss.middleware.advice;

import com.papss.middleware.exception.ApiException;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.http.HttpStatus;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class ApiErrorResponseTest {

    @Test
    @DisplayName("ApiErrorResponse from ApiException should map fields correctly")
    void apiErrorResponseFromApiException() {
        List<String> errors = List.of("e1", "e2");
        ApiException ex = new ApiException(HttpStatus.BAD_REQUEST, "Bad data", errors);

        ApiErrorResponse response = new ApiErrorResponse(ex);

        assertEquals(HttpStatus.BAD_REQUEST, response.getStatus());
        assertEquals(HttpStatus.BAD_REQUEST.name(), response.getError());
        assertEquals("Bad data", response.getMessage());
        assertEquals(errors, response.getErrors());
    }

    @Test
    @DisplayName("ApiErrorResponse from Throwable uses exception message when not 500")
    void apiErrorResponseFromThrowableUsesMessageWhenNot500() {
        RuntimeException ex = new RuntimeException("Oops");
        ApiErrorResponse response = new ApiErrorResponse(HttpStatus.NOT_FOUND, ex);

        assertEquals(HttpStatus.NOT_FOUND, response.getStatus());
        assertNull(response.getError());
        assertNull(response.getErrors());
        assertEquals("An error occurred: Oops", response.getMessage());
    }

    @Test
    @DisplayName("ApiErrorResponse from Throwable masks message for 500")
    void apiErrorResponseFromThrowableMasksFor500() {
        RuntimeException ex = new RuntimeException("Sensitive details");
        ApiErrorResponse response = new ApiErrorResponse(HttpStatus.INTERNAL_SERVER_ERROR, ex);

        assertEquals(HttpStatus.INTERNAL_SERVER_ERROR, response.getStatus());
        assertEquals("An error occurred: Internal Server Error", response.getMessage());
    }

    @Test
    @DisplayName("ApiErrorResponse with null exception doesn't set message")
    void apiErrorResponseWithNullException() {
        ApiErrorResponse response = new ApiErrorResponse(HttpStatus.BAD_REQUEST, null);
        assertEquals(HttpStatus.BAD_REQUEST, response.getStatus());
        assertNull(response.getMessage());
    }
}
