package com.equitybank.gag.papss.ots.service.impl;

import com.equitybank.gag.papss.ots.dto.channelRequest.namecheck.ChannelNamecheckDetailsReq;
import com.equitybank.gag.papss.ots.dto.channelRequest.statusCheck.ChannelStatusCheckDetailsReq;
import com.equitybank.gag.papss.ots.dto.channelRequest.transaction.ChannelCreditTransferDetailsReq;
import com.equitybank.gag.papss.ots.entity.TransactionMaster;
import com.equitybank.gag.papss.ots.exception.CustomException;
import com.equitybank.gag.papss.ots.jpos.space.configs.JposConstants;
import com.equitybank.gag.papss.ots.service.DateService;
import com.equitybank.gag.papss.ots.service.ISOPayloadXmlComposerService;
import org.jpos.transaction.Context;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.InputStream;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.nio.charset.StandardCharsets;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.Map;

import static com.equitybank.gag.papss.ots.config.ApplicationConstants.*;

@Service
public class ISOPayloadXmlComposerServiceImpl implements ISOPayloadXmlComposerService {
    private static final Logger log = LoggerFactory.getLogger(ISOPayloadXmlComposerServiceImpl.class);

    private final String papssId;
    private final DateService dateService;

    @Autowired
    public ISOPayloadXmlComposerServiceImpl(@Value("${papss.equity-bank-id}") String papssId,
                                            DateService dateService) {
        this.papssId = papssId;
        this.dateService = dateService;
    }

    @Override
    public String composeAcmt023NamecheckRequest(ChannelNamecheckDetailsReq req) throws CustomException {
        try {
            String messageId = generateMessageId(papssId);
            String currentIsoDateTime = dateService.getCurrentIsoDateAndTime();
            String template = loadTemplate("/templates/ACMT023.xml");

            // Handle the {{#sender_bic_code}}...{{/sender_bic_code}} block manually
            if (req.getSender().getBic() != null && !req.getSender().getBic().isEmpty()) {
                // Replace block with <BICFI>value</BICFI>
                template = template.replaceAll("\\{\\{#sender_bic_code}}.*?\\{\\{/sender_bic_code}}", "<BICFI>" + req.getSender().getBic() + "</BICFI>");
            } else {
                // Remove the whole block if no value
                template = template.replaceAll("\\{\\{#sender_bic_code}}.*?\\{\\{/sender_bic_code}}", "");
            }

            // Do the standard replacements
            return template
                    .replace("{{sender_papss_id}}", req.getSender().getInstitutionId())
                    .replace("{{receiver_papss_id}}", req.getReceiver().getInstitutionId())
                    .replace("{{toClearingSystemId}}", DEFAULT_PAPSS_CLEARING_SYSTEM_ID)
                    .replace("{{account_number}}", req.getReceiver().getAccountNumber())
                    .replace("{{messageId}}", messageId)
                    .replace("{{creationDateTime}}", currentIsoDateTime);

        } catch (Exception e) {
            throw new CustomException("Error composing acmt.023 request: " + e.getMessage());
        }
    }

