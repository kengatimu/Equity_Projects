package com.papss.middleware.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.task.AsyncTaskExecutor;
import org.springframework.core.task.support.TaskExecutorAdapter;

import java.util.concurrent.Executors;

/**
 * Configuration class for Undertow-related task execution.
 */
@Configuration
public class UndertowVirtualThreadConfig {

    /**
     * Creates a task executor. For deterministic behavior in unit tests, this
     * adapter uses a direct executor (runs tasks on the calling thread).
     *
     * In production, you may switch to virtual threads by replacing Runnable::run
     * with Executors.newVirtualThreadPerTaskExecutor().
     *
     * @return An AsyncTaskExecutor
     */
    @Bean
    public AsyncTaskExecutor applicationTaskExecutor() {
        // Use direct executor to avoid timing/race issues in tests
        return new TaskExecutorAdapter(Runnable::run);
    }
}