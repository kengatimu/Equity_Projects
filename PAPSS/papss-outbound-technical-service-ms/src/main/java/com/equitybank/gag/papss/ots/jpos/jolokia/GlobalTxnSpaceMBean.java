package com.equitybank.gag.papss.ots.jpos.jolokia;

import com.equitybank.gag.papss.ots.jpos.jolokia.metrics.*;

/**
 * GlobalTxnSpaceMBean
 * Defines the contract for exposing transaction metrics grouped into five logical categories.
 * This is what Jolokia/JConsole will read from.
 */
public interface GlobalTxnSpaceMBean {

    // 1. Queue Metrics
    QueueMetrics getQueueMetrics();

    // 2. TransactionManager Metrics
    TransactionManagerMetrics getTransactionManagerMetrics();

    // 3. Performance / Throughput Metrics
    PerformanceMetrics getPerformanceMetrics();

    // 4. System Health Metrics
    SystemHealthMetrics getSystemHealthMetrics();

    // 5. Summary (high-level important metrics only)
    SummaryMetrics getSummary();
}
