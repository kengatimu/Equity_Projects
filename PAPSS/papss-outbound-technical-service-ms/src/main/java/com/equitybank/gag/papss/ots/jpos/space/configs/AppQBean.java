package com.equitybank.gag.papss.ots.jpos.space.configs;

import com.equitybank.gag.papss.ots.jpos.jolokia.GlobalTxnSpace;
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

import static com.equitybank.gag.papss.ots.jpos.space.configs.JposConstants.SHARED_SPACE_NAME;

public class AppQBean extends QBeanSupport {
    private static final Logger log = LoggerFactory.getLogger(AppQBean.class);

    // Shared MUX instances for Finacle connections
    public static MUX drcMux;
    public static MUX suMux;
    public static MUX keMux;

    // Global transaction space shared across TMs
    public static Space<String, Object> GLOBAL_TXN_SPACE;

    private ObjectName globalTxnMBean;

    @Override
    public void init() {
        // Called during Q2 initialization phase for ALL QBeans
        log.info("[AppQBean] Initializing shared components...");

        // ===================================================================
        // === MOVED: This logic now runs during the init() phase           ===
        // === This ensures the space and MBean are available for other    ===
        // === QBeans (like TransactionManager) during their init() phase. ===
        // ===================================================================
        registerGlobalTxnSpace();
        registerGlobalTxnSpaceMBean();
    }

    @Override
    public void start() {
        // Called when QBean starts in Q2, after ALL QBeans have been initialized
        log.info("[AppQBean] Starting live components...");

        // Initialize MUXes now that the system is ready to go live
//        initializeMux("drc-mux", "drcMux"); // load DRC mux
//        initializeMux("su-mux", "suMux");   // load SU mux
        initializeMux("ke-mux", "keMux");   // load KE mux

    }

    // Register the shared GLOBAL_TXN_SPACE into NameRegistrar
    private void registerGlobalTxnSpace() {
        try {
            // Create or get default jPOS transient space
            GLOBAL_TXN_SPACE = SpaceFactory.getSpace("tspace:default");

            // Register space globally so all TMs can access it
            NameRegistrar.register(SHARED_SPACE_NAME, GLOBAL_TXN_SPACE);

            log.info("[AppQBean] {} registered in NameRegistrar", SHARED_SPACE_NAME);
        } catch (Exception e) {
            log.error("[AppQBean] Failed to register {}: {}", SHARED_SPACE_NAME, e.getMessage(), e);
        }
    }

    // Initialize MUX instance by config property and assign it to static field
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
            // Wrap the shared TSpace into an MBean service for queue/session visibility
            GlobalTxnSpace globalTxnSpace = new GlobalTxnSpace((TSpace<String, Object>) GLOBAL_TXN_SPACE);

            // Obtain the platform MBean server reference
            MBeanServer mBeanServer = ManagementFactory.getPlatformMBeanServer();

            // Use a generic, reusable JMX domain name instead of package-derived
            String jmxDomain = "jpos.txn.monitor";

            // Construct ObjectName for the GlobalTxnSpace MBean
            globalTxnMBean = new ObjectName(jmxDomain + ":type=GlobalTxnSpace");

            // Register the MBean with the platform MBeanServer
            mBeanServer.registerMBean(globalTxnSpace, globalTxnMBean);

            // Register the MBean instance so the MetricsParticipant can find it.
            NameRegistrar.register("jpos.metrics.mbean", globalTxnSpace);

            // Log success with the registered ObjectName
            log.info("[AppQBean] Registered GlobalTxnSpace MBean at {}", globalTxnMBean);
            log.info("[AppQBean] Registered GlobalTxnSpace instance in NameRegistrar for metrics collection.");

        } catch (Exception e) {
            // Log failure with exception details
            log.error("[AppQBean] Failed to register GlobalTxnSpace MBean: {}", e.getMessage(), e);
        }
    }


    @Override
    public void stop() {
        // Called when QBean stops in Q2
        log.info("[AppQBean] Stopping ISO8583AppQBean...");
        unregisterGlobalTxnSpaceMBean(); // cleanup MBean
    }

    // Unregister GlobalTxnSpace MBean on shutdown
    private void unregisterGlobalTxnSpaceMBean() {
        try {
            if (globalTxnMBean != null) {
                ManagementFactory.getPlatformMBeanServer().unregisterMBean(globalTxnMBean);
                log.info("[AppQBean] Unregistered GlobalTxnSpace MBean");
            }
            // Also unregister from NameRegistrar
            NameRegistrar.unregister("jpos.metrics.mbean");
            log.info("[AppQBean] Unregistered GlobalTxnSpace instance from NameRegistrar.");
        } catch (Exception e) {
            log.error("[AppQBean] Failed to unregister GlobalTxnSpace MBean: {}", e.getMessage(), e);
        }
    }
}
