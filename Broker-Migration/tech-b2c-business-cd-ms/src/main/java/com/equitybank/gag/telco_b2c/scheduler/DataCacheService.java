package com.equitybank.gag.telco_b2c.scheduler;

import java.util.Map;

public interface DataCacheService {
    void updateHashMap();

    Map<String, String> getCachedData();
}