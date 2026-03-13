package com.equitybank.gag.mtn_money_ms.config;

import org.apache.http.HeaderElement;
import org.apache.http.HeaderElementIterator;
import org.apache.http.HttpResponse;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.config.Registry;
import org.apache.http.config.RegistryBuilder;
import org.apache.http.conn.ConnectionKeepAliveStrategy;
import org.apache.http.conn.socket.ConnectionSocketFactory;
import org.apache.http.conn.socket.PlainConnectionSocketFactory;
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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.Scheduled;

import javax.net.ssl.SSLContext;
import java.io.FileInputStream;
import java.io.IOException;
import java.security.*;
import java.security.cert.CertificateException;
import java.util.concurrent.TimeUnit;

@Configuration
public class HttpConfigs {
    private static final Logger log = LoggerFactory.getLogger(HttpConfigs.class);

    // Determines the timeout in milliseconds until a connection is established.
    private static final int CONNECT_TIMEOUT = 10000; // 10 seconds

    // The timeout in milliseconds for requesting a connection from the connection manager.
    private static final int REQUEST_TIMEOUT = 10000; // 10 seconds

    // The timeout in milliseconds for waiting for data from the server.
    private static final int SOCKET_TIMEOUT = 30000; // 30 seconds

    // The maximum number of total open connections managed by the connection manager.
    private static final int MAX_TOTAL_CONNECTIONS = 200;

    // The maximum number of concurrent connections per route (destination host).
    private static final int DEFAULT_MAX_PER_ROUTE = 50;

    // The default keep-alive time in milliseconds for persistent connections.
    private static final int DEFAULT_KEEP_ALIVE_TIME_MILLIS = 20000; // 20 seconds

    // The time in seconds to wait before closing idle connections.
    private static final int CLOSE_IDLE_CONNECTION_WAIT_TIME_SECS = 30;

    // Environment variables
    private final String keystoreLocation;
    private final String keystorePassword;
    private final String keystoreInstanceType;

    @Autowired
    public HttpConfigs(@Value("${server.ssl.keystore-location}") String keystoreLocation,
                       @Value("${server.ssl.keystore-password}") String keystorePassword,
                       @Value("${server.ssl.keystore-type}") String keystoreInstanceType) {
        this.keystoreLocation = keystoreLocation;
        this.keystorePassword = keystorePassword;
        this.keystoreInstanceType = keystoreInstanceType;
    }

    @Bean
    public PoolingHttpClientConnectionManager poolingConnectionManager() {
        FileInputStream fis = null;
        try {
            // Load the .p12 keystore
            KeyStore keyStore = KeyStore.getInstance(keystoreInstanceType);
            fis = new FileInputStream(keystoreLocation);
            keyStore.load(fis, keystorePassword.toCharArray());

            // Create SSLContext with the keystore
            SSLContext sslContext = SSLContexts.custom()
                    .loadKeyMaterial(keyStore, keystorePassword.toCharArray()) // Use the keystore
                    .loadTrustMaterial(keyStore, null) // Trust the keystore
                    .build();

            // Create SSLConnectionSocketFactory with hostname verification DISABLED
            // SSLConnectionSocketFactory sslConnectionFactory = new SSLConnectionSocketFactory(sslContext, NoopHostnameVerifier.INSTANCE);

            // Create SSLConnectionSocketFactory with hostname verification enabled
            SSLConnectionSocketFactory sslConnectionFactory = new SSLConnectionSocketFactory(sslContext);

            // Register both HTTP and HTTPS socket factories
            Registry<ConnectionSocketFactory> registry = RegistryBuilder
                    .<ConnectionSocketFactory>create()
                    .register("https", sslConnectionFactory)
                    .register("http", PlainConnectionSocketFactory.INSTANCE)
                    .build();

            // Create PoolingHttpClientConnectionManager
            PoolingHttpClientConnectionManager poolingConnectionManager = new PoolingHttpClientConnectionManager(registry);
            poolingConnectionManager.setMaxTotal(MAX_TOTAL_CONNECTIONS);
            poolingConnectionManager.setDefaultMaxPerRoute(DEFAULT_MAX_PER_ROUTE);
            return poolingConnectionManager;
        } catch (KeyStoreException | NoSuchAlgorithmException | CertificateException | IOException |
                 UnrecoverableKeyException | KeyManagementException e) {
            log.error("Error loading keystore or creating SSLContext" + e.getMessage());
            return new PoolingHttpClientConnectionManager(); // Fallback to default
        } finally {
            if (fis != null) {
                try {
                    fis.close();
                } catch (IOException e) {
                    log.error("IOException closing FileInputStream" + e.getMessage());
                }
            }
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