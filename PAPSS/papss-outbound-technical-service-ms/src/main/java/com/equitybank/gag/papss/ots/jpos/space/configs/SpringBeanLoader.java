package com.equitybank.gag.papss.ots.jpos.space.configs;

import org.jpos.q2.QBeanSupport;
import org.springframework.context.ApplicationContext;

/**
 * This Q2 component bridges the Spring ApplicationContext into the Q2 runtime.
 * The context is statically injected from the main Spring Boot class.
 */
public class SpringBeanLoader extends QBeanSupport {
    private static ApplicationContext applicationContext;

    /**
     * Sets the Spring context from the Spring Boot application.
     * This should be called during startup from the main application class.
     */
    public static void setApplicationContext(ApplicationContext context) {
        applicationContext = context;
    }

    /**
     * Allows Q2 participants to access the registered Spring context.
     */
    public static ApplicationContext getApplicationContext() {
        return applicationContext;
    }

    @Override
    public void startService() {
        if (applicationContext != null) {
            getLog().info("SpringBeanLoader: Spring ApplicationContext successfully registered.");
        } else {
            getLog().warn("SpringBeanLoader: Spring ApplicationContext is NULL. Check main class for setApplicationContext().");
        }
    }

    @Override
    public void stopService() {
        getLog().info("SpringBeanLoader: Stopping and clearing ApplicationContext.");
        applicationContext = null;
    }
}
