package com.equitybank.gag.papss.its.jpos.jolokia.metrics;

/**
 * SummaryMetrics
 *
 * High-level snapshot of system performance and health.
 */
public class SummaryMetrics {
    private final int activeTms;          // Number of active TransactionManagers
    private final long txnStarted;        // Total transactions started
    private final long txnCompleted;      // Total transactions completed
    private final long txnAborted;        // Total transactions aborted
    private final double successRatePct;  // Success rate percentage
    private final double tpsSinceStart;   // Transactions per second (average since application start)
    private final double tps10s;          // Transactions per second (10s window)
    private final double tps1m;           // Transactions per second (1m window)
    private final double tps5m;           // Transactions per second (5m window)
    private final String lastUpdated;     // Timestamp of last snapshot

    public SummaryMetrics(int activeTms,
                          long txnStarted,
                          long txnCompleted,
                          long txnAborted,
                          double successRatePct,
                          double tpsSinceStart,
                          double tps10s,
                          double tps1m,
                          double tps5m,
                          String lastUpdated) {
        this.activeTms = activeTms;
        this.txnStarted = txnStarted;
        this.txnCompleted = txnCompleted;
        this.txnAborted = txnAborted;
        this.successRatePct = successRatePct;
        this.tpsSinceStart = tpsSinceStart;
        this.tps10s = tps10s;
        this.tps1m = tps1m;
        this.tps5m = tps5m;
        this.lastUpdated = lastUpdated;
    }

    public int getActiveTms() { return activeTms; }
    public long getTxnStarted() { return txnStarted; }
    public long getTxnCompleted() { return txnCompleted; }
    public long getTxnAborted() { return txnAborted; }
    public double getSuccessRatePct() { return successRatePct; }
    public double getTpsSinceStart() { return tpsSinceStart; }
    public double getTps10s() { return tps10s; }
    public double getTps1m() { return tps1m; }
    public double getTps5m() { return tps5m; }
    public String getLastUpdated() { return lastUpdated; }
}
