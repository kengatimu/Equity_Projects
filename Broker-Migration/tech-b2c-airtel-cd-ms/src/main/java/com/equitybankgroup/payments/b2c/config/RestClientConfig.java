package com.equitybankgroup.payments.b2c.config;

import java.security.cert.X509Certificate;
import org.apache.hc.client5.http.impl.classic.CloseableHttpClient;
import org.apache.hc.client5.http.config.RequestConfig;
import org.apache.hc.client5.http.impl.classic.HttpClients;
import org.apache.hc.client5.http.impl.io.PoolingHttpClientConnectionManager;
import org.apache.hc.core5.http.io.SocketConfig;
import org.apache.hc.core5.ssl.SSLContextBuilder;
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
import java.util.Arrays;
import java.util.concurrent.TimeUnit;
import org.apache.hc.client5.http.socket.ConnectionSocketFactory;
import org.apache.hc.client5.http.socket.PlainConnectionSocketFactory;
import org.apache.hc.client5.http.ssl.SSLConnectionSocketFactory;
import org.apache.hc.client5.http.ssl.TrustAllStrategy;
import org.apache.hc.core5.http.config.RegistryBuilder;
import org.apache.hc.core5.util.TimeValue;
import org.apache.http.conn.ssl.NoopHostnameVerifier;
import org.apache.http.ssl.TrustStrategy;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.converter.xml.MappingJackson2XmlHttpMessageConverter;

@Configuration
@EnableScheduling
public class RestClientConfig {

    private static final int CONNECT_TIMEOUT = 10000;
    private static final int REQUEST_TIMEOUT = 20000;
    private static final int SOCKET_TIMEOUT = 30000;

    private static final int MAX_TOTAL_CONNECTIONS = 500;
    private static final int DEFAULT_MAX_PER_ROUTE = 150;

    private static final int DEFAULT_KEEP_ALIVE_TIME_MILLIS = 20000;
    private static final int CLOSE_IDLE_CONNECTION_WAIT_TIME_SECS = 30;

    private static final Logger LOGGER = LoggerFactory.getLogger(RestClientConfig.class);

    @Bean("poolingConnectionManager")
    public PoolingHttpClientConnectionManager poolingConnectionManager() throws Exception {
        SSLContext sslContext = SSLContextBuilder.create()
                .loadTrustMaterial(null, TrustAllStrategy.INSTANCE)
                .build();

        PoolingHttpClientConnectionManager poolingConnectionManager = new PoolingHttpClientConnectionManager();
        poolingConnectionManager.setMaxTotal(MAX_TOTAL_CONNECTIONS);
        poolingConnectionManager.setDefaultMaxPerRoute(DEFAULT_MAX_PER_ROUTE);

        SocketConfig socketConfig = SocketConfig.custom()
                .setSoTimeout(SOCKET_TIMEOUT, TimeUnit.MILLISECONDS)
                .build();
        poolingConnectionManager.setDefaultSocketConfig(socketConfig);

        return poolingConnectionManager;
    }

    @Bean("httpClient")
    public CloseableHttpClient httpClient() throws Exception {
        RequestConfig requestConfig = RequestConfig.custom()
                .setConnectTimeout(CONNECT_TIMEOUT, TimeUnit.MILLISECONDS)
                .setConnectionRequestTimeout(REQUEST_TIMEOUT, TimeUnit.MILLISECONDS)
                .build();

        return HttpClients.custom()
                .setConnectionManager(poolingConnectionManager())
                .setDefaultRequestConfig(requestConfig)
                .build();
    }

    @Bean
    public Runnable idleConnectionMonitor(@Qualifier("poolingConnectionManager") PoolingHttpClientConnectionManager connectionManager) {
        return new Runnable() {
            @Override
            @Scheduled(fixedDelay = 10000)
            public void run() {
                try {
                    LOGGER.trace("Closing expired and idle connections...");
                    connectionManager.closeExpired();
                    connectionManager.closeIdle(TimeValue.ofSeconds(CLOSE_IDLE_CONNECTION_WAIT_TIME_SECS));
                } catch (Exception e) {
                    LOGGER.error("Error in IdleConnectionMonitor: {}", e.getMessage(), e);
                }
            }
        };
    }
    
