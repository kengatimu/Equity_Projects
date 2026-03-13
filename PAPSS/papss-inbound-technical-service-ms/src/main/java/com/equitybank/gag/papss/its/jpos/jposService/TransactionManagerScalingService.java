package com.equitybank.gag.papss.its.jpos.jposService;

import java.util.List;

public interface TransactionManagerScalingService {

    // Attempts to start a new Transaction Manager instance.
    // Returns the queue name of the newly started TM, or null if creation failed or max TMs reached.
    String startNewTm(String rrn);

    // Gets a sorted list of currently active TM queue names.
    List<String> getActiveTmQueues();

    // Gets the current queue depth (items waiting) for a specific TM queue.
    int getQueueDepth(String rrn, String queueName);
}