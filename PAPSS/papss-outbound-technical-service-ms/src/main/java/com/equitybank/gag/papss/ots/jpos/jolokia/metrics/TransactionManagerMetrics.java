package com.equitybank.gag.papss.ots.jpos.jolokia.metrics;

import java.util.Map;

/**
 * TransactionManagerMetrics
 *
 * DTO carrying transaction-related metrics across all TransactionManagers.
 */
public class TransactionManagerMetrics {
    private final long totalTxnStarted;                    // total transactions started
    private final long totalTxnCompleted;                  // total transactions completed
    private final long totalTxnAborted;                    // total transactions aborted
    private final double txnSuccessRatePct;             // percentage of successful txns
    private final double avgTxnDurationMs;              // average txn duration
    private final long maxDurationMs;                   // max observed txn duration
    private final Map<String, Integer> currentInProgress; // in-progress txns per TM
    private final Map<String, Integer> activeSessions;    // active sessions per TM
    private final Map<String, Integer> maxSessions;       // max sessions per TM

    public TransactionManagerMetrics(
            long totalTxnStarted,
            long totalTxnCompleted,
            long totalTxnAborted,
            double txnSuccessRatePct,
            double avgTxnDurationMs,
            long maxDurationMs,
            Map<String, Integer> currentInProgress,
            Map<String, Integer> activeSessions,
            Map<String, Integer> maxSessions
    ) {
        this.totalTxnStarted = totalTxnStarted;
        this.totalTxnCompleted = totalTxnCompleted;
        this.totalTxnAborted = totalTxnAborted;
        this.txnSuccessRatePct = txnSuccessRatePct;
        this.avgTxnDurationMs = avgTxnDurationMs;
        this.maxDurationMs = maxDurationMs;
        this.currentInProgress = currentInProgress;
        this.activeSessions = activeSessions;
        this.maxSessions = maxSessions;
    }

    public long getTotalTxnStarted() {
        return totalTxnStarted;
    }

    public long getTotalTxnCompleted() {
        return totalTxnCompleted;
    }

    public long getTotalTxnAborted() {
        return totalTxnAborted;
    }

    public double getTxnSuccessRatePct() {
        return txnSuccessRatePct;
    }

    public double getAvgTxnDurationMs() {
        return avgTxnDurationMs;
    }

    public long getMaxDurationMs() {
        return maxDurationMs;
    }

    public Map<String, Integer> getCurrentInProgress() {
        return currentInProgress;
    }

    public Map<String, Integer> getActiveSessions() {
        return activeSessions;
    }

    public Map<String, Integer> getMaxSessions() {
        return maxSessions;
    }
}
