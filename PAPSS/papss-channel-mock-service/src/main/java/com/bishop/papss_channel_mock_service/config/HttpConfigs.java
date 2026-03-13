package com.bishop.papss_channel_mock_service.config;

import org.apache.http.*;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.config.Registry;
import org.apache.http.config.RegistryBuilder;
import org.apache.http.conn.ConnectionKeepAliveStrategy;
import org.apache.http.conn.socket.*;
import org.apache.http.conn.ssl.*;
import org.apache.http.impl.client.*;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.apache.http.message.BasicHeaderElementIterator;
import org.apache.http.protocol.HTTP;
import org.apache.http.protocol.HttpContext;
import org.apache.http.ssl.SSLContexts;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.*;
import org.springframework.scheduling.annotation.Scheduled;

import javax.net.ssl.SSLContext;
import java.io.FileInputStream;
import java.security.KeyStore;
import java.util.concurrent.TimeUnit;

@Configuration
public class HttpConfigs {

    private static final Logger log = LoggerFactory.getLogger(HttpConfigs.class);

    // Timeout and connection pool constants
    private static final int CONNECT_TIMEOUT = 15000; // Time to establish connection with server (ms)
    private static final int REQUEST_TIMEOUT = 15000; // Time to wait for a connection from the pool (ms)
    private static final int SOCKET_TIMEOUT = 30000; // Time to wait for data after connection is established (ms)

    private static final int MAX_TOTAL_CONNECTIONS = 200; // Max total connections allowed in the pool
    private static final int DEFAULT_MAX_PER_ROUTE = 50; // Max connections allowed per route (per target host)

    private static final int DEFAULT_KEEP_ALIVE_TIME_MILLIS = 30000; // Default keep-alive duration if server doesn't specify (ms)
    private static final int CLOSE_IDLE_CONNECTION_WAIT_TIME_SECS = 30; // Time after which idle connections are closed (seconds)

    private final String keystoreLocation;
    private final String keystorePassword;
    private final String keystoreType;
    private final String truststoreLocation;
    private final String truststorePassword;
    private final String truststoreType;
    private final boolean trustAllCertificates;
    private final boolean skipHostnameVerification;

    public HttpConfigs(@Value("${server.ssl.key-store}") String keystoreLocation,
                       @Value("${server.ssl.key-store-password}") String keystorePassword,
                       @Value("${server.ssl.key-store-type}") String keystoreType,
                       @Value("${server.ssl.trust-store:}") String truststoreLocation, // Defaults to empty string if not found
                       @Value("${server.ssl.trust-store-password:}") String truststorePassword, // Defaults to empty string if not found
                       @Value("${server.ssl.trust-store-type:}") String truststoreType, // Defaults to empty string if not found
                       @Value("${http.ssl.trust-all:false}") boolean trustAllCertificates, // Defaults to false if not found
                       @Value("${http.ssl.skip-hostname-verification:false}") boolean skipHostnameVerification) {
        this.keystoreLocation = keystoreLocation;
        this.keystorePassword = keystorePassword;
        this.keystoreType = keystoreType;
        this.truststoreLocation = truststoreLocation;
        this.truststorePassword = truststorePassword;
        this.truststoreType = truststoreType;
        this.trustAllCertificates = trustAllCertificates;
        this.skipHostnameVerification = skipHostnameVerification;
    }

    // Builds a CloseableHttpClient using internal SSL config and hostname verification settings
    @Bean(name = "closeableHttpClient")
    public CloseableHttpClient closeableHttpClient() {
        PoolingHttpClientConnectionManager poolingHttpConnMgr = buildConnectionManager();
        return buildHttpClient(poolingHttpConnMgr);
    }

