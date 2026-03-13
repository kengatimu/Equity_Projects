package com.equitybank.gag.dummy_telco_b2c_ms.config;

import org.apache.catalina.connector.Connector;
import org.apache.coyote.http11.Http11NioProtocol;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.boot.web.server.Ssl;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class HTTPSConfigs {

    private final int httpPort;
    private final int httpsPort;
    private final String keyAlias;
    private final String keyStore;
    private final boolean sslEnabled;
    private final String keyStoreType;
    private final String keyStorePassword;

    public HTTPSConfigs(@Value("${http.port}") int httpPort,
                        @Value("${https.port}") int httpsPort,
                        @Value("${server.ssl.key-alias}") String keyAlias,
                        @Value("${server.ssl.key-store}") String keyStore,
                        @Value("${server.ssl.enabled}") boolean sslEnabled,
                        @Value("${server.ssl.key-store-type}") String keyStoreType,
                        @Value("${server.ssl.key-store-password}") String keyStorePassword) {
        this.httpPort = httpPort;
        this.httpsPort = httpsPort;
        this.keyAlias = keyAlias;
        this.keyStore = keyStore;
        this.sslEnabled = sslEnabled;
        this.keyStoreType = keyStoreType;
        this.keyStorePassword = keyStorePassword;
    }

    @Bean
    public TomcatServletWebServerFactory servletContainer() {
        TomcatServletWebServerFactory factory = new TomcatServletWebServerFactory();

        // Add HTTP connector (port 8072)
        factory.addAdditionalTomcatConnectors(createHttpConnector());

        // Enable HTTPS (port 8443)
        Ssl ssl = new Ssl();
        ssl.setEnabled(sslEnabled);
        ssl.setKeyStore(keyStore);
        ssl.setKeyStorePassword(keyStorePassword);
        ssl.setKeyStoreType(keyStoreType);
        ssl.setKeyAlias(keyAlias);
        factory.setSsl(ssl);
        factory.setPort(httpsPort);

        return factory;
    }

    private Connector createHttpConnector() {
        Connector connector = new Connector(Http11NioProtocol.class.getName());
        connector.setScheme("http");
        connector.setPort(httpPort);
        connector.setSecure(false);
        return connector;
    }
}
