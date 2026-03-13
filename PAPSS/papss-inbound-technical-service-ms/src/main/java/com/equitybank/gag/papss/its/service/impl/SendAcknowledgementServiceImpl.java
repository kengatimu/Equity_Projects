package com.equitybank.gag.papss.its.service.impl;

import com.equitybank.gag.papss.its.entity.TransactionMaster;
import com.equitybank.gag.papss.its.enums.TransactionStatus;
import com.equitybank.gag.papss.its.enums.TransactionType;
import com.equitybank.gag.papss.its.jpos.space.configs.JposConstants;
import com.equitybank.gag.papss.its.service.DatabaseService;
import com.equitybank.gag.papss.its.service.PapssIdResolverService;
import com.equitybank.gag.papss.its.service.SendAcknowledgementService;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.util.EntityUtils;
import org.jpos.transaction.Context;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.nio.charset.StandardCharsets;

import static com.equitybank.gag.papss.its.config.StatusCodeMessages.*;
import static com.equitybank.gag.papss.its.enums.TransactionStatus.TIMEOUT;

@Service
public class SendAcknowledgementServiceImpl implements SendAcknowledgementService {
    private final static Logger log = LoggerFactory.getLogger(SendAcknowledgementServiceImpl.class);

    private final PapssIdResolverService papssIdResolverService;
    private final CloseableHttpClient closeableHttpClient;
    private final DatabaseService databaseService;
    private final String papssACKUrl;

    public SendAcknowledgementServiceImpl(PapssIdResolverService papssIdResolverService,
                                          CloseableHttpClient closeableHttpClient,
                                          DatabaseService databaseService,
                                          @Value("${service.urls.ack-url}") String papssACKUrl) {
        this.papssIdResolverService = papssIdResolverService;
        this.closeableHttpClient = closeableHttpClient;
        this.databaseService = databaseService;
        this.papssACKUrl = papssACKUrl;
    }

    @Override
    public void sendAck(Boolean sendAck, Boolean sequenceExists, String messageSeq, String messageType, Context ctx) {
        if (!sendAck) {
            return;
        }
        try {
            TransactionMaster entity;
            try {
                // Get the current transaction status
                entity = databaseService.getSavedRecord(messageSeq, TransactionType.CREDIT_TRANSFER);
            } catch (Exception e) {
                // Papss possible duplicate flag true for pacs.008 request, but no DB record in our system.
                // Continue to Sending ACK only.
                log.info("Sending {} ACKMessage To Papss for Message Sequence - {} via URL - {}", messageType, messageSeq, papssACKUrl);
                HttpPost post = buildHttpPost(papssACKUrl, messageSeq, sequenceExists);
                postToPapss(messageSeq, post, ctx);
                return;
            }

            // If sending original response to papss timed out, do not send ack
            TransactionStatus transactionStatus = ctx.get(JposConstants.TXN_STATUS);
            if (transactionStatus == null) {
                transactionStatus = entity.getStatus();
            }

            // Do not send ACK if ACSC timed out
            if (transactionStatus.equals(TIMEOUT)) {
                log.info("{}: Could not send original response to papss due to timeout. ACK cannot be sent", messageSeq);
                return;
            }

            log.info("Sending {} ACKMessage To Papss for Message Sequence - {} via URL - {}", messageType, messageSeq, papssACKUrl);

            // Build and send HTTP ACK to PAPSS
            HttpPost post = buildHttpPost(papssACKUrl, messageSeq, sequenceExists);
            postToPapss(messageSeq, post, ctx);
        } catch (Exception e) {
            log.error("{}: Exception occurred when sending {} acknowledgement to PAPSS: {}", messageSeq, messageType, e.getMessage());
        }
    }

    private HttpPost buildHttpPost(String url, String messageSeq, Boolean sequenceExists) {
        String bodyText = !sequenceExists ? "NotFound" : "Stored";
        log.info("{}: ACK Body Text: {}", messageSeq, bodyText);

        // Create HTTP POST request with PAPSS-specific headers
        HttpPost post = new HttpPost(url);
        post.setHeader("X-PAPSSRTP-Channel", papssIdResolverService.resolvePapssId());
        post.setHeader("X-PAPSSRTP-MessageSeq", messageSeq);
        post.setHeader("X-PAPSS-RTP-Version", PAPSS_RTP_VERSION);
        post.setHeader("Accept", "*/*");
        post.setEntity(new StringEntity(bodyText, StandardCharsets.UTF_8));
        return post;
    }

    private void postToPapss(String messageSeq, HttpPost post, Context ctx) throws IOException {
        // Execute HTTP POST and capture PAPSS response
        try (CloseableHttpResponse response = closeableHttpClient.execute(post)) {
            HttpEntity httpEntity = response.getEntity();
            int statusCode = response.getStatusLine().getStatusCode();
            String httpStatusMsg = response.getStatusLine().getReasonPhrase();
            String papssResponseString = httpEntity != null ? EntityUtils.toString(httpEntity, StandardCharsets.UTF_8) : "";

            // Log HTTP response details
            log.info(String.format(HTTP_RESPONSE_LOG_TEMPLATE, statusCode, httpStatusMsg, papssResponseString));

            // Save HTTP response in context for auditing
            ctx.put(JposConstants.PAPSS_HTTP_ACK_STATUS_CODE, statusCode);
            ctx.put(JposConstants.PAPSS_HTTP_ACK_RESPONSE_STRING, papssResponseString);
        }
        log.info("{}: ACK sent.", messageSeq);
    }
}