    @Override
    public String composePacs008TransactionRequest(Context ctx, ChannelCreditTransferDetailsReq req) throws CustomException {
        try {
            String rrn = req.getChannelInfo().getRrn();
            String currentIsoDateTime = dateService.getCurrentIsoDateAndTime();
            String currentIsoDateSimple = dateService.getCurrentIsoDateOnly();
            String endToEndId = dateService.getEndToEndId(rrn, req.getSender().getInstitutionId());
            String senderAmount = req.getTransactionInfo().getSenderAmount();
            String receiverAmount = req.getTransactionInfo().getReceiverAmount();
            BigDecimal senderAmountBigDecimal = new BigDecimal(senderAmount).setScale(2, RoundingMode.HALF_UP);
            BigDecimal receiverAmountBigDecimal = new BigDecimal(receiverAmount).setScale(2, RoundingMode.HALF_UP);

            // Get the generated papss message id from context
            String messageId = ctx.get(JposConstants.ISO20022_PACS008_TXN_ORIGINAL_MESSAGE_ID);
            if  (messageId == null) {
                messageId = generateMessageId(papssId);
            }

            // Compose instrument type
            String instrumentCode = DEFAULT_LOCAL_INSTRUMENT_CODE;
            String senderCurrency = req.getSender().getCurrency();
            String receiverCurrency = req.getReceiver().getCurrency();
            if ("USD".equalsIgnoreCase(senderCurrency) || "USD".equalsIgnoreCase(receiverCurrency)) {
                instrumentCode = DEFAULT_USD_INSTRUMENT_CODE;
            }

//            String endToEndId = dateService.getEndToEndId(rrn, req.getSender().getInstitutionId(), req.getReceiver().getInstitutionId());

            // Put messageId and creationDateTime in jpos context
            ctx.put(JposConstants.ISO20022_PACS008_END_TO_END_ID, endToEndId);
            ctx.put(JposConstants.ISO20022_PACS008_TXN_ORIGINAL_MESSAGE_ID, messageId);
            ctx.put(JposConstants.ISO20022_PACS008_TXN_CREATION_DATE_AND_TIME, currentIsoDateTime);

            // Load PACS008 xml template
            String template = loadTemplate("/templates/PACS008.xml");

            // Conditional BIC blocks replacements
            if (req.getSender().getBic() != null && !req.getSender().getBic().isEmpty()) {
                template = template.replaceAll("\\{\\{#sender_bic_id}}.*?\\{\\{/sender_bic_id}}", "<BICFI>" + req.getSender().getBic() + "</BICFI>");
            } else {
                template = template.replaceAll("\\{\\{#sender_bic_id}}.*?\\{\\{/sender_bic_id}}", "");
            }

            if (req.getReceiver().getBic() != null && !req.getReceiver().getBic().isEmpty()) {
                template = template.replaceAll("\\{\\{#receiver_bic_id}}.*?\\{\\{/receiver_bic_id}}", "<BICFI>" + req.getReceiver().getBic() + "</BICFI>");
            } else {
                template = template.replaceAll("\\{\\{#receiver_bic_id}}.*?\\{\\{/receiver_bic_id}}", "");
            }

            // Standard replacements
            return template
                    .replace("{{sender_papss_id}}", req.getSender().getInstitutionId())
                    .replace("{{sender_account_number}}", req.getSender().getAccountNumber())
                    .replace("{{sender_account_name}}", req.getSender().getAccountName())
                    .replace("{{sender_country}}", req.getSender().getCountryCode())
                    .replace("{{sender_address}}", req.getSender().getAddress())
                    .replace("{{sender_currency}}", senderCurrency)
                    .replace("{{sender_amount}}", senderAmountBigDecimal.toString())
                    .replace("{{receiver_papss_id}}", req.getReceiver().getInstitutionId())
                    .replace("{{receiver_account_number}}", req.getReceiver().getAccountNumber())
                    .replace("{{receiver_account_name}}", req.getReceiver().getAccountName())
                    .replace("{{receiver_country}}", req.getReceiver().getCountryCode())
                    .replace("{{receiver_address}}", req.getReceiver().getEmailAddress())
                    .replace("{{receiver_currency}}", receiverCurrency)
                    .replace("{{receiver_amount}}", receiverAmountBigDecimal.toString())
                    .replace("{{fx_rate}}", req.getTransactionInfo().getFxRate())
                    .replace("{{purpose_code}}", DEFAULT_PAPSS_CATEGORY_PURPOSE)
                    .replace("{{instrm_type}}", instrumentCode)
                    .replace("{{ctgy_purp}}", DEFAULT_PAPSS_PURPOSE_CODE)
                    .replace("{{narration}}", req.getTransactionInfo().getNarration())
                    .replace("{{transactionChannel}}", DEFAULT_PAPSS_TRANSACTION_CHANNEL)
                    .replace("{{end_to_end_ref}}", endToEndId)
                    .replace("{{toClearingSystemId}}", DEFAULT_PAPSS_CLEARING_SYSTEM_ID)
                    .replace("{{messageId}}", messageId)
                    .replace("{{creationDateTime}}", currentIsoDateTime)
                    .replace("{{creationDateSimple}}", currentIsoDateSimple);

        } catch (Exception e) {
            throw new CustomException("Error composing pacs.008 request: " + e.getMessage());
        }
    }

    @Override
    public String composePacs028StatusCheckRequest(ChannelStatusCheckDetailsReq req, TransactionMaster existingRecord) throws CustomException {
        try {
            String messageId = generateMessageId(papssId);
            String currentIsoDateTime = dateService.getCurrentIsoDateAndTime();
            String originalTransactionDateTime = existingRecord.getPapssTxnCreationTime();
            String originalMessageId = existingRecord.getPapssMessageId();

            String template = loadTemplate("/templates/PACS028.xml");

            return template
                    .replace("{{senderPapssId}}", req.getSender().getInstitutionId())
                    .replace("{{toClearingSystemId}}", DEFAULT_PAPSS_CLEARING_SYSTEM_ID)
                    .replace("{{originalMessageId}}", originalMessageId)
                    .replace("{{originalTransactionDateTime}}", originalTransactionDateTime)
                    .replace("{{messageId}}", messageId)
                    .replace("{{creationDateTime}}", currentIsoDateTime);

        } catch (Exception e) {
            throw new CustomException("Error composing pacs.028 request: " + e.getMessage());
        }
    }

    @Override
    public String composeFxRateUpdateRequest(Map<String, String> fxRateParamsMap) throws CustomException {

        try {
            // Mandatory fields validation (fail fast)
            String[] requiredKeys = {"accountType", "buyRate", "sellRate", "countryCode", "localCurrency", "fxRateName"};

            for (String key : requiredKeys) {
                if (!fxRateParamsMap.containsKey(key) || fxRateParamsMap.get(key) == null) {
                    throw new CustomException("Missing required FX rate field: " + key);
                }
            }

            String messageId = generateMessageId(papssId);
            String creationDateTime = dateService.getCurrentIsoDateAndTime();

            String template = loadTemplate("/templates/POST_FX_RATE.xml");

            return template
                    .replace("{{senderPapssId}}", papssId)
                    .replace("{{messageId}}", messageId)
                    .replace("{{creationDateTime}}", creationDateTime)
                    .replace("{{accountType}}", fxRateParamsMap.get("accountType"))
                    .replace("{{buyRate}}", fxRateParamsMap.get("buyRate"))
                    .replace("{{sellRate}}", fxRateParamsMap.get("sellRate"))
                    .replace("{{countryCode}}", fxRateParamsMap.get("countryCode"))
                    .replace("{{localCurrency}}", fxRateParamsMap.get("localCurrency"))
                    .replace("{{fxRateName}}", fxRateParamsMap.get("fxRateName"));

        } catch (Exception e) {
            throw new CustomException("Error composing FX rate update request: " + e.getMessage());
        }
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
}
