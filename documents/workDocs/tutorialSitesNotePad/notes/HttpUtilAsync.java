package com.equitybank.payments.interbank.outbound.utils;

import com.equitybank.payments.interbank.outbound.pojo.error.ErrorStatus;
import com.microsoft.applicationinsights.TelemetryClient;
import org.apache.http.conn.ssl.TrustSelfSignedStrategy;
import org.apache.http.ssl.SSLContexts;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.net.ssl.SSLContext;
import java.io.IOException;
import java.io.InputStream;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.security.*;
import java.security.cert.CertificateException;
import java.util.concurrent.CompletableFuture;

@Service
public class HttpUtilAsync {
    private static final Logger logger = LoggerFactory.getLogger(HttpUtil.class);

    private final TelemetryClient telemetryClient;

    @Value("${encrypt.key-store.location}")
    private String keystorePath;

    @Value("${encrypt.key-store.alias}")
    private String keyAlias;

    @Value("${encrypt.key-store.password}")
    private String keyPass;

    @Autowired
    public HttpUtilAsync(TelemetryClient telemetryClient) {
        this.telemetryClient = telemetryClient;
    }

    public void postRequest(String data, String beneficiaryAccount, String type, ErrorStatus errorStatus) throws IOException {

        String url = "https://api.start.ipsl.co.ke/iso20022/async/v1/credit-transfer";

        char[] password = keyPass.toCharArray();
        InputStream is;
        KeyStore ks;

        try {
            ks = KeyStore.getInstance(KeyStore.getDefaultType());
            is = getClass().getClassLoader().getResourceAsStream(keystorePath);
            ks.load(is, password);

            SSLContext sslContext = SSLContexts.custom()
                .loadKeyMaterial(ks, password)
                .loadTrustMaterial(null, new TrustSelfSignedStrategy())
                .build();

            HttpClient httpClient = HttpClient.newBuilder()
                .sslContext(sslContext)
                .build();

            HttpRequest mainRequest = HttpRequest.newBuilder()
                .POST(HttpRequest.BodyPublishers.ofString(data))
                .header("Accept", "application/xml")
                .headers("Content-type", "application/xml")
                .uri(URI.create(url))
                .build();

            CompletableFuture<HttpResponse<String>> responseFuture =
                httpClient.sendAsync(mainRequest, HttpResponse.BodyHandlers.ofString());

            responseFuture.whenComplete((res, error) -> {
                if (res != null) {
                    logger.info("onResponse Called");
                    int statCode = res.statusCode();
                    String xmlRes = res.body();

                    logger.info("Request URl: " + url);
                    logger.info("StatusCode::: " + statCode);
                    logger.info("xmlResponse::: " + xmlRes);

                    logger.info("response.toString()::: " + res.toString());


                    logger.info(res.body());
                }
                if (error != null) {
                    logger.info("error.getMessage(): " + error.getMessage());
                    logger.info("error.toString()::: " + error.toString());

                    error.printStackTrace();
                }
            });
        } catch (KeyStoreException | KeyManagementException | UnrecoverableKeyException | IOException | NoSuchAlgorithmException | CertificateException e) {
            e.printStackTrace();
        }
    }
}

