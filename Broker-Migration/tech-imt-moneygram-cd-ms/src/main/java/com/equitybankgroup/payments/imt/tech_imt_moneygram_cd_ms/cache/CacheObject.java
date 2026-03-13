/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.cache;

import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Data;

/**
 *
 * @author ronaldcheruiyot
 */
@Data
@AllArgsConstructor
public class CacheObject {
    
    private Date updateTime;
    
    private Object cacheData;
    
}
