package com.equitybank.gag.papss.ots.service.impl;

import com.equitybank.gag.papss.ots.dto.channelResponse.ChannelResponse;
import com.equitybank.gag.papss.ots.dto.channelResponse.ChannelStatusInfo;
import com.equitybank.gag.papss.ots.dto.fxrate.PaymentFXRate;
import com.equitybank.gag.papss.ots.dto.participants.ParticipantsResponse;
import com.equitybank.gag.papss.ots.entity.TransactionMaster;
import com.equitybank.gag.papss.ots.enums.TransactionStatus;
import com.equitybank.gag.papss.ots.enums.TransactionType;
import com.equitybank.gag.papss.ots.exception.CustomException;
import com.equitybank.gag.papss.ots.service.PayloadChannelResponseComposerService;
import com.fasterxml.jackson.dataformat.xml.XmlMapper;
import com.google.gson.Gson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

import static com.equitybank.gag.papss.ots.config.ApplicationConstants.*;
import static com.equitybank.gag.papss.ots.enums.TransactionStatus.*;

@Service
public class PayloadChannelResponseComposerServiceImpl implements PayloadChannelResponseComposerService {
    private static final Logger log = LoggerFactory.getLogger(PayloadChannelResponseComposerServiceImpl.class);

    private final Map<String, String> papssErrorMap;
    private final Gson gson;

    @Autowired
    public PayloadChannelResponseComposerServiceImpl(@Qualifier("papssErrorCodeMapping") Map<String, String> papssErrorMap,
                                                     Gson gson) {
        this.papssErrorMap = papssErrorMap;
        this.gson = gson;
    }

    @Override
    public ChannelResponse composeGetParticipantsResponse(String xmlResponse) throws CustomException {
        return parsePapssResponse(xmlResponse, ParticipantsResponse.class, "Participants successfully retrieved.", TransactionType.GET_PARTICIPANT.name());
    }

    @Override
    public ChannelResponse composeGetFxRateResponse(String xmlResponse) throws CustomException {
        return parsePapssResponse(xmlResponse, PaymentFXRate.class, "Get Fx Rate Successfully processed", TransactionType.GET_FX_RATE.name());
    }

    // Common parser for PAPSS responses.
    private ChannelResponse parsePapssResponse(String xmlResponse, Class<?> targetClass, String successMessage, String type) {
        String statusDesc;
        Object parsedObject = null;
        TransactionStatus status = FAILURE;

        if (xmlResponse != null && !xmlResponse.trim().isEmpty()) {
            String trimmedResponse = xmlResponse.trim();

            if (trimmedResponse.startsWith("<")) {
                try {
                    XmlMapper xmlMapper = new XmlMapper();
                    parsedObject = xmlMapper.readValue(trimmedResponse, targetClass);
                    status = SUCCESS;
                    statusDesc = successMessage;
                } catch (Exception e) {
                    log.error("[{}]: Failed to parse XML response - {}", targetClass.getSimpleName(), e.getMessage());
                    statusDesc = "Failed to parse PAPSS " + targetClass.getSimpleName() + " XML response";
                }
            } else {
                log.error("[{}]: PAPSS returned error message with 200 status - {}", targetClass.getSimpleName(), trimmedResponse);
                statusDesc = trimmedResponse;
            }
        } else {
            statusDesc = "Empty response from PAPSS";
        }

        // Build ChannelStatusInfo
        ChannelStatusInfo statusInfo = new ChannelStatusInfo();
        statusInfo.setStatus(String.valueOf(status));
        statusInfo.setCode(status.getCode());
        statusInfo.setDescription(statusDesc);

        // Build ChannelResponse
        ChannelResponse channelResponse = new ChannelResponse();
        channelResponse.setChannelStatusInfo(statusInfo);

        if (status == SUCCESS && parsedObject != null) {
            if (TransactionType.GET_PARTICIPANT.name().equals(type)) {
                channelResponse.setParticipants((ParticipantsResponse) parsedObject);
            } else if (TransactionType.GET_FX_RATE.name().equals(type)) {
                channelResponse.setPaymentFXRate((PaymentFXRate) parsedObject);
            }
        }
        return channelResponse;
    }

