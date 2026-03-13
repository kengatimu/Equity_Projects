package com.equitybank.gag.papss.ots.jpos.jolokia;

import com.equitybank.gag.papss.ots.jpos.jolokia.metrics.*;
import org.jpos.space.TSpace;
import org.jpos.transaction.TransactionManager;
import org.jpos.util.NameRegistrar;

import java.util.*;
import java.util.concurrent.ConcurrentLinkedDeque;
import java.util.concurrent.atomic.AtomicLong;

public class GlobalTxnSpace implements GlobalTxnSpaceMBean {
    private final TSpace<String, Object> space;
    private final long startTime = System.currentTimeMillis(); // Start time for overall TPS calculation

    // === Thread-safe Internal metric caches ===
    private final Map<String, Integer> lastQueueDepths = new HashMap<>();
    private final Map<String, Long> oldestMsgTimestamps = new HashMap<>();
    private final AtomicLong totalStarted = new AtomicLong(0);
    private final AtomicLong totalCompleted = new AtomicLong(0);
    private final AtomicLong totalAborted = new AtomicLong(0);
    private final AtomicLong totalDuration = new AtomicLong(0);
    private final AtomicLong maxDuration = new AtomicLong(0);
    private final Deque<Long> txnTimestamps = new ConcurrentLinkedDeque<>();

    public GlobalTxnSpace(TSpace<String, Object> space) {
        this.space = space;
    }

    // === Public MBean Methods ===
    @Override
    public synchronized QueueMetrics getQueueMetrics() {
        Map<String, Integer> depthDeltas = new HashMap<>();
        Map<String, Long> oldestAges = new HashMap<>();
        long now = System.currentTimeMillis();
        for (String q : discoverQueues()) {
            int currentDepth = getQueueDepth(q);
            int lastDepth = lastQueueDepths.getOrDefault(q, 0);
            depthDeltas.put(q, currentDepth - lastDepth);
            lastQueueDepths.put(q, currentDepth);
            Long ts = oldestMsgTimestamps.get(q);
            oldestAges.put(q, ts != null ? now - ts : 0L);
        }
        return new QueueMetrics(getQueueDepths(), depthDeltas, oldestAges, getRegisteredQueues());
    }

    @Override
    public TransactionManagerMetrics getTransactionManagerMetrics() {
        return new TransactionManagerMetrics(
                totalStarted.get(),
                totalCompleted.get(),
                totalAborted.get(),
                getTxnSuccessRatePct(),
                getAvgTxnDurationMs(),
                maxDuration.get(),
                getCurrentTxnInProgress(),
                getActiveSessionsPerTm(),
                getMaxSessionsPerTm()
        );
    }

    @Override
    public PerformanceMetrics getPerformanceMetrics() {
        return new PerformanceMetrics(
                getTpsSinceStart(),
                getTxnTps10s(),
                getTxnTps1m(),
                getTxnTps5m(),
                getAvgTxnDurationMs(),
                maxDuration.get()
        );
    }

    @Override
    public SystemHealthMetrics getSystemHealthMetrics() {
        return new SystemHealthMetrics(
                discoverTms().size(),
                totalStarted.get(),
                totalCompleted.get(),
                totalAborted.get(),
                getTxnSuccessRatePct()
        );
    }

    @Override
    public SummaryMetrics getSummary() {
        return new SummaryMetrics(
                discoverTms().size(),
                totalStarted.get(),
                totalCompleted.get(),
                totalAborted.get(),
                getTxnSuccessRatePct(),
                getTpsSinceStart(),
                getTxnTps10s(),
                getTxnTps1m(),
                getTxnTps5m(),
                new Date().toString()
        );
    }

    // === Legacy attributes ===
    public Map<String, Integer> getQueueDepths() {
        Map<String, Integer> depths = new HashMap<>();
        for (String q : discoverQueues()) {
            depths.put(q, getQueueDepth(q));
        }
        return depths;
    }

    public String[] getRegisteredQueues() {
        return discoverQueues().toArray(new String[0]);
    }

