/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.config;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.client.ClientHttpResponse;
import org.springframework.util.StreamUtils;
import org.springframework.web.client.DefaultResponseErrorHandler;

/**
 *
 * @author ronaldcheruiyot
 */
public class RestTemplateErrorHandler extends DefaultResponseErrorHandler {

    @Override
    public void handleError(ClientHttpResponse response) throws IOException {
        // Wrap the response to cache the body
//        BufferingClientHttpResponseWrapper bufferedResponse = new BufferingClientHttpResponseWrapper(response);
//
//        HttpStatusCode status = bufferedResponse.getStatusCode();
        // Check if the status code is a 4xx error
        /*
        if (status.is4xxClientError()) {
        // Read the cached response body as a string
        String responseBody = StreamUtils.copyToString(bufferedResponse.getBody(), StandardCharsets.UTF_8);
        // Print or log the status and response body
        System.out.println("Client error: " + status.value() + " " + bufferedResponse.getStatusText());
        System.out.println("Response body: " + responseBody);
        // Return without throwing an exception
        return;
        }
         */
//        if (!status.is2xxSuccessful()) {
//            super.handleError(bufferedResponse);
//        }

    }
}