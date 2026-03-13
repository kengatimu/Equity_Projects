package com.equitybank.gag.telco_b2c.patterns.strategy.xmlReqProcessor.strategyService.impl;

import com.equitybank.gag.telco_b2c.dto.airtime.request.Envelope;
import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.mapper.CustomMapperService;
import com.equitybank.gag.telco_b2c.patterns.strategy.xmlReqProcessor.strategyService.XmlTypeProcessingStrategyService;
import com.equitybank.gag.telco_b2c.service.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.security.SignatureException;
import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.Map;

import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.FIELD_VALIDATION_ERROR;

@Service("sendValidationStrategy")
public class SendValidationStrategyService implements XmlTypeProcessingStrategyService {
    private static final Logger log = LoggerFactory.getLogger(SendValidationStrategyService.class);

    private final XmlProcessingCommonClassesService xmlProcessingCommonClassesService;
    private final XmlFieldsValidatorService xmlFieldsValidatorService;
    private final TransactionValidationAndMappingService transactionValidationAndMappingService;
    private final CustomMapperService customMapperService;
    private final ImtCallerService imtCallerService;

    public SendValidationStrategyService(XmlProcessingCommonClassesService xmlProcessingCommonClassesService,
                                         XmlFieldsValidatorService xmlFieldsValidatorService,
                                         TransactionValidationAndMappingService transactionValidationAndMappingService,
                                         CustomMapperService customMapperService,
                                         ImtCallerService imtCallerService) {
        this.xmlProcessingCommonClassesService = xmlProcessingCommonClassesService;
        this.xmlFieldsValidatorService = xmlFieldsValidatorService;
        this.transactionValidationAndMappingService = transactionValidationAndMappingService;
        this.customMapperService = customMapperService;
        this.imtCallerService = imtCallerService;
    }

