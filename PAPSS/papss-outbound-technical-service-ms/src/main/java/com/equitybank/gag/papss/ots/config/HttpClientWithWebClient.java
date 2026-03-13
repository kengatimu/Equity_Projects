//package com.equitybank.gag.papss.ots.config;
//
//import io.netty.channel.ChannelOption;
//import io.netty.handler.ssl.SslContext;
//import io.netty.handler.ssl.SslContextBuilder;
//import io.netty.handler.ssl.util.InsecureTrustManagerFactory;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.http.client.reactive.ReactorClientHttpConnector;
//import org.springframework.web.reactive.function.client.WebClient;
//import reactor.netty.http.client.HttpClient;
//import reactor.netty.resources.ConnectionProvider;
//import reactor.netty.tcp.SslProvider;
//
//import javax.net.ssl.KeyManagerFactory;
//import javax.net.ssl.TrustManagerFactory;
//import java.io.FileInputStream;
//import java.security.KeyStore;
//import java.time.Duration;
//
//@Configuration
//public class HttpClientWithWebClient {
//
//    private static final Logger log = LoggerFactory.getLogger(HttpClientWithWebClient.class);
//
//    // TCP connection establishment timeout (milliseconds)
//    private static final int CONNECT_TIMEOUT = 15000;
//
//    // Maximum time to wait for a server response (seconds)
//    private static final int RESPONSE_TIMEOUT = 50;
//
//    // Maximum concurrent connections allowed in the pool
//    private static final int MAX_CONNECTIONS = 200;
//
//    // Maximum time a connection can remain idle before eviction (seconds)
//    private static final int MAX_IDLE_SECONDS = 30;
//
//    // PAPSS client keystore properties (contains private key + certificate)
//    private final String keyStorePath;
//    private final String keyStorePassword;
//    private final String keyStoreType;
//
//    // PAPSS truststore properties (trusted server certificates)
//    private final String trustStorePath;
//    private final String trustStorePassword;
//    private final String trustStoreType;
//
//    // SSL behaviour flags
//    private final boolean trustAllCertificates;
//    private final boolean skipHostnameVerification;
//
//    public HttpClientWithWebClient(
//            @Value("${papss.signing.key-store}") String keyStorePath,
//            @Value("${papss.signing.key-store-password}") String keyStorePassword,
//            @Value("${papss.signing.key-store-type}") String keyStoreType,
//            @Value("${papss.ssl.trust-store}") String trustStorePath,
//            @Value("${papss.ssl.trust-store-password}") String trustStorePassword,
//            @Value("${papss.ssl.trust-store-type}") String trustStoreType,
//            @Value("${http.ssl.trust-all:false}") boolean trustAllCertificates,
//            @Value("${http.ssl.skip-hostname-verification:false}") boolean skipHostnameVerification
//    ) {
//        this.keyStorePath = keyStorePath;
//        this.keyStorePassword = keyStorePassword;
//        this.keyStoreType = keyStoreType;
//        this.trustStorePath = trustStorePath;
//        this.trustStorePassword = trustStorePassword;
//        this.trustStoreType = trustStoreType;
//        this.trustAllCertificates = trustAllCertificates;
//        this.skipHostnameVerification = skipHostnameVerification;
//    }
//
//    // =========================================================
//    // PAPSS WEBCLIENT (mTLS + configurable validation)
//    // =========================================================
//    @Bean(name = "papssWebClient")
//    public WebClient papssWebClient() {
//
//        log.info("Creating PAPSS WebClient with SSL configuration.");
//
//        try {
//
//            // Create dedicated connection pool for PAPSS outbound traffic
//            ConnectionProvider provider = ConnectionProvider.builder("papss-pool")
//                    .maxConnections(MAX_CONNECTIONS)                // Maximum concurrent active connections
//                    .maxIdleTime(Duration.ofSeconds(MAX_IDLE_SECONDS)) // Idle eviction threshold
//                    .evictInBackground(Duration.ofSeconds(20))     // Background cleanup interval
//                    .build();
//
//            // Build SSL context using mTLS and truststore configuration
//            SslContext sslContext = buildPapssSslContext();
//
//            // Create Reactor Netty HttpClient with timeout and SSL configuration
//            HttpClient httpClient = HttpClient.create(provider)
//                    .option(ChannelOption.CONNECT_TIMEOUT_MILLIS, CONNECT_TIMEOUT) // TCP connect timeout
//                    .responseTimeout(Duration.ofSeconds(RESPONSE_TIMEOUT))         // Response read timeout
//                    .secure(sslSpec -> {
//
//                        sslSpec.sslContext(sslContext);     // Attach SSL context
//                        sslSpec.protocols("TLSv1.2");       // Restrict to TLSv1.2 (same as Apache setup)
//
//                        // Apply hostname verification behaviour
//                        if (skipHostnameVerification) {
//                            log.warn("Hostname verification DISABLED.");
//                            sslSpec.defaultConfiguration(SslProvider.DefaultConfigurationType.NONE);
//                        } else {
//                            log.info("Hostname verification ENABLED.");
//                            sslSpec.defaultConfiguration(SslProvider.DefaultConfigurationType.TCP);
//                        }
//                    });
//
//            // Build WebClient with the configured HttpClient
//            return WebClient.builder()
//                    .clientConnector(new ReactorClientHttpConnector(httpClient))
//                    .build();
//
//        } catch (Exception e) {
//
//            // Log full stacktrace for operational visibility
//            log.error("Failed to initialize PAPSS WebClient.", e);
//
//            // Fail fast if SSL configuration is invalid
//            throw new RuntimeException("Unable to create PAPSS WebClient.", e);
//        }
//    }
//
//    // =========================================================
//    // FINACLE WEBCLIENT (trust-all internal TLS)
//    // =========================================================
//    @Bean(name = "finacleWebClient")
//    public WebClient finacleWebClient() {
//
//        log.warn("Creating FINACLE WebClient with TRUST-ALL SSL configuration.");
//
//        try {
//
//            // Create dedicated connection pool for Finacle outbound traffic
//            ConnectionProvider provider = ConnectionProvider.builder("finacle-pool")
//                    .maxConnections(MAX_CONNECTIONS)
//                    .maxIdleTime(Duration.ofSeconds(MAX_IDLE_SECONDS))
//                    .evictInBackground(Duration.ofSeconds(20))
//                    .build();
//
//            // Build SSL context that trusts all certificates (internal environment)
//            SslContext sslContext = SslContextBuilder.forClient()
//                    .trustManager(InsecureTrustManagerFactory.INSTANCE)
//                    .build();
//
//            // Create HttpClient configured with trust-all SSL
//            HttpClient httpClient = HttpClient.create(provider)
//                    .option(ChannelOption.CONNECT_TIMEOUT_MILLIS, CONNECT_TIMEOUT)
//                    .responseTimeout(Duration.ofSeconds(RESPONSE_TIMEOUT))
//                    .secure(sslSpec -> {
//                        sslSpec.sslContext(sslContext); // Attach insecure SSL context
//                        sslSpec.protocols("TLSv1.2");   // Enforce TLSv1.2
//                        sslSpec.defaultConfiguration(SslProvider.DefaultConfigurationType.NONE); // Disable hostname verification
//                    });
//
//            return WebClient.builder()
//                    .clientConnector(new ReactorClientHttpConnector(httpClient))
//                    .build();
//
//        } catch (Exception e) {
//
//            log.error("Failed to initialize FINACLE WebClient.", e);
//            throw new RuntimeException("Unable to create FINACLE WebClient.", e);
//        }
//    }
//
//    // =========================================================
//    // SSL CONTEXT BUILDER FOR PAPSS (mTLS)
//    // =========================================================
//    private SslContext buildPapssSslContext() throws Exception {
//
//        // Load client keystore containing private key and certificate
//        KeyStore keyStore = KeyStore.getInstance(keyStoreType);
//        try (FileInputStream fis = new FileInputStream(keyStorePath)) {
//            keyStore.load(fis, keyStorePassword.toCharArray());
//        }
//        log.info("Loaded PAPSS client keystore from {}", keyStorePath);
//
//        // Initialize KeyManagerFactory for client authentication (mTLS)
//        KeyManagerFactory kmf = KeyManagerFactory.getInstance(KeyManagerFactory.getDefaultAlgorithm());
//        kmf.init(keyStore, keyStorePassword.toCharArray());
//
//        // Prepare SSL context builder with client key material
//        SslContextBuilder builder = SslContextBuilder.forClient()
//                .keyManager(kmf);
//
//        // Apply trust-all flag if enabled
//        if (trustAllCertificates) {
//
//            log.warn("Trust-all SSL mode ENABLED.");
//            builder.trustManager(InsecureTrustManagerFactory.INSTANCE);
//
//        } else {
//
//            // Load truststore containing trusted certificate authorities
//            KeyStore trustStore = KeyStore.getInstance(trustStoreType);
//            try (FileInputStream fis = new FileInputStream(trustStorePath)) {
//                trustStore.load(fis, trustStorePassword.toCharArray());
//            }
//            log.info("Loaded PAPSS truststore from {}", trustStorePath);
//
//            // Initialize TrustManagerFactory for server certificate validation
//            TrustManagerFactory tmf = TrustManagerFactory.getInstance(TrustManagerFactory.getDefaultAlgorithm());
//            tmf.init(trustStore);
//
//            builder.trustManager(tmf);
//        }
//
//        // Build final SSL context
//        return builder.build();
//    }
//}
