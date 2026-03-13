package com.papss.middleware.config;

import org.junit.jupiter.api.Test;
import org.springframework.core.task.AsyncTaskExecutor;
import org.springframework.core.task.support.TaskExecutorAdapter;

import java.util.concurrent.CompletableFuture;
import java.util.concurrent.atomic.AtomicBoolean;

import static org.junit.jupiter.api.Assertions.*;

class UndertowVirtualThreadConfigTest {

    @Test
    void applicationTaskExecutor_returnsAsyncTaskExecutor_andExecutesTask() {
        UndertowVirtualThreadConfig cfg = new UndertowVirtualThreadConfig();
        AsyncTaskExecutor exec = cfg.applicationTaskExecutor();

        assertNotNull(exec);
        assertTrue(exec instanceof TaskExecutorAdapter);

        AtomicBoolean ran = new AtomicBoolean(false);
        CompletableFuture<Void> f = CompletableFuture.runAsync(() -> exec.execute(() -> ran.set(true)));
        f.join();
        assertTrue(ran.get());
    }
}
