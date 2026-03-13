package com.equitybank.gag.papss.its.scheduler;

import com.equitybank.gag.papss.its.pojo.papssMessages.InboundMessageReqObject;
import com.equitybank.gag.papss.its.service.PapssIdResolverService;
import com.equitybank.gag.papss.its.service.PapssInboundMessageRouterService;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

import static com.equitybank.gag.papss.its.config.StatusCodeMessages.*;

/**
 * Periodically polls PAPSS inbound endpoint for new messages (GET /papss/Message).
 * Logs all response headers line by line, handles EMPTY placeholders, and routes valid messages.
 */
@Service
public class InboundPollingService {
    private static final Logger log = LoggerFactory.getLogger(InboundPollingService.class);

    private final String papssInboundUrl;
    private final CloseableHttpClient closeableHttpClient;
    private final PapssIdResolverService papssIdResolverService;
    private final PapssInboundMessageRouterService papssInboundMessageRouterService;

    public InboundPollingService(@Value("${service.urls.common-url}") String papssInboundUrl,
                                 CloseableHttpClient closeableHttpClient,
                                 PapssIdResolverService papssIdResolverService,
                                 PapssInboundMessageRouterService papssInboundMessageRouterService) {
        this.papssInboundUrl = papssInboundUrl;
        this.closeableHttpClient = closeableHttpClient;
        this.papssIdResolverService = papssIdResolverService;
        this.papssInboundMessageRouterService = papssInboundMessageRouterService;
    }

    // After startup, wait 4s then run. After each run finishes, wait 5s before running again.
    @Scheduled(fixedDelayString = "${polling.delay.ms:5000}", initialDelayString = "${polling.initial.delay.ms:4000}")
    public void pollInboundMessages() {
        log.info("Inbound Polling PAPSS Messages Started At {}...", LocalDateTime.now());

        try {
            HttpGet httpGet = new HttpGet(papssInboundUrl);
            httpGet.addHeader("X-PAPSSRTP-Channel", papssIdResolverService.resolvePapssId());
            httpGet.addHeader("X-PAPSSRTP-Version", PAPSS_RTP_VERSION);
            httpGet.addHeader("Accept", "*/*");

            try (CloseableHttpResponse response = closeableHttpClient.execute(httpGet)) {
                int statusCode = response.getStatusLine().getStatusCode();
                String statusMsg = response.getStatusLine().getReasonPhrase();

                if (statusCode != 200) {
                    log.error("PAPSS returned Non-200 for {}. \nStatusCode: {} \nStatusMsg: {}", papssInboundUrl, statusCode, statusMsg);
                    log.info("Poll ended at {}", LocalDateTime.now());
                    return;
                }

                // Log headers one per line for clarity
                log.info("======== PAPSS Received Request Headers ========");
                for (Header header : response.getAllHeaders()) {
                    log.info("[Header] {}: {}", header.getName(), header.getValue());
                }
                log.info("======== PAPSS Received Request Headers ========");

                // Extract response body and status marker
                HttpEntity entity = response.getEntity();
                String body = entity != null ? EntityUtils.toString(entity).trim() : "";
                String reqStatus = getHeader(response, "X-PAPSSRTP-ReqSts", "").trim();

                // Determine if PAPSS returned an empty/no-message result
                boolean isEmpty = reqStatus.equalsIgnoreCase("EMPTY")  // Explicit PAPSS marker
                                || body.isEmpty()                                  // Empty body or whitespace
                                || body.equalsIgnoreCase("null")       // Some LBs return literal null
                                || body.equalsIgnoreCase("<html/>")    // HTML tag means no inbound message
                                || body.toLowerCase().contains("<html");           // Any HTML means no inbound message

                if (isEmpty) {
                    log.info("PAPSS returned no inbound messages. Body is EMPTY.");
                    log.info("Message polling ended at {}", LocalDateTime.now());
                    return;
                }

                // Extract message headers
                String messageType = getHeader(response, "X-PAPSSRTP-MessageType");
                String messageSequence = getHeader(response, "X-PAPSSRTP-MessageSeq");
                String possibleDuplicate = getHeader(response, "X-PAPSSRTP-PossibleDuplicate");

                // If X-PAPSSRTP-PossibleDuplicate header is missing, treat the transaction as new
                if (possibleDuplicate == null || possibleDuplicate.isBlank()) {
                    log.warn("{}: Missing X-PAPSSRTP-PossibleDuplicate header - treating request as a new transaction.", messageSequence);
                    possibleDuplicate = "false";
                }

                log.info("Received message Details: \nmessageType={} \nmessageSequence={} \npossibleDuplicate={} \nXmlBody={}", messageType, messageSequence, possibleDuplicate, body);

                // Dispatch message for routing
                log.info("{}: Routing the received request to the router service...", messageSequence);
                InboundMessageReqObject inboundReq = new InboundMessageReqObject(messageType, messageSequence, body);
                papssInboundMessageRouterService.route(inboundReq, Boolean.parseBoolean(possibleDuplicate));

                log.info("{}: {} Request routed successfully.", messageSequence, messageType);
            }

        } catch (Exception e) {
            log.error("Polling error: {}", e.getMessage(), e);
        }

        log.info("Poll ended at {}", LocalDateTime.now());
    }

    private String getHeader(CloseableHttpResponse res, String name) {
        return getHeader(res, name, null);
    }

    private String getHeader(CloseableHttpResponse res, String name, String def) {
        return res.getFirstHeader(name) != null ? res.getFirstHeader(name).getValue() : def;
    }
}
