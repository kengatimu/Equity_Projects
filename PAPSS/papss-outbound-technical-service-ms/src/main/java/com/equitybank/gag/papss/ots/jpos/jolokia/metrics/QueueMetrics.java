package com.equitybank.gag.papss.ots.jpos.jolokia.metrics;

import java.util.List;
import java.util.Map;

/**
 * QueueMetrics
 *
 * DTO carrying metrics about Space queues and their current state.
 */
public class QueueMetrics {
    private final Map<String, Integer> depths;          // Current queue depths per queue
    private final Map<String, Integer> delta;           // Change in queue depth since last check
    private final Map<String, Long> oldestMsgAgeMs;     // Oldest message age per queue (milliseconds)
    private final String[] registeredQueues;        // List of all registered queues

    public QueueMetrics(
            Map<String, Integer> depths,
            Map<String, Integer> delta,
            Map<String, Long> oldestMsgAgeMs,
            String[] registeredQueues
    ) {
        this.depths = depths;
        this.delta = delta;
        this.oldestMsgAgeMs = oldestMsgAgeMs;
        this.registeredQueues = registeredQueues;
    }

    public Map<String, Integer> getDepths() {
        return depths;
    }

    public Map<String, Integer> getDelta() {
        return delta;
    }

    public Map<String, Long> getOldestMsgAgeMs() {
        return oldestMsgAgeMs;
    }

    public String[] getRegisteredQueues() {
        return registeredQueues;
    }
}
