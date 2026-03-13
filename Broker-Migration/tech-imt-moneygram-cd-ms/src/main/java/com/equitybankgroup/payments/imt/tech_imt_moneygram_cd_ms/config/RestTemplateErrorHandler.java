package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.config;


import org.springframework.http.client.ClientHttpResponse;
import org.springframework.web.client.DefaultResponseErrorHandler;

import java.io.IOException;

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
//        System.out.println("Status code: " + response.getRawStatusCode());
        System.out.println("is4xxClientError(): " + response.getStatusCode().is4xxClientError());
        return response.getStatusCode().is4xxClientError() || response.getStatusCode().is5xxServerError();
    }
}
