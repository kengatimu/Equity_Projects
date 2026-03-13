package com.papss.middleware.exception;

import lombok.Getter;
import lombok.Setter;
import org.springframework.http.HttpStatus;

import java.io.Serial;
import java.util.List;

@Getter
@Setter
public class ApiException extends RuntimeException {

    @Serial
    private static final long serialVersionUID = -604721106232505596L;

    private final HttpStatus httpStatus;

    private final String error;

    private List<String> errors;

    private final String message;


    public ApiException(final HttpStatus httpStatus, final String message) {
        super(message);
        this.httpStatus = httpStatus;
        this.error = httpStatus.name();
        this.message = message;
    }


    public ApiException(final HttpStatus httpStatus, final String message, final Throwable cause) {
        super(message, cause);
        this.httpStatus = httpStatus;
        this.error = httpStatus.name();
        this.message = message;
    }


    public ApiException(final HttpStatus httpStatus, final String message, List<String> errors) {
        super(message);
        this.httpStatus = httpStatus;
        this.error = httpStatus.name();
        this.errors = errors;
        this.message = message;
    }
}
