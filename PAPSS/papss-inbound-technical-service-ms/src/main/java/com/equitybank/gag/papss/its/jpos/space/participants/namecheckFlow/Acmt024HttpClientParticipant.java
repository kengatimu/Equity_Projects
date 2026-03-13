package com.equitybank.gag.papss.its.jpos.space.participants.namecheckFlow;

import com.equitybank.gag.papss.its.enums.TransactionStatus;
import com.equitybank.gag.papss.its.jpos.space.configs.JposConstants;
import com.equitybank.gag.papss.its.service.PapssIdResolverService;
import com.equitybank.gag.papss.its.service.PayloadXmlComposerService;
import com.equitybank.gag.papss.its.service.SendAcknowledgementService;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.util.EntityUtils;
import org.jpos.transaction.Context;
import org.jpos.transaction.TransactionParticipant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.core.env.Environment;

import java.io.Serializable;
import java.nio.charset.StandardCharsets;

import static com.equitybank.gag.papss.its.config.StatusCodeMessages.*;
import static com.equitybank.gag.papss.its.enums.PapssStatusCodes.RJCT;
import static com.equitybank.gag.papss.its.enums.TransactionStatus.FAILURE;

public final class Acmt024HttpClientParticipant implements TransactionParticipant {
    private static final Logger log = LoggerFactory.getLogger(Acmt024HttpClientParticipant.class);

    private SendAcknowledgementService sendAcknowledgementService;
    private CloseableHttpClient closeableHttpClient;
    private PapssIdResolverService papssIdResolverService;
    private String papssUrl;

    public Acmt024HttpClientParticipant() {
        try {
            ApplicationContext context = com.equitybank.gag.papss.its.jpos.space.configs.SpringBeanLoader.getApplicationContext();
            if (context == null) {
                log.error("Spring ApplicationContext is null.");
                return;
            }

            this.sendAcknowledgementService = context.getBean(SendAcknowledgementService.class);
            this.closeableHttpClient = (CloseableHttpClient) context.getBean("closeableHttpClient");
            this.papssIdResolverService = context.getBean(PapssIdResolverService.class);
            Environment env = context.getEnvironment();
            this.papssUrl = env.getProperty("service.urls.common-url");

            log.info("Acmt024HttpClientParticipant initialized. PAPSS URL={}", papssUrl);
        }
        catch (Exception e) {
            log.error("Failed to initialize Acmt024HttpClientParticipant: {}", e.getMessage(), e);
        }
    }

    @Override
    public int prepare(long id, Serializable serialisedContext) {
        Context ctx = (Context) serialisedContext;
        String rrn = (String) ctx.get(JposConstants.RRN);

        // For pacs008 message, go to the next participant
        String stateKey = ctx.get(JposConstants.STATE_KEY);
        if ("pacs008".equalsIgnoreCase(stateKey)) {
            return PREPARED;
        }

        log.info("{}: Starting Acmt024HttpClient Participant.", rrn);

        String xml = (String) ctx.get(JposConstants.SIGNED_ACMT_RESPONSE_XML_CONTEXT);
        if (xml == null || xml.isEmpty()) {
            updateJposContext(ctx, rrn, "No signed acmt.024 XML response in context.");
            return ABORTED;
        }

        if (papssUrl == null || papssUrl.isEmpty()) {
            updateJposContext(ctx, rrn, "PAPSS URL missing in config.");
            return ABORTED;
        }

        if (closeableHttpClient == null) {
            updateJposContext(ctx, rrn, "HttpClient bean is null.");
            return ABORTED;
        }

        HttpPost post = buildAcmt024HttpPost(papssUrl, xml);
        log.info("{}: Posting acmt.024 to PAPSS: {}", rrn, papssUrl);
        log.info("{}: Post Body: {}", rrn, xml);

        try (CloseableHttpResponse response = closeableHttpClient.execute(post)) {
            // Log Response Headers
            String ipsStatus = null;
            Header[] headers = response.getAllHeaders();

            if (headers != null && headers.length > 0) {
                log.info("{}: PAPSS Response Headers", rrn);

                for (Header h : headers) {
                    log.info("{}: {} = {}", rrn, h.getName(), h.getValue());
                }

                log.info("{}: END HEADERS", rrn);

                // Extract X-PAPSSRTP-ReqSts header
                Header ipsStatusHeader = response.getFirstHeader("X-PAPSSRTP-ReqSts");
                if (ipsStatusHeader != null) {
                    ipsStatus = ipsStatusHeader.getValue();
                    log.info("{}: X-PAPSSRTP-ReqSts = {}", rrn, ipsStatus);
                } else {
                    log.info("{}: X-PAPSSRTP-ReqSts header not present", rrn);
                }

            } else {
                log.info("{}: No headers returned from PAPSS.", rrn);
            }

            int statusCode = response.getStatusLine().getStatusCode();
            String reason = response.getStatusLine().getReasonPhrase();

            HttpEntity entity = response.getEntity();
            String responseStr = (entity != null)
                    ? EntityUtils.toString(entity, StandardCharsets.UTF_8)
                    : "";

            log.info(String.format(HTTP_RESPONSE_LOG_TEMPLATE, statusCode, reason, responseStr));

            // Acknowledge receipt --- Namecheck don;t require ack, so sendAck flag is false
            sendAcknowledgementService.sendAck(false,true, rrn, ACMT0023_MESSAGE_TYPE, ctx);

            // Store response
            ctx.put(JposConstants.SENT_PAPSS_STATUS_CODE, ipsStatus);
            ctx.put(JposConstants.PAPSS_HTTP_STATUS_CODE, statusCode);
            ctx.put(JposConstants.TXN_STATUS, TransactionStatus.SUCCESS);

            // Cleanup
            ctx.put(JposConstants.SIGNED_ACMT_RESPONSE_XML_CONTEXT, "");
            ctx.put(JposConstants.REQUEST_PAYLOAD_CONTEXT, "");
            ctx.put(JposConstants.HTTP_POSTING_REQUIRED_ON_ABORT, false); // to avoid sending papss with error response

            // To safely exit the namecheck flow, use Aborted with No_Join. Otherwise, Prepared will call transaction flow
            return ABORTED | NO_JOIN;
        }
        catch (Exception e) {
            log.error("{}: Exception posting acmt.023: {}", rrn, e.getMessage(), e);
            updateJposContext(ctx, rrn, "Exception posting acmt.023: " + e.getMessage());
            return ABORTED;
        }
    }