    @Override
    public String process(boolean isInternal, String requestXml, Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException, SignatureException {
        // Validate request input structure and signature
        validateRequest(isInternal, xmlTagsMap, rrn, type);

        // Validate amounts and update the DB record with incoming request fields
        validateAmountsAndUpdateTransactionRecordWithRequestInputs(rrn, xmlTagsMap, type);

        // Format DOB into timestamp format
        requestXml = formatDOB(requestXml, xmlTagsMap, type);

        // Add <poeCapabilities> XML block before closing tag
        requestXml = addPoeCapabilities(requestXml);

        // Get bank ID from XML
        String bankId = xmlTagsMap.getOrDefault("bankId", "");

        // Retrieve the saved DB record
        TransactionDetails transactionDetails = xmlProcessingCommonClassesService.getSavedDbRecord(rrn, type);

        // Send request and get XML response
        String responseXml = xmlProcessingCommonClassesService.sendRequestAndGetResponse(transactionDetails, xmlTagsMap, bankId, requestXml, type, rrn);

        // Return final response
        return processResponse(transactionDetails, bankId, rrn, responseXml, type, false);
    }

    private void validateRequest(boolean isInternal, Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException, SignatureException {
        xmlFieldsValidatorService.validateXmlRequestFields(xmlTagsMap, type);
        transactionValidationAndMappingService.validateSignature(isInternal, xmlTagsMap, new request(), new Envelope(), rrn, type);
    }

    private void validateAmountsAndUpdateTransactionRecordWithRequestInputs(String rrn, Map<String, String> xmlTagsMap, String type) throws CustomException {
        // Get the existing record from DB
        TransactionDetails existing = transactionValidationAndMappingService.getDatabaseRecord(rrn, type);

        // Validate amounts: Fee lookup amounts should be the same with validation amounts
        validateAmountWithFeeLookupAmounts(rrn, xmlTagsMap, existing);

        // Update the existing record with send validation details
        TransactionDetails entity = customMapperService.composeTransactionRecordEntity(existing, xmlTagsMap, type);
        if (entity != null) {
            xmlProcessingCommonClassesService.updateDatabaseRecord(entity, rrn, type);
        }
    }

    private void validateAmountWithFeeLookupAmounts(String rrn, Map<String, String> xmlTagsMap, TransactionDetails existing) throws CustomException {
        // Retrieve the stored fee lookup amount
        BigDecimal feeLookupAmount = existing.getAmount();

        // Retrieve the validation amount supplied in the XML map
        String validationAmountStr = xmlTagsMap.get("amount");

        try {
            // Convert to BigDecimal
            BigDecimal validationAmount = new BigDecimal(validationAmountStr.trim());

            // Normalize both to 2 decimal places to handle 20 vs 20.00 comparisons
            BigDecimal normalizedFeeLookup = feeLookupAmount.setScale(2, RoundingMode.HALF_UP);
            BigDecimal normalizedValidation = validationAmount.setScale(2, RoundingMode.HALF_UP);

            // Compare the two amounts
            if (normalizedFeeLookup.compareTo(normalizedValidation) != 0) {
                String errorMsg = String.format("[%s] Amount mismatch: Fee lookup amount (%s) differs from validation amount (%s).", rrn, normalizedFeeLookup, normalizedValidation);
                log.error(errorMsg);
                throw new CustomException(FIELD_VALIDATION_ERROR + "The amount supplied from Fee lookup is different from the one supplied in the send validation request.");
            }

        } catch (NumberFormatException e) {
            String errorMsg = String.format("[%s] Invalid number format for validation amount: %s", rrn, validationAmountStr);
            log.error(errorMsg, e);
            throw new CustomException(FIELD_VALIDATION_ERROR + "Invalid validation amount format supplied in the request.");
        }
    }

    private String formatDOB(String requestXml, Map<String, String> xmlTagsMap, String type) {
        String dob = "moneygram-send-validation-request".equals(type)
                ? xmlTagsMap.get("senderDOB")
                : xmlTagsMap.get("receiverDOB");

        String dobTimeStamp = getDobTimeStamp(dob);

        // Update requestXml senderDob tag
        return refactorRequestXml(requestXml, dobTimeStamp, type);
    }

    private String addPoeCapabilities(String requestXml) {
        String snippet = """
            <poeCapabilities>
                <poeCapability>
                    <infoKey>returnReferenceNumber</infoKey>
                    <value>true</value>
                </poeCapability>
            </poeCapabilities>
        """;
        return requestXml.replace("</sendValidationRequest>", snippet + "</sendValidationRequest>");
    }

    private String getDobTimeStamp(String senderDob) {
        // Parse the input date
        LocalDate localDate = LocalDate.parse(senderDob);

        // Add time and set GMT+3 offset
        OffsetDateTime offsetDateTime = localDate.atStartOfDay().atOffset(ZoneOffset.ofHours(3));

        // Define the desired output format
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSXXX");

        // Format the date
        return offsetDateTime.format(formatter);
    }

    private String refactorRequestXml(String requestXml, String dobTimeStamp, String type) {
        int endIndex;
        int startIndex;

        // Extract the current DOB
        if ("moneygram-send-validation-request".equals(type)) {
            startIndex = requestXml.indexOf("<senderDOB>") + "<senderDOB>".length();
            endIndex = requestXml.indexOf("</senderDOB>");
        } else {
            startIndex = requestXml.indexOf("<receiverDOB>") + "<receiverDOB>".length();
            endIndex = requestXml.indexOf("</receiverDOB>");
        }

        if (endIndex != -1) {
            // Replace the value in the string
            return requestXml.substring(0, startIndex) + dobTimeStamp + requestXml.substring(endIndex);
        } else {
            log.warn("The <senderDOB> tag was not found in the XML!");
        }
        return requestXml;
    }

    private String processResponse(TransactionDetails transactionDetails, String bankId, String rrn, String responseXml, String type, boolean readResponseString) throws CustomException {
        return imtCallerService.processResponse(transactionDetails, bankId, rrn, responseXml, type, readResponseString);
    }
}
