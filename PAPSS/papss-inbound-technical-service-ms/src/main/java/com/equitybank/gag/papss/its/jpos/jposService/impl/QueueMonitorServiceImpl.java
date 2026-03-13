package com.equitybank.gag.papss.its.jpos.jposService.impl;

import com.equitybank.gag.papss.its.jpos.jposService.QueueMonitorService;
import org.jpos.space.TSpace;
import org.jpos.util.NameRegistrar;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import static com.equitybank.gag.papss.its.jpos.space.configs.JposConstants.SHARED_SPACE_NAME_INBOUND;


/**
 * Implementation of QueueMonitorService that uses JMX to retrieve queue depths.
 * Assumes jPOS Q2 and Spring Boot application run in the same JVM.
 */

@Service
public class QueueMonitorServiceImpl implements QueueMonitorService {
    private static final Logger log = LoggerFactory.getLogger(QueueMonitorServiceImpl.class);

    @Override
    public int getQueueDepth(String rrn, String queueName) {
        try {
            Object spaceObj = NameRegistrar.get(SHARED_SPACE_NAME_INBOUND);

            if (spaceObj instanceof TSpace<?, ?> tSpace) {
                // Use the queue name as the key to get the size of that queue
                int size = tSpace.size(queueName);
                log.debug("{}: Queue '{}' has size {}", rrn, queueName, size);
                return size;
            }

            log.warn("{}: GLOBAL_TXN_SPACE is not a TSpace instance. Returning -1.", rrn);
            return -1;
        } catch (NameRegistrar.NotFoundException e) {
            log.warn("{}: GLOBAL_TXN_SPACE not found in NameRegistrar. Returning -1.", rrn);
            return -1;
        } catch (Exception e) {
            log.error("{}: Unexpected error while retrieving size for queue '{}': {}", rrn, queueName, e.getMessage(), e);
            return -1;
        }
    }
}