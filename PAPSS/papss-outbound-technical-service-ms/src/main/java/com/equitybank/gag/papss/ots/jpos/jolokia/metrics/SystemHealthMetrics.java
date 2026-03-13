package com.equitybank.gag.papss.ots.jpos.jolokia.metrics;

/**
 * SystemHealthMetrics
 *
 * DTO carrying overall system health and transaction statistics.
 */
public class SystemHealthMetrics {
    private final int numberOfActiveTms;     // Total number of active Transaction Managers
    private final long totalTxnStarted;      // Total number of transactions started
    private final long totalTxnCompleted;    // Total number of transactions completed
    private final long totalTxnAborted;      // Total number of transactions aborted
    private final double txnSuccessRatePct;     // Success rate percentage

    public SystemHealthMetrics(int numberOfActiveTms,
                               long totalTxnStarted,
                               long totalTxnCompleted,
                               long totalTxnAborted,
                               double txnSuccessRatePct) {
        this.numberOfActiveTms = numberOfActiveTms;
        this.totalTxnStarted = totalTxnStarted;
        this.totalTxnCompleted = totalTxnCompleted;
        this.totalTxnAborted = totalTxnAborted;
        this.txnSuccessRatePct = txnSuccessRatePct;
    }

    public int getNumberOfActiveTms() {
        return numberOfActiveTms;
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
}
