package com.equitybank.payments.imt.b2c.drcbroker.service.util;

import com.equitybank.payments.imt.b2c.drcbroker.service.model.error.status.ErrorStatus;
import com.squareup.okhttp.OkHttpClient;
import com.squareup.okhttp.Request;
import com.squareup.okhttp.Response;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.concurrent.TimeUnit;

@Service
public class HttpBrokerCall {
    private static final Logger log = LoggerFactory.getLogger(HttpBrokerCall.class);
    private final String Content_TYPE = "application/x-www-form-urlencoded";

    public String postJson(String targetUrl, String tokenRequest, ErrorStatus errorStatus) {
        OkHttpClient client = new OkHttpClient();
        client.setHostnameVerifier((hostname, session) -> true);
        client.setConnectTimeout(55, TimeUnit.SECONDS);
        client.setReadTimeout(55, TimeUnit.SECONDS);
        com.squareup.okhttp.RequestBody body = com.squareup.okhttp.RequestBody.create(com.squareup.okhttp.MediaType.parse("text/plain"), tokenRequest);

        Request request;
        request = new Request.Builder()
                .url(targetUrl)
                .addHeader("Content-Type", Content_TYPE)
                .post(body)
                .build();
        Response response = null;
        try {
            response = client.newCall(request).execute();
            log.info("Returned Token Response::: " + response);
            return response.body().string();
        } catch (IOException e) {
            e.printStackTrace();
            errorStatus.setStatus("Failed");
            errorStatus.setStatusCode("500");
            errorStatus.setStatusDesc(" Request To Broker Failed::: " + response.message());
            errorStatus.setStatusMessage("HTTP Request Failed: " + response.message());
            log.error("HTTP Request To Broker Failed. IOException Occurred: " + e.getMessage());
            return null;
        } catch (Exception e) {
            errorStatus.setStatus("Failed");
            errorStatus.setStatusCode("500");
            errorStatus.setStatusDesc(" Request To Broker Failed::: " + response.message());
            errorStatus.setStatusMessage("HTTP Request Failed: " + response.message());
            log.error("HTTP Request To Broker Failed. Exception Occurred: " + e.getMessage());
            return null;
        }
    }
}
