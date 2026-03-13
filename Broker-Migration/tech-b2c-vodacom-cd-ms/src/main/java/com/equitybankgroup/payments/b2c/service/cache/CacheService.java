/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.service.cache;

import com.equitybankgroup.payments.b2c.model.StatusDetails;
import com.google.common.cache.Cache;
import com.google.common.cache.CacheBuilder;
import java.time.Duration;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;
import jakarta.annotation.PostConstruct;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

/**
 *
 * @author ronaldcheruiyot
 */
@Slf4j
@RequiredArgsConstructor
public class CacheService {

    private final Integer TRANSACTION_CACHE_MAXIMUM_WAIT_TIME = 7200; //2 hours
    
    private final Integer TRANSACTION_CACHE_MAXIMUM_LOAD = 1000;

    private final CacheRemovalListener removalListener;

    Cache<String, Map<String, String>> cache;
    
    private final Map<String, CountDownLatch> latchMap = new ConcurrentHashMap<>();

    @PostConstruct
    public void init() {
        cache =
            CacheBuilder
                .newBuilder()
                .maximumSize(TRANSACTION_CACHE_MAXIMUM_LOAD)
                .expireAfterWrite(TRANSACTION_CACHE_MAXIMUM_WAIT_TIME, TimeUnit.SECONDS)
                .removalListener(removalListener)
                .build();
    }
    
    public void updateCacheFromApiCall(String key, Map<String, String> newValue) {
        cache.put(key, newValue);
        CountDownLatch latch = latchMap.get(key);
        if (latch != null) {
            latch.countDown(); // Signal that the cache is updated
        }
    }
    
    public void insretFromMainThread(String key, Map<String, String> value) {
        CountDownLatch latch = new CountDownLatch(1);
        latchMap.put(key, latch);
        cache.put(key, value);
    }
    
    public boolean waitForUpdate(String key, long timeout, TimeUnit unit) throws InterruptedException {
        CountDownLatch latch = latchMap.get(key);
        if (latch != null) {
            return latch.await(timeout, unit); // Wait until the cache is updated or timeout occurs
        }
        return false;
    }
    
    public boolean insert(String key, Map<String, String> value) {
        log.info("Inserting entry with key: " + key + " into cache");
        try {
            this.cache.put(key, value);
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

    public void update(String key, Map<String, String> value) {
        try {
            log.info("Updating entry with key: " + key + ", value: " + value + " into cache");
            Map<String, String> obj = cache.getIfPresent(key);
            if (obj == null) return;
            this.cache.put(key, obj);
            log.info("Update is successful");
        } catch (Exception ex) {
            log.info("Could not update cache: " + ex.getMessage());
        }
    }

    public Map<String, String> retrieveObject(String key) throws ExecutionException {
        log.debug("Retrieving entry with key: " + key + " from cache");
        Map<String, String> map = this.cache.getIfPresent(key);
        log.debug("Retrieval is successful");
        return map;
    }

    public void countSizeOfCache() {
        log.info("Number of entries in cache================================================>: " + cache.size());
    }
}
