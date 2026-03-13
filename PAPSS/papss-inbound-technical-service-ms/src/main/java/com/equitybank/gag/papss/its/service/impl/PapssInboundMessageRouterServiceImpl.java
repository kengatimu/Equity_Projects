package com.equitybank.gag.papss.its.service.impl;

import com.equitybank.gag.papss.its.entity.TransactionMaster;
import com.equitybank.gag.papss.its.enums.TransactionStatus;
import com.equitybank.gag.papss.its.enums.TransactionType;
import com.equitybank.gag.papss.its.exception.CustomException;
import com.equitybank.gag.papss.its.jpos.jposService.TransactionDispatcherService;
import com.equitybank.gag.papss.its.pojo.papssMessages.InboundMessageReqObject;
import com.equitybank.gag.papss.its.service.*;
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
import java.time.OffsetDateTime;
import java.util.Map;

import static com.equitybank.gag.papss.its.config.StatusCodeMessages.*;
import static com.equitybank.gag.papss.its.enums.PapssStatusCodes.*;
import static com.equitybank.gag.papss.its.enums.TransactionStatus.*;

@Service
public class PapssInboundMessageRouterServiceImpl implements PapssInboundMessageRouterService {

    private static final Logger log = LoggerFactory.getLogger(PapssInboundMessageRouterServiceImpl.class);

    private final String papssUrl;
    private final DatabaseService databaseService;
    private final XmlReaderService xmlReaderService;
    private final CloseableHttpClient closeableHttpClient;
    private final PapssIdResolverService papssIdResolverService;
    private final PayloadXmlComposerService payloadXmlComposerService;
    private final SendAcknowledgementService sendAcknowledgementService;
    private final TransactionDispatcherService transactionDispatcherService;
    private final ISOSignatureGenerationService isoSignatureGenerationService;

    public PapssInboundMessageRouterServiceImpl(@Value("${service.urls.common-url}") String papssUrl,
                                                DatabaseService databaseService,
                                                XmlReaderService xmlReaderService,
                                                CloseableHttpClient closeableHttpClient,
                                                PapssIdResolverService papssIdResolverService,
                                                PayloadXmlComposerService payloadXmlComposerService,
                                                SendAcknowledgementService sendAcknowledgementService,
                                                TransactionDispatcherService transactionDispatcherService,
                                                ISOSignatureGenerationService isoSignatureGenerationService) {
        this.papssUrl = papssUrl;
        this.databaseService = databaseService;
        this.xmlReaderService = xmlReaderService;
        this.closeableHttpClient = closeableHttpClient;
        this.papssIdResolverService = papssIdResolverService;
        this.payloadXmlComposerService = payloadXmlComposerService;
        this.sendAcknowledgementService = sendAcknowledgementService;
        this.transactionDispatcherService = transactionDispatcherService;
        this.isoSignatureGenerationService = isoSignatureGenerationService;
    }

    @Override
    public void route(InboundMessageReqObject inboundMessageReqObject, boolean possibleDuplicate) {
        String messageSeq = inboundMessageReqObject.getMessageSeq();
        String messageType = inboundMessageReqObject.getMessageType();

        try {
            switch (messageType) {
                case PACS008_MESSAGE_TYPE -> handlePacs008(inboundMessageReqObject, possibleDuplicate);
                case ACMT0023_MESSAGE_TYPE -> handleAcmt023(inboundMessageReqObject);
                default -> {
                    // Unsupported message types send ACK only
                    log.info("{}: Unsupported messageType {}. Sending ACK only.", messageSeq, messageType);
                    sendAcknowledgementService.sendAck(true, false, messageSeq, messageType, new Context());
                }
            }
        } catch (Exception e) {
            log.error("{}: Router exception: {}", messageSeq, e.getMessage());
        }
    }

    private void handleAcmt023(InboundMessageReqObject req) throws CustomException {
        String rrn = req.getMessageSeq();
        // NameCheck is always processed fresh through JPOS
        log.info("{}: Processing NameCheck acmt.023.", rrn);
        transactionDispatcherService.dispatch(req);
    }

