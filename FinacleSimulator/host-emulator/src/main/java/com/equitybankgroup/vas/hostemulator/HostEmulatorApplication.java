package com.equitybankgroup.vas.hostemulator;

import org.jpos.q2.Q2;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.core.env.Environment;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class HostEmulatorApplication {
        
    
    public static ApplicationContext applicationContext;
    private static Q2 q2;
    private final Environment env;
    
    public HostEmulatorApplication(Environment env) {
            this.env = env;
        }

    public static void main(String[] args) {
        applicationContext = (ApplicationContext)SpringApplication.run(HostEmulatorApplication.class, args);
        q2 = new Q2();
        q2.start();
    }

}
