package com.equitybank.gag.papss.its.jpos.space.participants;

import com.equitybank.gag.papss.its.entity.FinacleTransaction;
import com.equitybank.gag.papss.its.entity.TransactionMaster;
import com.equitybank.gag.papss.its.enums.PapssStatusCodes;
import com.equitybank.gag.papss.its.enums.TransactionStatus;
import com.equitybank.gag.papss.its.enums.TransactionType;
import com.equitybank.gag.papss.its.exception.CustomException;
import com.equitybank.gag.papss.its.jpos.jposService.ISOMessageBuilderService;
import com.equitybank.gag.papss.its.jpos.jposService.ISOMsgSerializerAndDeserializerService;
import com.equitybank.gag.papss.its.jpos.jposService.SendToFinacleService;
import com.equitybank.gag.papss.its.jpos.space.configs.JposConstants;
import com.equitybank.gag.papss.its.jpos.space.configs.SpringBeanLoader;
import com.equitybank.gag.papss.its.service.*;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.util.EntityUtils;
import org.jpos.iso.ISOMsg;
import org.jpos.transaction.AbortParticipant;
import org.jpos.transaction.Context;
import org.jpos.transaction.TransactionParticipant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.core.env.Environment;

import java.io.IOException;
import java.io.Serializable;
import java.nio.charset.StandardCharsets;
import java.time.OffsetDateTime;
import java.util.Map;

import static com.equitybank.gag.papss.its.config.StatusCodeMessages.*;
import static com.equitybank.gag.papss.its.enums.PapssStatusCodes.*;
import static com.equitybank.gag.papss.its.enums.TransactionStatus.FINACLE_DEBITED;
import static com.equitybank.gag.papss.its.enums.TransactionStatus.TIMEOUT;
import static com.equitybank.gag.papss.its.jpos.space.configs.JposConstants.*;

/**
 * Handles TransactionManager abort events:
 * - Sends PAPSS RJCT responses (acmt.024 / pacs.002)
 * - Sends Finacle reversal when required
 * - Updates DB with final failure status
 */
public final class TransactionErrorHandlingParticipant implements TransactionParticipant, AbortParticipant {

    private static final Logger log = LoggerFactory.getLogger(TransactionErrorHandlingParticipant.class);

    // Injected dependencies
    private Map<String, String> finacleErrorMapping;
    private CloseableHttpClient closeableHttpClient;
    private PapssIdResolverService papssIdResolverService;
    private ISOMessageBuilderService isoMessageBuilderService;
    private PayloadXmlComposerService payloadXmlComposerService;
    private SendAcknowledgementService sendAcknowledgementService;
    private ISOSignatureGenerationService isoSignatureGenerationService;
    private ISOMsgSerializerAndDeserializerService isoMsgSerializerAndDeserializerService;
    private SendToFinacleService sendToFinacleService;
    private DatabaseService databaseService;

    private String papssUrl;

    public TransactionErrorHandlingParticipant() {
        // Load beans from Spring
        ApplicationContext context = SpringBeanLoader.getApplicationContext();

        if (context == null) {
            log.error("ApplicationContext is null.");
            return;
        }

        try {
            Environment env = context.getEnvironment();
            this.finacleErrorMapping = (Map<String, String>) context.getBean("finacleErrorMapping");
            this.closeableHttpClient = context.getBean(CloseableHttpClient.class);
            this.papssIdResolverService = context.getBean(PapssIdResolverService.class);
            this.isoMessageBuilderService = context.getBean(ISOMessageBuilderService.class);
            this.payloadXmlComposerService = context.getBean(PayloadXmlComposerService.class);
            this.sendAcknowledgementService = context.getBean(SendAcknowledgementService.class);
            this.isoSignatureGenerationService = context.getBean(ISOSignatureGenerationService.class);
            this.isoMsgSerializerAndDeserializerService = context.getBean(ISOMsgSerializerAndDeserializerService.class);
            this.sendToFinacleService = context.getBean(SendToFinacleService.class);
            this.databaseService = context.getBean(DatabaseService.class);
            this.papssUrl = env.getProperty("service.urls.common-url");

            log.info("TransactionErrorHandlingParticipant initialized. PAPSS URL: {}", papssUrl);
        } catch (Exception e) {
            log.error("Failed to initialize TransactionErrorHandlingParticipant: {}", e.getMessage());
        }
    }

