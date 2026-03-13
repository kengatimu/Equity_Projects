package com.equitybankgroup.payments.b2c.config;

import org.apache.hc.client5.http.impl.classic.CloseableHttpClient;
import org.apache.hc.client5.http.config.RequestConfig;
import org.apache.hc.client5.http.impl.classic.HttpClients;
import org.apache.hc.client5.http.impl.io.PoolingHttpClientConnectionManager;
import org.apache.hc.client5.http.socket.ConnectionSocketFactory;
import org.apache.hc.client5.http.socket.PlainConnectionSocketFactory;
import org.apache.hc.client5.http.ssl.NoopHostnameVerifier;
import org.apache.hc.client5.http.ssl.SSLConnectionSocketFactory;
import org.apache.hc.core5.http.config.Registry;
import org.apache.hc.core5.http.config.RegistryBuilder;
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
import org.apache.hc.core5.util.TimeValue;

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

    @Bean
    public PoolingHttpClientConnectionManager poolingConnectionManager() throws Exception {
        // Create SSLContext with default truststore (no need for TrustAllStrategy)
        SSLContext sslContext = SSLContextBuilder.create()
                .loadTrustMaterial(null, (chain, authType) -> true) // Use default truststore
                .build();

        // Create SSLConnectionSocketFactory with hostname verification DISABLED
         SSLConnectionSocketFactory sslSocketFactory = new SSLConnectionSocketFactory(sslContext, NoopHostnameVerifier.INSTANCE);

        // Create SSLConnectionSocketFactory with default hostname verifier
//        SSLConnectionSocketFactory sslSocketFactory = new SSLConnectionSocketFactory(sslContext);

        // Register both HTTP and HTTPS socket factories
        Registry<ConnectionSocketFactory> socketFactoryRegistry = RegistryBuilder.<ConnectionSocketFactory>create()
                .register("http", PlainConnectionSocketFactory.INSTANCE)
                .register("https", sslSocketFactory)
                .build();

        // Create PoolingHttpClientConnectionManager with the socket factory registry
        PoolingHttpClientConnectionManager poolingConnectionManager = new PoolingHttpClientConnectionManager(socketFactoryRegistry);

        // Configure connection pool settings
        poolingConnectionManager.setMaxTotal(MAX_TOTAL_CONNECTIONS);
        poolingConnectionManager.setDefaultMaxPerRoute(DEFAULT_MAX_PER_ROUTE);

        // Configure socket settings
        SocketConfig socketConfig = SocketConfig.custom()
                .setSoTimeout(SOCKET_TIMEOUT, TimeUnit.MILLISECONDS)
                .build();
        poolingConnectionManager.setDefaultSocketConfig(socketConfig);

        return poolingConnectionManager;
    }

    @Bean
    public CloseableHttpClient httpClient(PoolingHttpClientConnectionManager poolingConnectionManager) {
        RequestConfig requestConfig = RequestConfig.custom()
                .setConnectTimeout(CONNECT_TIMEOUT, TimeUnit.MILLISECONDS)
                .setConnectionRequestTimeout(REQUEST_TIMEOUT, TimeUnit.MILLISECONDS)
                .build();

        return HttpClients.custom()
                .setConnectionManager(poolingConnectionManager)
                .setDefaultRequestConfig(requestConfig)
                .build();
    }

    @Bean
    public Runnable idleConnectionMonitor(PoolingHttpClientConnectionManager connectionManager) {
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

    @Bean("defaultRestTemplate")
    @Primary
    public RestTemplate restTemplate(CloseableHttpClient httpClient) {
        RestTemplate restTemplate = new RestTemplate(new HttpComponentsClientHttpRequestFactory(httpClient));
        MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter();
        converter.setSupportedMediaTypes(Arrays.asList(MediaType.ALL));
        restTemplate.getMessageConverters().add(converter);
        return restTemplate;
    }
}