package com.papss.middleware.config;

import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.task.TaskExecutor;
import org.springframework.core.task.support.TaskExecutorAdapter;

import java.util.concurrent.Executors;

@Configuration
@RequiredArgsConstructor
public class TaskExecutorConfig {

    /**
     * Creates a task executor that uses virtual threads.
     * This significantly improves the application's ability to handle concurrent tasks
     * by using lightweight virtual threads instead of platform threads.
     *
     * Virtual threads are designed for I/O-bound workloads and can handle thousands of concurrent tasks
     * with minimal resource usage compared to traditional platform threads.
     *
     * @return A task executor that uses virtual threads
     */
    @Bean
    public TaskExecutor taskExecutor() {
        // Create a TaskExecutorAdapter that delegates to a virtual thread executor
        return new TaskExecutorAdapter(Executors.newVirtualThreadPerTaskExecutor());
    }
}
