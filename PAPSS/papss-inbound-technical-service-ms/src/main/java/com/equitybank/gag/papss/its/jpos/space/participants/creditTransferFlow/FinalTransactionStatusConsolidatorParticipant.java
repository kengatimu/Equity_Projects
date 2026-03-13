package com.equitybank.gag.papss.its.jpos.space.participants.creditTransferFlow;

import com.equitybank.gag.papss.its.entity.TransactionMaster;
import com.equitybank.gag.papss.its.enums.PapssStatusCodes;
import com.equitybank.gag.papss.its.enums.TransactionStatus;
import com.equitybank.gag.papss.its.enums.TransactionType;
import com.equitybank.gag.papss.its.exception.CustomException;
import com.equitybank.gag.papss.its.jpos.space.configs.JposConstants;
import com.equitybank.gag.papss.its.jpos.space.configs.SpringBeanLoader;
import com.equitybank.gag.papss.its.service.*;
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
import java.util.Map;

import static com.equitybank.gag.papss.its.config.StatusCodeMessages.*;
import static com.equitybank.gag.papss.its.enums.PapssStatusCodes.*;
import static com.equitybank.gag.papss.its.enums.TransactionStatus.*;
import static com.equitybank.gag.papss.its.jpos.space.configs.JposConstants.*;
import static com.equitybank.gag.papss.its.jpos.space.configs.JposConstants.PAPSS_ERROR_MESSAGE;

/**
 * Final participant for pacs.008 inbound credit transfer.
 * - If TRANSACTION_PREPARED = true → builds ACSC pacs.002, signs, sends to PAPSS, updates DB.
 * - If aborts → sets NEEDS_FINACLE_REVERSAL flag so TransactionErrorHandlingParticipant will reverse & send RJCT.
 */
public class FinalTransactionStatusConsolidatorParticipant implements TransactionParticipant {
    private static final Logger log = LoggerFactory.getLogger(FinalTransactionStatusConsolidatorParticipant.class);

    private String papssUrl;
    private CloseableHttpClient httpClient;
    private DatabaseService databaseService;
    private XmlReaderService xmlReaderService;
    private PapssIdResolverService papssIdResolverService;
    private PayloadXmlComposerService payloadXmlComposerService;
    private SendAcknowledgementService sendAcknowledgementService;
    private ISOSignatureGenerationService isoSignatureGenerationService;

    public FinalTransactionStatusConsolidatorParticipant() {
        // Load Spring beans from context
        ApplicationContext context = SpringBeanLoader.getApplicationContext();
        if (context != null) {
            try {
                Environment env = context.getEnvironment();
                this.papssUrl = env.getProperty("service.urls.common-url");
                this.httpClient = (CloseableHttpClient) context.getBean("closeableHttpClient");
                this.databaseService = context.getBean(DatabaseService.class);
                this.databaseService = context.getBean(DatabaseService.class);
                this.xmlReaderService = context.getBean(XmlReaderService.class);
                this.papssIdResolverService = context.getBean(PapssIdResolverService.class);
                this.payloadXmlComposerService = context.getBean(PayloadXmlComposerService.class);
                this.sendAcknowledgementService = context.getBean(SendAcknowledgementService.class);
                this.isoSignatureGenerationService = context.getBean(ISOSignatureGenerationService.class);
                log.info("Spring beans initialized for FinalTransactionStatusConsolidatorParticipant.");
            } catch (Exception e) {
                log.error("Failed to initialize Spring beans: {}", e.getMessage(), e);
            }
        }
    }

