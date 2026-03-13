/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.service.business.http;

import com.equitybankgroup.payments.b2c.dto.airtel.TokenResp;
import java.util.logging.Level;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.retry.support.RetryTemplate;
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
    RetryTemplate retryTemplate;
    
    @Autowired
    @Qualifier("defaultRestTemplate")
    RestTemplate defaultRestTemplate;
    
    @Autowired
    @Qualifier("customRestTemplate")
    RestTemplate customRestTemplate;
    
    public String httpPost(String url, HttpHeaders headers, String payload)
    {   
        try
        {
            final HttpEntity<?> entity = new HttpEntity<>(payload, headers);
            log.info("REQUEST PAYLOAD: " + payload);
            log.info("SENDING POST REQUEST TO URL: " + url);
            ResponseEntity<String> response = defaultRestTemplate.exchange(url, HttpMethod.POST, entity, String.class);
            log.info("RESPONSE RECEIVED.");
            log.info("RESPONSE STATUS CODE: " + response.getStatusCode());
            log.info("RESPONSE BODY: " + response.getBody());
            return response.getBody();
            
        } catch(RestClientException e)
        {
            e.printStackTrace(System.out);
            return extractJson(e.getMessage());
        }
    }
    
    public ResponseEntity httpPost(String url, HttpEntity entity, Class<?> returnType)
    {   
        try
        {
            System.out.println("HTTP POST URL: " + url);
            System.out.println("Request String: " + entity.getBody());
            log.info("SENDING POST REQUEST TO URL: " + url);
            ResponseEntity responseEntity = defaultRestTemplate.exchange(url, HttpMethod.POST, entity, returnType, new Object[0]);

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
            ResponseEntity<String> response = defaultRestTemplate.exchange(url, HttpMethod.GET, entity, String.class);
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
    
    public String customHttpPost(String url, HttpHeaders headers, String payload)
    {   
        try
        {
            final HttpEntity<?> entity = new HttpEntity<>(payload, headers);
            log.info("REQUEST PAYLOAD: " + payload);
            log.info("SENDING POST REQUEST TO URL: " + url);
            ResponseEntity<String> response = customRestTemplate.exchange(url, HttpMethod.POST, entity, String.class);
            log.info("RESPONSE RECEIVED.");
            log.info("RESPONSE STATUS CODE: " + response.getStatusCode());
            log.info("RESPONSE BODY: " + response.getBody());
            return response.getBody();
            
        } catch(RestClientException e)
        {
            e.printStackTrace(System.out);
            return extractJson(e.getMessage());
        }
    }
    
    public ResponseEntity customHttpPost(String url, HttpEntity entity, Class<?> returnType)
    {   
        try
        {
            System.out.println("HTTP POST URL: " + url);
            System.out.println("Request String: " + entity.getBody());
            log.info("SENDING POST REQUEST TO URL: " + url);
            ResponseEntity responseEntity = customRestTemplate.exchange(url, HttpMethod.POST, entity, returnType, new Object[0]);

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
    
    public String customHttpGet(String url, HttpHeaders headers)
    {
        try
        {
            final HttpEntity<?> entity = new HttpEntity<>(headers);
            log.info("SENDING GET REQUEST TO URL " + url);
            ResponseEntity<String> response = customRestTemplate.exchange(url, HttpMethod.GET, entity, String.class);
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
    
    private static String extractJson(String input)
    {
        Pattern pattern = Pattern.compile("\\{.*\\}");
        Matcher matcher = pattern.matcher(input);
        
        if (matcher.find()) {
            String jsonPart = matcher.group();
            return jsonPart;
        }
        return null;
    }
    
    public static void main(String[] args) {
        System.out.println(extractJson(" 400 : \"{\"status\":{\"response_code\":\"DP02050001000\",\"code\":\"400\",\"success\":false,\"message\":\"Missing/Invalid total\"}}\""));
    }
    
    
}
