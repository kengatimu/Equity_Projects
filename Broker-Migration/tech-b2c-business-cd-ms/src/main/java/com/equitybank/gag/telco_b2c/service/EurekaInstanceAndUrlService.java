package com.equitybank.gag.telco_b2c.service;

import com.equitybank.gag.telco_b2c.exception.CustomException;

public interface EurekaInstanceAndUrlService {
    void checkInstanceStatus(String telco, String rrn) throws CustomException;

    String getUrl(String telco, String type) throws CustomException;
}
