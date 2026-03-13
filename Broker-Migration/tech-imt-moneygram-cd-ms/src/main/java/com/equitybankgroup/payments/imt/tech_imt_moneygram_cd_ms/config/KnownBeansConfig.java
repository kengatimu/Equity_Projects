/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.config;

import com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.cache.CacheRemovalListener;
import com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.cache.CacheService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 *
 * @author ronaldcheruiyot
 */
@Configuration
public class KnownBeansConfig {
    
    @Bean
    public CacheService createCacheService()
    {
       return new CacheService(new CacheRemovalListener());
    }
    
}
