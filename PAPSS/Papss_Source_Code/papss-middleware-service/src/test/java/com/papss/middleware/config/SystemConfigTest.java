package com.papss.middleware.config;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class SystemConfigTest {

    @Test
    void gettersAndSetters_work() {
        SystemConfig cfg = new SystemConfig();
        cfg.setEnableInbound(true);
        cfg.setEnableOutbound(false);
        cfg.setPollingExecutorThreadDelay(10L);
        cfg.setPollingExecutorThreadRate(20L);
        cfg.setPollingExecutorsPerParticipant(3);
        cfg.setToClearingSystemId("SYS");
        cfg.setIpsBaseUrl("http://localhost");
        cfg.setIpsPort("8080");

        assertTrue(cfg.getEnableInbound());
        assertFalse(cfg.getEnableOutbound());
        assertEquals(10L, cfg.getPollingExecutorThreadDelay());
        assertEquals(20L, cfg.getPollingExecutorThreadRate());
        assertEquals(3, cfg.getPollingExecutorsPerParticipant());
        assertEquals("SYS", cfg.getToClearingSystemId());
        assertEquals("http://localhost", cfg.getIpsBaseUrl());
        assertEquals("8080", cfg.getIpsPort());
    }
}
