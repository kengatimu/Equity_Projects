package com.papss.middleware.config;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Setter
@Getter
@Configuration
@ConfigurationProperties(prefix = "papss.system")
public class SystemConfig {
    private Boolean enableInbound;
    private Boolean enableOutbound;
    private Long pollingExecutorThreadDelay;
    private Long pollingExecutorThreadRate;
    private Integer pollingExecutorsPerParticipant;
    private String toClearingSystemId;
    private String ipsBaseUrl;
    private String ipsPort;

}
