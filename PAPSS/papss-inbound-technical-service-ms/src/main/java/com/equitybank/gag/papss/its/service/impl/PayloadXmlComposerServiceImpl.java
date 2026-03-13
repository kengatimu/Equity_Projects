package com.equitybank.gag.papss.its.service.impl;

import com.equitybank.gag.papss.its.config.StatusCodeMessages;
import com.equitybank.gag.papss.its.exception.CustomException;
import com.equitybank.gag.papss.its.service.DateService;
import com.equitybank.gag.papss.its.service.PapssIdResolverService;
import com.equitybank.gag.papss.its.service.PayloadXmlComposerService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static com.equitybank.gag.papss.its.config.StatusCodeMessages.EQUITY_SWIFT_BIC_CODE;
import static com.equitybank.gag.papss.its.config.StatusCodeMessages.PAPSS_SCHEMA_NAME;
import static com.equitybank.gag.papss.its.enums.PapssStatusCodes.*;

@Service
public class PayloadXmlComposerServiceImpl implements PayloadXmlComposerService {
    private static final Logger log = LoggerFactory.getLogger(PayloadXmlComposerServiceImpl.class);

    private final DateService dateService;
    private final PapssIdResolverService papssIdResolverService;

    @Autowired
    public PayloadXmlComposerServiceImpl(DateService dateService,
                                         PapssIdResolverService papssIdResolverService) {
        this.dateService = dateService;
        this.papssIdResolverService = papssIdResolverService;
    }

    @Override
    public String composeAcmt024SuccessResponse(String rrn, Map<String, String> requestMap) throws CustomException {
        try {
            if (requestMap == null || requestMap.isEmpty()) {
                throw new CustomException("Inbound requestMap cannot be null or empty");
            }

            // === Extract and validate required inbound values ===
            String originalBizMsgId = requireValue(requestMap, "bizMsgId");
            String senderInstitutionId = requireValue(requestMap, "senderInstitutionId");
            String senderBic = requireValue(requestMap, "senderBic");
            String accountNumber = requireValue(requestMap, "accountNumber");
            String originalId = requireValue(requestMap, "originalId");

            // === Your own values ===
            String participantMmbId = "KE1011";
            String papssMmb = "XA0001";

            // === Additional data ===
            String accountName = requireValue(requestMap, "name");

            // IMPORTANT → Use placeholder email because PAPSS schema rejects empty email
            String email = "email.unknown@equitybank.co.ke";

            String currency = requestMap.getOrDefault("accountCurrency", "");

            // === Build message IDs ===
            String rspBizMsgId = originalBizMsgId + "-RSP";
            String timestamp = dateService.getCurrentIsoDateAndTime();

            // === Load template ===
            String template = loadTemplate("/templates/ACMT024.xml");

            // === Replace placeholders ===
            template = template
                    .replace("{{clearing_sys_id_prtry}}", StatusCodeMessages.CLEARING_SYSTEM_ID)
                    .replace("{{participant_member_id}}", participantMmbId)
                    .replace("{{participant_clearing_system_id}}", papssMmb)
                    .replace("{{message_id}}", rspBizMsgId)
                    .replace("{{msg_def_idr}}", "acmt.024.001.02")
                    .replace("{{create_date_time}}", timestamp)
                    .replace("{{assignee_member_id}}", senderInstitutionId)
                    .replace("{{original_assignment_message_id}}", originalBizMsgId)
                    .replace("{{rpt_original_id}}", originalId)
                    .replace("{{rpt_vrfctn}}", "true")
                    .replace("{{account_number}}", accountNumber)
                    .replace("{{scheme_name_cd}}", PAPSS_SCHEMA_NAME)
                    .replace("{{account_name}}", accountName)
                    .replace("{{account_email}}", email)
                    .replace("{{account_currency}}", currency);

            // === Handle {{#participant_bic_fi}}...{{/participant_bic_fi}} safely ===
            String blockRegex = "\\{\\{#participant_bic_fi}}([\\s\\S]*?)\\{\\{/participant_bic_fi}}";
            Matcher matcher = Pattern.compile(blockRegex).matcher(template);

            if (matcher.find()) {
                String blockBody = matcher.group(1);
                String expandedBlock = blockBody.replace("{{participant_bic_fi}}", EQUITY_SWIFT_BIC_CODE);
                template = template.replace(matcher.group(0), expandedBlock);
            } else {
                log.warn("{}: No participant_bic_fi block found in ACMT024 template", rrn);
            }

            return template;

        } catch (Exception e) {
            log.error("{}: Error composing acmt.024 success response: {}", rrn, e.getMessage());
            throw new CustomException("Error composing acmt.024 success response: " + e.getMessage());
        }
    }

