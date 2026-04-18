package com.equitybank.payments.imt.b2c.response.service.impl;

import com.equitybank.payments.imt.b2c.response.service.CallBackHTTPService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.concurrent.CompletableFuture;

@Service
public class CallBackHTTPServiceImpl implements CallBackHTTPService {
    private static final Logger log = LoggerFactory.getLogger(CallBackHTTPServiceImpl.class);

    @Override
    public void sendCallback(String callBackUrl, String jsonResponse) {
        log.info("FinaL Response ::: " + jsonResponse);
        Duration duration = Duration.ofSeconds(50);
        try {
            // delay 10 seconds
            Thread.sleep(5000);

            HttpClient httpClient = HttpClient.newBuilder().build();
            HttpRequest request = HttpRequest.newBuilder()
                    .timeout(duration)
                    .POST(HttpRequest.BodyPublishers.ofString(jsonResponse))
                    .header("Accept", "application/json")
                    .headers("Content-Type", "application/json; utf-8")
                    .uri(URI.create(callBackUrl))
                    .build();

            CompletableFuture<HttpResponse<String>> responseFuture =
                    httpClient.sendAsync(request, HttpResponse.BodyHandlers.ofString());
            log.info("Request::: " + request.toString());
            log.info("Response Future::: " + responseFuture.get().body());

            responseFuture.whenComplete((res, error) -> {
                if (res != null) {
                    String response = res.body();
                    log.info("Response::: " + response);
                    log.info("Callback Called Successfully Via URL: " + callBackUrl + ". Response: " + response);
                }
                if (error != null) log.error("Error Occurred: " + error.getMessage());
            });

        } catch (Exception e) {
            e.printStackTrace();
            log.error("Exception Occurred::: " + e.getMessage());
        }
    }
}
