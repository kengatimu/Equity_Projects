package com.equitybank.gag.orange_money_ms.service.impl;

import com.equitybank.gag.orange_money_ms.service.TokenGenerateService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class TokenGenerateServiceImpl implements TokenGenerateService {
    
    @Value("${equity-orange.endpoint.noexpiretoken}")
    private String noexpiretoken;
    
    @Override
    public String generateToken() {
        return this.noexpiretoken;
    }
}
