package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.config;

import java.util.concurrent.Executor;
import java.util.concurrent.ExecutorService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.aop.interceptor.AsyncUncaughtExceptionHandler;
import org.springframework.aop.interceptor.SimpleAsyncUncaughtExceptionHandler;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.scheduling.annotation.AsyncConfigurer;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

@Configuration
@EnableAsync
@EnableScheduling
public class AsyncConfiguration implements AsyncConfigurer {

    private final Logger log = LoggerFactory.getLogger(AsyncConfiguration.class);
    
    @Value("${config.async.corePoolSize}")
    private int corePoolSize;
    
    @Value("${config.async.maxPoolSize}")
    private int maxPoolSize;
    
    @Value("${config.async.queueCapacity}")
    private int queueCapacity;
    
    @Override
    @Bean(name = "taskExecutor")
    public Executor getAsyncExecutor() {
        log.debug("Creating Async Task Executor");
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        int numOfCores = Runtime.getRuntime().availableProcessors();
        executor.setCorePoolSize(corePoolSize);
        executor.setMaxPoolSize(maxPoolSize);
        executor.setQueueCapacity(queueCapacity);
        executor.setThreadNamePrefix("task-");

        log.info("NUMBER OF CORES: " + numOfCores);
        log.info("CORE POOL SIZE: " + executor.getCorePoolSize());
        log.info("MAX POOL SIZE: " + executor.getMaxPoolSize());
        log.info("QUEUE CAPACITY: 10000");
        log.info("THREAD NAME PREFIX: " + executor.getThreadNamePrefix());
        return executor;
    }

    @Override
    public AsyncUncaughtExceptionHandler getAsyncUncaughtExceptionHandler() {
        return new SimpleAsyncUncaughtExceptionHandler();
    }
    
    @Bean
    @Primary
    public ExecutorService getExecutorService() {
        // Convert TaskExecutor to ExecutorService
        ExecutorService executorService = ((ThreadPoolTaskExecutor) getAsyncExecutor()).getThreadPoolExecutor();
        return executorService;
    }
    
}
