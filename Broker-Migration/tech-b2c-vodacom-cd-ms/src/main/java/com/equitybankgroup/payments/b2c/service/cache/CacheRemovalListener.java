/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.service.cache;

import com.google.common.cache.RemovalCause;
import com.google.common.cache.RemovalListener;
import com.google.common.cache.RemovalNotification;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

/**
 *
 * @author ronaldcheruiyot
 */
@Slf4j
public class CacheRemovalListener implements RemovalListener {

    @Override
    public void onRemoval(RemovalNotification notification) {
        System.out.println("Going to remove data from Transation cache");
        log.info("Data with following key is being removed : " + notification.getKey());
        if (notification.getCause() == RemovalCause.EXPIRED) {
            log.info(notification.getKey() + "|This data expired: ");
        } else {
            log.info(notification.getKey() + "|This data didn't expired but evacuated intentionally: " + notification.getCause());
        }
    }
}