    @Override
    public int prepare(long id, Serializable ctxObj) {
        Context ctx = (Context) ctxObj;
        String rrn = (String) ctx.get(RRN);
        log.info("{}: Prepare phase reached — nothing to do.", rrn);
        return PREPARED;
    }

    @Override
    public void commit(long id, Serializable ctxObj) {
        Context ctx = (Context) ctxObj;
        String rrn = (String) ctx.get(RRN);
        log.info("{}: Commit phase (no action required).", rrn);
    }

    @Override
    public void abort(long id, Serializable ctxObj) {
        Context ctx = (Context) ctxObj;
        String rrn = (String) ctx.get(RRN);
        String originalType = (String) ctx.get(MESSAGE_TYPE);

        log.info("{}: Abort initiated — starting failure handling.", rrn);

        try {
            // NameCheck abort
            if (ACMT0023_MESSAGE_TYPE.equalsIgnoreCase(originalType)) {
                ctx.put(REQUEST_PAYLOAD_CONTEXT, ""); // Remove request payload from context
                sendPapssReject(ctx, rrn, ACMT0024_MESSAGE_TYPE, originalType);
                removeContextInfo(ctx);
                logJposContext(rrn, ctx);
                return;
            }

            // Credit Transfer abort
            if (PACS008_MESSAGE_TYPE.equalsIgnoreCase(originalType)) {
                ctx.put(REQUEST_PAYLOAD_CONTEXT, ""); // Remove request payload from context
                handlePacsAbort(ctx, rrn, originalType);
                removeContextInfo(ctx);
                logJposContext(rrn, ctx);
                return;
            }

            log.warn("{}: Unknown message type '{}'. No abort handler applied.", rrn, originalType);

        } catch (Exception e) {
            updateJposContext(ctx, rrn, "Abort Exception: " + e.getMessage());
            removeContextInfo(ctx);
            logJposContext(rrn, ctx);
            log.error("{}: Abort exception: {}", rrn, e.getMessage());
        }
    }

    private void handlePacsAbort(Context ctx, String rrn, String originalType) throws Exception {
        // Optional: send Finacle reversal
        if (Boolean.TRUE.equals(ctx.get(NEEDS_FINACLE_REVERSAL))) {
            sendFinacleReversal(ctx, rrn);
        }

        // Send PACS002 RJCT
        sendPapssReject(ctx, rrn, PACS002_MESSAGE_TYPE, originalType);

        // Final DB update
        updateDatabaseOnAbort(ctx, rrn);
    }

