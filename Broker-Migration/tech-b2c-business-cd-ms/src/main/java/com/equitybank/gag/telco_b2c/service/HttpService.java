package com.equitybank.gag.telco_b2c.service;

import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.exception.CustomExceptionForReversal;

import java.util.Map;

public interface HttpService {
    String httpCall(String requestBody, String telco, String rrn, String type, String bankId, String channelId) throws CustomException, CustomExceptionForReversal;

    void callbackHttpCall(String callbackUrl, String requestXml, String rrn, String type);

    void telcoCallbackHttpCall(Map<String, String> xmlTagsMap, String callbackUrl, String responseXmlString, String rrn, String type);

    String finacleHttpCall (String finacleRequestXml, String finacleFIEndpoint) throws CustomException;
}