    @Override
    public ChannelResponse composeNamecheckResponse(String rrn, Map<String, String> resultMap, String type) {
        String status = resultMap.get("status");
        return "true".equalsIgnoreCase(status)
                ? buildNamecheckSuccessJson(rrn, resultMap)
                : buildNamecheckFailureJson(rrn, resultMap);
    }

    @Override
    public ChannelResponse composeTransactionResponse(String rrn, Map<String, String> resultMap, String type) {
        String ipsStatus = resultMap.getOrDefault("ipsStatus", "");
        log.info("{}: Received ipsStatus: {}", rrn, ipsStatus);

        if ("CREDIT_TRANSFER".equalsIgnoreCase(type)) {
            if ("ACCP".equalsIgnoreCase(ipsStatus)) {
                // Pending (accepted but not yet settled)
                return buildTransactionResponseJson(rrn, resultMap, PENDING, DEFAULT_PENDING_CODE, PENDING.getDescription());
            }

            if ("ACSC".equalsIgnoreCase(ipsStatus)) {
                // Success (settlement completed)
                return buildTransactionResponseJson(rrn, resultMap, SUCCESS, DEFAULT_SUCCESS_CODE, SUCCESS.getDescription());
            }

            // Anything else counts as failure
            return buildFailureTransactionJson(rrn, resultMap, getFailureMessage(resultMap));
        }

        // Handle all other types (callbacks)
        return "ACSC".equalsIgnoreCase(ipsStatus)
                ? buildTransactionResponseJson(rrn, resultMap, SUCCESS, DEFAULT_SUCCESS_CODE, SUCCESS.getDescription())
                : buildFailureTransactionJson(rrn, resultMap, getFailureMessage(resultMap));
    }

    @Override
    public ChannelResponse composeStatusCheckResponse(String rrn, Map<String, String> resultMap, String type) {
        String ipsStatus = resultMap.get("ipsStatus");

        return ("ACSC".equalsIgnoreCase(String.valueOf(ipsStatus)) || "ACCP".equalsIgnoreCase(String.valueOf(ipsStatus)))
                ? buildStatusCheckResponseJson(rrn, resultMap, SUCCESS, DEFAULT_SUCCESS_CODE, SUCCESS.getDescription())
                : buildStatusCheckResponseJson(rrn, resultMap, FAILURE, DEFAULT_ERROR_CODE, FAILURE.getDescription());
    }

    @Override
    public ChannelResponse composePendingResponse(String rrn, Map<String, String> resultMap) {
        return buildTransactionResponseJson(rrn, resultMap, PENDING, DEFAULT_PENDING_CODE, PENDING.getDescription());
    }

    @Override
    public ChannelResponse composeStatusCheckDbResponse(String originalRrn, TransactionMaster entity) {
        String rrn = entity.getRrn();
        String statusCode = entity.getResponseCode();
        TransactionStatus status = entity.getStatus();
        String statusDesc = entity.getResponseMessage();

        // Put details in the map
        Map<String, String> resultMap = new HashMap<>();
//        resultMap.put("type", entity.getIpsStatus());
//        resultMap.put("reason", entity.getIpsStatusReason());
//        resultMap.put("code", entity.getIpsStatusCode());
//        resultMap.put("description", entity.getIpsStatusDescription());
//        resultMap.put("originalRrn", originalRrn);

        resultMap.put("status", String.valueOf(entity.getStatus()));
        resultMap.put("ipsStatus", entity.getIpsStatus());
        resultMap.put("reason", entity.getIpsStatusReason());
        resultMap.put("reasonCode", entity.getIpsStatusCode());
        resultMap.put("description", entity.getIpsStatusDescription());
        resultMap.put("originalRrn", originalRrn);

        return buildStatusCheckResponseJson(rrn, resultMap, status, statusCode, statusDesc);
    }

