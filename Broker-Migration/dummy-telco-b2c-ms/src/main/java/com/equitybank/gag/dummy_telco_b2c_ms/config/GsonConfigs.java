package com.equitybank.gag.dummy_telco_b2c_ms.config;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class GsonConfigs {

    @Bean
    public Gson gso(){
        return new GsonBuilder()
                .setPrettyPrinting()
                .create();
    }
}