    private void handlePacs008(InboundMessageReqObject req, boolean duplicate) throws CustomException {
        String rrn = req.getMessageSeq();
        String messageType = req.getMessageType();
        String xmlPayload = req.getPayload();

        boolean pacs002SentToPapss = false;

        try {
            // Parse inbound XML into resultMap used for pacs.002 reconstruction
            Map<String, String> resultMap = xmlReaderService.processInboundXml(rrn, xmlPayload, TransactionType.CREDIT_TRANSFER.name());

            // Handle new pacs.008 request first (non duplicate)
            if (!duplicate) {
                log.info("{}: New pacs.008 received. Checking DB for duplicates.", rrn);

                try {
                    databaseService.checkTransactionExists(rrn, TransactionType.CREDIT_TRANSFER);

                    // Fresh message: Dispatch to JPOS TM
                    log.info("{}: No existing DB record found. Dispatching the message to JPOS TM", rrn);
                    transactionDispatcherService.dispatch(req);
                    return;

                } catch (CustomException ex) {
                    log.info("{}: A duplicate record exists in our system. Returning De-Dup RJCT status to papss", rrn);
                    String pacs002DupXmlResponse = payloadXmlComposerService.composePacs002FailureResponse(resultMap, DEFAULT_PAPSS_DE_DUP_ERROR_CODE);
                    pacs002SentToPapss = signAndSendMessageToPapps(pacs002DupXmlResponse, rrn);

                    // Send ACK to Papss
                    sendAcknowledgementService.sendAck(pacs002SentToPapss, true, rrn, messageType, new Context());
                    return;
                }
            }

            // Handle duplicates (when X-PAPSSRTP-PossibleDuplicate = true)
            log.warn("Duplicate pacs.008 request {} detected.", rrn);

            // Fails if no DB record (handled in catch)
            TransactionMaster entity = databaseService.getSavedRecord(rrn, TransactionType.CREDIT_TRANSFER);

            // Determine IPS status code if not saved
            String ipsStatusCode = (entity.getIpsStatusCode() == null || entity.getIpsStatusCode().isEmpty()) ? DEFAULT_PAPSS_ERROR_CODE : entity.getIpsStatusCode();

            String pacs002ResponseXml;
            if (FAILURE.equals(entity.getStatus())) {
                // If previous status was failure, send RJCT
                log.info("{}: Previous status was FAILURE. Sending RJCT status to papss.", rrn);
                pacs002ResponseXml = payloadXmlComposerService.composePacs002FailureResponse(resultMap, "RJCT");

            } else if (TransactionStatus.TIMEOUT.equals(entity.getStatus())) {
                // Timeout case handled separately
                pacs002ResponseXml = processTimeoutStatus(resultMap, entity, rrn, ipsStatusCode);

            } else {
                // If previous status was success, send ACSC
                log.info("{}: Previous status was SUCCESS. Sending ACSC status to papss.", rrn);
                pacs002ResponseXml = payloadXmlComposerService.composePacs002SuccessResponse(resultMap);
            }

            // Send final pacs.002 to PAPSS
            pacs002SentToPapss = signAndSendMessageToPapps(pacs002ResponseXml, rrn);

            // Always send ACK after successful pacs.002 delivery
            sendAcknowledgementService.sendAck(pacs002SentToPapss, true, rrn, messageType, new Context());

        } catch (CustomException e) {
            if (RECORD_NOT_FOUND.equals(e.getMessage())) {
                // Papss duplicate flag true, but our DB has no record. Cannot reconstruct pacs.002, Send ACK only
                log.warn("{}: Papss possible duplicate flag true for pacs.008 request, but no DB record in our system. Sending ACK only.", rrn);
                sendAcknowledgementService.sendAck(true, false, rrn, messageType, new Context());
            } else {
                // Do not send ACK after processing failures. This will force papss to resend the request
                log.error("{}: CustomException: {}", rrn, e.getMessage());
                sendAcknowledgementService.sendAck(false, true, rrn, messageType, new Context());
            }

        } catch (Exception e) {
            // Unrecoverable error, send ACK depending on the value of pacs002SentToPapss
            log.error("{}: Unexpected error occurred: {}", rrn, e.getMessage());
            e.printStackTrace(System.out);
            sendAcknowledgementService.sendAck(pacs002SentToPapss, true, rrn, messageType, new Context());
        }
    }

    private boolean signAndSendMessageToPapps(String pacs002Xml, String rrn) throws CustomException {
        try {
            log.info("{}: Signing pacs.002 request", rrn);

            // Sign outgoing pacs.002 using PAPSS DS rules
            String signedPacs002ResponseXml = isoSignatureGenerationService.generateXMLDigitalSignature(rrn, pacs002Xml, TransactionType.CREDIT_TRANSFER.name());

            // Generate http post request
            HttpPost httpPost = buildPacs002HttpPost(papssUrl, signedPacs002ResponseXml);

            // Send pacs002 xml response to papss
            sendToPapss(rrn, signedPacs002ResponseXml, httpPost);

            // Pacs002 response sent successfully
            return true;
        } catch (Exception e) {
            log.error("{}: Failed to send pacs.002 to PAPSS. Exception occurred: {}", rrn, e.getMessage());
            return false;
        }
    }

