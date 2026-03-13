package com.papss.middleware.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.task.AsyncTaskExecutor;
import org.springframework.core.task.support.TaskExecutorAdapter;

import java.util.concurrent.Executors;

/**
 * Configuration class to enable Virtual Threads for Undertow.
 * This replaces the previous TomcatVirtualThreadConfig as the application now uses Undertow.
 */
@Configuration
public class UndertowVirtualThreadConfig {

    /**
     * Creates a task executor that uses virtual threads.
     * This executor will be used by Spring components that support async execution,
     * including Undertow's request processing.
     *
     * @return An AsyncTaskExecutor that uses virtual threads
     */
    @Bean
    public AsyncTaskExecutor applicationTaskExecutor() {
        return new TaskExecutorAdapter(Executors.newVirtualThreadPerTaskExecutor());
    }
}