package com.equitybank.gag.telco_b2c.config;

import org.apache.http.HeaderElement;
import org.apache.http.HeaderElementIterator;
import org.apache.http.HttpResponse;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.config.Registry;
import org.apache.http.config.RegistryBuilder;
import org.apache.http.conn.ConnectionKeepAliveStrategy;
import org.apache.http.conn.socket.ConnectionSocketFactory;
import org.apache.http.conn.socket.PlainConnectionSocketFactory;
import org.apache.http.conn.ssl.NoopHostnameVerifier;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.apache.http.message.BasicHeaderElementIterator;
import org.apache.http.protocol.HTTP;
import org.apache.http.protocol.HttpContext;
import org.apache.http.ssl.SSLContexts;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.Scheduled;

import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import java.security.cert.X509Certificate;
import java.util.concurrent.TimeUnit;

@Configuration
public class HttpConfigs {
    private static final Logger log = LoggerFactory.getLogger(HttpConfigs.class);

    // Timeouts in milliseconds (fail fast)
    private static final int CONNECT_TIMEOUT = 10000;         // TCP connect timeout
    private static final int REQUEST_TIMEOUT = 5000;         // Time to get from pool
    private static final int SOCKET_TIMEOUT = 50000;         // Remote call max wait

    // Connection Pool
    private static final int MAX_TOTAL_CONNECTIONS = 1000;    // High concurrency
    private static final int DEFAULT_MAX_PER_ROUTE = 300;

    private static final int DEFAULT_KEEP_ALIVE_TIME_MILLIS = 20 * 1000;  // Shorter reuse
    private static final int CLOSE_IDLE_CONNECTION_WAIT_TIME_SECS = 30;

    @Bean
    public PoolingHttpClientConnectionManager poolingConnectionManager() {
        try {
            // Create a custom TrustManager that accepts all certificates
            TrustManager[] trustAllCertificates = new TrustManager[]{
                    new X509TrustManager() {
                        public X509Certificate[] getAcceptedIssuers() {
                            return null;
                        }

                        public void checkClientTrusted(X509Certificate[] certs, String authType) {
                            // Do nothing
                        }

                        public void checkServerTrusted(X509Certificate[] certs, String authType) {
                            // Do nothing
                        }
                    }
            };

            // Configures and returns a connection manager with a pool of HTTP connections,
            // supporting both HTTP and HTTPS protocols, and setting the maximum number of connections.
            // By default, it will validate server certificates.
            // It won't work in your case if you're dealing with certificates that are not in the default truststore
            // (e.g., self-signed certificates or certificates from custom certificate authorities).
//            SSLContext sslcontext = SSLContexts.createDefault();

            // Set up the SSLContext with the TrustManager that accepts all certificates
            SSLContext sslcontext = SSLContexts.custom()
                    .loadTrustMaterial((chain, authType) -> true)  // Trust all
                    .build();

            SSLConnectionSocketFactory sslConnectionFactory = new SSLConnectionSocketFactory(sslcontext, NoopHostnameVerifier.INSTANCE);

            Registry<ConnectionSocketFactory> registry = RegistryBuilder
                    .<ConnectionSocketFactory>create()
                    .register("https", sslConnectionFactory)
                    .register("http", PlainConnectionSocketFactory.INSTANCE)
                    .build();

            PoolingHttpClientConnectionManager poolingConnectionManager = new PoolingHttpClientConnectionManager(registry);
            poolingConnectionManager.setMaxTotal(MAX_TOTAL_CONNECTIONS);
            poolingConnectionManager.setDefaultMaxPerRoute(DEFAULT_MAX_PER_ROUTE);
            return poolingConnectionManager;
        } catch (Exception e) {
            log.error("Error creating SSLContext with TrustManager to ignore certificate validation", e);

            // Returning a default PoolingHttpClientConnectionManager to prevent failure
            return new PoolingHttpClientConnectionManager();  // Default behavior
        }
    }

    @Bean
    public ConnectionKeepAliveStrategy connectionKeepAliveStrategy() {
        // Configures and returns a strategy for managing the keep-alive duration of HTTP connections,
        // ensuring connections are kept alive for a specified period.
        return (HttpResponse response, HttpContext context) -> {
            HeaderElementIterator it = new BasicHeaderElementIterator(response.headerIterator(HTTP.CONN_KEEP_ALIVE));
            while (it.hasNext()) {
                HeaderElement he = it.nextElement();
                String param = he.getName();
                String value = he.getValue();

                if (value != null && param.equalsIgnoreCase("timeout")) {
                    return Long.parseLong(value) * 1000;
                }
            }
            return DEFAULT_KEEP_ALIVE_TIME_MILLIS;
        };
    }

    @Bean("closeableHttpClient1")
    public CloseableHttpClient closeableHttpClient() {
        // Configures and returns an HTTP client with custom request configurations,
        // a connection manager, and a keep-alive strategy.
        RequestConfig requestConfig = RequestConfig
                .custom()
                .setConnectionRequestTimeout(REQUEST_TIMEOUT)
                .setConnectTimeout(CONNECT_TIMEOUT)
                .setSocketTimeout(SOCKET_TIMEOUT)
                .build();

        return HttpClients
                .custom()
                .setDefaultRequestConfig(requestConfig)
                .setConnectionManager(poolingConnectionManager())
                .setKeepAliveStrategy(connectionKeepAliveStrategy())
                .build();
    }

    @Scheduled(fixedDelay = 20000) // 20 secs
    public void idleConnectionMonitor() {
        PoolingHttpClientConnectionManager connectionManager = poolingConnectionManager();
        if (connectionManager == null) {
            return;
        }
        try {
            int leasedConnections = connectionManager.getTotalStats().getLeased();
            int availableConnections = connectionManager.getTotalStats().getAvailable();

            // Close connections only if there are any connections
            if (leasedConnections > 0 || availableConnections > 0) {
                log.info("Closing Expired and Idle Http Connections...");
                connectionManager.closeExpiredConnections();
                connectionManager.closeIdleConnections(CLOSE_IDLE_CONNECTION_WAIT_TIME_SECS, TimeUnit.SECONDS);
                log.info("Expired and Idle Http Connections Closed");
            }
        } catch (Exception e) {
            log.error("Exception Occurred When Trying To Close Expired and Idle Http Connections. msg= {}", e.getMessage());
        }
    }
}