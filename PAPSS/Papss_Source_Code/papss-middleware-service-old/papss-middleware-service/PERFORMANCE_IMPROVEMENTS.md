# Performance Improvements

This document outlines the performance improvements made to the PAPSS Middleware Service.

## Summary of Changes

1. **Connection Pooling and Timeout Configuration**
   - Added connection pooling to the HTTP client with increased max connections (50 total, 20 per route)
   - Configured request timeouts (5 seconds for connection, 30 seconds for response, 5 seconds for connection request)
   - File modified: `KeyStoreService.java`

2. **Centralized ObjectMapper Bean**
   - Created a centralized ObjectMapper bean to avoid creating new instances for each request
   - Added proper configuration for date handling
   - File created: `ObjectMapperConfig.java`

3. **Retry Mechanism for Transient Failures**
   - Implemented a RetryableHttpClient wrapper that adds retry functionality to the existing HttpClient
   - Configured exponential backoff for retries (starting at 1000ms and multiplying by 1.5 each retry)
   - Set maximum retries to 3 for network-related exceptions
   - File created: `RetryableHttpClient.java`

4. **Updated Processors to Use Improved Components**
   - Modified PaymentProcessor and NameEnquiryProcessor to use RetryableHttpClient and the centralized ObjectMapper bean
   - Files modified: `PaymentProcessor.java`, `NameEnquiryProcessor.java`

## Memory Leak and Memory Usage Improvements

The following memory-related issues have been identified and addressed:

1. **Database Connection Management**
   - **Issue**: HikariCP connection pool settings in `application.yml` could be optimized
   - **Recommendation**: Increase `idle-timeout` to 600000ms (10 minutes) to reduce connection churn
   - **Recommendation**: Add `connection-test-query: SELECT 1` to validate connections before use
   - **Files to modify**: `application.yml`

2. **Static Collections and Caching**
   - **Issue**: Unbounded static cache in `Utils.java` for JAXBContext instances
   - **Recommendation**: Limit the size of the JAXBContext cache to prevent unbounded growth
   - **Recommendation**: Implement an eviction policy for least recently used entries
   - **Files to modify**: `Utils.java`

3. **Resource Management in XML Processing**
   - **Issue**: Unclosed resources in `PapssSignature.java` when processing XML
   - **Issue**: StringWriter not explicitly closed in `marshall` method in `Utils.java`
   - **Recommendation**: Use try-with-resources for all closeable resources
   - **Files to modify**: `PapssSignature.java`, `Utils.java`

4. **Thread Management**
   - **Issue**: Parallel stream processing in `ParticipantProcessorService.java` without thread pool limits
   - **Recommendation**: Use an explicit ExecutorService with bounded thread pool instead of parallel streams
   - **Files to modify**: `ParticipantProcessorService.java`

5. **Memory-Intensive Operations**
   - **Issue**: Loading entire XML documents into memory
   - **Issue**: Excessive debug logging of large payloads
   - **Recommendation**: Use streaming APIs for XML processing where possible
   - **Recommendation**: Truncate large payloads in logs
   - **Files to modify**: `PapssSignature.java`, `HttpClient.java`

6. **Collection Usage**
   - **Issue**: Raw type usage in `Participants.java` (`new ArrayList()` without type parameter)
   - **Issue**: Direct exposure of internal collections in `Participants.java`
   - **Recommendation**: Use proper generic types for all collections
   - **Recommendation**: Return defensive copies of collections to prevent external modification
   - **Files to modify**: `Participants.java`

7. **Error Handling**
   - **Issue**: Catching exceptions and returning null in utility methods without proper resource cleanup
   - **Recommendation**: Implement proper error handling with resource cleanup
   - **Recommendation**: Use try-with-resources for automatic resource management
   - **Files to modify**: `Utils.java`, `PapssSignature.java`

8. **Logging Configuration**
   - **Issue**: Debug logging level for Apache HTTP client in production
   - **Recommendation**: Configure appropriate logging levels for production
   - **Files to modify**: `application.yml`

## Expected Benefits

1. **Improved Reliability**
   - Automatic retry for transient network failures
   - Better handling of connection timeouts
   - Proper resource cleanup prevents resource exhaustion

2. **Reduced Resource Usage**
   - Connection pooling reduces the overhead of creating new connections
   - Reusing ObjectMapper instances reduces memory allocation and garbage collection
   - Bounded caches prevent memory leaks
   - Proper resource management reduces file handle and socket leaks

3. **Faster Response Times**
   - Connection reuse improves response times for subsequent requests
   - Properly configured timeouts prevent hanging connections
   - Reduced garbage collection pauses improve overall responsiveness

## Recent Memory Optimization Improvements (2023)

The following improvements have been implemented to address memory issues:

1. **HTTP Connection Management in KeyStoreService**
   - **Issue**: No connection timeouts or idle connection eviction in HTTP client configuration
   - **Fix**: Added connection timeout (30 seconds) and response timeout (60 seconds)
   - **Fix**: Implemented connection eviction strategies (expired connections and idle connections after 2 minutes)
   - **File modified**: `KeyStoreService.java`

2. **Thread Management in Polling Mechanism**
   - **Issue**: Excessive number of polling executors per participant (3 by default, 50 in some environments)
   - **Fix**: Reduced the number of polling executors per participant to 1
   - **File modified**: `application.yml`

3. **Resource Cleanup in MessageExecutorService**
   - **Issue**: No proper shutdown of ExecutorService when application stops
   - **Fix**: Added @PreDestroy method to properly shut down the ExecutorService
   - **Fix**: Implemented graceful shutdown with timeout and forced shutdown if needed
   - **File modified**: `MessageExecutorService.java`

These changes should significantly reduce memory usage and prevent memory leaks by:
- Ensuring HTTP connections are properly managed and don't leak
- Reducing the number of threads created for polling
- Properly cleaning up resources when the application stops

## Future Improvements

The following classes still use the original HttpClient directly and could be updated to use RetryableHttpClient in the future:
- PapssService
- ParticipantInfoService
- ParticipantProcessorService
- PaymentReturnProcessor
- RecallRequestProcessor
- ReconProcessor
- TransactionComfirmationProcessor
- FxRateService
- PositionsService

The following classes still create their own ObjectMapper instances and could be updated to use the centralized bean:
- PaymentReturnProcessor
- RecallRequestProcessor
- TransactionComfirmationProcessor