    @Override
    public int prepare(long id, Serializable serializable) {
        Context ctx = (Context) serializable;
        String rrn = (String) ctx.get(JposConstants.RRN);

        log.info("{}: Starting FinalTransactionStatusConsolidator Participant.", rrn);

        // Ensure services are available
        if (httpClient == null || databaseService == null || payloadXmlComposerService == null || isoSignatureGenerationService == null || xmlReaderService == null) {
            updateJposContext(ctx, rrn, "Required beans/services not initialized.");
            ctx.put(JposConstants.NEEDS_FINACLE_REVERSAL, true);
            return ABORTED;
        }

        // Transaction has to be prepared successfully from the previous participant before proceeding
        boolean transactionPrepared = Boolean.TRUE.equals((Boolean) ctx.get(JposConstants.TRANSACTION_PREPARED));
        if (!transactionPrepared) {
            updateJposContext(ctx, rrn, "Previous participant set TRANSACTION_PREPARED flag as false.");
            ctx.put(JposConstants.NEEDS_FINACLE_REVERSAL, true);
            return ABORTED;
        }

        // Retrieve requestMap from context
        @SuppressWarnings("unchecked")
        Map<String, String> requestMap = (Map<String, String>) ctx.get(JposConstants.PACS008_REQUEST_MAP);
        if (requestMap == null || requestMap.isEmpty()) {
            updateJposContext(ctx, rrn, "Request map missing from context.");
            ctx.put(JposConstants.NEEDS_FINACLE_REVERSAL, true);
            return ABORTED;
        }

        // Load the latest transaction entity from DB
        TransactionMaster entity;
        try {
            entity = databaseService.getSavedRecord(rrn, TransactionType.CREDIT_TRANSFER);
            ctx.put(JposConstants.TRANSACTION_ENTITY_CONTEXT, entity);
            log.info("{}: Loaded latest TransactionMaster from DB.", rrn);
        } catch (Exception e) {
            updateJposContext(ctx, rrn, "Failed to load latest transaction from DB. Exception occurred: " + e.getMessage());
            ctx.put(JposConstants.NEEDS_FINACLE_REVERSAL, true);
            return ABORTED;
        }

        String pacs002ResponseXml;
        String signedPacs002ResponseXml = "";
        try {
            // Set final db status: Pending. Final status from ips
            setFinalDbStatus(rrn, entity, PENDING);

            // Save record in the DB
            updateDatabase(rrn, entity, "Updating DB with final status: Success");

            // Build ACSC pacs.002
            log.info("{}: Building pacs.002 ACCP message.", rrn);
            pacs002ResponseXml = payloadXmlComposerService.composePacs002SuccessResponse(requestMap);

            // Sign message
            log.info("{}: Signing pacs.002 ACCP message.", rrn);
            signedPacs002ResponseXml = isoSignatureGenerationService.generateXMLDigitalSignature(rrn, pacs002ResponseXml, TransactionType.CREDIT_TRANSFER.name());

            // Send to PAPSS
            log.info("{}: Sending pacs.002 ACCP to PAPSS via URL: {} \nPacs002 XML Body: {}", rrn, papssUrl, signedPacs002ResponseXml);
            HttpPost post = buildPacs002HttpPost(papssUrl, signedPacs002ResponseXml);

            try (CloseableHttpResponse response = httpClient.execute(post)) {
                // Extract HTTP status and response body
                HttpEntity httpEntity = response.getEntity();
                int statusCode = response.getStatusLine().getStatusCode();
                String httpStatusMsg = response.getStatusLine().getReasonPhrase();
                String papssResponseString = httpEntity != null ? EntityUtils.toString(httpEntity, StandardCharsets.UTF_8) : "";

                // Log the HTTP call result
                log.info("\n ==============================================");
                log.info("{}: Received pacs002 response from papss", rrn);
                log.info(String.format(HTTP_RESPONSE_LOG_TEMPLATE, statusCode, httpStatusMsg, papssResponseString));

                // Process the received pacs002 response from papss
                processReceivedPacs002(ctx, rrn, statusCode, papssResponseString);

                // Save HTTP response in context for downstream processing/audit
                ctx.put(JposConstants.PAPSS_HTTP_STATUS_CODE, statusCode);
                ctx.put(JposConstants.PAPSS_HTTP_RESPONSE_STRING, papssResponseString);
                ctx.put(JposConstants.SENT_PAPSS_STATUS_CODE, ACCP.name());
            }

            // Send ACK message to papss
            sendAcknowledgementService.sendAck(true, true, rrn, PACS008_MESSAGE_TYPE, ctx);

            // Log the ack message
            log.info("{}: Sent ACK message for {} to PAPSS.", rrn, PACS008_MESSAGE_TYPE);

            // Log the final completion message
            log.info("{}: FinalTransactionStatusConsolidatorParticipant completed successfully.", rrn);

            // Update jpos context
            updateSuccessJposContext(ctx, rrn, SUCCESS.getDescription());
            resetJposContext(ctx);

            // Log summary final status
            logSummaryJposContextFinalStatus(rrn, ctx);
            return PREPARED;

        } catch (CustomException e) {
            updateJposContext(ctx, rrn, e.getMessage());
            handleCustomExceptionAndFinalDbUpdate(ctx, rrn, entity, e);

            // Log summary final status
            logSummaryJposContextFinalStatus(rrn, ctx);
            return ABORTED;

        } catch (Exception e) {
            String exception = e.getMessage().toLowerCase();
            String statusMessage = "";

            // Handle timeout exceptions
            if (exception.contains("timeout") || exception.contains("time out") || exception.contains("timed out")) {
                statusMessage = "Timeout Exception Occurred When Calling Papss: " + e.getMessage();
                updateJposContext(ctx, rrn, statusMessage);
            } else {
                statusMessage = "Internal Exception Occurred: " + e.getMessage();
                updateJposContext(ctx, rrn, statusMessage);
            }
            // Handle and update db with the exception details
            handleUnexpectedExceptionAndFinalDbUpdate(ctx, rrn, entity, statusMessage);

            // Log summary final status
            logSummaryJposContextFinalStatus(rrn, ctx);
            return ABORTED;
        }
    }

