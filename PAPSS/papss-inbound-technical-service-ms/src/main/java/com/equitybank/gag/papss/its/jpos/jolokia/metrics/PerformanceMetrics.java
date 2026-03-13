package com.equitybank.gag.papss.its.jpos.jolokia.metrics;

/**
 * PerformanceMetrics
 *
 * DTO carrying system performance-related metrics.
 */
public class PerformanceMetrics {
    private final double tpsSinceStart;       // Transactions per second (average since application start)
    private final double tps10s;              // Transactions per second (10-second rolling window)
    private final double tps1m;               // Transactions per second (1-minute rolling window)
    private final double tps5m;               // Transactions per second (5-minute rolling window)
    private final double avgTxnDurationMs;    // Average transaction duration (milliseconds)
    private final long maxTxnDurationMs;      // Maximum observed transaction duration (milliseconds)

    public PerformanceMetrics(double tpsSinceStart,
                              double tps10s,
                              double tps1m,
                              double tps5m,
                              double avgTxnDurationMs,
                              long maxTxnDurationMs) {
        this.tpsSinceStart = tpsSinceStart;
        this.tps10s = tps10s;
        this.tps1m = tps1m;
        this.tps5m = tps5m;
        this.avgTxnDurationMs = avgTxnDurationMs;
        this.maxTxnDurationMs = maxTxnDurationMs;
    }

    public double getTpsSinceStart() {
        return tpsSinceStart;
    }

    public double getTps10s() {
        return tps10s;
    }

    public double getTps1m() {
        return tps1m;
    }

    public double getTps5m() {
        return tps5m;
    }

    public double getAvgTxnDurationMs() {
        return avgTxnDurationMs;
    }

    public long getMaxTxnDurationMs() {
        return maxTxnDurationMs;
    }
}
