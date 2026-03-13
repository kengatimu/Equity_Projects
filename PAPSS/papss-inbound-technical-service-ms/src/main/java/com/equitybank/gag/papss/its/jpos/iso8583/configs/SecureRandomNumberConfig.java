package com.equitybank.gag.papss.its.jpos.iso8583.configs;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.security.SecureRandom;

@Configuration
public class SecureRandomNumberConfig {
    @Bean (name = "secureRandom")
    public SecureRandom secureRandom() {
        return new SecureRandom(); // Secure generator for cryptographic use
    }
}