    private void processReceivedPacs002(Context ctx, String rrn, int statusCode, String papssResponseString) throws CustomException {
        Map<String, String> pacs002ResponseMap = xmlReaderService.processPacs002Response(rrn, papssResponseString);
        log.info("{}: Pacs002 Response Map: {}", rrn, pacs002ResponseMap);

        // Update context with the papss pacs002 response
        ctx.put(JposConstants.PACS008_RESPONSE_MAP, pacs002ResponseMap);

        // Get the map details
        String papssStatus = pacs002ResponseMap.getOrDefault("status", "");
        String papssStatusCode = pacs002ResponseMap.getOrDefault("statusCode", "");
        String papssStatusDesc = pacs002ResponseMap.getOrDefault("statusDesc", "");

        // To avoid optimistic lock, fetch the latest db record
        TransactionMaster entity = databaseService.getSavedRecord(rrn, TransactionType.CREDIT_TRANSFER);

        // Final success status
        if ("ACSC".equalsIgnoreCase(papssStatus)) {
            log.info("{}: PAPSS returned ACSC – Transaction completed and settled", rrn);

            // Update context with ACSC status
            ctx.put(JposConstants.RECEIVED_PAPSS_STATUS_CODE, ACSC.name());

            // Set final db status: Success
            setFinalDbStatus(rrn, entity, SUCCESS);
            return;
        }

        // Pending status - Accepted but not settled
        if ("ACCP".equalsIgnoreCase(papssStatus)) {
            log.info("{}: PAPSS returned ACCP – Transaction is pending", rrn);

            // Update context with ACSC status
            ctx.put(JposConstants.RECEIVED_PAPSS_STATUS_CODE, ACCP.name());

            // Set final db status: Pending
            setFinalDbStatus(rrn, entity, PENDING);
            return;
        }

        // Update context with RJCT status
        ctx.put(JposConstants.RECEIVED_PAPSS_STATUS_CODE, RJCT.name());

        // Final Failure - RJCT or anything unexpected
        throw new CustomException(DEFAULT_PAC002_RESPONSE_FAILURE + papssStatus + ". " + papssStatusCode + ": " + papssStatusDesc);
    }

