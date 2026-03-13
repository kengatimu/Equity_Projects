package com.papss.middleware.advice;

import com.papss.middleware.dto.ResponseDto;
import com.papss.middleware.exception.ApiException;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.MissingRequestHeaderException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import java.util.List;


@Slf4j
@RestControllerAdvice(basePackages = "com.papss.middleware")
@RequiredArgsConstructor
public class ApiExceptionHandler extends ResponseEntityExceptionHandler {


    @ExceptionHandler({
            ApiException.class,
    })
    public ResponseEntity<Object> handleApiException(final ApiException ex, final HttpServletRequest request) {
        log.error("API Exception handled", ex);

        final ApiErrorResponse apiErrorResponse = new ApiErrorResponse(ex);
        return new ResponseEntity<>(apiErrorResponse, apiErrorResponse.getStatus());
    }

    @ExceptionHandler(ClassNotFoundException.class)
    public ResponseEntity<Object> catchEntityNotFoundException(ClassNotFoundException exception, final HttpServletRequest request) {
        final ApiErrorResponse apiErrorResponse = new ApiErrorResponse(HttpStatus.NOT_FOUND, exception);
        return new ResponseEntity<>(apiErrorResponse, HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler({RuntimeException.class})
    public ResponseEntity<Object> catchUncaught(RuntimeException ex, final HttpServletRequest request) {
        log.error("Unknown Exception Handled", ex);

        final ApiErrorResponse apiErrorResponse = new ApiErrorResponse(
                HttpStatus.INTERNAL_SERVER_ERROR, ex);
        return new ResponseEntity<>(apiErrorResponse, apiErrorResponse.getStatus());
    }


    @Override
    protected ResponseEntity<Object> handleMethodArgumentNotValid(MethodArgumentNotValidException ex, HttpHeaders headers, HttpStatusCode status, WebRequest request) {
        log.error("MethodArgumentNotValidException Handled", ex);
        List<String> errorList = getAllErrorMessages(ex);
        ResponseDto responseDto = new ResponseDto(false, errorList);

        return new ResponseEntity<>(responseDto, headers, status);
    }

    @ExceptionHandler(MissingRequestHeaderException.class)
    public ResponseEntity<Object> onMissingRequestHeaderException(MissingRequestHeaderException exception, final HttpServletRequest request) {
        ApiException spacesApiException = new ApiException(
                HttpStatus.BAD_REQUEST,
                exception.getMessage()
        );

        return handleApiException(spacesApiException, request);
    }

    private static List<String> getAllErrorMessages(MethodArgumentNotValidException exception) {
        return exception.getBindingResult()
                .getFieldErrors()
                .stream()
                .map(ApiExceptionHandler::formatFieldErrorMessage)
                .toList();
    }

    private static String formatFieldErrorMessage(FieldError error) {
        return String.format("Validation failed for '%s' field. Rejected value: '%s'. %s",
                error.getField(), error.getRejectedValue(), error.getDefaultMessage());
    }


}
