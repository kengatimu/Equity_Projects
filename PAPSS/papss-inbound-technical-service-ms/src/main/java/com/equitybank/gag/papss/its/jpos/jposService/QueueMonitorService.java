package com.equitybank.gag.papss.its.jpos.jposService;

public interface QueueMonitorService {
    int getQueueDepth(String rrn, String queueName);
}
