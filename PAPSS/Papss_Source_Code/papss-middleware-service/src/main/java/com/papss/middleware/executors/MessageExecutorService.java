package com.papss.middleware.executors;

import com.papss.middleware.service.inbound.ParticipantProcessorService;
import jakarta.annotation.PreDestroy;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

@Slf4j
@Component
@RequiredArgsConstructor
@ConditionalOnProperty(name = "papss.system.enableInbound", havingValue = "true", matchIfMissing = true)
public class MessageExecutorService {

    private final ParticipantProcessorService participantProcessorService;

    // Create a single ExecutorService using virtual threads for better performance
    private final ExecutorService executorService = Executors.newVirtualThreadPerTaskExecutor();

    /**
     * Scheduled method that processes participants using virtual threads.
     * This implementation uses a single virtual thread to call the participant processor,
     * which internally processes all participants in parallel.
     * 
     * Using virtual threads provides better performance and resource utilization
     * compared to traditional platform threads.
     */
    @Scheduled(fixedRateString = "${papss.system.pollingExecutorThreadRate}", initialDelayString = "${papss.system.pollingExecutorThreadDelay}")
    public void execute() {
        executorService.submit(() -> {
            try {
                log.debug("Polling executor thread started");
                participantProcessorService.processParticipant();
            } catch (Exception e) {
                log.error("Error in participant processing: {}", e.getMessage(), e);
            }
        });
    }

    /**
     * Properly shutdown the executor service when the application is stopped.
     * This prevents memory leaks by ensuring all resources are released.
     */
    @PreDestroy
    public void shutdown() {
        log.info("Shutting down MessageExecutorService");
        executorService.shutdown();
        try {
            // Wait for tasks to complete with a timeout
            if (!executorService.awaitTermination(60, TimeUnit.SECONDS)) {
                log.warn("ExecutorService did not terminate in the specified time. Forcing shutdown.");
                executorService.shutdownNow();

                // Wait again for tasks to respond to being cancelled
                if (!executorService.awaitTermination(60, TimeUnit.SECONDS)) {
                    log.error("ExecutorService did not terminate");
                }
            }
        } catch (InterruptedException e) {
            log.error("Interrupted while waiting for ExecutorService shutdown", e);
            // Preserve interrupt status
            Thread.currentThread().interrupt();
            // Force shutdown if interrupted
            executorService.shutdownNow();
        }
        log.info("MessageExecutorService shutdown complete");
    }
}
