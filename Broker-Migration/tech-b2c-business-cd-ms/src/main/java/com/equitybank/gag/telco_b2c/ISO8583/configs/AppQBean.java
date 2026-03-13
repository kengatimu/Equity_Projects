package com.equitybank.gag.telco_b2c.ISO8583.configs;

import org.jpos.iso.MUX;
import org.jpos.q2.QBeanSupport;
import org.jpos.util.NameRegistrar;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class AppQBean extends QBeanSupport {
    private static final Logger log = LoggerFactory.getLogger(AppQBean.class);

    public static MUX drcMux; // Now a MUXPool for DRC
    public static MUX suMux; // Now a MUXPool for South Sudan
    public static MUX keMux; // Now a MUXPool for Kenya

    public void init() {
        log.info("ISO8583AppQBean initialization...");
    }

    public void start() {
        log.info("Starting ISO8583AppQBean...");

        // Initialize DRC MUX (which is the MUXPool for DRC)
        initializeMux("drc-mux", "drcMux");

        // Initialize South Sudan MUX (which is the MUXPool for SS)
//        initializeMux("su-mux", "suMux");
//
//        // Initialize Kenya MUX (which is the MUXPool for KE)
        initializeMux("ke-mux", "keMux");
    }

    private void initializeMux(String configPropertyName, String muxFieldName) {
        try {
            log.info("Initializing {}", muxFieldName);

            // The NameRegistrar will correctly return a QMUX or a MUXPool based on the XML name
            String muxLookupName = "mux." + this.cfg.get(configPropertyName);
            MUX currentMux = NameRegistrar.get(muxLookupName);

            // The isConnected() method on a MUXPool checks if at least one underlying MUX is connected.
            // On a QMUX, it checks its single connection.
            if (currentMux != null && currentMux.isConnected()) {
                log.info("FIN " + configPropertyName.toUpperCase().replace("-MUX", "") + " Mux (or MUXPool) FOUND and connected: " + muxLookupName);
            } else {
                log.info("FIN " + configPropertyName.toUpperCase().replace("-MUX", "") + " Mux (or MUXPool) found but not connected: " + muxLookupName);
            }

            // Assign the retrieved MUX/MUXPool to the appropriate field
            switch (muxFieldName) {
                case "drcMux" -> drcMux = currentMux;
                case "suMux" -> suMux = currentMux;
                case "keMux" -> keMux = currentMux;
                default -> log.error("Unknown MUX field name: " + muxFieldName);
            }

        } catch (NameRegistrar.NotFoundException ex) {
            log.error("FIN " + configPropertyName.toUpperCase().replace("-MUX", "") + " MUX (or MUXPool) NOT Found!! " + ex.getMessage());
            ex.printStackTrace(System.out);
        } catch (Exception ex) {
            log.error("Unexpected error during " + configPropertyName.toUpperCase().replace("-MUX", "") + " MUX (or MUXPool) initialization: " + ex.getMessage());
            ex.printStackTrace(System.out);
        }
    }

    public void stop() {
        // Cleanup or close resources if necessary (though Q2 handles component stopping)
        log.info("Stopping ISO8583AppQBean...");
    }
}