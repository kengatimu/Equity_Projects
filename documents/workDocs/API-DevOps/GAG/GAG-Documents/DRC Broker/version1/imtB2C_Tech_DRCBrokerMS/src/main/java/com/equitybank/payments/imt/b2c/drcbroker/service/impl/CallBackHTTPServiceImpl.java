package com.equitybank.payments.imt.b2c.drcbroker.service.impl;

import com.equitybank.payments.imt.b2c.drcbroker.domain.ParamConfigs;
import com.equitybank.payments.imt.b2c.drcbroker.repository.ParamConfigsRepository;
import com.equitybank.payments.imt.b2c.drcbroker.service.CallBackHTTPService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.Optional;
import java.util.concurrent.CompletableFuture;

@Service
public class CallBackHTTPServiceImpl implements CallBackHTTPService {
    private static final Logger log = LoggerFactory.getLogger(CallBackHTTPServiceImpl.class);

    private final ParamConfigsRepository paramConfigsRepository;

    @Autowired
    public CallBackHTTPServiceImpl(ParamConfigsRepository paramConfigsRepository) {
        this.paramConfigsRepository = paramConfigsRepository;
    }

    @Override
    public void sendCallback(String callBackUrl, String jsonResponse, String type) {
        Optional<ParamConfigs> optionalCallbackUrl = paramConfigsRepository.findByConfigId("business-service-call-back-url");
        callBackUrl = optionalCallbackUrl.get().getConfigValue();

        log.info("Sending Callback Response To Business Service Via URL: " + callBackUrl);
        Duration duration = Duration.ofSeconds(50);
        try {
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

            log.info("Request::: " + request);
            log.info("Response Future::: " + responseFuture.get().body());

            String finalCallBackUrl = callBackUrl;
            responseFuture.whenComplete((res, error) -> {
                if (res != null) {
                    String response = res.body();
                    log.info("Response::: " + response);
                    log.info("Callback To Business Service Called Successfully Via URL: " + finalCallBackUrl + ". Response: " + response);
                }
                if (error != null) log.error("On CallBackHTTPServiceImpl.sendCallback, Error Occurred: " + error.getMessage());
            });
        } catch (Exception e) {
            log.error("On CallBackHTTPServiceImpl.sendCallback, Exception Occurred::: " + e.getMessage());
        }
    }
}
