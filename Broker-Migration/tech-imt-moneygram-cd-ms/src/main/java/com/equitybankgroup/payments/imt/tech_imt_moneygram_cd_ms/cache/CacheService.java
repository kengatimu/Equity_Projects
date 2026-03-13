/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.cache;

import com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.service.util.DateUtil;
import com.google.common.cache.Cache;
import com.google.common.cache.CacheBuilder;
import java.util.Date;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;

/**
 *
 * @author ronaldcheruiyot
 */
@Slf4j
public class CacheService {

    private final Integer TRANSACTION_CACHE_MAXIMUM_WAIT_TIME = 86400; //2 hours
    
    private final Integer TRANSACTION_CACHE_MAXIMUM_LOAD = 1000;

    Cache<String, CacheObject> cache;
    
    
    public CacheService(CacheRemovalListener removalListener)
    {
        this.cache =
            CacheBuilder
                .newBuilder()
                .maximumSize(TRANSACTION_CACHE_MAXIMUM_LOAD)
                .expireAfterWrite(TRANSACTION_CACHE_MAXIMUM_WAIT_TIME, TimeUnit.SECONDS)
                .removalListener(removalListener)
                .build();
    }
    
    // Schedule this method to run every day at midnight
    @Scheduled(cron = "0 0 0 * * ?")
    public void clearCacheAtMidnight() {
        log.info("Clearing cache at midnight");
        cache.invalidateAll();
        log.info("Cache cleared successfully");
    }
    
    public boolean insert(String key, Object value) {
        log.info("Inserting entry with key: " + key + " into cache");
        try {
            this.cache.put(key, new CacheObject(DateUtil.getCurrentTime(), value));
            log.info("Insert is successful, curent cache size: " + cache.size());
            return true;
        } catch (Exception ex) {
            log.info("Could not insert into cache: " + ex.getMessage());
            log.info("curent cache size: " + cache.size());
            return false;
        }
    }

    public void remove(String key) {
        try {
            this.cache.invalidate(key);
        } catch (Exception e) {
            log.error("Error trying to invalidate cache");
        }
    }

    public void update(String key, Object value) {
        try {
            log.info("Updating entry with key: " + key + ", value: " + value + " into cache");
            Object obj = cache.getIfPresent(key);
            if (obj == null) return;
            this.cache.put(key, new CacheObject(DateUtil.getCurrentTime(), value));
            log.info("Update is successful");
        } catch (Exception ex) {
            log.info("Could not update cache: " + ex.getMessage());
        }
    }

    public Object retrieveObject(String key) throws ExecutionException {
        log.debug("Retrieving entry with key: " + key + " from cache");
        CacheObject map = this.cache.getIfPresent(key);
        if(map == null)
        {
            log.debug("Object not found!");
            return null;
        }
        Date date = map.getUpdateTime();
        boolean isStale = DateUtil.checkifDateExpired(date);
        if(isStale)
        {
            log.debug("Object is expired!");
            this.remove(key);
            return null;
        }
        log.debug("Retrieval is successful");
        return map.getCacheData();
        
    }

    public void countSizeOfCache() {
        log.info("Number of entries in cache================================================>: " + cache.size());
    }
}
