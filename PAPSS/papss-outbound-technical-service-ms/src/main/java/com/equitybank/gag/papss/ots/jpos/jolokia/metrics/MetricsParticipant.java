package com.equitybank.gag.papss.ots.jpos.jolokia.metrics;

import com.equitybank.gag.papss.ots.jpos.jolokia.GlobalTxnSpace;
import org.jpos.core.Configurable;
import org.jpos.core.Configuration;
import org.jpos.core.ConfigurationException;
import org.jpos.transaction.Context;
import org.jpos.transaction.TransactionParticipant;
import org.jpos.util.NameRegistrar;
import java.io.Serializable;

public class MetricsParticipant implements TransactionParticipant, Configurable {

    private GlobalTxnSpace metricsMBean;
    private static final String START_TIME_KEY = "metrics.participant.start.time";

    @Override
    public void setConfiguration(Configuration cfg) throws ConfigurationException {
        // This is called once on startup. We find and cache our MBean instance.
        try {
            metricsMBean = NameRegistrar.get("jpos.metrics.mbean");
        } catch (NameRegistrar.NotFoundException e) {
            throw new ConfigurationException("GlobalTxnSpace MBean not found in NameRegistrar with key 'jpos.metrics.mbean'", e);
        }
    }

    @Override
    public int prepare(long id, Serializable context) {
        if (metricsMBean != null) {
            // Transaction is starting
            metricsMBean.recordTxnStarted();

            // Store the start time in the context to calculate duration later
            ((Context) context).put(START_TIME_KEY, System.currentTimeMillis());
        }
        return PREPARED;
    }

    @Override
    public void commit(long id, Serializable context) {
        if (metricsMBean != null) {
            // Transaction finished successfully
            long startTime = (Long) ((Context) context).get(START_TIME_KEY);
            long duration = System.currentTimeMillis() - startTime;
            metricsMBean.recordTxnCompleted(duration);
        }
    }

    @Override
    public void abort(long id, Serializable context) {
        if (metricsMBean != null) {
            // Transaction was aborted
            Long startTime = (Long) ((Context) context).get(START_TIME_KEY);
            if (startTime != null) {
                long duration = System.currentTimeMillis() - startTime;
                metricsMBean.recordTxnAborted(duration);
            } else {
                // Aborted before prepare(), e.g., in a pre-participant
                metricsMBean.recordTxnAborted(0);
            }
        }
    }
}