    @Bean
    public Runnable customIdleConnectionMonitor(@Qualifier("customPoolingConnectionManager") PoolingHttpClientConnectionManager connectionManager) {
        return new Runnable() {
            @Override
            @Scheduled(fixedDelay = 10000)
            public void run() {
                try {
                    LOGGER.trace("Closing expired and idle connections...");
                    connectionManager.closeExpired();
                    connectionManager.closeIdle(TimeValue.ofSeconds(CLOSE_IDLE_CONNECTION_WAIT_TIME_SECS));
                } catch (Exception e) {
                    LOGGER.error("Error in IdleConnectionMonitor: {}", e.getMessage(), e);
                }
            }
        };
    }
    
    @Bean("customPoolingConnectionManager")
    public PoolingHttpClientConnectionManager customPoolingConnectionManager() throws Exception {
//        SSLContext sslContext = SSLContextBuilder.create()
//                .loadTrustMaterial(null, TrustAllStrategy.INSTANCE)
//                .build();
//
//        // Use the SSLContext to create an SSLConnectionSocketFactory
//        SSLConnectionSocketFactory sslSocketFactory = new SSLConnectionSocketFactory(sslContext);

        TrustStrategy acceptingTrustStrategy = (X509Certificate[] chain, String authType) -> true;
        SSLContext sslContext = org.apache.http.ssl.SSLContexts.custom().loadTrustMaterial(null, acceptingTrustStrategy).build();
        SSLConnectionSocketFactory sslSocketFactory = new SSLConnectionSocketFactory(sslContext, NoopHostnameVerifier.INSTANCE);

        // Create the connection manager with the SSL factory
        PoolingHttpClientConnectionManager poolingConnectionManager
                = new PoolingHttpClientConnectionManager(
                        RegistryBuilder.<ConnectionSocketFactory>create()
                                .register("https", sslSocketFactory)
                                .register("http", PlainConnectionSocketFactory.getSocketFactory())
                                .build()
                );

        poolingConnectionManager.setMaxTotal(MAX_TOTAL_CONNECTIONS);
        poolingConnectionManager.setDefaultMaxPerRoute(DEFAULT_MAX_PER_ROUTE);

        SocketConfig socketConfig = SocketConfig.custom()
                .setSoTimeout(SOCKET_TIMEOUT, TimeUnit.MILLISECONDS)
                .build();
        poolingConnectionManager.setDefaultSocketConfig(socketConfig);

        return poolingConnectionManager;
    }

    @Bean("customttpClient")
    public CloseableHttpClient customttpClient() throws Exception {
        RequestConfig requestConfig = RequestConfig.custom()
                .setConnectTimeout(CONNECT_TIMEOUT, TimeUnit.MILLISECONDS)
                .setConnectionRequestTimeout(REQUEST_TIMEOUT, TimeUnit.MILLISECONDS)
                .build();

        return HttpClients.custom()
                .setConnectionManager(customPoolingConnectionManager())
                .setDefaultRequestConfig(requestConfig)
                .build();
    }

    @Bean("defaultRestTemplate")
    @Primary
    public RestTemplate restTemplate() throws Exception {
        RestTemplate restTemplate = new RestTemplate(new HttpComponentsClientHttpRequestFactory(httpClient()));
        MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter();
        converter.setSupportedMediaTypes(Arrays.asList(MediaType.ALL));
        restTemplate.getMessageConverters().add(converter);
        restTemplate.setErrorHandler(new RestTemplateErrorHandler());
        return restTemplate;
    }
    
    /*
    @Bean("customRestTemplate")
    public RestTemplate customRestTemplate() throws Exception {
        RestTemplate restTemplate = new RestTemplate(new HttpComponentsClientHttpRequestFactory(customttpClient()));
        restTemplate.setMessageConverters(Arrays.asList(
                new MappingJackson2HttpMessageConverter() // JSON Support
        ));
        restTemplate.setErrorHandler(new RestTemplateErrorHandler());
        return restTemplate;
    }
    */
    
    @Bean("customRestTemplate")
    @Primary
    public RestTemplate customRestTemplate() throws Exception {
        RestTemplate restTemplate = new RestTemplate(new HttpComponentsClientHttpRequestFactory(customttpClient()));
        MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter();
        converter.setSupportedMediaTypes(Arrays.asList(MediaType.ALL));
        restTemplate.getMessageConverters().add(converter);
//        restTemplate.getMessageConverters().add(new MappingJackson2XmlHttpMessageConverter());
        restTemplate.setErrorHandler(new RestTemplateErrorHandler());
        return restTemplate;
    }
}
