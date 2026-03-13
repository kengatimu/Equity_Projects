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

import java.security.SignatureException;
import java.time.LocalDate;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.Map;

@Service("receiveValidationStrategy")
public class ReceiveValidationStrategyService implements XmlTypeProcessingStrategyService {
    private static final Logger log = LoggerFactory.getLogger(ReceiveValidationStrategyService.class);

    private final XmlFieldsValidatorService xmlFieldsValidatorService;
    private final XmlProcessingCommonClassesService xmlProcessingCommonClassesService;
    private final TransactionValidationAndMappingService transactionValidationAndMappingService;
    private final CustomMapperService customMapperService;
    private final ImtCallerService imtCallerService;

    public ReceiveValidationStrategyService(XmlFieldsValidatorService xmlFieldsValidatorService,
                                            XmlProcessingCommonClassesService xmlProcessingCommonClassesService,
                                            TransactionValidationAndMappingService transactionValidationAndMappingService,
                                            CustomMapperService customMapperService,
                                            ImtCallerService imtCallerService) {
        this.xmlFieldsValidatorService = xmlFieldsValidatorService;
        this.xmlProcessingCommonClassesService = xmlProcessingCommonClassesService;
        this.transactionValidationAndMappingService = transactionValidationAndMappingService;
        this.customMapperService = customMapperService;
        this.imtCallerService = imtCallerService;
    }

    @Override
    public String process(boolean isInternal, String requestXml, Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException, SignatureException {

        // Validate XML request fields and signature
        validateRequest(isInternal, xmlTagsMap, rrn, type);

        // Update the database record with new input fields
        updateTransactionRecordWithRequestInputs(rrn, xmlTagsMap, type);

        // Format DOB field
        requestXml = formatDOB(requestXml, xmlTagsMap, type);

        // Get bank ID
        String bankId = xmlTagsMap.getOrDefault("bankId", "");

        // Retrieve DB record
        TransactionDetails transactionDetails = xmlProcessingCommonClassesService.getSavedDbRecord(rrn, type);

        // Send request externally and get response
        String responseXml = xmlProcessingCommonClassesService.sendRequestAndGetResponse(transactionDetails, xmlTagsMap, bankId, requestXml, type, rrn);

        // Process and return response
        return processResponse(transactionDetails, bankId, rrn, responseXml, type, false);
    }

    // Validates structure and signature of the request
    private void validateRequest(boolean isInternal, Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException, SignatureException {
        xmlFieldsValidatorService.validateXmlRequestFields(xmlTagsMap, type);
        transactionValidationAndMappingService.validateSignature(isInternal, xmlTagsMap, new request(), new Envelope(), rrn, type);
    }

    private void updateTransactionRecordWithRequestInputs(String rrn, Map<String, String> xmlTagsMap, String type) throws CustomException {
        TransactionDetails transactionRecord = transactionValidationAndMappingService.getDatabaseRecord(rrn, type);
        TransactionDetails entity = customMapperService.composeTransactionRecordEntity(transactionRecord, xmlTagsMap, type);
        if (entity != null) {
            xmlProcessingCommonClassesService.updateDatabaseRecord(entity, rrn, type);
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
