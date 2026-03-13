package com.equitybankgroup.payments.b2c.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.core.task.TaskExecutor;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import java.util.concurrent.ThreadPoolExecutor;

@Configuration
@EnableAsync
public class TaskExecutorConfiguration {
    @Primary
    @Bean(name = "taskExecutor")
    public TaskExecutor taskExecutor() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();

        executor.setCorePoolSize(50); // Number of core threads
        executor.setMaxPoolSize(150); // Maximum number of threads
        executor.setQueueCapacity(10000); // Queue capacity
        executor.setKeepAliveSeconds(60); // Keep alive time for idle threads
        executor.setThreadNamePrefix("AsyncExecutor-"); // Thread name prefix

        // Policy for rejected tasks when the queue is full: abort the task and throw a RejectedExecutionException
        executor.setRejectedExecutionHandler(new ThreadPoolExecutor.AbortPolicy());

        // Ensure all tasks are completed before shutdown
        executor.setWaitForTasksToCompleteOnShutdown(true);
        executor.setAwaitTerminationSeconds(60); // Maximum wait time for tasks to complete on shutdown

        // Initialize the executor
        executor.initialize();

        return executor;
    }
}
