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
     * Creates a task executor. For deterministic behavior in unit tests, this
     * adapter uses a direct executor (runs tasks on the calling thread).
     *
     * In production, you may switch to virtual threads by replacing Runnable::run
     * with Executors.newVirtualThreadPerTaskExecutor().
     *
     * @return A task executor adapter
     */
    @Bean
    public TaskExecutor taskExecutor() {
        // Use direct executor to avoid timing/race issues in tests
        return new TaskExecutorAdapter(Runnable::run);
    }
}
