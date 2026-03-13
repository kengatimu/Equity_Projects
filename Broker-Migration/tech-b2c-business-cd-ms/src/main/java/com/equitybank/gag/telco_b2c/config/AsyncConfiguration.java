package com.equitybank.gag.telco_b2c.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.aop.interceptor.AsyncUncaughtExceptionHandler;
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
public class AsyncConfiguration implements AsyncConfigurer {

    private static final Logger log = LoggerFactory.getLogger(AsyncConfiguration.class);

    @Override
    @Bean(name = "taskExecutor")
    @Primary
    public TaskExecutor getAsyncExecutor() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();

        executor.setCorePoolSize(100);       // Handle many small requests
        executor.setMaxPoolSize(400);        // Allow bursts
        executor.setQueueCapacity(25000);    // Large queue for incoming tasks
        executor.setKeepAliveSeconds(60);    // Keep idle threads for reuse

        executor.setThreadNamePrefix("AsyncExecutor-"); // Thread name prefix

        // Custom handler for rejected tasks with logging
        executor.setRejectedExecutionHandler((r, ex) -> {
            log.error("Task rejected from AsyncExecutor: {}", r.toString());
            throw new RejectedExecutionException("Task rejected due to overload: " + ex);
        });

        // Graceful shutdown
        executor.setWaitForTasksToCompleteOnShutdown(true);
        executor.setAwaitTerminationSeconds(60);

        executor.initialize();
        return executor;
    }

    @Override
    public AsyncUncaughtExceptionHandler getAsyncUncaughtExceptionHandler() {
        return (throwable, method, params) ->
                log.error("Uncaught async error in method '{}' with params {}: {}", method.getName(), Arrays.toString(params), throwable.getMessage(), throwable);
    }
}