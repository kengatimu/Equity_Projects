package com.equitybank.gag.papss.ots.jpos.iso8583.configs;

import com.equitybank.gag.papss.ots.jpos.iso8583.packager.FinaclePackager;
import org.jpos.iso.ISOPackager;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class FinaclePackagerConfig {

    @Bean
    @Qualifier("finaclePackager")
    public ISOPackager finaclePackager() {
        return new FinaclePackager();
    }
}