    @Override
    public String composeAcmt024NamecheckFailureResponse(String rrn, Map<String, String> requestMap, String errorCode)
            throws CustomException {
        try {
            if (requestMap == null || requestMap.isEmpty()) {
                throw new CustomException("Inbound requestMap cannot be null or empty");
            }

            // === Extract inbound values ===
            String originalBizMsgId = requireValue(requestMap, "bizMsgId");
            String senderInstitutionId = requireValue(requestMap, "senderInstitutionId");
            String senderBic = requireValue(requestMap, "senderBic");
            String accountNumber = requireValue(requestMap, "accountNumber");
            String originalId = requireValue(requestMap, "originalId");

            // === Your side ===
            String participantMmbId = "KE1011";
            String papssMmb = "XA0001";

            // === Build IDs ===
            String rspBizMsgId = originalBizMsgId + "-RSP";
            String timestamp = dateService.getCurrentIsoDateAndTime();

            // === Load XML template ===
            String template = loadTemplate("/templates/ACMT024_RCT.xml");

            // === Fill placeholders ===
            template = template
                    .replace("{{clearing_sys_id_prtry}}", StatusCodeMessages.CLEARING_SYSTEM_ID)
                    .replace("{{participant_member_id}}", participantMmbId)
                    .replace("{{participant_clearing_system_id}}", papssMmb)
                    .replace("{{message_id}}", rspBizMsgId)
                    .replace("{{msg_def_idr}}", "acmt.024.001.02")
                    .replace("{{create_date_time}}", timestamp)
                    .replace("{{assignee_member_id}}", senderInstitutionId)
                    .replace("{{original_assignment_message_id}}", originalBizMsgId)
                    .replace("{{rpt_original_id}}", originalId)
                    .replace("{{rpt_vrfctn}}", "false")
                    .replace("{{reject_reason}}", errorCode)
                    .replace("{{account_number}}", accountNumber)
                    .replace("{{scheme_name_cd}}", PAPSS_SCHEMA_NAME);

            // === Handle {{#participant_bic_fi}} block correctly ===
            String blockRegex = "\\{\\{#participant_bic_fi}}([\\s\\S]*?)\\{\\{/participant_bic_fi}}";
            Matcher matcher = Pattern.compile(blockRegex).matcher(template);

            if (matcher.find()) {
                String blockBody = matcher.group(1);
                String expandedBlock = blockBody.replace("{{participant_bic_fi}}", EQUITY_SWIFT_BIC_CODE);
                template = template.replace(matcher.group(0), expandedBlock);
            } else {
                log.warn("{}: No participant_bic_fi block found in ACMT024_RCT template", rrn);
            }

            return template;

        } catch (Exception e) {
            log.error("{}: Error composing acmt.024 failure response: {}", rrn, e.getMessage());
            throw new CustomException("Error composing acmt.024 failure response: " + e.getMessage());
        }
    }