    private void sendPapssReject(Context ctx, String rrn, String messageType, String originalType) throws Exception {
        // Determine request map + reject type
        String requestMapKey;
        String rejectType;

        // If PAPSS reject posting is disabled for this txn
        Boolean postRequired = (Boolean) ctx.get(HTTP_POSTING_REQUIRED_ON_ABORT);
        log.info("{}: HTTP_POSTING_REQUIRED_ON_ABORT? {}",rrn, postRequired);

        if (postRequired != null && !postRequired) {
            log.info("{}: PAPSS posting skipped. Sending ACK only.", rrn);
            sendACKToPapps(rrn, originalType, ctx);
            removeContextInfo(ctx);
            logJposContext(rrn, ctx);
            return;
        }

        if (ACMT0024_MESSAGE_TYPE.equals(messageType)) {
            requestMapKey = NAMECHECK_REQUEST_MAP;
            rejectType = "acmt024";
        } else if (PACS002_MESSAGE_TYPE.equals(messageType)) {
            requestMapKey = PACS008_REQUEST_MAP;
            rejectType = "pacs002";
        } else {
            log.warn("{}: Unsupported RJCT message type {}", rrn, messageType);
            return;
        }

        @SuppressWarnings("unchecked")
        Map<String, String> requestMap = (Map<String, String>) ctx.get(requestMapKey);
        log.info("{}: {} Request Map Details: {}", rrn, originalType, requestMap);

        if (requestMap == null || requestMap.isEmpty()) {
            log.warn("{}: Missing request map. Cannot build RJCT message. Sending ACK only.", rrn);
            sendACKToPapps(rrn, originalType, ctx);
            return;
        }

        String errorCode = (String) ctx.get(PAPSS_ERROR_CODE);
        if (errorCode == null || errorCode.isBlank()) errorCode = DEFAULT_PAPSS_ERROR_CODE;

        // Compose XML
        log.info("{}: Preparing {} response xml", rrn, rejectType);
        String failureXml = rejectType.equals("acmt024")
                ? payloadXmlComposerService.composeAcmt024NamecheckFailureResponse(rrn, requestMap, errorCode)
                : payloadXmlComposerService.composePacs002FailureResponse(requestMap, errorCode);

        // Sign XML
        log.info("{}: Signing {} response xml", rrn, rejectType);
        String type = resolveTransactionType(rrn, ctx);
        String signedXml = isoSignatureGenerationService.generateXMLDigitalSignature(rrn, failureXml, type);

        // Send to PAPSS
        HttpPost post = buildHttpPost(papssUrl, signedXml, messageType);
        sendPostResponseToPapss(rrn, messageType, post, ctx, papssUrl, signedXml);

        // Always send ACK after RJCT except for timeouts
        TransactionStatus status = ctx.get(JposConstants.TXN_STATUS);
        if (status != null && !status.equals(TIMEOUT)) {
            sendACKToPapps(rrn, originalType, ctx);
        }
    }

    private void sendACKToPapps(String rrn, String messageType, Context ctx) {
        if ("acmt.023".equalsIgnoreCase(messageType)) {
            sendAcknowledgementService.sendAck(false, true, rrn, messageType, ctx);
            log.info("{}: Message type {} does not require ACK to be sent.", rrn, messageType);
        } else {
            log.info("{}: Sending ACK for {}...", rrn, messageType);
            sendAcknowledgementService.sendAck(true, true, rrn, messageType, ctx);
        }
    }

    private String resolveTransactionType(String rrn, Context ctx) {
        String type = (String) ctx.get(MESSAGE_TYPE);

        if (type == null || type.isBlank()) {
            log.warn("{}: MESSAGE_TYPE missing in context.", rrn);
            return "";
        }
        if (type.contains(ACMT0023_MESSAGE_TYPE)) return TransactionType.NAMECHECK.name();
        if (type.contains(PACS008_MESSAGE_TYPE)) return TransactionType.CREDIT_TRANSFER.name();

        log.warn("{}: Unknown MESSAGE_TYPE '{}'.", rrn, type);
        return "";
    }

    private HttpPost buildHttpPost(String url, String xmlPayload, String messageType) {
        HttpPost post = new HttpPost(url);
        post.setHeader("X-PAPSSRTP-Channel", papssIdResolverService.resolvePapssId());
        post.setHeader("X-PAPSSRTP-MessageType", messageType);
        post.setHeader("X-PAPSS-RTP-Version", PAPSS_RTP_VERSION);
        post.setHeader("X-PAPSSRTP-ReqSts", RJCT.name());
        post.setHeader("Content-Type", "application/xml");
        post.setHeader("Accept", "*/*");
        post.setHeader("Accept-Encoding", "gzip");
        post.setEntity(new StringEntity(xmlPayload, StandardCharsets.UTF_8));
        return post;
    }

    private void sendPostResponseToPapss(String rrn, String messageType, HttpPost post, Context ctx, String papssUrl, String signedXml) throws IOException {
        log.info("{}: Posting {} RJCT to PAPSS: {}", rrn, messageType, papssUrl);
        log.info("{}: Post Body: {}", rrn, signedXml);

        try (CloseableHttpResponse response = closeableHttpClient.execute(post)) {
            HttpEntity entity = response.getEntity();

            int statusCode = response.getStatusLine().getStatusCode();
            String statusMsg = response.getStatusLine().getReasonPhrase();
            String body = entity != null ? EntityUtils.toString(entity, StandardCharsets.UTF_8) : "";

            log.info(String.format(HTTP_RESPONSE_LOG_TEMPLATE, statusCode, statusMsg, body));
            ctx.put(PAPSS_HTTP_STATUS_CODE, statusCode);
        }
    }

