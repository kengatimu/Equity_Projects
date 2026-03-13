package com.equitybank.gag.papss.its.jpos.jolokia;

import org.jolokia.server.core.http.AgentServlet;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class JolokiaConfig {

    @Bean
    public ServletRegistrationBean<AgentServlet> jolokiaServlet() {
        ServletRegistrationBean<AgentServlet> registration =
                new ServletRegistrationBean<>(new AgentServlet(), "/actuator/jolokia/*");
        registration.setName("jolokia");
        return registration;
    }
}