    @Override
    public String composePacs002SuccessResponse(Map<String, String> requestMap) throws CustomException {
        try {
            String papssId = papssIdResolverService.resolvePapssId();
            String template = loadTemplate("/templates/PACS002.xml");

            // Generate timestamps
            String creationTime = dateService.getCurrentIsoDateAndTime();

            // Replace placeholders
            template = template
                    .replace("{{fr_bicfi}}", EQUITY_SWIFT_BIC_CODE)
                    .replace("{{fr_memberId}}", papssId)
                    .replace("{{member_id}}", StatusCodeMessages.PARTICIPANT_CLEARING_SYSTEM_ID)
//                    .replace("{{messageId}}", requestMap.get("messageId"))
                    .replace("{{messageId}}", generateMessageId(papssId))
                    .replace("{{create_date}}", creationTime)
                    .replace("{{creationDateTime}}", creationTime)
                    .replace("{{original_messageId}}", requestMap.get("messageId"))
                    .replace("{{grp_sts}}", ACCP.name())
                    .replace("{{original_instrumentId}}", requestMap.get("papssMessageId"))
                    .replace("{{original_endToEndId}}", requestMap.get("endToEndId"))
                    .replace("{{original_transactionId}}", requestMap.get("papssMessageId"))
//                    .replace("{{acceptance_dateTime}}", creationTime)
                    .replace("{{acceptance_dateTime}}", requestMap.get("acceptanceTime"))
                    .replace("{{local_instrument}}", requestMap.get("local_instrument"))
                    .replace("{{ctgy_purp}}", requestMap.get("ctgy_purp"))
                    .replace("{{dbtr_bicFi}}", requestMap.get("senderBic"))
                    .replace("{{dbtr_memberId}}", requestMap.get("senderInstitutionId"));

            return template;

        } catch (Exception e) {
            throw new CustomException("Error composing pacs.002 success: " + e.getMessage());
        }
    }


    @Override
    public String composePacs002FailureResponse(Map<String, String> requestMap, String errorCode) throws CustomException {
        try {
            String papssId = papssIdResolverService.resolvePapssId();

            String template = loadTemplate("/templates/PACS002_RJCT.xml");

            // Generate timestamps
            String creationTime = dateService.getCurrentIsoDateAndTime();

            template = template
                    .replace("{{fr_memberId}}", papssIdResolverService.resolvePapssId())
//                    .replace("{{messageId}}", requestMap.get("messageId"))
                    .replace("{{messageId}}", generateMessageId(papssId))
                    .replace("{{create_date}}", creationTime)
                    .replace("{{creationDateTime}}", creationTime)
                    .replace("{{original_messageId}}", requestMap.get("messageId"))
                    .replace("{{original_instrumentId}}", requestMap.get("papssMessageId"))
                    .replace("{{original_endToEndId}}", requestMap.get("endToEndId"))
                    .replace("{{original_transactionId}}", requestMap.get("papssMessageId"))
                    .replace("{{grp_sts}}", RJCT.name())
                    .replace("{{reason_code}}", errorCode)
                    .replace("{{acceptance_dateTime}}", creationTime)
                    .replace("{{local_instrument}}", requestMap.get("local_instrument"))
                    .replace("{{dbtr_memberId}}", requestMap.get("senderInstitutionId"));

            return template;

        } catch (Exception e) {
            throw new CustomException("Error composing pacs.002 failure: " + e.getMessage());
        }
    }

    @Override
    public String composePacs004Reversal(Map<String, String> requestMap, String errorCode) {
        return "";
    }

    public static String generateMessageId(String senderPapssId) {
        OffsetDateTime now = OffsetDateTime.now(ZoneOffset.UTC);
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyyMMdd");
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HHmmss");

        String extractedDate = now.format(dateFormatter);
        String extractedTime = now.format(timeFormatter);

        return extractedDate + senderPapssId + extractedTime;
    }

    private String loadTemplate(String path) throws Exception {
        try (InputStream inputStream = getClass().getResourceAsStream(path)) {
            if (inputStream == null) {
                throw new CustomException("Template not found: " + path);
            }
            return new String(inputStream.readAllBytes(), StandardCharsets.UTF_8);
        }
    }

    /**
     * Helper to enforce presence of required XML fields.
     */
    private String requireValue(Map<String, String> map, String key) throws CustomException {
        String value = map.get(key);
        if (value == null || value.isBlank()) {
            log.warn("Missing mandatory value for key: " + key);
//            throw new CustomException("Missing mandatory value for key: " + key);
            return "";
        }
        return value;
    }

}
