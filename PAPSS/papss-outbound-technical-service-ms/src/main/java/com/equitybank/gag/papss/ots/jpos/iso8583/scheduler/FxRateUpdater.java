package com.equitybank.gag.papss.ots.jpos.iso8583.scheduler;

import com.equitybank.gag.papss.ots.exception.CustomException;
import com.equitybank.gag.papss.ots.service.FinacleFxRateService;
import com.equitybank.gag.papss.ots.service.ISOPayloadXmlComposerService;
import com.equitybank.gag.papss.ots.service.ISOSignatureGenerationService;
import org.apache.http.Header;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

import static com.equitybank.gag.papss.ots.config.ApplicationConstants.*;

@Service
public class FxRateUpdater {

    private static final Logger log = LoggerFactory.getLogger(FxRateUpdater.class);

    // PAPSS FX Rate update endpoint
    private final String papssPostFxRateUrl;

    // PAPSS fx rate name
    private final String papssFxRateName;

    // PAPSS id
    private final String papssId;

    // PAPSS HTTP client (mTLS + PAPSS trust config)
    private final CloseableHttpClient httpClient;

    // XML composer for FX rate update payload
    private final ISOPayloadXmlComposerService xmlComposerService;

    // XML digital signature service
    private final ISOSignatureGenerationService signatureGenerationService;

    // Finacle FX rate fetcher
    private final FinacleFxRateService finacleFxRateService;

    public FxRateUpdater(@Value("${service.urls.post-fx-rate-url}") String papssPostFxRateUrl,
                         @Value("${papss.fx-rate-name}") String papssFxRateName,
                         @Value("${papss.equity-bank-id}") String papssId,
                         @Qualifier("closeableHttpClient") CloseableHttpClient httpClient,
                         ISOPayloadXmlComposerService xmlComposerService,
                         ISOSignatureGenerationService signatureGenerationService,
                         FinacleFxRateService finacleFxRateService) {
        this.papssPostFxRateUrl = papssPostFxRateUrl;
        this.papssFxRateName = papssFxRateName;
        this.papssId = papssId;
        this.httpClient = httpClient;
        this.xmlComposerService = xmlComposerService;
        this.signatureGenerationService = signatureGenerationService;
        this.finacleFxRateService = finacleFxRateService;
    }

    // For fixed delay use this
     @Scheduled(fixedDelayString = "${fx-rate.delay.ms:300000}", initialDelayString = "${polling.initial.delay.ms:4000}")

    // Cron: Runs at 09:00 and 16:00, Monday to Friday (treasury working hours)
//    @Scheduled(cron = "0 0 9,16 ? * MON-FRI")
    public void postFxRate() {

        LocalDateTime startTime = LocalDateTime.now();
        log.info("FX Rate posting job started at {}", startTime);

        boolean success = false;
        String failureReason = null;

        try {
            // Fetch USD/KES FX rates from Finacle
            Map<String, String> finacleRatesMap;
            try {
                finacleRatesMap = finacleFxRateService.fetchUsdKesRates();
            } catch (Exception e) {
                failureReason = "Aborted FX update — failed to fetch rates from Finacle: " + e.getMessage();
                log.error(failureReason);
                return; // Do not proceed to PAPSS
            }

            // Prepare mandatory PAPSS FX rate attributes
            Map<String, String> fxRateParamsMap = new HashMap<>();
            fxRateParamsMap.put("accountType", DEFAULT_LOCAL_INSTRUMENT_CODE);
            fxRateParamsMap.put("countryCode", DEFAULT_COUNTRY_CODE);
            fxRateParamsMap.put("localCurrency", DEFAULT_LOCAL_CURRENCY);
            fxRateParamsMap.put("fxRateName", papssFxRateName);

            // Inject buy/sell rates fetched from Finacle
            fxRateParamsMap.putAll(finacleRatesMap);

            // Build unsigned FX rate update XML
            String fxRateXml = xmlComposerService.composeFxRateUpdateRequest(fxRateParamsMap);

            // Digitally sign the FX rate update payload
            String signedXml = signatureGenerationService.generateXMLDigitalSignature("FXRATE", fxRateXml, "FX_RATE_UPDATE");
            log.info("Signed Fx Rate Update Xml For PAPSS: {}", signedXml);

            // Prepare PAPSS HTTP POST request
            HttpPost post = new HttpPost(papssPostFxRateUrl);
            post.addHeader("X-PAPSSRTP-Channel", papssId);
            post.addHeader("X-PAPSSRTP-Version", PAPSS_RTP_VERSION);
            post.addHeader("Content-Type", "application/xml");
            post.setEntity(new StringEntity(signedXml, StandardCharsets.UTF_8));

            log.info("Sending FX Rate Update request to PAPSS via url: {}", papssPostFxRateUrl);
            try (CloseableHttpResponse response = httpClient.execute(post)) {

                int httpStatus = response.getStatusLine().getStatusCode();
                String httpStatusMsg = response.getStatusLine().getReasonPhrase();
                String responseBody = response.getEntity() != null
                        ? EntityUtils.toString(response.getEntity(), StandardCharsets.UTF_8)
                        : null;

                // Log PAPSS response headers for traceability
                log.info("======== PAPSS Response Headers ========");
                for (Header header : response.getAllHeaders()) {
                    log.info("[Header] {}: {}", header.getName(), header.getValue());
                }
                log.info("======== PAPSS Response Headers ========");

                // Centralized response logging
                log.info(String.format(HTTP_RESPONSE_LOG_TEMPLATE, httpStatus, httpStatusMsg, responseBody));

                // Treat any non-2xx as failure
                if (httpStatus >= 300) {
                    throw new CustomException("PAPSS rejected FX update with HTTP " + httpStatus);
                }
            }

            success = true;

        } catch (Exception e) {
            failureReason = "FX Rate posting job failed: " + e.getMessage();
            log.error(failureReason);
        } finally {
            // Always log job completion status
            if (success) {
                log.info("FX Rate posting job completed SUCCESSFULLY at {}", LocalDateTime.now());
            } else {
                log.warn("FX Rate posting job completed with FAILURE at {}. Reason: {}", LocalDateTime.now(), failureReason != null ? failureReason : "Unknown");
            }
        }
    }
}
