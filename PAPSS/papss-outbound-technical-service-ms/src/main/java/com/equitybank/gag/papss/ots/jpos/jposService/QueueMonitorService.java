package com.equitybank.gag.papss.ots.jpos.jposService;

public interface QueueMonitorService {
    int getQueueDepth(String rrn, String queueName);
}