    @Override
    public void commit(long id, Serializable serialisedContext) {
        Context ctx = (Context) serialisedContext;
        String rrn = (String) ctx.get(JposConstants.RRN);
        log.info("{}: Commit phase (no action).", rrn);
    }

    @Override
    public void abort(long id, Serializable serialisedContext) {
        Context ctx = (Context) serialisedContext;
        String rrn = (String) ctx.get(JposConstants.RRN);
        log.info("{}: Abort phase (no action).", rrn);
    }

    // Build HttpPost for pacs.002 with required PAPSS headers
    private HttpPost buildPacs002HttpPost(String url, String xmlPayload) {
        HttpPost post = new HttpPost(url);
        post.setHeader("X-PAPSSRTP-Channel", papssIdResolverService.resolvePapssId());
        post.setHeader("X-PAPSSRTP-ReqSts", ACSC.name());
        post.setHeader("X-PAPSS-RTP-Version", PAPSS_RTP_VERSION);
        post.setHeader("X-PAPSSRTP-MessageType", PACS002_MESSAGE_TYPE);
        post.setEntity(new StringEntity(xmlPayload, StandardCharsets.UTF_8));
        post.setHeader("Content-Type", "application/xml");
        post.setHeader("Accept-Encoding", "gzip");
        post.setHeader("Accept", "*/*");
        return post;
    }

    // Set final success DB status
    private void setFinalDbStatus(String rrn, TransactionMaster entity, TransactionStatus status) {
        // We are sending ACCP to ips, so the current status is pending until we receive ACSC
        entity.setStatus(status);
        entity.setResponseCode(status.getCode());
        entity.setResponseMessage(status.getDescription());

        PapssStatusCodes papssStatusCodes = ACSC;
        if (status == PENDING) {
            papssStatusCodes = ACCP;
        }

        // Update ips status
        entity.setIpsStatus(papssStatusCodes.name());
        entity.setIpsStatusCode(papssStatusCodes.name());
        entity.setIpsStatusReason(papssStatusCodes.getDescription());
        entity.setIpsStatusDescription(papssStatusCodes.getDescription());

        // update papss payloads
//        String creditTransferRequestXml = (String) ctx.get(JposConstants.REQUEST_PAYLOAD_CONTEXT);
//        entity.getPayload().setPapssRequest(creditTransferRequestXml);
//        entity.getPayload().setPapssResponse(signedPacs002ResponseXml);
    }

    // Handle CustomException case
    private void handleCustomExceptionAndFinalDbUpdate(Context ctx, String rrn, TransactionMaster entity, CustomException e) {
        handleFinalFailure(ctx, rrn, e.getMessage(), "DB update after CustomException");
    }

    // Handle unexpected exception case
    private void handleUnexpectedExceptionAndFinalDbUpdate(Context ctx, String rrn, TransactionMaster entity, String statusMessage) {
        handleFinalFailure(ctx, rrn, statusMessage, "DB update after unexpected exception");
    }

