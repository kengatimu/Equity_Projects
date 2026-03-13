/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.service.business;

import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.dto.africell.TokenResp;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.service.util.MiscUtil;
import com.google.gson.Gson;
import jakarta.xml.bind.DatatypeConverter;
import java.security.KeyManagementException;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.List;
import javax.net.ssl.SSLContext;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.StatusLine;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.NoopHostnameVerifier;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Component;

/**
 *
 * @author ronaldcheruiyot
 */
@Slf4j
@Component
public class AfricellUtil {
    
    @Value("${africell.cd.token.url}")
    private String africellTokenURL;
    @Value("${africell.cd.registration.token.url}")
    private String africellRegistrationTokenURL;
    @Value("${africell.cd.token.consumerKey}")
    private String consumerKey;
    @Value("${africell.cd.token.consumerSecret}")
    private String consumerSecret;
    @Value("${africell.cd.registration.token.consumerKey}")
    private String registrationConsumerKey;
    @Value("${africell.cd.registration.token.consumerSecret}")
    private String registrationConsumerSecret;
//    @Value("${africell.cd.userID}")
    
    public String getAfricellRegistrationToken() {
//        return "Y01wQ2ZfTTdHbEdTeGZXVmkzRlRKMk5lV3NzYTp5WHh3Zjc4dURCSWVjUFV2b043dzV4NW5XMDRh";
        
//        String basicToken = registrationConsumerKey.trim() + ":" + registrationConsumerSecret.trim();
//        String basicToken = "Y01wQ2ZfTTdHbEdTeGZXVmkzRlRKMk5lV3NzYTp5WHh3Zjc4dURCSWVjUFV2b043dzV4NW5XMDRh";
//        log.info("AUTH:...:" + basicToken);
//        String encoded = DatatypeConverter.printBase64Binary(basicToken.getBytes());
        String encoded = "Y01wQ2ZfTTdHbEdTeGZXVmkzRlRKMk5lV3NzYTp5WHh3Zjc4dURCSWVjUFV2b043dzV4NW5XMDRh";
//        log.info("AUTH:...:" + basicToken);

        try (CloseableHttpClient httpclient = useTrustingTrustManager()) {
            HttpPost req = new HttpPost(africellRegistrationTokenURL);
            req.addHeader("Content-Type", "application/x-www-form-urlencoded");
            req.addHeader("Authorization", "Basic " + encoded);
            log.info("AUTH(ENCODED):...:" + encoded);
            log.info("SENDING... Get Token Request");
            
            List<NameValuePair> nameValuePairList = new ArrayList<>();
            nameValuePairList.add(new BasicNameValuePair("grant_type", "client_credentials"));

            req.setEntity(new UrlEncodedFormEntity(nameValuePairList, "utf-8"));
            MiscUtil.printHeaders(req.getAllHeaders(), "registrationToken");
            log.info("******REQUEST EXECUTE** ");
            try (CloseableHttpResponse response = httpclient.execute(req)) {
                StatusLine status = response.getStatusLine();
                System.out.println("STATUS CODE FROM " + africellRegistrationTokenURL + " " + status.getStatusCode());

                HttpEntity respEntity = response.getEntity();
                if (respEntity != null) {
                    String responseStr = EntityUtils.toString(respEntity);
                    log.info("DUMP:..Start");
                    log.info(responseStr);
                    log.info("DUMP:..End");
                    if (responseStr != null) {
                        log.info("Access token found!");
                        TokenResp token = (new Gson()).fromJson(responseStr, TokenResp.class);
                        return token.getAccess_token();
                    } else log.info("Access token NOT found.");
                } else log.info("respEntity for token is null");
            }
        } catch (Exception e) {
            log.error("Exception: {}", e.getMessage());
        }
        return null;

    }
    
    public String getAfricellToken() {
        
        String basicToken = consumerKey.trim() + ":" + consumerSecret.trim();
        log.info("AUTH:...:" + basicToken);
        String encoded = DatatypeConverter.printBase64Binary(basicToken.getBytes());

        try (CloseableHttpClient httpclient = useTrustingTrustManager()) {
            HttpPost req = new HttpPost(africellTokenURL);
            req.addHeader("Content-Type", "application/x-www-form-urlencoded");
            req.addHeader("Authorization", "Basic " + encoded);

            log.info("SENDING... Get Token Request");

            List<NameValuePair> nameValuePairList = new ArrayList<>();
            nameValuePairList.add(new BasicNameValuePair("grant_type", "client_credentials"));

            req.setEntity(new UrlEncodedFormEntity(nameValuePairList, "utf-8"));

            log.info("******REQUEST EXECUTE** ");
            try (CloseableHttpResponse response = httpclient.execute(req)) {
                StatusLine status = response.getStatusLine();
                System.out.println("STATUS CODE FROM " + africellTokenURL + " " + status.getStatusCode());

                HttpEntity respEntity = response.getEntity();
                if (respEntity != null) {
                    String responseStr = EntityUtils.toString(respEntity);
                    log.info("DUMP:..Start");
                    log.info(responseStr);
                    log.info("DUMP:..End");
                    if (responseStr != null) {
                        log.info("Access token found!");
                        TokenResp token = (new Gson()).fromJson(responseStr, TokenResp.class);
                        return token.getAccess_token();
                    } else log.info("Access token NOT found.");
                } else log.info("respEntity for token is null");
            }
        } catch (Exception e) {
            log.error("Exception: {}", e.getMessage());
        }
        return null;
    }
    
    public CloseableHttpClient useTrustingTrustManager() {
        try {
            System.setProperty("sun.security.ssl.allowUnsafeRenegotiation", "true");
            // Trust strategy accepting all certificates
            org.apache.hc.core5.ssl.TrustStrategy acceptingTrustStrategy = new org.apache.hc.core5.ssl.TrustStrategy() {
                @Override
                public boolean isTrusted(X509Certificate[] chain, String authType) throws CertificateException {
                    return true;
                }
            };
            SSLContext sslContext = org.apache.hc.core5.ssl.SSLContexts.custom().loadTrustMaterial(null, acceptingTrustStrategy).build();

            SSLConnectionSocketFactory csf = new SSLConnectionSocketFactory(sslContext, NoopHostnameVerifier.INSTANCE);
            CloseableHttpClient httpClient = HttpClients.custom().setSSLSocketFactory(csf).build();

            return httpClient;
        } catch (KeyManagementException | KeyStoreException | NoSuchAlgorithmException t) {
            t.printStackTrace(System.out);

            return null;
        }

    }
    
}
