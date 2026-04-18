package com.equitybankgroup.retail.loanpayment.service;

import org.apache.commons.lang3.StringUtils;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLContexts;
import org.apache.http.conn.ssl.TrustStrategy;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Service;

import javax.net.ssl.SSLContext;
import java.security.KeyStore;
import java.util.List;

import org.apache.http.HttpEntity;
import org.apache.http.client.config.RequestConfig;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@Service
public class HttpUtls {

    Logger lg = LogManager.getLogger(this.getClass().getName());

    public String postRequestWithCredentails(String url, String data, List<String> headerValues, String credentails) {
        String xml_response = "";
        // Create a new HttpClient and Post Header
        CloseableHttpClient httpclient = null;
        httpclient = HttpClients.custom().build();
        try {
            // String url_endpoint = "";
            SSLConnectionSocketFactory sscsf;
            if (StringUtils.contains(url, "https")) {
                TrustStrategy trustStrategy = new TrustStrategy() {
                    public boolean isTrusted(java.security.cert.X509Certificate[] x509Certificates, String string) {
                        //
                        return true;
                    }
                };
                KeyStore ks = KeyStore.getInstance("JKS");
                SSLContext sslcontext = SSLContexts.custom().loadTrustMaterial(ks, trustStrategy).build();
                sscsf = new SSLConnectionSocketFactory(sslcontext,
                        SSLConnectionSocketFactory.ALLOW_ALL_HOSTNAME_VERIFIER);
                httpclient = HttpClients.custom().setSSLSocketFactory(sscsf).build();
            }

            HttpPost httppost = new HttpPost(url);
            String encoding = new String(java.util.Base64.getEncoder().encode(credentails.getBytes())); //  .encode ("test1:test1");
            httppost.setHeader("Authorization", "Basic " + encoding);
            httppost.setEntity(new StringEntity(data));//, "UTF-8"
            for (String str : headerValues) {
                try {
                    String[] split = StringUtils.split(str, ":");
                    httppost.setHeader(split[0], split[1]);
                    lg.info(split[0] + ":" + split[1]);
                } catch (Exception e) {
                }
            }

            CloseableHttpResponse response = httpclient.execute(httppost);
            try {
                HttpEntity resEntity = response.getEntity();

                if (resEntity != null) {
                    xml_response = EntityUtils.toString(resEntity);
                }
                EntityUtils.consume(resEntity);
            } catch (Exception e) {
            } finally {
                response.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                httpclient.close();
            } catch (Exception e) {
            }
        }

        try {
            lg.info("Request URl: " + url + "********* Request: " + data + "************Response: " + xml_response);
        } catch (Exception e) {
        }
        return xml_response;
    }

    public String postRequest(String url, String data, List<String> headerValues) {
        String xml_response = "";
        // Create a new HttpClient and Post Header
        CloseableHttpClient httpclient = null;
        httpclient = HttpClients.custom().build();
        try {
            // String url_endpoint = "";
            SSLConnectionSocketFactory sscsf;
            if (StringUtils.startsWith(url, "https")) {
                TrustStrategy trustStrategy = new TrustStrategy() {
                    public boolean isTrusted(java.security.cert.X509Certificate[] x509Certificates, String string) {
                        return true;
                    }
                };
                KeyStore ks = KeyStore.getInstance("JKS");
                SSLContext sslcontext = SSLContexts.custom().loadTrustMaterial(ks, trustStrategy).build();
                sscsf = new SSLConnectionSocketFactory(sslcontext,
                        SSLConnectionSocketFactory.ALLOW_ALL_HOSTNAME_VERIFIER);
                httpclient = HttpClients.custom().setSSLSocketFactory(sscsf).build();
            }

            HttpPost httppost = new HttpPost(url);
            try {
                //@TODO use per url timeout period, store timeout in a db
                RequestConfig.Builder reqConfig = RequestConfig.custom();
                reqConfig.setConnectTimeout(30000);
                reqConfig.setConnectionRequestTimeout(50000);
                reqConfig.setSocketTimeout(30000);
                httppost.setConfig(reqConfig.build());
            } catch (Exception e) {
            }
            httppost.setEntity(new StringEntity(data));//, "UTF-8"
            for (String str : headerValues) {
                try {
                    String[] split = StringUtils.split(str, ":");
                    httppost.setHeader(split[0], split[1]);
                } catch (Exception e) {
                }
            }

            CloseableHttpResponse response = httpclient.execute(httppost);
            try {
                HttpEntity resEntity = response.getEntity();

                if (resEntity != null) {
                    xml_response = EntityUtils.toString(resEntity);
                }
                EntityUtils.consume(resEntity);
            } catch (Exception e) {
            } finally {
                response.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                httpclient.close();
            } catch (Exception e) {
            }
        }
        try {
            lg.info("Request URl: " + url + "********* Request: " + data + "************Response: " + xml_response);
        } catch (Exception e) {
        }
        return xml_response;
    }
}