    // Shared failure handling logic
    private void handleFinalFailure(Context ctx, String rrn, String errorMsg, String dbLogMessage) {
        log.error("{}: {}", rrn, errorMsg);

        boolean isTimeout = errorMsg != null && (errorMsg.toLowerCase().contains("timeout")
                        || errorMsg.toLowerCase().contains("time out")
                        || errorMsg.toLowerCase().contains("timed out"));

        // Inbound: reversal NEVER happens for timeout cases
        ctx.put(JposConstants.NEEDS_FINACLE_REVERSAL, !isTimeout);

        // For timeout, we do NOT send PAPSS rejection. Let PAPSS retry.
        ctx.put(JposConstants.HTTP_POSTING_REQUIRED_ON_ABORT, !isTimeout);

        // Do not send Papss another message after sending the original pacs002 message. Do finacle reversal
        if (errorMsg != null && errorMsg.startsWith(DEFAULT_PAC002_RESPONSE_FAILURE)) {
            ctx.put(JposConstants.HTTP_POSTING_REQUIRED_ON_ABORT, false);
            ctx.put(JposConstants.NEEDS_FINACLE_REVERSAL, true);
        }

        TransactionStatus finalStatus = isTimeout ? TransactionStatus.TIMEOUT : TransactionStatus.FAILURE;

        String finalMessage = isTimeout ? "Timeout occurred while sending pacs002 response to PAPSS." : (finalStatus + " - " + errorMsg);

        try {
            TransactionMaster entity = databaseService.getSavedRecord(rrn, TransactionType.CREDIT_TRANSFER);

            // IPS fields update
            if (isTimeout) {
                entity.setIpsStatus(PDNG.name());
                entity.setIpsStatusCode(PDNG.name());
            } else {
                entity.setIpsStatus(RJCT.name());
                entity.setIpsStatusCode(RJCT.name());
            }

            entity.setStatus(finalStatus);
            entity.setResponseCode(finalStatus.getCode());
            entity.setResponseMessage(finalMessage);
            entity.setIpsStatusReason(finalMessage);
            entity.setIpsStatusDescription(finalMessage);

            // Update Db status
            updateDatabase(rrn, entity, dbLogMessage);
            log.info("{}: DB update complete. Final status={}.", rrn, finalStatus);

        } catch (Exception e) {
            log.error("{}: DB update error: {}", rrn, e.getMessage());
        }
    }

    // Centralized DB update helper
    private void updateDatabase(String rrn, TransactionMaster entity, String logMessage) {
        log.info("{}: {}", rrn, logMessage);
        databaseService.updateDbRecord(entity);
        log.info("{}: DB status updated successfully.", rrn);
    }

    // Helper to update context with error/status
    private void updateJposContext(Context ctx, String rrn, String statMessage) {
        String statusMessage = statMessage.toLowerCase();
        log.error("{}: {}", rrn, statusMessage);

        ctx.put(JposConstants.STATUS_MESSAGE, statusMessage);
        ctx.put(JposConstants.TXN_STATUS, FAILURE);
        ctx.put(JposConstants.STATUS_CODE, FAILURE.getCode());

        // At this stage, we were trying to send accp to papss, so send_papss_status_code is accp;
        ctx.put(JposConstants.SENT_PAPSS_STATUS_CODE, ACCP.name());

        // Get the response map from context
        @SuppressWarnings("unchecked")
        Map<String, String> responseMap = (Map<String, String>) ctx.get(PACS008_RESPONSE_MAP);

        // Do not blindly overwrite PAPSS status once set (ACSC / ACCP)
        String receivedPapssStatus = (String) ctx.get(RECEIVED_PAPSS_STATUS_CODE);
        if (receivedPapssStatus == null || RJCT.name().equals(receivedPapssStatus)) {
            if (responseMap != null) {
                ctx.put(JposConstants.RECEIVED_PAPSS_STATUS_CODE, RJCT.name());
                ctx.put(JposConstants.PAPSS_ERROR_CODE, responseMap.getOrDefault("statusCode", ""));
                ctx.put(JposConstants.PAPSS_ERROR_MESSAGE, responseMap.getOrDefault("statusDesc", ""));
            } else {
                ctx.put(JposConstants.RECEIVED_PAPSS_STATUS_CODE, RJCT.name());
                ctx.put(JposConstants.PAPSS_ERROR_CODE, DEFAULT_PAPSS_ERROR_CODE);
                ctx.put(JposConstants.PAPSS_ERROR_MESSAGE, DEFAULT_PAPSS_ERROR_MESSAGE);
            }
        }

        // Send a RJCT status to PAPSS after abort for this participant
        // (except timeout, and PACS002InboundResponseError which are handled below)
        ctx.put(JposConstants.HTTP_POSTING_REQUIRED_ON_ABORT, true);

        if (statMessage.startsWith(DEFAULT_PAC002_RESPONSE_FAILURE)) {
            ctx.put(JposConstants.HTTP_POSTING_REQUIRED_ON_ABORT, false);
            ctx.put(JposConstants.NEEDS_FINACLE_REVERSAL, true);
        }

        // Handle timeout context update
        if (statusMessage.contains("timeout")) {
            log.info("{}: Updating context with timeout status", rrn);

            ctx.put(JposConstants.TXN_STATUS, TIMEOUT);
            ctx.put(JposConstants.STATUS_CODE, TIMEOUT.getCode());
            ctx.put(JposConstants.SENT_PAPSS_STATUS_CODE, TIMEOUT.name());
            ctx.put(JposConstants.PAPSS_ERROR_CODE, TIMEOUT.name());
            ctx.put(JposConstants.PAPSS_ERROR_MESSAGE, "Timeout occurred when calling papss");

            // No need to send another PAPSS response after a timeout
            ctx.put(JposConstants.HTTP_POSTING_REQUIRED_ON_ABORT, false);
        }
    }

