package com.equitybank.gag.papss.its.jpos.space.configs;

import com.equitybank.gag.papss.its.jpos.jolokia.GlobalTxnSpace;
import org.jpos.iso.MUX;
import org.jpos.q2.QBeanSupport;
import org.jpos.space.Space;
import org.jpos.space.SpaceFactory;
import org.jpos.space.TSpace;
import org.jpos.util.NameRegistrar;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.management.MBeanServer;
import javax.management.ObjectName;
import java.lang.management.ManagementFactory;

import static com.equitybank.gag.papss.its.jpos.space.configs.JposConstants.SHARED_SPACE_NAME_INBOUND;

public class AppQBean extends QBeanSupport {
    private static final Logger log = LoggerFactory.getLogger(AppQBean.class);

    // Shared MUX instances for Finacle connections
    public static MUX drcMux;
    public static MUX suMux;
    public static MUX keMux;

    // Global transaction space shared across TMs (inbound-specific)
    public static Space<String, Object> GLOBAL_TXN_SPACE;

    private ObjectName globalTxnMBean;

    @Override
    public void init() {
        // Called during Q2 initialization phase for ALL QBeans
        log.info("[AppQBean] Initializing shared components for inbound service...");

        // Ensure space and MBean are ready before TransactionManagers start
        registerGlobalTxnSpace();
        registerGlobalTxnSpaceMBean();
    }

    @Override
    public void start() {
        // Called when QBean starts in Q2, after ALL QBeans have been initialized
        log.info("[AppQBean] Starting live components for inbound service...");

        // Initialize only relevant MUXes for inbound ISO channels
        initializeMux("ke-mux", "keMux");
//        initializeMux("drc-mux", "drcMux");
//        initializeMux("su-mux", "suMux");
    }

    // Register the shared GLOBAL_TXN_SPACE_INBOUND into NameRegistrar
    private void registerGlobalTxnSpace() {
        try {
            // Create or get a unique inbound space to avoid colliding with outbound service
            GLOBAL_TXN_SPACE = SpaceFactory.getSpace("tspace:inbound");

            // Register space globally so all inbound TMs can access it
            NameRegistrar.register(SHARED_SPACE_NAME_INBOUND, GLOBAL_TXN_SPACE);

            log.info("[AppQBean] {} registered in NameRegistrar", SHARED_SPACE_NAME_INBOUND);
        } catch (Exception e) {
            log.error("[AppQBean] Failed to register {}: {}", SHARED_SPACE_NAME_INBOUND, e.getMessage(), e);
        }
    }

    // Initialize MUX instance by config property and assign to static field
    private void initializeMux(String configPropertyName, String muxFieldName) {
        try {
            log.info("[AppQBean] Initializing {}", muxFieldName);

            // Lookup MUX name from Q2 config
            String muxLookupName = "mux." + this.cfg.get(configPropertyName);

            // Lookup mux instance
            MUX currentMux = NameRegistrar.get(muxLookupName);

            if (currentMux != null && currentMux.isConnected()) {
                log.info("[AppQBean] {} MUX (or pool) is CONNECTED: {}", configPropertyName.toUpperCase(), muxLookupName);
            } else {
                log.warn("[AppQBean] {} MUX (or pool) found but NOT CONNECTED: {}", configPropertyName.toUpperCase(), muxLookupName);
            }

            // Assign to correct static field
            switch (muxFieldName) {
                case "drcMux" -> drcMux = currentMux;
                case "suMux" -> suMux = currentMux;
                case "keMux" -> keMux = currentMux;
                default -> log.error("[AppQBean] Unknown MUX field name: {}", muxFieldName);
            }

        } catch (NameRegistrar.NotFoundException ex) {
            log.error("[AppQBean] {} MUX not found in NameRegistrar: {}", configPropertyName.toUpperCase(), ex.getMessage(), ex);
        } catch (Exception ex) {
            log.error("[AppQBean] Unexpected error initializing {} MUX: {}", configPropertyName.toUpperCase(), ex.getMessage(), ex);
        }
    }

    // Register GlobalTxnSpace as a JMX MBean for external monitoring
    private void registerGlobalTxnSpaceMBean() {
        try {
            GlobalTxnSpace globalTxnSpace = new GlobalTxnSpace((TSpace<String, Object>) GLOBAL_TXN_SPACE);
            MBeanServer mBeanServer = ManagementFactory.getPlatformMBeanServer();

            // Use a distinct JMX domain for inbound visibility
            String jmxDomain = "jpos.txn.monitor.inbound";

            globalTxnMBean = new ObjectName(jmxDomain + ":type=GlobalTxnSpace");
            mBeanServer.registerMBean(globalTxnSpace, globalTxnMBean);

            NameRegistrar.register("jpos.metrics.mbean.inbound", globalTxnSpace);

            log.info("[AppQBean] Registered GlobalTxnSpace MBean under domain '{}'", jmxDomain);
        } catch (Exception e) {
            log.error("[AppQBean] Failed to register GlobalTxnSpace MBean: {}", e.getMessage(), e);
        }
    }

    @Override
    public void stop() {
        // Called when QBean stops in Q2
        log.info("[AppQBean] Stopping inbound AppQBean...");
        unregisterGlobalTxnSpaceMBean();
    }

    // Unregister GlobalTxnSpace MBean on shutdown
    private void unregisterGlobalTxnSpaceMBean() {
        try {
            if (globalTxnMBean != null) {
                ManagementFactory.getPlatformMBeanServer().unregisterMBean(globalTxnMBean);
                log.info("[AppQBean] Unregistered GlobalTxnSpace MBean (inbound)");
            }

            // Also unregister from NameRegistrar
            NameRegistrar.unregister("jpos.metrics.mbean.inbound");
            log.info("[AppQBean] Unregistered inbound GlobalTxnSpace instance from NameRegistrar.");
        } catch (Exception e) {
            log.error("[AppQBean] Failed to unregister GlobalTxnSpace MBean: {}", e.getMessage(), e);
        }
    }
}
