package com.equitybank.payments.imt.b2c.drcbroker.config;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.modelmapper.ModelMapper;
import org.modelmapper.convention.MatchingStrategies;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class KnownBeansConfig {

    @Bean
    public Gson gson() {
        return new GsonBuilder()
                .serializeNulls()
                .excludeFieldsWithoutExposeAnnotation()
                .setPrettyPrinting()
                .create();
    }

    @Bean
    public ModelMapper modelMapper() {
        ModelMapper myModelMapper = new ModelMapper();
        myModelMapper.getConfiguration().setMatchingStrategy(MatchingStrategies.STRICT);
        return myModelMapper;
    }
}
