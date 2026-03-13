/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.config;

import java.io.IOException;
import org.springframework.http.client.ClientHttpResponse;
import org.springframework.web.client.DefaultResponseErrorHandler;

/**
 *
 * @author ronaldcheruiyot
 */
public class RestTemplateErrorHandler extends DefaultResponseErrorHandler {
    
    @Override
    public void handleError(ClientHttpResponse response) throws IOException {
        System.out.println("NOOP ERROR HANDLING!!!");
        //NOOP
    }
    
    @Override
    public boolean hasError(ClientHttpResponse response) throws IOException {
        // Customize when you want to handle errors
        System.out.println("HANDLING ERRORS!!!");
        System.out.println("Status code: " + response.getRawStatusCode());
        System.out.println("is4xxClientError(): " + response.getStatusCode().is4xxClientError());
        return response.getStatusCode().is4xxClientError() || response.getStatusCode().is5xxServerError();
    }
}
