package com.equitybankgroup.vas.hostemulator.emulator.fin;

import java.io.Serializable;
import java.util.Date;
import org.jpos.core.Configurable;
import org.jpos.core.Configuration;
import org.jpos.core.ConfigurationException;
import org.jpos.iso.ISOException;
import org.jpos.iso.MUX;
import org.jpos.q2.QBeanSupport;
import org.jpos.util.NameRegistrar;
import org.slf4j.LoggerFactory;

public class AppQBean extends QBeanSupport implements Configurable, Serializable {

    public static MUX kemux;
    public static MUX ugmux;
    public static MUX rwmux;
    public static MUX tzmux;
    public static MUX sumux;
    public static MUX drmux;
    public static MUX ppnmux;
    public static boolean keMuxBusy = false;
    public static boolean drMuxBusy = false;
    public static boolean ppnMuxBusy = false;
    public static Date drLastPosted = null;
    public static Date keLastPosted = null;

    private Configuration configuration;

    private final org.slf4j.Logger log = LoggerFactory.getLogger(AppQBean.class);

    @Override
    public void setConfiguration(Configuration config) throws ConfigurationException {
        this.configuration = config;
    }

    @Override
    protected void initService() throws ISOException {
        System.out.println("AppQBean Init service: ");
    }

    @Override
    public void startService() {
        System.out.println("AppQBean Starting...");
        
        try {
            String drMX = "mux." + this.getConfiguration().get("finmux");
            kemux = (MUX) NameRegistrar.get(drMX);
            log.info("KE Fin Mux  FOUND: " + drMX + " is connected: "+ kemux.isConnected());
        } catch (NameRegistrar.NotFoundException ex) {
            log.error("KE FIN MUX NOT Found!!" + ex.getMessage());
        }
        

        try {
            NameRegistrar.register("appQBean", this);
            log.info("appQBean registered");
        } catch (Exception e) {
            log.error("appQBean failed to register" + e.getMessage());
        }
    }

    @Override
    public void stopService() {
        System.out.println("AppQBean Stopping AppQBean");
    }

    @Override
    public Configuration getConfiguration() {
        return this.configuration;
    }
}
