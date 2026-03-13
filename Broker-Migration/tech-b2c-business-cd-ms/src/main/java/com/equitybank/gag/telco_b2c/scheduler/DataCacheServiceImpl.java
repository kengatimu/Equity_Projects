package com.equitybank.gag.telco_b2c.scheduler;

import com.equitybank.gag.telco_b2c.entity.ParamConfigs;
import com.equitybank.gag.telco_b2c.service.DatabaseService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import static com.equitybank.gag.telco_b2c.config.ApplicationConstants.DEFAULT_RATE_CONFIG_ID;

@Service
public class DataCacheServiceImpl implements DataCacheService {
    private static final Logger log = LoggerFactory.getLogger(DataCacheService.class);
    private final Map<String, String> dataCacheMap = new HashMap<>();

    private final DatabaseService databaseService;

    public DataCacheServiceImpl(DatabaseService databaseService) {
        this.databaseService = databaseService;
    }

    @Override
    @Scheduled(fixedDelay = 3600000, zone = "Africa/Nairobi") // Runs every hour
    public void updateHashMap() {
        try {
            Optional<ParamConfigs> optionalParamConfigs = databaseService.getConfigRecord();
            if (optionalParamConfigs.isPresent()) {
                ParamConfigs paramConfigs = optionalParamConfigs.get();
                dataCacheMap.put(DEFAULT_RATE_CONFIG_ID, paramConfigs.getConfigValue());
            } else {
                log.warn("No configuration record found for caching.");
            }
        } catch (Exception e) {
            log.error("Exception Occurred In DataCacheService: {}", e.getMessage());
        }
    }

    @Override
    public Map<String, String> getCachedData() {
        return dataCacheMap;
    }
}
