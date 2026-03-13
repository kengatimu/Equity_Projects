package com.equitybank.gag.papss.ots.config;

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
    private static final int CONNECT_TIMEOUT = 15000;
    private static final int REQUEST_TIMEOUT = 15000;
    private static final int SOCKET_TIMEOUT = 50000;
    private static final int MAX_TOTAL_CONNECTIONS = 200;
    private static final int DEFAULT_MAX_PER_ROUTE = 50;
    private static final int DEFAULT_KEEP_ALIVE_TIME_MILLIS = 30000;
    private static final int CLOSE_IDLE_CONNECTION_WAIT_TIME_SECS = 30;

    // Properties for the PAPSS-specific HTTP client, including the configuration flags
    private final String papssKeystoreLocation;
    private final String papssKeystorePassword;
    private final String papssKeystoreType;
    private final String papssTruststoreLocation;
    private final String papssTruststorePassword;
    private final String papssTruststoreType;
    private final boolean trustAllCertificates;
    private final boolean skipHostnameVerification;

    public HttpConfigs(@Value("${papss.signing.key-store}") String papssKeystoreLocation,
                       @Value("${papss.signing.key-store-password}") String papssKeystorePassword,
                       @Value("${papss.signing.key-store-type}") String papssKeystoreType,
                       @Value("${papss.ssl.trust-store}") String papssTruststoreLocation,
                       @Value("${papss.ssl.trust-store-password}") String papssTruststorePassword,
                       @Value("${papss.ssl.trust-store-type}") String papssTruststoreType,
                       @Value("${http.ssl.trust-all:false}") boolean trustAllCertificates,
                       @Value("${http.ssl.skip-hostname-verification:false}") boolean skipHostnameVerification) {
        this.papssKeystoreLocation = papssKeystoreLocation;
        this.papssKeystorePassword = papssKeystorePassword;
        this.papssKeystoreType = papssKeystoreType;
        this.papssTruststoreLocation = papssTruststoreLocation;
        this.papssTruststorePassword = papssTruststorePassword;
        this.papssTruststoreType = papssTruststoreType;
        this.trustAllCertificates = trustAllCertificates;
        this.skipHostnameVerification = skipHostnameVerification;
    }

    // This bean is now exclusively for the PAPSS connection
    @Bean (name = "closeableHttpClient")
    public CloseableHttpClient papssHttpClient() {
        log.info("Creating PAPSS-specific HTTP client bean.");
        PoolingHttpClientConnectionManager poolingHttpConnMgr = buildConnectionManager();
        return buildHttpClient(poolingHttpConnMgr);
    }

    @Bean(name = "closeableHttpClient_finacle")
    public CloseableHttpClient finacleHttpClient() {
        log.warn("Creating FINACLE HTTP client with TRUST-ALL SSL.");

        try {
            // Trust ALL certificates (Finacle internal TLS)
            SSLContext sslContext = SSLContexts.custom()
                    .loadTrustMaterial((chain, authType) -> true)
                    .build();

            SSLConnectionSocketFactory socketFactory = new SSLConnectionSocketFactory(
                    sslContext,
                    NoopHostnameVerifier.INSTANCE);

            Registry<ConnectionSocketFactory> registry = RegistryBuilder.<ConnectionSocketFactory>create()
                            .register("https", socketFactory)
                            .register("http", PlainConnectionSocketFactory.INSTANCE)
                            .build();

            PoolingHttpClientConnectionManager cm = new PoolingHttpClientConnectionManager(registry);

            cm.setMaxTotal(MAX_TOTAL_CONNECTIONS);
            cm.setDefaultMaxPerRoute(DEFAULT_MAX_PER_ROUTE);

            return buildHttpClient(cm);

        } catch (Exception e) {
            throw new RuntimeException("Failed to create Finacle HTTP client: "  + e.getMessage());
        }
    }

    // Creates a connection manager using the PAPSS P12 file for key and the new truststore for trust validation.
    private PoolingHttpClientConnectionManager buildConnectionManager() {
        try {
            // Load the Keystore for client authentication
            KeyStore keyStore = KeyStore.getInstance(papssKeystoreType);
            try (FileInputStream keystoreFis = new FileInputStream(papssKeystoreLocation)) {
                keyStore.load(keystoreFis, papssKeystorePassword.toCharArray());
                log.info("Loaded keystore from {}.", papssKeystoreLocation);
            }

            SSLContext sslContext;

            // Apply the trustAllCertificates flag
            if (trustAllCertificates) {
                log.warn("Trusting ALL certificates as per configuration.");
                sslContext = SSLContexts.custom()
                        .loadKeyMaterial(keyStore, papssKeystorePassword.toCharArray())
                        .loadTrustMaterial((chain, authType) -> true)
                        .build();
            } else {
                // Load the Truststore for server validation
                KeyStore trustStore = KeyStore.getInstance(papssTruststoreType);
                try (FileInputStream truststoreFis = new FileInputStream(papssTruststoreLocation)) {
                    trustStore.load(truststoreFis, papssTruststorePassword.toCharArray());
                    log.info("Loaded custom truststore from {}.", papssTruststoreLocation);
                }

                sslContext = SSLContexts.custom()
                        .loadKeyMaterial(keyStore, papssKeystorePassword.toCharArray())
                        .loadTrustMaterial(trustStore, null)
                        .build();
            }

            // Apply the skipHostnameVerification flag
            SSLConnectionSocketFactory socketFactory = skipHostnameVerification
                    ? new SSLConnectionSocketFactory(sslContext, NoopHostnameVerifier.INSTANCE)
                    : new SSLConnectionSocketFactory(sslContext, new String[]{"TLSv1.2"}, null, new DefaultHostnameVerifier());

            // Log whether hostname verification is enabled or disabled
            if (skipHostnameVerification) {
                log.warn("Hostname verification DISABLED for this pool.");
            } else {
                log.info("Hostname verification ENABLED for this pool.");
            }

            Registry<ConnectionSocketFactory> registry = RegistryBuilder.<ConnectionSocketFactory>create()
                    .register("https", socketFactory)
                    .register("http", PlainConnectionSocketFactory.INSTANCE)
                    .build();

            PoolingHttpClientConnectionManager pool = new PoolingHttpClientConnectionManager(registry);
            pool.setMaxTotal(MAX_TOTAL_CONNECTIONS);
            pool.setDefaultMaxPerRoute(DEFAULT_MAX_PER_ROUTE);
            return pool;

        } catch (Exception e) {
            log.error("Could not initialize PAPSS SSL connection manager", e);
            throw new RuntimeException("Failed to initialize PAPSS SSL context", e);
        }
    }

    // Keep your other helper methods as-is
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

    @Scheduled(fixedDelay = 20000)
    public void idleConnectionMonitor() {
        PoolingHttpClientConnectionManager connMgr = buildConnectionManager();
        cleanIdleConnections(connMgr, "papssHttpClientPool");
    }

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