    private void sendFinacleReversal(Context ctx, String rrn) throws CustomException {
        log.info("{}: Starting Finacle Reversal", rrn);

        // Load the latest DB record
        TransactionMaster entity;
        try {
            entity = databaseService.getSavedRecord(rrn, TransactionType.CREDIT_TRANSFER);
            ctx.put(TRANSACTION_ENTITY_CONTEXT, entity);
        } catch (Exception e) {
            log.error("{}: Failed loading DB record for reversal: {}", rrn, e.getMessage());
            return;
        }

        // Build reversal ISO
        ISOMsg reversalRequest = isoMessageBuilderService.buildReversalMessage(rrn);
        entity.getTransactionPayload().setFinTxnReversalIsoRequest(isoMsgSerializerAndDeserializerService.serializeISOMsg(reversalRequest));

        // Send reversal
        ISOMsg reversalResponse = sendToFinacleService.sendReversalRequest(rrn, reversalRequest, DEFAULT_BANK_ID_KE, TransactionType.CREDIT_TRANSFER);
        entity.getTransactionPayload().setFinTxnReversalIsoResponse(isoMsgSerializerAndDeserializerService.serializeISOMsg(reversalResponse));

        // Process result
        String f39 = reversalResponse.getString(39);
        if (f39 == null || f39.isBlank()) {
            log.error("{}: Finacle reversal response missing field 39. Aborting.", rrn);
            throw new CustomException("Missing F39 from Finacle reversal response.");
        }
        if ("000".equals(f39)) {
            log.info("{}: Finacle reversal successful", rrn);
            updateReversalStatus(ctx, rrn, entity, TransactionStatus.REVERSED_OK, null);
        } else {
            String desc = finacleErrorMapping.getOrDefault(f39, "Unknown Finacle error: " + f39);
            updateReversalStatus(ctx, rrn, entity, TransactionStatus.REVERSED_NOK, desc);
            log.error("{}: Finacle reversal failed with status: {} - {}", rrn, f39, desc);
            throw new CustomException("Finacle reversal failed with status: " + f39 + " - " + desc);
        }
    }

    private void updateReversalStatus(Context ctx, String rrn, TransactionMaster entity, TransactionStatus status, String failureReason) {

        OffsetDateTime now = OffsetDateTime.now();
        String desc = failureReason != null ? "Abort reversal failed: " + failureReason : status.getDescription();

        FinacleTransaction finTxn = entity.getFinacleTransaction();
        finTxn.setReversalStatus(status);
        finTxn.setReversalResponseCode(status.getCode());
        finTxn.setReversalResponseDesc(desc);
        finTxn.setUpdatedAt(now);
        finTxn.setReversalCompletedAt(now);

        entity.setFinacleStatus(status);
        entity.setFinacleResponseCode(status.getCode());
        entity.setFinacleResponseMessage(desc);
        entity.setCompletedAt(now);

        ctx.put(TRANSACTION_ENTITY_CONTEXT, entity);
        log.info("{}: Reversal status updated: {}", rrn, status);
    }