    @Override
    public void commit(long id, Serializable serialisedContext) {
        // Nothing to do
    }

    @Override
    public void abort(long id, Serializable serialisedContext) {
        // Nothing to do
    }

    private HttpPost buildAcmt024HttpPost(String url, String xmlPayload) {
        HttpPost post = new HttpPost(url);
        post.setHeader("X-PAPSSRTP-Channel", papssIdResolverService.resolvePapssId());
        post.setHeader("X-PAPSS-RTP-Version", PAPSS_RTP_VERSION);
        post.setHeader("X_PAPSSRTP_MessageType", ACMT0023_MESSAGE_TYPE);
        post.setHeader("Accept", "*/*");
        post.setHeader("Accept-Encoding", "gzip");
        post.setHeader("Content-Type", "application/xml");
        post.setEntity(new StringEntity(xmlPayload, StandardCharsets.UTF_8));
        return post;
    }

    // Helper to update context with error/status
    private void updateJposContext(Context ctx, String rrn, String statusMessage) {
        log.error("{}: {}", rrn, statusMessage);

        TransactionStatus status = FAILURE;

        // Default: send RJCT status to PAPSS after abort
        ctx.put(JposConstants.HTTP_POSTING_REQUIRED_ON_ABORT, true);

        // Handle timeout cases separately
        if (statusMessage != null &&
                (statusMessage.contains("timeout")
                        || statusMessage.contains("time out")
                        || statusMessage.contains("timed out"))) {

            status = TransactionStatus.TIMEOUT;

            // For timeouts, do NOT send RJCT status to PAPSS after abort
            ctx.put(JposConstants.HTTP_POSTING_REQUIRED_ON_ABORT, false);
        }

        // Core transaction status fields
        ctx.put(JposConstants.STATUS_MESSAGE, statusMessage);
        ctx.put(JposConstants.TXN_STATUS, status);
        ctx.put(JposConstants.STATUS_CODE, status.getCode());

        // PAPSS-side error fields
        ctx.put(JposConstants.SENT_PAPSS_STATUS_CODE, RJCT);
        ctx.put(JposConstants.PAPSS_ERROR_CODE, DEFAULT_PAPSS_ERROR_CODE);
        ctx.put(JposConstants.PAPSS_ERROR_MESSAGE, DEFAULT_PAPSS_ERROR_MESSAGE);

        // Name-check never requires Finacle reversal
        ctx.put(JposConstants.NEEDS_FINACLE_REVERSAL, false);
    }

}
