///*
// * To change this license header, choose License Headers in Project Properties.
// * To change this template file, choose Tools | Templates
// * and open the template in the editor.
// */
//package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.service.business.http;
//
//import com.netflix.appinfo.InstanceInfo;
//import com.netflix.discovery.EurekaClient;
//import com.netflix.discovery.shared.Application;
//import lombok.RequiredArgsConstructor;
//import lombok.extern.slf4j.Slf4j;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpEntity;
//import org.springframework.http.HttpHeaders;
//import org.springframework.http.HttpMethod;
//import org.springframework.http.ResponseEntity;
//import org.springframework.stereotype.Service;
//import org.springframework.web.client.RestClientException;
//import org.springframework.web.client.RestTemplate;
//
//
///**
// *
// * @author ronaldcheruiyot
// */
//@Slf4j
//@Service
//@RequiredArgsConstructor
//public class OutboundHttpAdapter {
//
//    private final RestTemplate restTemplate;
//
//    private final EurekaClient eurekaClient;
//
//public String httpPostInternal(String microserviceName, String endpoint, HttpHeaders headers, String payload)
//    {
//        try
//        {   
//            Application application = eurekaClient.getApplication(microserviceName);
//            if (application != null) {
//                InstanceInfo instanceInfo = application.getInstances().get(0);
//                String url = "http://" + instanceInfo.getIPAddr() + ":" + instanceInfo.getPort() + endpoint;
//                final HttpEntity<?> entity = new HttpEntity<>(payload, headers);
//                log.info("REQUEST PAYLOAD: {}", payload);
//                log.info("SENDING POST REQUEST TO URL:{}", url);
//                ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, entity, String.class);
//                log.info("RESPONSE RECEIVED.");
//                log.info("RESPONSE STATUS CODE: {}", response.getStatusCode());
//                log.info("RESPONSE BODY: {}", response.getBody());
//                return response.getBody();
//            } else {
//                log.info("Could not get Eureka application instance for " + microserviceName);
//            }
//            
//
//        } catch(RestClientException e)
//        {
//            e.printStackTrace(System.out);
//        }
//        return null;
//    }
//
//public String httpPost(String url, HttpHeaders headers, String payload)
//    {
//        try
//        {
//            final HttpEntity<?> entity = new HttpEntity<>(payload, headers);
//            log.info("REQUEST PAYLOAD: {}", payload);
//            log.info("SENDING POST REQUEST TO URL:{}", url);
//            ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, entity, String.class);
//            log.info("RESPONSE RECEIVED.");
//            log.info("RESPONSE STATUS CODE: {}", response.getStatusCode());
//            log.info("RESPONSE BODY: {}", response.getBody());
//            return response.getBody();
//
//        } catch(RestClientException e)
//        {
//            e.printStackTrace(System.out);
//        }
//        return null;
//    }
//
//    public ResponseEntity<?> httpPost(String url, HttpEntity<?> entity, Class<?> returnType)
//    {
//        try
//        {
//            System.out.println("HTTP POST URL: " + url);
//            System.out.println("Request String: " + entity.getBody());
//            log.info("SENDING POST REQUEST TO URL: {}", url);
//            ResponseEntity<?> responseEntity = restTemplate.exchange(url, HttpMethod.POST, entity, returnType, new Object[0]);
//
//            log.info("RESPONSE RECEIVED.");
//            log.info("RESPONSE STATUS CODE: {}", responseEntity.getStatusCode());
//            return responseEntity;
//        } catch(RestClientException e)
//        {
//            e.printStackTrace(System.out);
//        }
//        return null;
//    }
//
//    public String httpGet(String url, HttpHeaders headers)
//    {
//        try
//        {
//            final HttpEntity<?> entity = new HttpEntity<>(headers);
//            log.info("SENDING GET REQUEST TO URL: {}", url);
//            ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
//            log.info("RESPONSE RECEIVED.");
//            log.info("RESPONSE STATUS CODE: {}", response.getStatusCode());
//            log.info("RESPONSE BODY: {}", response.getBody());
//            return response.getBody();
//
//        } catch(RestClientException e)
//        {
//            e.printStackTrace(System.out);
//        }
//        return null;
//    }
//}
