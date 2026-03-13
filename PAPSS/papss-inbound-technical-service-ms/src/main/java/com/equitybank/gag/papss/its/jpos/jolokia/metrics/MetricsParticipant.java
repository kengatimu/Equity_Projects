package com.equitybank.gag.papss.its.jpos.jolokia.metrics;

import com.equitybank.gag.papss.its.jpos.jolokia.GlobalTxnSpace;
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
        // Try to look up the inbound-specific metrics MBean first
        try {
            String mbeanKey = cfg.get("metrics-mbean-key", "jpos.metrics.mbean.inbound");
            metricsMBean = NameRegistrar.get(mbeanKey);
        } catch (NameRegistrar.NotFoundException e) {
            throw new ConfigurationException(
                    "GlobalTxnSpace MBean not found in NameRegistrar. Expected key: 'jpos.metrics.mbean.inbound'", e
            );
        }
    }

    @Override
    public int prepare(long id, Serializable context) {
        if (metricsMBean != null) {
            metricsMBean.recordTxnStarted();
            ((Context) context).put(START_TIME_KEY, System.currentTimeMillis());
        }
        return PREPARED;
    }

    @Override
    public void commit(long id, Serializable context) {
        if (metricsMBean != null) {
            long startTime = (Long) ((Context) context).get(START_TIME_KEY);
            long duration = System.currentTimeMillis() - startTime;
            metricsMBean.recordTxnCompleted(duration);
        }
    }

    @Override
    public void abort(long id, Serializable context) {
        if (metricsMBean != null) {
            Long startTime = (Long) ((Context) context).get(START_TIME_KEY);
            long duration = startTime != null ? System.currentTimeMillis() - startTime : 0;
            metricsMBean.recordTxnAborted(duration);
        }
    }
}