    private void updateSuccessJposContext(Context ctx, String rrn, String statusMessage) {
        log.info("{}: {}", rrn, statusMessage);
        ctx.put(JposConstants.STATUS_MESSAGE, statusMessage);
        ctx.put(JposConstants.TXN_STATUS, SUCCESS);
        ctx.put(JposConstants.STATUS_CODE, SUCCESS.getCode());
        ctx.put(JposConstants.SENT_PAPSS_STATUS_CODE, ACCP);

        // Update the received papss status. Default to ACSC if null
        String papssReceivedStatusCode =  ctx.get(JposConstants.RECEIVED_PAPSS_STATUS_CODE);
        ctx.put(JposConstants.RECEIVED_PAPSS_STATUS_CODE, ACSC);
        if (papssReceivedStatusCode != null) {
            ctx.put(RECEIVED_PAPSS_STATUS_CODE, papssReceivedStatusCode);
        }

    }

    private void resetJposContext(Context ctx) {
        // Remove payloads from jpos context
        ctx.put(JposConstants.REQUEST_PAYLOAD_CONTEXT, "[requestPayloadContext content excluded]");
        ctx.put(JposConstants.ISO_MESSAGE_FINACLE_REQUEST, "[isoMessageFinacleRequest content excluded]");
        ctx.put(JposConstants.ISO_MESSAGE_FINACLE_RESPONSE, "[isoMessageFinacleResponse content excluded]");
        ctx.put(JposConstants.PAPSS_HTTP_RESPONSE_STRING, "[papssHttpResponseString content excluded]");
        ctx.put(JposConstants.PACS008_REQUEST_MAP, "[pacs008RequestMap content excluded]");
    }

    private void logSummaryJposContextFinalStatus(String rrn, Context ctx) {
        log.info("===== FinalTransactionStatusConsolidator Participant: Transaction Summary Status ====");
        log.info("{}: Status: {}", rrn, ctx.get(TXN_STATUS));
        log.info("{}: Status Message: {} ", rrn, ctx.get(STATUS_MESSAGE));
        log.info("{}: Transaction Status Sent To Papss: {} ", rrn, ctx.get(SENT_PAPSS_STATUS_CODE));
        log.info("{}: Transaction Status Received From Papss: {} ", rrn, ctx.get(RECEIVED_PAPSS_STATUS_CODE));
        log.info("{}: Papss Status Message: {}", rrn, ctx.get(PAPSS_ERROR_MESSAGE, ""));
        log.info("===== FinalTransactionStatusConsolidator Participant: Transaction Summary Status ====");
    }
}