    private ChannelResponse buildStatusCheckResponseJson(String rrn, Map<String, String> resultMap, TransactionStatus status, String statusCode, String statusDesc) {
        String originalRrn = resultMap.getOrDefault("originalRrn", "");

        String ipsStatus = resultMap.get("ipsStatus");
        String reason = resultMap.get("reason");
        String reasonCode = resultMap.get("reasonCode");
        String tranId = resultMap.getOrDefault("tranId", "");

        if ("ACCP".equalsIgnoreCase(ipsStatus)) {
            reason = "ACCP";
            reasonCode = "000";
        }

        String responseJson = "{\n" +
                "  \"rrn\": \"" + rrn + "\",\n" +
                "  \"ipsStatusInfo\": {\n" +
                "    \"tranId\": \"" + tranId + "\",\n" +
                "    \"status\": {\n" +
                "      \"type\": \"" + ipsStatus + "\",\n" +
                "      \"reason\": \""+ reason + "\",\n" +
                "      \"code\": \"" + reasonCode +"\",\n" +
                "      \"description\": \"" + statusDesc + "\"\n" +
                "    }\n" +
                "  },\n" +
                "    \"originalTxnStatusInfo\": {\n" +
                "        \"originalRrn\": \"" + originalRrn +"\",\n" +
                "        \"status\": \"" + status + "\",\n" +
                "        \"code\": \"" + statusCode + "\",\n" +
                "        \"description\": \"" + statusDesc + "\"\n" +
                "    },\n" +
                "  \"channelStatusInfo\": {\n" +
                "    \"status\": \"SUCCESS\",\n" +
                "    \"code\": \"00\",\n" +
                "    \"description\": \"Success.\"\n" +
                "  }\n" +
                "}";

        return gson.fromJson(responseJson, ChannelResponse.class);
    }

    private ChannelResponse buildNamecheckSuccessJson(String rrn, Map<String, String> resultMap) {
        String responseJson = "{\n" +
                "  \"rrn\": \"" + rrn + "\",\n" +
                "  \"ipsStatusInfo\": {\n" +
                "    \"status\": {\n" +
                "      \"type\": \"ACCP\",\n" +
                "      \"reason\": \"000\",\n" +
                "      \"code\": \"000\",\n" +
                "      \"description\": \"Success\"\n" +
                "    }\n" +
                "  },\n" +
                "  \"receiver\": {\n" +
                "    \"institutionId\": \"" + resultMap.get("receiverInstId") + "\",\n" +
                "    \"accountNumber\": \"" + resultMap.get("originalAccountId") + "\",\n" +
                "    \"accountCurrency\": \"" + resultMap.get("accountCurrency") + "\",\n" +
                "    \"accountName\": \"" + resultMap.get("name") + "\",\n" +
                "    \"emailAddress\": \"" + resultMap.get("email") + "\"\n" +
                "  },\n" +
                "  \"channelStatusInfo\": {\n" +
                "    \"status\": \"SUCCESS\",\n" +
                "    \"code\": \"00\",\n" +
                "    \"description\": \"Success.\"\n" +
                "  }\n" +
                "}";

        return gson.fromJson(responseJson, ChannelResponse.class);
    }

    private ChannelResponse buildNamecheckFailureJson(String rrn, Map<String, String> resultMap) {
        String reasonCode = resultMap.get("reasonCode");
        String errorDesc = papssErrorMap.getOrDefault(reasonCode, "MS03:Generic error");
        Map<String, String> errorParts = getPapssErrorDesc(errorDesc);

        String responseJson = "{\n" +
                "  \"rrn\": \"" + rrn + "\",\n" +
                "  \"ipsStatusInfo\": {\n" +
                "    \"status\": {\n" +
                "      \"type\": \"RJCT\",\n" +
                "      \"reason\": \"" + reasonCode + "\",\n" +
                "      \"code\": \"" + errorParts.get("code") + "\",\n" +
                "      \"description\": \"" + errorParts.get("message") + "\"\n" +
                "    }\n" +
                "  },\n" +
                "  \"channelStatusInfo\": {\n" +
                "    \"status\": \"FAILURE\",\n" +
                "    \"code\": \"01\",\n" +
                "    \"description\": \"" + errorParts.get("message") + "\"\n" +
                "  }\n" +
                "}";

        return gson.fromJson(responseJson, ChannelResponse.class);
    }

