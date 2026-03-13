package com.papss.middleware.config;

import org.junit.jupiter.api.Test;
import org.springframework.core.task.TaskExecutor;
import org.springframework.core.task.support.TaskExecutorAdapter;

import java.util.concurrent.CompletableFuture;
import java.util.concurrent.atomic.AtomicBoolean;

import static org.junit.jupiter.api.Assertions.*;

class TaskExecutorConfigTest {

    @Test
    void taskExecutor_returnsTaskExecutorAdapter_andExecutesTask() {
        TaskExecutorConfig cfg = new TaskExecutorConfig();
        TaskExecutor exec = cfg.taskExecutor();

        assertNotNull(exec);
        assertTrue(exec instanceof TaskExecutorAdapter);

        AtomicBoolean ran = new AtomicBoolean(false);
        CompletableFuture<Void> f = CompletableFuture.runAsync(() -> exec.execute(() -> ran.set(true)));
        f.join();
        // The task scheduled into the adapter should set the flag
        assertTrue(ran.get());
    }
}
