package com.papss.middleware.utils;

import com.papss.middleware.service.KeyStoreService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class HttpClient {
    private final KeyStoreService keyStoreService;

    public <T> ResponseEntity<T> getClient(String url, HttpEntity<?> request, String alias, Class<T> responseType) {
        log.debug("Requesting GET to url: {}", url);
        log.debug("Request Header Info {} ", request.getHeaders());
        ResponseEntity<T> responseEntity = keyStoreService.getRestTemplate(alias).exchange(url, HttpMethod.GET, request, responseType);
        log.debug("Response body: {}", responseEntity.getBody());
        return responseEntity;
    }



    public <T> ResponseEntity<T> postClient(String url, HttpEntity<?> request, String alias, Class<T> responseType) {
        log.debug("Requesting POST to url: {}", url);
        log.debug("Request body: {}", request.getBody());
        ResponseEntity<T> responseEntity = keyStoreService.getRestTemplate(alias).exchange(url, HttpMethod.POST, request, responseType);
        log.debug("Response body: {}", responseEntity.getBody());
        return responseEntity;
    }
}
