package com.equitybankgroup.payments.b2c.service.impl;

import com.equitybankgroup.payments.b2c.service.CallbackService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class CallbackServiceImpl implements CallbackService {
    private static final Logger log = LoggerFactory.getLogger(CallbackServiceImpl.class);

    private final String businessServiceUrl;
    private final RestTemplate restTemplate;

    @Autowired
    public CallbackServiceImpl(@Value("${vodacom.cd.business.service.callbackURL}") String businessServiceUrl,
                               RestTemplate restTemplate) {
        this.businessServiceUrl = businessServiceUrl;
        this.restTemplate = restTemplate;
    }

    @Override
    public void sendCallbackToBusinessService(String telcoResponseString) {

        // Set headers
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_XML);

        // Create the HttpEntity with the XML and headers
        HttpEntity<String> requestEntity = new HttpEntity<>(telcoResponseString, headers);

        // Make the POST request
//        ResponseEntity<String> response = restTemplate.exchange(businessServiceUrl, HttpMethod.POST, requestEntity, String.class);
        restTemplate.exchange(businessServiceUrl, HttpMethod.POST, requestEntity, String.class);

        // Print the business service response
//        log.info("Callback HTTP Status Code: " + response.getStatusCode());
//        log.info("Callback Response From Business Service: " + response.getBody());
    }
}
