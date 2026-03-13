package com.papss.middleware.advice;

import com.papss.middleware.exception.ApiException;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.http.HttpStatus;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ApiErrorResponse {

    /**
     * Http status
     */
    private HttpStatus status;

    /**
     * Error
     */
    private String error;

    /**
     * List of error messages
     */
    private List<String> errors;

    /**
     * Error message (could be localised)
     */
    private String message;
    public ApiErrorResponse(final HttpStatus status, final Throwable ex) {
        super();
        this.status = status;

        if (ex != null) {
            // Only include the exception message, not the full stack trace or class name
            this.message = "An error occurred: " + (status == HttpStatus.INTERNAL_SERVER_ERROR ? 
                "Internal Server Error" : ex.getMessage());
        }
    }

    public ApiErrorResponse(final ApiException apiException) {
        super();
        this.status = apiException.getHttpStatus();
        this.error = apiException.getError();
        if(apiException.getErrors() != null) {
            this.errors = apiException.getErrors();
        }
        this.message = apiException.getMessage();
    }
}