    public Map<String, Integer> getActiveSessionsPerTm() {
        Map<String, Integer> result = new HashMap<>();
        for (String tmName : discoverTms()) {
            try {
                result.put(tmName, ((TransactionManager) NameRegistrar.get(tmName)).getActiveSessions());
            } catch (Exception e) { result.put(tmName, -1); }
        }
        return result;
    }

    public Map<String, Integer> getMaxSessionsPerTm() {
        Map<String, Integer> result = new HashMap<>();
        for (String tmName : discoverTms()) {
            try {
                result.put(tmName, ((TransactionManager) NameRegistrar.get(tmName)).getMaxSessions());
            } catch (Exception e) { result.put(tmName, -1); }
        }
        return result;
    }

    public Map<String, Integer> getCurrentTxnInProgress() {
        Map<String, Integer> result = new HashMap<>();
        for (String tmName : discoverTms()) {
            try {
                result.put(tmName, ((TransactionManager) NameRegistrar.get(tmName)).getActiveTransactions());
            } catch (Exception e) { result.put(tmName, -1); }
        }
        return result;
    }

    public int getQueueDepth(String queueName) {
        try {
            return space.size(queueName);
        } catch (Exception e) { return -1; }
    }

    // === Discovery Helpers ===
    private Set<String> discoverQueues() {
        Set<String> queues = new TreeSet<>();
        for (String key : NameRegistrar.getAsMap().keySet()) {
            if (key.startsWith("tspace:") && key.toLowerCase().contains("queue")) {
                queues.add(key.replace("tspace:", ""));
            }
        }
        return queues;
    }

    private Set<String> discoverTms() {
        Set<String> tms = new TreeSet<>();
        for (Map.Entry<String, Object> entry : NameRegistrar.getAsMap().entrySet()) {
            if (entry.getValue() instanceof TransactionManager) {
                tms.add(entry.getKey());
            }
        }
        return tms;
    }

    // === Rolling stats updates ===
    public void recordTxnStarted() {
        totalStarted.incrementAndGet();
    }

    public void recordTxnCompleted(long durationMs) {
        totalCompleted.incrementAndGet();
        totalDuration.addAndGet(durationMs);
        updateMaxDuration(durationMs);
        txnTimestamps.addLast(System.currentTimeMillis());
    }

    public void recordTxnAborted(long durationMs) {
        totalAborted.incrementAndGet();
        totalDuration.addAndGet(durationMs);
        updateMaxDuration(durationMs);
        txnTimestamps.addLast(System.currentTimeMillis());
    }

    private void updateMaxDuration(long durationMs) {
        long currentMax;
        do {
            currentMax = maxDuration.get();
        } while (durationMs > currentMax && !maxDuration.compareAndSet(currentMax, durationMs));
    }

    public synchronized void recordMessageEnqueued(String queueName) {
        oldestMsgTimestamps.putIfAbsent(queueName, System.currentTimeMillis());
    }

    public synchronized void recordMessageDequeued(String queueName) {
        oldestMsgTimestamps.remove(queueName);
    }

    // === Private Calculation Helpers ===
    private double getTxnSuccessRatePct() {
        long attempted = totalCompleted.get() + totalAborted.get();
        return attempted == 0 ? 100.0 : (totalCompleted.get() * 100.0 / attempted);
    }

    private double getAvgTxnDurationMs() {
        long finished = totalCompleted.get() + totalAborted.get();
        return finished == 0 ? 0.0 : (double) totalDuration.get() / finished;
    }

    private double getTpsSinceStart() {
        long finished = totalCompleted.get() + totalAborted.get();
        long elapsedMs = System.currentTimeMillis() - startTime;
        return elapsedMs > 0 ? (double) finished * 1000.0 / elapsedMs : 0.0;
    }

    private double getTxnTps10s() {
        return calcTps(10_000L);
    }

    private double getTxnTps1m() {
        return calcTps(60_000L);
    }

    private double getTxnTps5m() {
        return calcTps(300_000L);
    }

    private double calcTps(long windowMs) {
        long now = System.currentTimeMillis();
        while (!txnTimestamps.isEmpty() && (now - txnTimestamps.peekFirst()) > windowMs) {
            txnTimestamps.pollFirst();
        }
        return (double) txnTimestamps.size() * 1000.0 / windowMs;
    }
}
