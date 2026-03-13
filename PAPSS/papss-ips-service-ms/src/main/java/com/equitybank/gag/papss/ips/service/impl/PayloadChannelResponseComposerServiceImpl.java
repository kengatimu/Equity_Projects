package com.equitybank.gag.papss.ips.service.impl;

import com.equitybank.gag.papss.ips.service.PayloadChannelResponseComposerService;
import com.equitybank.gag.papss.ips.enums.TransactionStatus;
import com.equitybank.gag.papss.ips.pojo.channelResponse.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

import static com.equitybank.gag.papss.ips.config.StatusCodeMessages.*;
import static com.equitybank.gag.papss.ips.enums.TransactionStatus.*;

@Service
public class PayloadChannelResponseComposerServiceImpl implements PayloadChannelResponseComposerService {
    private static final Logger log = LoggerFactory.getLogger(PayloadChannelResponseComposerServiceImpl.class);

    private final Map<String, String> papssErrorMap;

    @Autowired
    public PayloadChannelResponseComposerServiceImpl(@Qualifier("papssErrorCodeMapping") Map<String, String> papssErrorMap) {
        this.papssErrorMap = papssErrorMap;
    }

    @Override
    public ChannelResponse composeNamecheckResponse(String rrn, Map<String, String> resultMap, String type) {
        String status = resultMap.get("status");
        return "true".equalsIgnoreCase(status)
                ? composeSuccessNamecheckResponse(rrn, resultMap)
                : composeFailureNamecheckResponse(rrn, resultMap);
    }

    @Override
    public ChannelResponse composeTransactionResponse(String rrn, Map<String, String> resultMap, String type) {
        String status = resultMap.get("status");
        if ("CREDIT_TRANSFER".equalsIgnoreCase(type)) {
            return "ACCP".equalsIgnoreCase(status)
                    ? composeSuccessTransactionResponse(rrn, resultMap, PENDING, DEFAULT_PENDING_CODE, PENDING.getDescription())
                    : composeFailureTransactionResponse(rrn, resultMap, getFailureMessage(resultMap));
        }
        // For callback with final status
        return "ACSC".equalsIgnoreCase(status)
                ? composeSuccessTransactionResponse(rrn, resultMap, SUCCESS, DEFAULT_SUCCESS_CODE, SUCCESS.getDescription())
                : composeFailureTransactionResponse(rrn, resultMap, getFailureMessage(resultMap));
    }

    @Override
    public ChannelResponse composeStatusCheckResponse(String rrn, Map<String, String> resultMap, String type) {
        // Implement as needed
        return null;
    }

    private ChannelResponse composeSuccessNamecheckResponse(String rrn, Map<String, String> resultMap) {
        Status status = buildStatus("ACCP", "000", "000", SUCCESS.getDescription());
        Receiver receiver = buildReceiver(resultMap);
        ChannelStatusInfo channelStatusInfo = buildChannelStatusInfo(SUCCESS, DEFAULT_SUCCESS_CODE, SUCCESS.getDescription());
        return buildChannelResponse(rrn, status, receiver, channelStatusInfo);
    }

    private ChannelResponse composeFailureNamecheckResponse(String rrn, Map<String, String> resultMap) {
        Map<String, String> errorMap = getPapssErrorDesc(papssErrorMap.get(resultMap.get("reasonCode")));
        Status status = buildStatus("RJCT", errorMap.get("code"), resultMap.get("reasonCode"), errorMap.get("message"));
        ChannelStatusInfo channelStatusInfo = buildChannelStatusInfo(FAILURE, DEFAULT_ERROR_CODE, errorMap.get("message"));
        return buildChannelResponse(rrn, status, null, channelStatusInfo);
    }

    private ChannelResponse composeSuccessTransactionResponse(String rrn, Map<String, String> resultMap, TransactionStatus channelStatus, String channelCode, String channelDesc) {
        Status status = buildStatus(resultMap.get("status"), "000", "000", SUCCESS.getDescription());
        ChannelStatusInfo channelStatusInfo = buildChannelStatusInfo(channelStatus, channelCode, channelDesc);
        return buildChannelResponse(rrn, status, null, channelStatusInfo);
    }

    private ChannelResponse composeFailureTransactionResponse(String rrn, Map<String, String> resultMap, String message) {
        Map<String, String> errorMap = getPapssErrorDesc(papssErrorMap.get(resultMap.get("reasonCode")));
        Status status = buildStatus(resultMap.get("status"), errorMap.get("code"), resultMap.get("reasonCode"), errorMap.get("message"));
        ChannelStatusInfo channelStatusInfo = buildChannelStatusInfo(TransactionStatus.FAILURE, DEFAULT_ERROR_CODE, message);
        return buildChannelResponse(rrn, status, null, channelStatusInfo);
    }

    private Status buildStatus(String type, String reason, String code, String description) {
        Status status = new Status();
        status.setType(type);
        status.setReason(reason);
        status.setCode(code);
        status.setDescription(description);
        return status;
    }

    private Receiver buildReceiver(Map<String, String> resultMap) {
        Receiver receiver = new Receiver();
        receiver.setInstitutionId(resultMap.get("receiverInstId"));
        receiver.setAccountNumber(resultMap.get("originalAccountId"));
        receiver.setAccountName(resultMap.get("name"));
        receiver.setEmailAddress(resultMap.get("email"));
        return receiver;
    }

    private ChannelStatusInfo buildChannelStatusInfo(TransactionStatus status, String code, String description) {
        ChannelStatusInfo channelStatusInfo = new ChannelStatusInfo();
        channelStatusInfo.setStatus(String.valueOf(status));
        channelStatusInfo.setCode(code);
        channelStatusInfo.setDescription(description);
        return channelStatusInfo;
    }

    private ChannelResponse buildChannelResponse(String rrn, Status status, Receiver receiver, ChannelStatusInfo channelStatusInfo) {
        IpsStatusInfo ipsStatusInfo = new IpsStatusInfo();
        ipsStatusInfo.setStatus(status);

        ChannelResponse channelResponse = new ChannelResponse();
        channelResponse.setRrn(rrn);
        channelResponse.setIpsStatusInfo(ipsStatusInfo);
        channelResponse.setReceiver(receiver);
        channelResponse.setChannelStatusInfo(channelStatusInfo);
        return channelResponse;
    }

    private String getFailureMessage(Map<String, String> resultMap) {
        String rejectCode = resultMap.get("reasonCode");
        String papssErrorDesc = papssErrorMap.get(rejectCode);
        Map<String, String> papssErrorDescMap = getPapssErrorDesc(papssErrorDesc);
        return papssErrorDescMap.get("message");
    }


    private Map<String, String> getPapssErrorDesc(String papssErrorDesc) {
        Map<String, String> papssErrorDescMap = new HashMap<>();

        if (papssErrorDesc == null || papssErrorDesc.isEmpty()) {
            papssErrorDesc = "MS03:Generic error";
        }

        String[] parts = papssErrorDesc.split(":", 2); // Limit to 2 parts

        if (parts.length == 2) {
            papssErrorDescMap.put("code", parts[0]);
            papssErrorDescMap.put("message", parts[1]);
        } else {
            // Fallback if format is not as expected
            papssErrorDescMap.put("code", "MS03");
            papssErrorDescMap.put("message", papssErrorDesc);
        }

        return papssErrorDescMap;
    }
}
