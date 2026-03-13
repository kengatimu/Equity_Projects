package com.equitybank.gag.papss.ots.service.impl;

import com.equitybank.gag.papss.ots.exception.CustomException;
import com.equitybank.gag.papss.ots.service.FinacleFxRateService;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

import javax.xml.XMLConstants;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.ByteArrayInputStream;
import java.math.RoundingMode;
import java.math.BigDecimal;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import static com.equitybank.gag.papss.ots.config.ApplicationConstants.HTTP_RESPONSE_LOG_TEMPLATE;

@Service
public class FinacleFxRateServiceImpl implements FinacleFxRateService {

    private static final Logger log = LoggerFactory.getLogger(FinacleFxRateServiceImpl.class);

    // Finacle-specific HTTP client (no PAPSS mTLS)
    private final CloseableHttpClient httpClient;

    // Finacle FIXML endpoint
    private final String finacleFxUrl;

    public FinacleFxRateServiceImpl(@Qualifier("closeableHttpClient_finacle") CloseableHttpClient httpClient,
                                    @Value("${finacle.fi.ke-url}") String finacleFxUrl) {
        this.httpClient = httpClient;
        this.finacleFxUrl = finacleFxUrl;
    }

    @Override
    public Map<String, String> fetchUsdKesRates() throws CustomException {

        try {
            // TTS = sell rate
            BigDecimal sellRate = fetchRateByCode("TTS");

            // TTB = buy rate
            BigDecimal buyRate = fetchRateByCode("TTB");

            // Log the rates
            log.info("Finacle USD/KES FX ratesMap resolved: BUY(TTB)={} SELL(TTS)={}", buyRate, sellRate);

            Map<String, String> ratesMap = new HashMap<>();
            ratesMap.put("sellRate", String.valueOf(sellRate));
            ratesMap.put("buyRate", String.valueOf(buyRate));
            return ratesMap;

        } catch (Exception e) {
            // Any failure here aborts PAPSS FX update upstream
            throw new CustomException("Failed to fetch FX rates from Finacle: " + e.getMessage());
        }
    }

    private BigDecimal fetchRateByCode(String rateCode) throws Exception {

        log.info("Building Finacle FX request for rateCode={}", rateCode);

        String requestXml = buildRequestXml(rateCode);
        log.debug("Finacle FX request payload: {}", requestXml);

        HttpPost post = new HttpPost(finacleFxUrl);
        post.setHeader("Content-Type", "application/xml");
        post.setEntity(new StringEntity(requestXml, StandardCharsets.UTF_8));

        try (CloseableHttpResponse response = httpClient.execute(post)) {

            int httpStatus = response.getStatusLine().getStatusCode();
            String httpStatusMsg = response.getStatusLine().getReasonPhrase();
            String responseXml = EntityUtils.toString(response.getEntity(), StandardCharsets.UTF_8);

            // Centralised HTTP response logging
            log.info(String.format(HTTP_RESPONSE_LOG_TEMPLATE, httpStatus, httpStatusMsg, responseXml));

            // Transport-level failure (TLS / network / HTTP)
            if (httpStatus >= 300) {
                throw new CustomException("Finacle FX HTTP failure for rateCode=" + rateCode + ", httpStatus=" + httpStatus);
            }

            // Business-level failure still comes back as HTTP 200
            validateFinacleBusinessSuccess(responseXml, rateCode);

            // Extract numeric FX rate
            return extractAmountValue(responseXml);
        }
    }

    private String buildRequestXml(String rateCode) {

        // Finacle requires unique RequestUUID per call
        String requestUUID = "Req_" + UUID.randomUUID().toString().replace("-", "");

        // Finacle accepts ISO-8601 local timestamp
        String dateTime = LocalDateTime.now().toString();

        return """
                <?xml version="1.0" encoding="UTF-8"?>
                <FIXML xmlns="http://www.finacle.com/fixml"
                       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
                  <Header>
                    <RequestHeader>
                      <MessageKey>
                        <RequestUUID>%s</RequestUUID>
                        <ServiceRequestId>getExchangeRateForRateCode</ServiceRequestId>
                        <ServiceRequestVersion>10.2</ServiceRequestVersion>
                        <ChannelId>TPG</ChannelId>
                      </MessageKey>
                      <RequestMessageInfo>
                        <BankId>54</BankId>
                        <MessageDateTime>%s</MessageDateTime>
                      </RequestMessageInfo>
                    </RequestHeader>
                  </Header>
                  <Body>
                    <getExchangeRateForRateCodeRequest>
                      <ExchangeRateForRateCodeInputVO>
                        <fromCrncyCode>KES</fromCrncyCode>
                        <rateCode>%s</rateCode>
                        <toCrncyCode>USD</toCrncyCode>
                        <txnAmount>
                          <amountValue>1</amountValue>
                        </txnAmount>
                      </ExchangeRateForRateCodeInputVO>
                    </getExchangeRateForRateCodeRequest>
                  </Body>
                </FIXML>
                """.formatted(requestUUID, dateTime, rateCode);
    }

