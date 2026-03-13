package com.papss.middleware.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Data
@Component
@ConfigurationProperties(prefix = "core.banking")
public class CoreBankingProperties {
    private String url;
    private Path path;
}