    private void updateDatabaseOnAbort(Context ctx, String rrn) {
        log.info("{}: Abort triggered. Updating DB.", rrn);

        try {
            // Load the latest DB record for safe updates
            TransactionMaster entity;
            try {
                entity = databaseService.getSavedRecord(rrn, TransactionType.CREDIT_TRANSFER);
                ctx.put(TRANSACTION_ENTITY_CONTEXT, entity);
            } catch (Exception e) {
                // Cannot continue without a DB record
                updateJposContext(ctx, rrn, "Could not load original DB record: " + e.getMessage());
                return;
            }

            // Default error message
            String msg = (String) ctx.get(PAPSS_ERROR_MESSAGE);
            if (msg == null || msg.isBlank()) msg = TransactionStatus.FAILURE.getDescription();

            TransactionStatus ctxStatus = ctx.get(JposConstants.TXN_STATUS);

            // Default outcome for abort
            TransactionStatus finalStatus = TransactionStatus.FAILURE;
            String finalCode = TransactionStatus.FAILURE.getCode();
            String finalMessage = msg;

            // Timeout means ACSC was not delivered to PAPSS
            if (TransactionStatus.TIMEOUT.equals(ctxStatus)) {
                finalStatus = TransactionStatus.TIMEOUT;
                finalCode = TransactionStatus.TIMEOUT.getCode();
                finalMessage = "Timeout occurred while sending pacs002 response to PAPSS.";
            }

            // Update core transaction status
            entity.setStatus(finalStatus);
            entity.setResponseCode(finalCode);
            entity.setResponseMessage(finalMessage);
            entity.setCompletedAt(OffsetDateTime.now());

            // IPS-level status: PENDING when ACSC not delivered, RJCT for all other failures
            if (TransactionStatus.TIMEOUT.equals(finalStatus)) {
                entity.setIpsStatus(PDNG.name());
                entity.setIpsStatusCode(PDNG.name());
            } else {
                entity.setIpsStatus(RJCT.name());
                entity.setIpsStatusCode(RJCT.name());
            }

            entity.setIpsStatusReason(finalMessage);
            entity.setIpsStatusDescription(finalMessage);

            // Persist updates
            databaseService.updateDbRecord(entity);
            log.info("{}: DB update complete. Final status={}.", rrn, finalStatus);

        } catch (Exception e) {
            log.error("{}: DB update failure in abort handler: {}", rrn, e.getMessage());
        }
    }

    private void updateJposContext(Context ctx, String rrn, String statusMessage) {
        log.error("{}: {}", rrn, statusMessage);

        String errorCode = (String) ctx.get(PAPSS_ERROR_CODE);
        if (errorCode == null) errorCode = DEFAULT_PAPSS_ERROR_CODE;

        String errorMsg = (String) ctx.get(PAPSS_ERROR_MESSAGE);
        if (errorMsg == null) errorMsg = DEFAULT_PAPSS_ERROR_MESSAGE;

        ctx.put(STATUS_MESSAGE, statusMessage);
        ctx.put(TXN_STATUS, TransactionStatus.FAILURE);
        ctx.put(STATUS_CODE, TransactionStatus.FAILURE.getCode());
        ctx.put(PAPSS_ERROR_CODE, errorCode);
        ctx.put(PAPSS_ERROR_MESSAGE, errorMsg);

        // Remove from context
        ctx.put(REQUEST_PAYLOAD_CONTEXT, "[requestPayloadContext content excluded]");
        ctx.put(ISO_MESSAGE_FINACLE_REQUEST, "[isoMessageFinacleRequest content excluded]");
        ctx.put(ISO_MESSAGE_FINACLE_RESPONSE, "[isoMessageFinacleResponse content excluded]");
        ctx.put(PACS008_REQUEST_MAP, "[pacs008RequestMap content excluded]");
    }

    private void removeContextInfo(Context ctx) {
        // Remove from context
        ctx.put(REQUEST_PAYLOAD_CONTEXT, "[requestPayloadContext content excluded]");
        ctx.put(ISO_MESSAGE_FINACLE_REQUEST, "[isoMessageFinacleRequest content excluded]");
        ctx.put(ISO_MESSAGE_FINACLE_RESPONSE, "[isoMessageFinacleResponse content excluded]");
        ctx.put(PACS008_REQUEST_MAP, "[pacs008RequestMap content excluded]");
    }

    private void logJposContext(String rrn, Context ctx) {
        log.info("===== TransactionErrorHandling Participant: Transaction Summary Status ====");
        log.info("{}: Status: {}", rrn, ctx.get(TXN_STATUS));
        log.info("{}: Status Message: {} ", rrn, ctx.get(STATUS_MESSAGE));
        log.info("{}: Papss Error Code: {} ", rrn, ctx.get(PAPSS_ERROR_CODE));
        log.info("{}: Papss Error Message: {}", rrn, ctx.get(PAPSS_ERROR_MESSAGE));
        log.info("===== TransactionErrorHandling Participant: Transaction Summary Status ====");
    }
}
