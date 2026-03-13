package com.equitybank.gag.papss.ots.jpos.jposService.impl;

import com.equitybank.gag.papss.ots.jpos.space.configs.JposConstants;
import com.equitybank.gag.papss.ots.dto.channelRequest.transaction.ChannelCreditTransferDetailsReq;
import com.equitybank.gag.papss.ots.enums.TransactionStatus;
import com.equitybank.gag.papss.ots.exception.CustomException;
import com.equitybank.gag.papss.ots.jpos.jposService.TransactionDispatcherService;
import com.equitybank.gag.papss.ots.jpos.jposService.TransactionManagerScalingService;
import org.jpos.space.Space;
import org.jpos.space.SpaceFactory;
import org.jpos.transaction.Context;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.concurrent.atomic.AtomicBoolean;

import static com.equitybank.gag.papss.ots.config.ApplicationConstants.DEFAULT_ERROR;

/**
 * Service responsible for dispatching incoming transaction requests to an appropriate Transaction Manager (TM) queue.
 * It implements a least-busy routing strategy and manages demand-driven scaling by starting new TMs when existing ones are busy,
 * up to a configured maximum limit.
 */
@Service
public class TransactionDispatcherServiceImpl implements TransactionDispatcherService {
    private static final Logger log = LoggerFactory.getLogger(TransactionDispatcherServiceImpl.class);

    private final TransactionManagerScalingService tmScalingService;
    private final Space<String, Object> space;
    private final int queueDepthThreshold;
    private final int maxTms;
    private final long dispatchTimeoutMs;
    private final AtomicBoolean isTmScalingInProgress = new AtomicBoolean(false); // Prevents concurrent scaling

    public TransactionDispatcherServiceImpl(TransactionManagerScalingService tmScalingService,
                                            @Value("${jpos.tm.queue-depth-threshold}") int queueDepthThreshold,
                                            @Value("${jpos.tm.max-tms}") int maxTms,
                                            @Value("${jpos.tm.dispatch-timeout-ms:5000}") long dispatchTimeoutMs) {
        this.tmScalingService = tmScalingService;
        this.queueDepthThreshold = queueDepthThreshold;
        this.maxTms = maxTms;
        this.dispatchTimeoutMs = dispatchTimeoutMs;
        this.space = SpaceFactory.getSpace("tspace:default"); // Get shared jPOS space
    }

    /**
     * Dispatches an incoming credit transfer request to the least busy TM queue.
     * Implements least-busy routing and triggers TM scaling if all queues are busy.
     */
    @Override
    public void dispatch(ChannelCreditTransferDetailsReq req) throws CustomException {
        String rrn = req.getChannelInfo().getRrn();
        List<String> listOfActiveQueues = tmScalingService.getActiveTmQueues();

        // Fail early if no active TM queues are available for dispatch
        if (listOfActiveQueues.isEmpty()) {
            String msg = rrn + ": No active Transaction Managers available.";
            log.error(msg);
            throw new CustomException(DEFAULT_ERROR + msg);
        }

        String leastBusyQueue = null;
        int minQueueDepth = Integer.MAX_VALUE;
        boolean areAllQueuesBusy = true;

        // Check each TM queue for depth and select the least busy
        for (String queue : listOfActiveQueues) {
            int queueDepth = tmScalingService.getQueueDepth(rrn, queue);
            log.info("{}: Queue: '{}', queueDepth: {}", rrn, queue, queueDepth);

            if (queueDepth == -1) {
                log.info("{}: Unable to determine queueDepth for queue '{}'. Treating as busy/unusable for dispatch.", rrn, queue);
                continue;
            }

            if (queueDepth < queueDepthThreshold) {
                areAllQueuesBusy = false;
            }

            if (queueDepth < minQueueDepth) {
                minQueueDepth = queueDepth;
                leastBusyQueue = queue;
            }
        }

        // Attempt scaling if all queues are busy and max TMs not reached
        String newQueue = attemptScaleUpIfNeeded(rrn, areAllQueuesBusy, listOfActiveQueues.size(), minQueueDepth);

        // If scaling occurred, dispatch directly to the newly created queue
        if (newQueue != null) {
            leastBusyQueue = newQueue;
            minQueueDepth = 0; // Since it's just created
            log.info("{}: Dispatching to newly created TM queue '{}', depth: {}", rrn, leastBusyQueue, minQueueDepth);
        }

        // If no usable queue was found, abort and throw an exception.
        if (leastBusyQueue == null) {
            String msg = "No usable queues found (before or after scaling). Cannot dispatch.";
            log.error("{}: {} ", rrn, msg);
            throw new CustomException(DEFAULT_ERROR + msg);
        }

        // Build transaction context
        Context ctx = new Context();
        ctx.put(JposConstants.RRN, rrn);
        ctx.put(JposConstants.TRANSACTION_CONTEXT, req);
        ctx.put(JposConstants.TXN_STATUS, TransactionStatus.PENDING);

        try {
            // Put context into the selected TM queue with a timeout
            space.out(leastBusyQueue, ctx, dispatchTimeoutMs);
            log.info("{}: Successfully dispatched transaction to queue '{}' within {}ms.", rrn, leastBusyQueue, dispatchTimeoutMs);
        } catch (Exception e) {
            String msg = "Failed to dispatch transaction to jPOS queue '" + leastBusyQueue + "' within " + dispatchTimeoutMs + "ms. Error: " + e.getMessage();
            log.error("{}: {}", rrn, msg);
            throw new CustomException(DEFAULT_ERROR + msg);
        }
    }

    /**
     * Checks if scaling up is required based on queue depths and current TM count,
     * and attempts to create a new TM if conditions are met and no other scaling operation is already in progress.
     */
    private String attemptScaleUpIfNeeded(String rrn, boolean allQueuesBusy, int currentTms, int minDepth) {
        if (!allQueuesBusy) {
            log.info("{}: At least one queue not busy (min depth: {}). No scaling needed.", rrn, minDepth);
            return null;
        }

        if (currentTms >= maxTms) {
            log.warn("{}: Max TMs ({}) reached. Cannot scale further.", rrn, maxTms);
            return null;
        }

        // Only allow one thread to scale at a time using AtomicBoolean
        if (isTmScalingInProgress.compareAndSet(false, true)) {
            log.info("{}: All queues busy. Initiating TM scale-up.", rrn);
            try {
                String newQueue = tmScalingService.startNewTm(rrn);
                if (newQueue != null) {
                    log.info("{}: New TM started with queue '{}'", rrn, newQueue);
                    return newQueue;
                } else {
                    log.warn("{}: TM creation failed or limit reached.", rrn);
                }
            } finally {
                isTmScalingInProgress.set(false); // Ensure the scaling lock is always released
            }
        } else {
            log.info("{}: Scaling already in progress by another thread. Skipping current scaling attempt.", rrn);
        }
        return null;
    }
}