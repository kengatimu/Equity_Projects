package com.bishop.papss_channel_mock_service.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.aop.interceptor.AsyncUncaughtExceptionHandler;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.core.task.TaskExecutor;
import org.springframework.scheduling.annotation.AsyncConfigurer;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import java.util.Arrays;
import java.util.concurrent.RejectedExecutionException;

@Configuration
@EnableAsync
public class AsyncConfigs implements AsyncConfigurer {

    private static final Logger log = LoggerFactory.getLogger(AsyncConfigs.class);

    private final int corePoolSize;
    private final int maxPoolSize;
    private final int queueCapacity;
    private final int keepAliveSeconds;

    public AsyncConfigs(@Value("${async.core-pool-size:50}") int corePoolSize,       // Default to 50 if not defined
                        @Value("${async.max-pool-size:150}") int maxPoolSize,        // Default to 150 if not defined
                        @Value("${async.queue-capacity:10000}") int queueCapacity,   // Default to 10000 if not defined
                        @Value("${async.keep-alive-seconds:60}") int keepAliveSeconds // Thread idle timeout. Default to 60 if not defined
    ) {
        this.corePoolSize = corePoolSize;
        this.maxPoolSize = maxPoolSize;
        this.queueCapacity = queueCapacity;
        this.keepAliveSeconds = keepAliveSeconds;
    }

    @Override
    @Bean(name = "taskExecutor")
    @Primary
    public TaskExecutor getAsyncExecutor() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();

        executor.setCorePoolSize(corePoolSize); // Minimum number of threads always kept alive, even when idle
        executor.setMaxPoolSize(maxPoolSize); // Maximum number of threads allowed during peak load
        executor.setQueueCapacity(queueCapacity); // Size of the queue to hold tasks before new threads are created
        executor.setKeepAliveSeconds(keepAliveSeconds); // Time in seconds to keep extra (non-core) threads alive when idle
        executor.setThreadNamePrefix("AsyncExecutor-"); // Prefix used for naming threads in logs and debuggers

        // Logs and throws an exception when the thread pool and queue are full, rejecting new tasks
        executor.setRejectedExecutionHandler((runnable, executor1) -> {
            log.error("Task rejected from AsyncExecutor: {}", runnable.toString());
            throw new RejectedExecutionException("Task rejected due to overload: " + executor1);
        });

        executor.setWaitForTasksToCompleteOnShutdown(true); // Allow in-flight tasks to complete during shutdown instead of terminating abruptly
        executor.setAwaitTerminationSeconds(60); // Wait up to 60 seconds for tasks to finish before forcing shutdown

        executor.initialize(); // Initializes the thread pool and applies all configured settings
        return executor; // Returns the fully configured TaskExecutor
    }

    @Override
    // Handles uncaught exceptions thrown from @Async void methods and logs detailed error context
    public AsyncUncaughtExceptionHandler getAsyncUncaughtExceptionHandler() {
        return (throwable, method, params) -> log.error(
                "Uncaught async error in method '{}' with params {}: {}",
                method.getName(),
                Arrays.toString(params),
                throwable.getMessage(),
                throwable
        );
    }

}