    private ChannelResponse buildTransactionResponseJson(String rrn, Map<String, String> resultMap, TransactionStatus status, String code, String description) {
        String ipsStatus = resultMap.get("ipsStatus");
        String reason = resultMap.get("reason");
        String reasonCode = resultMap.get("reasonCode");
        String tranId = resultMap.getOrDefault("tranId", "");

        if ("ACCP".equalsIgnoreCase(ipsStatus)) {
            reason = "ACCP";
            reasonCode = "000";
        }
        String responseJson = "{\n" +
                "  \"rrn\": \"" + rrn + "\",\n" +
                "  \"ipsStatusInfo\": {\n" +
                "    \"tranId\": \"" + tranId + "\",\n" +
                "    \"status\": {\n" +
                "      \"type\": \"" + ipsStatus + "\",\n" +
                "      \"reason\": \""+ reason + "\",\n" +
                "      \"code\": \"" + reasonCode +"\",\n" +
                "      \"description\": \"" + description + "\"\n" +
                "    }\n" +
                "  },\n" +
                "  \"channelStatusInfo\": {\n" +
                "    \"status\": \"" + status + "\",\n" +
                "    \"code\": \"" + code + "\",\n" +
                "    \"description\": \"" + description + "\"\n" +
                "  }\n" +
                "}";

        return gson.fromJson(responseJson, ChannelResponse.class);
    }

    private ChannelResponse buildFailureTransactionJson(String rrn, Map<String, String> resultMap, String message) {
        String reason = resultMap.get("reason");
        String reasonCode = resultMap.get("reasonCode");
        String errorDesc = papssErrorMap.getOrDefault(reasonCode, "MS03:Generic error");
        Map<String, String> errorParts = getPapssErrorDesc(errorDesc);

        String responseJson = "{\n" +
                "  \"rrn\": \"" + rrn + "\",\n" +
                "  \"ipsStatusInfo\": {\n" +
                "    \"tranId\": \"\",\n" +
                "    \"status\": {\n" +
                "      \"type\": \"RJCT\",\n" +
                "      \"reason\": \"" + reason + "\",\n" +
                "      \"code\": \"" + errorParts.get("code") + "\",\n" +
                "      \"description\": \"" + errorParts.get("message") + "\"\n" +
                "    }\n" +
                "  },\n" +
                "  \"channelStatusInfo\": {\n" +
                "    \"status\": \"" + FAILURE + "\",\n" +
                "    \"code\": \"" + FAILURE.getCode() + "\",\n" +
                "    \"description\": \"" + message + "\"\n" +
                "  }\n" +
                "}";

        return gson.fromJson(responseJson, ChannelResponse.class);
    }

    private String getFailureMessage(Map<String, String> resultMap) {
        String rejectCode = resultMap.get("reasonCode");
        String papssErrorDesc = papssErrorMap.get(rejectCode);
        Map<String, String> papssErrorDescMap = getPapssErrorDesc(papssErrorDesc);
        return papssErrorDescMap.get("message");
    }

    private Map<String, String> getPapssErrorDesc(String papssErrorDesc) {
        Map<String, String> map = new HashMap<>();
        if (papssErrorDesc == null || papssErrorDesc.isEmpty()) {
            papssErrorDesc = "MS03:Generic error";
        }

        String[] parts = papssErrorDesc.split(":", 2);
        map.put("code", parts.length > 1 ? parts[0] : "MS03");
        map.put("message", parts.length > 1 ? parts[1] : papssErrorDesc);

        return map;
    }
}
