package com.equitybank.gag.papss.ots.jpos.space.configs;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;
import java.math.BigDecimal;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Component
@ConfigurationProperties(prefix = "limits.outbound")
public class TransactionLimitsPropConfig implements InitializingBean {

    private static final Logger log = LoggerFactory.getLogger(TransactionLimitsPropConfig.class);

    private BigDecimal maxTransactionLimit;
    private BigDecimal dailyTransactionLimit;
    private BigDecimal velocityLimit;

    // Getters and Setters for all limits
    public BigDecimal getMaxTransactionLimit() {
        return maxTransactionLimit;
    }

    public void setMaxTransactionLimit(BigDecimal maxTransactionLimit) {
        this.maxTransactionLimit = maxTransactionLimit;
    }

    public BigDecimal getDailyTransactionLimit() {
        return dailyTransactionLimit;
    }

    public void setDailyTransactionLimit(BigDecimal dailyTransactionLimit) {
        this.dailyTransactionLimit = dailyTransactionLimit;
    }

    public BigDecimal getVelocityLimit() {
        return velocityLimit;
    }

    public void setVelocityLimit(BigDecimal velocityLimit) {
        this.velocityLimit = velocityLimit;
    }

    @Override
    public void afterPropertiesSet() throws Exception {
        // Provide specific default values if limits are not explicitly configured
        if (this.maxTransactionLimit == null) {
            this.maxTransactionLimit = new BigDecimal("999999"); // Updated default
            log.warn("[TransactionConfig]: 'limits.outbound.max-transaction-limit' not configured. Defaulting to {}. Please configure this property.", this.maxTransactionLimit);
        }
        if (this.dailyTransactionLimit == null) {
            this.dailyTransactionLimit = new BigDecimal("999999"); // Updated default
            log.warn("[TransactionConfig]: 'limits.outbound.daily-transaction-limit' not configured. Defaulting to {}. Please configure this property.", this.dailyTransactionLimit);
        }
        if (this.velocityLimit == null) {
            this.velocityLimit = new BigDecimal("99999999"); // Updated default
            log.warn("[TransactionConfig]: 'limits.outbound.velocity-limit' not configured. Defaulting to {}. Please configure this property.", this.velocityLimit);
        }
    }
}