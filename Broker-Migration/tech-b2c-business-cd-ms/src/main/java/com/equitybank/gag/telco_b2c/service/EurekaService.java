package com.equitybank.gag.telco_b2c.service;

import com.equitybank.gag.telco_b2c.exception.CustomException;

public interface EurekaService {
    int getInstancePort(String telco) throws CustomException;

    String getInstanceName(String telco) throws CustomException;

    String getInstanceStatus(String telco) throws CustomException;

    String getInstanceIpAddress(String telco) throws CustomException;
}
