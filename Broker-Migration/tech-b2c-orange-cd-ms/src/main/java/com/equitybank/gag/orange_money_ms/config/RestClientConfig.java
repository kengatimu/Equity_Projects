/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybank.gag.orange_money_ms.config;

import org.apache.hc.client5.http.ConnectionKeepAliveStrategy;
import org.apache.hc.client5.http.config.RequestConfig;
import org.apache.hc.client5.http.impl.classic.CloseableHttpClient;
import org.apache.hc.client5.http.impl.classic.HttpClients;
import org.apache.hc.client5.http.impl.io.PoolingHttpClientConnectionManager;
import org.apache.hc.client5.http.socket.ConnectionSocketFactory;
import org.apache.hc.client5.http.socket.PlainConnectionSocketFactory;
import org.apache.hc.client5.http.ssl.SSLConnectionSocketFactory;
import org.apache.hc.core5.http.config.Registry;
import org.apache.hc.core5.http.config.RegistryBuilder;
import org.apache.hc.core5.ssl.SSLContexts;
import org.apache.hc.core5.ssl.TrustStrategy;
import org.apache.hc.core5.util.TimeValue;
import org.apache.http.HeaderElement;
import org.apache.http.HeaderElementIterator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.http.MediaType;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.web.client.RestTemplate;

import javax.net.ssl.SSLContext;
import java.io.IOException;
import java.security.KeyManagementException;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.UnrecoverableKeyException;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.List;
import java.util.concurrent.TimeUnit;
import org.apache.http.conn.ssl.NoopHostnameVerifier;

@Configuration
@EnableScheduling
public class RestClientConfig {

    // Timeout settings
    private static final int CONNECT_TIMEOUT_MS = 10_000;   // Connection timeout in milliseconds
    private static final int REQUEST_TIMEOUT_MS = 20_000;   // Request timeout in milliseconds
    private static final int SOCKET_TIMEOUT_MS = 30_000;    // Socket timeout in milliseconds

    // Connection pool settings
    private static final int MAX_TOTAL_CONNECTIONS = 500;       // Maximum total connections
    private static final int MAX_CONNECTIONS_PER_ROUTE = 150;   // Maximum connections per route

    // Keep-alive settings
    private static final TimeValue KEEP_ALIVE_DURATION = TimeValue.ofSeconds(20); // Keep-alive duration in seconds
    private static final TimeValue IDLE_CONNECTION_CLOSE_TIME = TimeValue.ofSeconds(30); // Idle connection close time in seconds

    // Logger
    private static final Logger LOGGER = LoggerFactory.getLogger(RestClientConfig.class);

    @Bean("poolingConnectionManager2")
    public PoolingHttpClientConnectionManager poolingConnectionManager()
            throws NoSuchAlgorithmException, KeyStoreException, KeyManagementException, IOException, CertificateException, UnrecoverableKeyException {

        // Trust strategy accepting all certificates
        TrustStrategy acceptingTrustStrategy = new TrustStrategy() {
            @Override
            public boolean isTrusted(X509Certificate[] chain, String authType) throws CertificateException {
                return true;
            }
        };
        SSLContext sslContext = SSLContexts.custom().loadTrustMaterial(null, acceptingTrustStrategy).build();

        // SSL connection socket factory with all hostnames allowed
        SSLConnectionSocketFactory sslSocketFactory = new SSLConnectionSocketFactory(
                sslContext,  NoopHostnameVerifier.INSTANCE);

        // Register HTTP and HTTPS socket factories
        Registry<ConnectionSocketFactory> socketFactoryRegistry = RegistryBuilder
                .<ConnectionSocketFactory>create()
                .register("https", sslSocketFactory)
                .register("http", new PlainConnectionSocketFactory())
                .build();

        // Create and configure the pooling connection manager
        PoolingHttpClientConnectionManager connectionManager = new PoolingHttpClientConnectionManager(socketFactoryRegistry);
        connectionManager.setMaxTotal(MAX_TOTAL_CONNECTIONS);
        connectionManager.setDefaultMaxPerRoute(MAX_CONNECTIONS_PER_ROUTE);

        return connectionManager;
    }

    @Bean("connectionKeepAliveStrategy2")
    public ConnectionKeepAliveStrategy connectionKeepAliveStrategy() {
        return (response, context) -> {
            HeaderElementIterator it = new HeaderElementIterator() {
                @Override
                public boolean hasNext() {
                    return false;
                }

                @Override
                public Object next() {
                    return null;
                }

                @Override
                public org.apache.http.HeaderElement nextElement() {
                    return null;
                }
            };
            while (it.hasNext()) {
                HeaderElement element = it.nextElement();
                assert element != null;
                String param = element.getName();
                String value = element.getValue();
                if (value != null && param.equalsIgnoreCase("timeout")) {
                    return TimeValue.ofSeconds(Long.parseLong(value));
                }
            }
            return KEEP_ALIVE_DURATION;
        };
    }

    @Bean("httpClient2")
    public CloseableHttpClient httpClient() throws NoSuchAlgorithmException, KeyStoreException, KeyManagementException, IOException, CertificateException, UnrecoverableKeyException {
        RequestConfig requestConfig = RequestConfig.custom()
                .setConnectionRequestTimeout(REQUEST_TIMEOUT_MS, TimeUnit.MILLISECONDS)
                .setResponseTimeout(CONNECT_TIMEOUT_MS, TimeUnit.MILLISECONDS)
                .build();

        return HttpClients.custom()
                .setDefaultRequestConfig(requestConfig)
                .setConnectionManager(poolingConnectionManager())
                .setKeepAliveStrategy(connectionKeepAliveStrategy())
                .build();
    }

    @Bean("idleConnectionMonitor2")
    public Runnable idleConnectionMonitor(final PoolingHttpClientConnectionManager connectionManager) {
        return new Runnable() {
            @Override
            @Scheduled(fixedDelay = 10_000)
            public void run() {
                try {
                    if (connectionManager != null) {
                        LOGGER.trace("IdleConnectionMonitor - Closing expired and idle connections...");
                        connectionManager.closeExpired();
                        connectionManager.closeIdle(IDLE_CONNECTION_CLOSE_TIME);
                    } else {
                        LOGGER.trace("IdleConnectionMonitor - Connection manager is not initialized");
                    }
                } catch (Exception e) {
                    LOGGER.error("IdleConnectionMonitor - Exception occurred: {}", e.getMessage(), e);
                }
            }
        };
    }

    @Bean("defaultRestTemplate")
    @Primary
    public RestTemplate restTemplate() throws NoSuchAlgorithmException, KeyStoreException, KeyManagementException, IOException, CertificateException, UnrecoverableKeyException {
        RestTemplate restTemplate = new RestTemplate(clientHttpRequestFactory());
        MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter();
        converter.setSupportedMediaTypes(List.of(MediaType.ALL));
        restTemplate.getMessageConverters().add(converter);
        restTemplate.setErrorHandler(new RestTemplateErrorHandler());
        return restTemplate;
    }

    @Bean("clientHttpRequestFactory2")
    public HttpComponentsClientHttpRequestFactory clientHttpRequestFactory() throws NoSuchAlgorithmException, KeyStoreException, KeyManagementException, IOException, CertificateException, UnrecoverableKeyException {
        HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory();
        factory.setHttpClient(httpClient());
        return factory;
    }
}


