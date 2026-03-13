/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybank.gag.orange_money_ms.service.business.impl;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;


/**
 *
 * @author ronaldcheruiyot
 */
@Service
@Slf4j
public class OutboundHttpAdapter {
    
    @Autowired
    @Qualifier("defaultRestTemplate")
    RestTemplate restTemplate;
    
    public String httpPost(String url, HttpHeaders headers, String payload)
    {   
        try
        {
            final HttpEntity<?> entity = new HttpEntity<>(payload, headers);
            log.info("REQUEST PAYLOAD: " + payload);
            log.info("SENDING POST REQUEST TO URL: " + url);
            ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, entity, String.class);
            log.info("RESPONSE RECEIVED.");
            log.info("RESPONSE STATUS CODE: " + response.getStatusCode());
            log.info("RESPONSE BODY: " + response.getBody());
            return response.getBody();
            
        } catch(RestClientException e)
        {
            e.printStackTrace(System.out);
        }
        return null;
    }
    
    public ResponseEntity httpPost(String url, HttpEntity entity, Class<?> returnType)
    {   
        try
        {
            System.out.println("HTTP POST URL: " + url);
            System.out.println("Request String: " + entity.getBody());
            log.info("SENDING POST REQUEST TO URL: " + url);
            ResponseEntity responseEntity = restTemplate.exchange(url, HttpMethod.POST, entity, returnType, new Object[0]);

            log.info("RESPONSE RECEIVED.");
            log.info("RESPONSE BODY: " + responseEntity.getBody());
            log.info("RESPONSE STATUS CODE: " + responseEntity.getStatusCode());
            return responseEntity;
            
        } catch(RestClientException e)
        {
            e.printStackTrace(System.out);
        }
        return null;
    }
    
    public String httpGet(String url, HttpHeaders headers)
    {
        try
        {
            final HttpEntity<?> entity = new HttpEntity<>(headers);
            log.info("SENDING GET REQUEST TO URL " + url);
            ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
            log.info("RESPONSE RECEIVED.");
            log.info("RESPONSE STATUS CODE: " + response.getStatusCode());
            log.info("RESPONSE BODY: " + response.getBody());
            return response.getBody();
            
        } catch(RestClientException e)
        {
            e.printStackTrace(System.out);
        }
        return null;
    }
    
    
    
    
}