    // Creates a connection manager with SSL and hostname verification settings based on YAML flags
    private PoolingHttpClientConnectionManager buildConnectionManager() {
        try (FileInputStream keystoreFis = new FileInputStream(keystoreLocation)) {

            // Load keystore
            KeyStore keyStore = KeyStore.getInstance(keystoreType);
            keyStore.load(keystoreFis, keystorePassword.toCharArray());

            SSLContext sslContext;

            // If enabled, trust all certificates, as per the configurations
            if (trustAllCertificates) {
                log.warn("Trusting ALL certificates as per configuration.");
                sslContext = SSLContexts.custom()
                        .loadKeyMaterial(keyStore, keystorePassword.toCharArray())
                        .loadTrustMaterial((chain, authType) -> true)
                        .build();
            } else {
                KeyStore trustStore = null;

                // Load the certs from the truststore. Only load truststore if location is provided
                if (!truststoreLocation.trim().isEmpty()) {
                    try (FileInputStream truststoreFis = new FileInputStream(truststoreLocation)) {
                        trustStore = KeyStore.getInstance(truststoreType);
                        trustStore.load(truststoreFis, truststorePassword.toCharArray());
                        log.info("Custom truststore loaded from: {}", truststoreLocation);
                    }
                } else {
                    log.info("No truststore configured. Using default system trust.");
                }

                // Default SSLContext trusting only configured certificates.
                sslContext = SSLContexts.custom()
                        .loadKeyMaterial(keyStore, keystorePassword.toCharArray())
                        .loadTrustMaterial(trustStore, null)
                        .build();
            }
            // Create socket factory: Use NoopHostnameVerifier if hostname verification is disabled, otherwise enforce default TLSv1.2 verification
            SSLConnectionSocketFactory socketFactory = skipHostnameVerification
                    ? new SSLConnectionSocketFactory(sslContext, NoopHostnameVerifier.INSTANCE)
                    : new SSLConnectionSocketFactory(sslContext, new String[]{"TLSv1.2"}, null, new DefaultHostnameVerifier());

            // Log whether hostname verification is enabled or disabled for this connection pool
            if (skipHostnameVerification) {
                log.warn("Hostname verification DISABLED for this pool.");
            } else {
                log.info("Hostname verification ENABLED for this pool.");
            }

            // Register socket factories for HTTPS and HTTP connections
            Registry<ConnectionSocketFactory> registry = RegistryBuilder.<ConnectionSocketFactory>create()
                    .register("https", socketFactory)
                    .register("http", PlainConnectionSocketFactory.INSTANCE)
                    .build();

            // Initialize connection pool using the registry and configure connection limits
            PoolingHttpClientConnectionManager pool = new PoolingHttpClientConnectionManager(registry);
            pool.setMaxTotal(MAX_TOTAL_CONNECTIONS);
            pool.setDefaultMaxPerRoute(DEFAULT_MAX_PER_ROUTE);
            return pool;

        } catch (Exception e) {
            log.error("Could not initialize SSL connection manager", e);
            return new PoolingHttpClientConnectionManager();
        }
    }

    // Create HTTP client with custom timeouts, connection pool, and keep-alive strategy
    private CloseableHttpClient buildHttpClient(PoolingHttpClientConnectionManager cm) {
        RequestConfig config = RequestConfig.custom()
                .setConnectionRequestTimeout(REQUEST_TIMEOUT)
                .setConnectTimeout(CONNECT_TIMEOUT)
                .setSocketTimeout(SOCKET_TIMEOUT)
                .build();

        return HttpClients.custom()
                .setDefaultRequestConfig(config)
                .setConnectionManager(cm)
                .setKeepAliveStrategy(connectionKeepAliveStrategy())
                .build();
    }

    // Define keep-alive strategy based on server's timeout header or fallback to default
    @Bean
    public ConnectionKeepAliveStrategy connectionKeepAliveStrategy() {
        return (HttpResponse response, HttpContext context) -> {
            HeaderElementIterator it = new BasicHeaderElementIterator(response.headerIterator(HTTP.CONN_KEEP_ALIVE));
            while (it.hasNext()) {
                HeaderElement header = it.nextElement();
                if ("timeout".equalsIgnoreCase(header.getName()) && header.getValue() != null) {
                    return Long.parseLong(header.getValue()) * 1000;
                }
            }
            return DEFAULT_KEEP_ALIVE_TIME_MILLIS;
        };
    }

    // Scheduled task (runs every 20s) to clean idle and expired connections from the pool
    @Scheduled(fixedDelay = 20000)
    public void idleConnectionMonitor() {
        PoolingHttpClientConnectionManager connMgr = buildConnectionManager();
        cleanIdleConnections(connMgr, "connMgr");
    }

    // Utility method to close idle and expired connections
    private void cleanIdleConnections(PoolingHttpClientConnectionManager manager, String name) {
        try {
            int leased = manager.getTotalStats().getLeased();
            int available = manager.getTotalStats().getAvailable();
            if (leased > 0 || available > 0) {
                log.info("Cleaning idle/expired connections in {}...", name);
                manager.closeExpiredConnections();
                manager.closeIdleConnections(CLOSE_IDLE_CONNECTION_WAIT_TIME_SECS, TimeUnit.SECONDS);
            }
        } catch (Exception e) {
            log.error("Failed to clean connections for {}: {}", name, e.getMessage());
        }
    }
}