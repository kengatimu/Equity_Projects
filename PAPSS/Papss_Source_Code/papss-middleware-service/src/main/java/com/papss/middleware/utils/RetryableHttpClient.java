package com.papss.middleware.utils;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.ResourceAccessException;
import org.springframework.web.client.RestClientException;

import java.net.SocketTimeoutException;
import java.util.concurrent.TimeUnit;

/**
 * A wrapper around HttpClient that adds retry functionality for transient failures.
 * This improves reliability by automatically retrying failed requests due to network issues.
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class RetryableHttpClient {
    private final HttpClient httpClient;

    private static final int MAX_RETRIES = 3;
    private static final long INITIAL_BACKOFF_MS = 0; // No delay for instant response
    private static final double BACKOFF_MULTIPLIER = 0.0; // No backoff multiplier to ensure no delay

    /**
     * Performs a GET request with retry functionality for transient failures.
     *
     * @param url the URL to send the request to
     * @param request the HTTP entity containing headers and/or body
     * @param alias the SSL key alias to use
     * @param responseType the type of the response
     * @param <T> the type of the response
     * @return the response entity
     */
    public <T> ResponseEntity<T> getWithRetry(String url, HttpEntity<?> request, String alias, Class<T> responseType) {
        int retryCount = 0;
        long backoffTime = INITIAL_BACKOFF_MS;

        while (true) {
            try {
                return httpClient.getClient(url, request, alias, responseType);
            } catch (Exception e) {
                if (shouldRetry(e, retryCount)) {
                    retryCount++;
                    log.warn("Request to {} failed (attempt {}). Retrying immediately. Error: {}", 
                            url, retryCount, e.getMessage());

                    // No sleep delay for immediate retry
                    if (Thread.currentThread().isInterrupted()) {
                        throw new RestClientException("Thread interrupted", new InterruptedException());
                    }

                    // No backoff time increase
                    backoffTime = 0;
                } else {
                    log.error("Request to {} failed after {} retries: {}", url, retryCount, e.getMessage());
                    throw e;
                }
            }
        }
    }

    /**
     * Performs a POST request with retry functionality for transient failures.
     *
     * @param url the URL to send the request to
     * @param request the HTTP entity containing headers and/or body
     * @param alias the SSL key alias to use
     * @param responseType the type of the response
     * @param <T> the type of the response
     * @return the response entity
     */
    public <T> ResponseEntity<T> postWithRetry(String url, HttpEntity<?> request, String alias, Class<T> responseType) {
        int retryCount = 0;
        long backoffTime = INITIAL_BACKOFF_MS;

        while (true) {
            try {
                return httpClient.postClient(url, request, alias, responseType);
            } catch (Exception e) {
                if (shouldRetry(e, retryCount)) {
                    retryCount++;
                    log.warn("Request to {} failed (attempt {}). Retrying immediately. Error: {}", 
                            url, retryCount, e.getMessage());

                    // No sleep delay for immediate retry
                    if (Thread.currentThread().isInterrupted()) {
                        throw new RestClientException("Thread interrupted", new InterruptedException());
                    }

                    // No backoff time increase
                    backoffTime = 0;
                } else {
                    log.error("Request to {} failed after {} retries: {}", url, retryCount, e.getMessage());
                    throw e;
                }
            }
        }
    }

    /**
     * Determines if a request should be retried based on the exception type and retry count.
     *
     * @param e the exception that occurred
     * @param retryCount the current retry count
     * @return true if the request should be retried, false otherwise
     */
    private boolean shouldRetry(Exception e, int retryCount) {
        // Only retry if we haven't exceeded the maximum number of retries
        if (retryCount >= MAX_RETRIES) {
            return false;
        }

        // Only retry for network-related exceptions
        return e instanceof ResourceAccessException || 
               e instanceof SocketTimeoutException ||
               (e.getCause() != null && e.getCause() instanceof SocketTimeoutException);
    }
}
