package com.equitybank.gag.telco_b2c.service.impl;

import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.service.EurekaService;
import com.netflix.appinfo.InstanceInfo;
import com.netflix.discovery.EurekaClient;
import com.netflix.discovery.shared.Application;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import static com.equitybank.gag.telco_b2c.config.ApplicationConstants.*;
import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.*;

@Service
public class EurekaServiceImpl implements EurekaService {
    private static final Logger log = LoggerFactory.getLogger(EurekaServiceImpl.class);

    private final EurekaClient eurekaClient;

    @Autowired
    public EurekaServiceImpl(EurekaClient eurekaClient) {
        this.eurekaClient = eurekaClient;
    }

    @Override
    public int getInstancePort(String telco) throws CustomException {
        InstanceInfo instanceInfo = getInstanceInfo(telco);
        return instanceInfo.getPort();
    }

    @Override
    public String getInstanceName(String telco) throws CustomException {
        InstanceInfo instanceInfo = getInstanceInfo(telco);
        return instanceInfo.getAppName();
    }

    @Override
    public String getInstanceStatus(String telco) throws CustomException {
        InstanceInfo instanceInfo = getInstanceInfo(telco);
        return instanceInfo.getStatus().name();
    }

    @Override
    public String getInstanceIpAddress(String telco) throws CustomException {
        InstanceInfo instanceInfo = getInstanceInfo(telco);
        return instanceInfo.getIPAddr();
    }

    private InstanceInfo getInstanceInfo(String telco) throws CustomException {
        String errorMsg = "Application not found or no instances available for telco: ";
        Application application = eurekaClient.getApplication(getServiceName(telco.toUpperCase()));
        if (application == null || application.getInstances().isEmpty()) {
            throw new CustomException(EUREKA_FAILURE + errorMsg + telco);
        }
        return application.getInstances().get(0);
    }

    private String getServiceName(String telco) throws CustomException {
        log.info("Telco: " + telco);
        if (telco.contains("ORANGE")) {
            return ORANGE_MONEY_APPLICATION_NAME;
        } else if (telco.contains("AIRTEL")) {
            return AIRTEL_MONEY_APPLICATION_NAME;
        } else if (telco.contains("VODACOM")) {
            return VODACOM_MONEY_APPLICATION_NAME;
        } else if (telco.contains("MPESA-KE")) {
            return SAFARICOM_MPESA_APPLICATION_NAME;
        } else if (telco.contains("AFRICELL")) {
            return AFRICELL_MONEY_APPLICATION_NAME;
        } else if (telco.contains("MTN")) {
            return MTN_MONEY_APPLICATION_NAME;
        } else if (telco.contains(MONEY_GRAM)) {
            return MONEY_GRAM_APPLICATION_NAME;
        } else if (telco.contains(THUNES)) {
            return THUNES_APPLICATION_NAME;
        } else if (telco.contains(WENDI)) {
            return WENDI_APPLICATION_NAME;
        }
        throw new CustomException(EUREKA_FAILURE + telco + " does not exist");
    }
}