    private String processTimeoutStatus(Map<String, String> resultMap, TransactionMaster entity, String rrn, String ipsStatusCode) throws CustomException {
        // If debit succeeded in Finacle, treat as ACSC
        if (FINACLE_DEBITED.equals(entity.getFinacleStatus())) {
            // Update the db with success status
            updateDatabase(rrn, entity, "success");

            log.info("{}: Current transaction status is Timeout but debit/credit was success. Sending ACSC to Papss.", rrn);
            return payloadXmlComposerService.composePacs002SuccessResponse(resultMap);
        }

        // Update the db with failure status
        updateDatabase(rrn, entity, "failure");

        // Otherwise treat it as RJCT
        log.info("{}: Current transaction status is Timeout but debit/credit was: {}. Sending RJCT to Papss.", rrn, entity.getFinacleStatus());
        return payloadXmlComposerService.composePacs002FailureResponse(resultMap, ipsStatusCode);
    }

    private void updateDatabase(String rrn, TransactionMaster entity, String status) {
        String responseMessage;
        if ("success".equalsIgnoreCase(status)) {
            responseMessage = "Finacle Dr/Cr was successful. Final status updated to: SUCCESS";
            entity.setStatus(TransactionStatus.SUCCESS);
            entity.setResponseCode(SUCCESS.getCode());
            entity.setResponseMessage(responseMessage);
            entity.setIpsStatus(COMPLETED.name());
            entity.setIpsStatusCode(ACSC.name());
            entity.setIpsStatusReason(COMPLETED.getDescription());
            entity.setIpsStatusDescription(ACSC.getDescription());
            entity.setCompletedAt(OffsetDateTime.now());
        } else {
            responseMessage = "Finacle Dr/Cr failed. Final status updated to: FAILURE";
            entity.setStatus(FAILURE);
            entity.setResponseCode(FAILURE.getCode());
            entity.setResponseMessage(responseMessage);
            entity.setIpsStatus(RJCT.name());
            entity.setIpsStatusCode(RJCT.name());
            entity.setIpsStatusReason(FAILURE.getDescription());
            entity.setIpsStatusDescription(RJCT.getDescription());
            entity.setCompletedAt(OffsetDateTime.now());
        }
        // Updating db with final status
        log.info("{}: Updating Database with final transaction status. Status: {}", rrn, status.toUpperCase());
        databaseService.updateDbRecord(entity);
        log.info("{}: {}", rrn, responseMessage);
    }

    private void sendToPapss(String messageSequence, String signedPacs002ResponseXml, HttpPost post) throws IOException {
        log.info("{}: Sending pacs.002 to PAPSS via url: {}. \nSigned Pacs002 XML {}", messageSequence, papssUrl, signedPacs002ResponseXml);
        try (CloseableHttpResponse response = closeableHttpClient.execute(post)) {
            // Extract HTTP status and response body
            HttpEntity httpEntity = response.getEntity();
            int statusCode = response.getStatusLine().getStatusCode();
            String httpStatusMsg = response.getStatusLine().getReasonPhrase();
            String papssResponseString = httpEntity != null ? EntityUtils.toString(httpEntity, StandardCharsets.UTF_8) : "";

            // Log the HTTP call result
            log.info(String.format(HTTP_RESPONSE_LOG_TEMPLATE, statusCode, httpStatusMsg, papssResponseString));
        }

    }

    private HttpPost buildPacs002HttpPost(String url, String xml) {
        HttpPost post = new HttpPost(url);

        // PAPSS RTP envelope headers
        post.setHeader("X-PAPSSRTP-Channel", papssIdResolverService.resolvePapssId());
        post.setHeader("X-PAPSSRTP-ReqSts", ACSC.name());
        post.setHeader("X-PAPSS-RTP-Version", PAPSS_RTP_VERSION);
        post.setHeader("X-PAPSSRTP-MessageType", PACS002_MESSAGE_TYPE);

        // HTTP meta headers
        post.setHeader("Content-Type", "application/xml");
        post.setHeader("Accept-Encoding", "gzip");
        post.setHeader("Accept", "*/*");

        post.setEntity(new StringEntity(xml, StandardCharsets.UTF_8));
        return post;
    }
}