    private void validateFinacleBusinessSuccess(String responseXml, String rateCode) throws Exception {

        Document doc = parseXml(responseXml);

        // Any Error / ErrorCode / ErrorDesc indicates business failure
        NodeList errorNodes = doc.getElementsByTagNameNS("*", "Error");
        NodeList errorCodeNodes = doc.getElementsByTagNameNS("*", "ErrorCode");
        NodeList errorDescNodes = doc.getElementsByTagNameNS("*", "ErrorDesc");

        if ((errorNodes != null && errorNodes.getLength() > 0)
                || (errorCodeNodes != null && errorCodeNodes.getLength() > 0)
                || (errorDescNodes != null && errorDescNodes.getLength() > 0)) {

            String errorCode = extractFirstTagValue(doc, "ErrorCode");
            String errorDesc = extractFirstTagValue(doc, "ErrorDesc");

            throw new CustomException("Finacle FX failed for rateCode=" + rateCode + " [" + errorCode + "] " + errorDesc);
        }
    }

    private BigDecimal extractAmountValue(String responseXml) throws Exception {

        Document doc = parseXml(responseXml);

        // Primary source: outputAmount/amountValue
        NodeList amountNodes = doc.getElementsByTagNameNS("*", "amountValue");
        if (amountNodes != null && amountNodes.getLength() > 0) {
            String value = amountNodes.item(0).getTextContent();
            if (value != null && !value.isBlank()) {
                return new BigDecimal(value.trim()).setScale(2, RoundingMode.HALF_UP);
            }
        }

        // Fallback: varCrncyUnits carries the same effective rate
        NodeList varUnitsNodes = doc.getElementsByTagNameNS("*", "varCrncyUnits");
        if (varUnitsNodes != null && varUnitsNodes.getLength() > 0) {
            String value = varUnitsNodes.item(0).getTextContent();
            if (value != null && !value.isBlank()) {
                log.warn("amountValue missing — using varCrncyUnits as fallback");
                return new BigDecimal(value.trim()).setScale(2, RoundingMode.HALF_UP);
            }
        }

        throw new CustomException("Finacle FX response missing amountValue and varCrncyUnits");
    }

    private Document parseXml(String xml) throws Exception {

        // Create a namespace-aware XML factory (required for Finacle FIXML)
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        factory.setNamespaceAware(true);

        // Disallow DOCTYPE declarations to prevent XXE payloads
        factory.setFeature("http://apache.org/xml/features/disallow-doctype-decl", true);

        // Disable resolution of external general entities
        factory.setFeature("http://xml.org/sax/features/external-general-entities", false);

        // Disable resolution of external parameter entities
        factory.setFeature("http://xml.org/sax/features/external-parameter-entities", false);

        // Prevent loading of external DTDs during parsing
        factory.setFeature("http://apache.org/xml/features/nonvalidating/load-external-dtd", false);

        // Disable XInclude processing
        factory.setXIncludeAware(false);

        // Prevent entity expansion inside the XML document
        factory.setExpandEntityReferences(false);

        // Enable JAXP secure processing limits to mitigate DoS attacks (e.g. billion laughs)
        factory.setFeature(XMLConstants.FEATURE_SECURE_PROCESSING, true);

        // Explicitly block access to external DTDs
        factory.setAttribute(XMLConstants.ACCESS_EXTERNAL_DTD, "");

        // Explicitly block access to external XML schemas
        factory.setAttribute(XMLConstants.ACCESS_EXTERNAL_SCHEMA, "");

        // Build the hardened document builder
        return factory.newDocumentBuilder().parse(new ByteArrayInputStream(xml.getBytes(StandardCharsets.UTF_8)));
    }

    private String extractFirstTagValue(Document doc, String tagName) {

        // Namespace-agnostic lookup
        NodeList nodes = doc.getElementsByTagNameNS("*", tagName);

        if (nodes != null && nodes.getLength() > 0) {
            String value = nodes.item(0).getTextContent();
            return value != null ? value.trim() : null;
        }

        return null;
    }
}
