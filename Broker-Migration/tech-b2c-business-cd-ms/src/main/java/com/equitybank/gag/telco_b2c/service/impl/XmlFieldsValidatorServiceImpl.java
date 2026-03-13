package com.equitybank.gag.telco_b2c.service.impl;

import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.service.TransactionValidationAndMappingService;
import com.equitybank.gag.telco_b2c.service.XmlFieldsValidatorService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.Map;
import java.util.Set;

import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.CURRENCY_MISMATCH;
import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.FIELD_VALIDATION_ERROR;

@Service
public class XmlFieldsValidatorServiceImpl implements XmlFieldsValidatorService {
    private static final Logger log = LoggerFactory.getLogger(XmlFieldsValidatorServiceImpl.class);
    private static final String PRODUCT_TYPE = "SEND";
    private static final Set<String> THIRD_PARTY_SET = Set.of("NONE", "ORG", "PERSON");

    private final TransactionValidationAndMappingService transactionValidationAndMappingService;

    @Autowired
    public XmlFieldsValidatorServiceImpl(TransactionValidationAndMappingService transactionValidationAndMappingService) {
        this.transactionValidationAndMappingService = transactionValidationAndMappingService;
    }

    @Override
    public void validateXmlRequestFields(Map<String, String> xmlTagsMap, String type) throws CustomException {

        // Validate mandatory channel fields
        validateMandatoryChannelInfoFields(xmlTagsMap, type);

        // Validate request fields based on type
        switch (type) {
            case "moneygram-fee-lookup" -> validateMoneyGramFeeLookupFields(xmlTagsMap, type);
            case "moneygram-receive-reference-number-request" -> validateReferenceNumberRequestFields(xmlTagsMap);
            case "moneygram-get-field-for-product" -> validateGetFieldForProductFields(xmlTagsMap, type);
            case "moneygram-receive-get-field-for-product" -> validateReceiveGetFieldForProductFields(xmlTagsMap, type);
            case "moneygram-send-validation-request" -> validateSendValidationRequestFields(xmlTagsMap, type);
            case "moneygram-receive-validation-request" -> validateReceiverValidationRequestFields(xmlTagsMap);
            case "moneygram-commit-transaction" -> validateCommitTransactionRequestFields(xmlTagsMap, type);
            case "moneygram-receive-commit-transaction" ->
                    validateReceiveCommitTransactionRequestFields(xmlTagsMap, type);
            case "moneygram-detail-lookup" -> validateDetailLookupRequestFields(xmlTagsMap);
            case "moneygram-send-reversal" -> validateSendReversalRequestFields(xmlTagsMap);
            case "moneygram-amend-transaction" -> validateAmendTransactionRequestFields(xmlTagsMap);
            case "moneygram-receive-reversal" -> validateReceiverReversalRequestFields(xmlTagsMap);
            case "moneygram-code-table-service" -> validateCodeTableRequestFields(xmlTagsMap);
            default -> {
                if ("status-check-airtime".equals(type)
                        || "status-check-banktowallet".equals(type)
                        || "status-check-floatpurchase".equals(type)
                        || "bank-to-wallet-namecheck".equals(type)
                        || "airtime-topup-namecheck".equals(type)
                        || "float-purchase-namecheck".equals(type)) {
                    break;
                }
                throw new CustomException(String.format("%sUnknown request type: %s", FIELD_VALIDATION_ERROR, type));
            }
        }
    }

    private void validateMandatoryChannelInfoFields(Map<String, String> xmlTagsMap, String type) throws CustomException {
        Set<String> channelInfoSet;
        if ("bank-to-wallet-namecheck".equals(type)
                || "airtime-topup-namecheck".equals(type)
                || "float-purchase-namecheck".equals(type)) {
            channelInfoSet = Set.of("msgId", "channel", "bankId", "telcom", "mobileNumber", "signature");

        } else if ("status-check-airtime".equals(type)
                || "status-check-banktowallet".equals(type)
                || "status-check-floatpurchase".equals(type)) {
            channelInfoSet = Set.of("rrn", "channel", "bankId", "telco", "signature");

        } else {
            channelInfoSet = Set.of("rrn", "channelId", "sourceSystemId", "bankId", "signature");
        }

        // Validate mandatory fields
        for (String fieldName : channelInfoSet) {
            emptyFieldCheck(xmlTagsMap.get(fieldName), fieldName);
        }
    }

    private void validateMoneyGramFeeLookupFields(Map<String, String> xmlTagsMap, String type) throws CustomException {
        validateAmountFields(xmlTagsMap, type);
        validateCountryCode(xmlTagsMap.get("receiveCountry"), "receiveCountry");
    }

    private void validateGetFieldForProductFields(Map<String, String> xmlTagsMap, String type) throws CustomException {
        validateCountryCode(xmlTagsMap.get("receiveCountry"), "receiveCountry");
        validateDeliveryOption(xmlTagsMap.get("deliveryOption"));
        validateCurrencyCode(xmlTagsMap.get("receiveCurrency"), "receiveCurrency");
        validateAmountFields(xmlTagsMap, type);
        validateCurrencyCode(xmlTagsMap.get("sendCurrency"), "sendCurrency");
    }

    private void validateReceiveGetFieldForProductFields(Map<String, String> xmlTagsMap, String type) throws CustomException {
        validateCountryCode(xmlTagsMap.get("receiveCountry"), "receiveCountry");
        emptyFieldCheck(xmlTagsMap.get("thirdPartyType"), "thirdPartyType");
        validateCurrencyCode(xmlTagsMap.get("receiveCurrency"), "receiveCurrency");
        validateCurrencyCode(xmlTagsMap.get("sendCurrency"), "sendCurrency");
        validateAmountFields(xmlTagsMap, type);
        emptyFieldCheck(xmlTagsMap.get("productType"), "productType");
        emptyFieldCheck(xmlTagsMap.get("consumerId"), "consumerId");
        emptyFieldCheck(xmlTagsMap.get("formFreeStaging"), "formFreeStaging");
    }

    private void validateSendValidationRequestFields(Map<String, String> xmlTagsMap, String type) throws CustomException {
        validateAmountFields(xmlTagsMap, type);
        validateDeliveryOption(xmlTagsMap.get("deliveryOption"));
        validateCurrencyCode(xmlTagsMap.get("receiveCurrency"), "receiveCurrency");
        validateName(xmlTagsMap.get("senderFirstName"), "senderFirstName");
        validateName(xmlTagsMap.get("senderLastName"), "senderLastName");
        validateAddress(xmlTagsMap.get("senderAddress"), "senderAddress");
        validateCity(xmlTagsMap.get("senderCity"), "senderCity");
        validateSenderCountry(xmlTagsMap.get("senderCountry"));
        validateSenderHomePhone(xmlTagsMap.get("senderHomePhone"));
        validateName(xmlTagsMap.get("receiverFirstName"), "receiverFirstName");
        validateName(xmlTagsMap.get("receiverLastName"), "receiverLastName");
        validateSenderPhotoIdType(xmlTagsMap.get("senderPhotoIdType"));
        validateSenderPhotoIdNumber(xmlTagsMap.get("senderPhotoIdNumber"));
        validateSenderPhotoIdCountry(xmlTagsMap.get("senderPhotoIdCountry"));
        validateSenderDOB(xmlTagsMap.get("senderDOB"));
        validateMgiTransactionSessionID(xmlTagsMap.get("mgiTransactionSessionID"));
    }

    private void validateReceiverValidationRequestFields(Map<String, String> xmlTagsMap) throws CustomException {
        validateNotEmpty(xmlTagsMap.get("operatorName"), "operatorName");
        validateReferenceNumberField(xmlTagsMap.get("referenceNumber"));
        validateCurrencyCode(xmlTagsMap.get("receiveCurrency"), "receiveCurrency");
        validateAmountField(xmlTagsMap.get("agentCheckAmount"), "agentCheckAmount", "agentCheckAmount");
        validateAddress(xmlTagsMap.get("receiverAddress"), "receiverAddress");
        validateCity(xmlTagsMap.get("receiverCity"), "receiverCity");
        validateCountryCode(xmlTagsMap.get("receiverCountry"), "receiverCountry");
        validateNotEmpty(xmlTagsMap.get("receiverPhotoIdType"), "receiverPhotoIdType");
        validatePhotoIdNumber(xmlTagsMap.get("receiverPhotoIdNumber"));
        validateCountryCode(xmlTagsMap.get("receiverPhotoIdCountry"), "receiverPhotoIdCountry");
        validateReceiverDOB(xmlTagsMap.get("receiverDOB"));
        validateConsumerId(xmlTagsMap.get("consumerId"));
        validateMgiTransactionSessionID(xmlTagsMap.get("mgiTransactionSessionID"));
        validateFormFreeStaging(xmlTagsMap.get("formFreeStaging"));
        validatePhoneCountryCode(xmlTagsMap.get("receiverPhoneCountryCode"), "receiverPhoneCountryCode");
    }

    private void validateCommitTransactionRequestFields(Map<String, String> xmlTagsMap, String type) throws CustomException {
        validateMgiTransactionSessionID(xmlTagsMap.get("mgiTransactionSessionID"));
        validateNotEmpty(xmlTagsMap.get("senderAccountNumber"), "senderAccountNumber");
        validateTransactionCurrency(xmlTagsMap.get("transactionCurrency"));
        validateNotEmpty(xmlTagsMap.get("callbackUrl"), "callbackUrl");
    }

    private void validateReceiveCommitTransactionRequestFields(Map<String, String> xmlTagsMap, String type) throws CustomException {
        validateMgiTransactionSessionID(xmlTagsMap.get("mgiTransactionSessionID"));
        validateNotEmpty(xmlTagsMap.get("receiverAccountNumber"), "receiverAccountNumber");
        validateTransactionCurrency(xmlTagsMap.get("transactionCurrency"));
        validateNotEmpty(xmlTagsMap.get("callbackUrl"), "callbackUrl");
    }

    private void validateTransactionCurrency(String transactionCurrency) throws CustomException {
        validateNotEmpty(transactionCurrency, "transactionCurrency");
        if (!transactionCurrency.equalsIgnoreCase("USD")) {
            throw new CustomException(String.format("%sTransaction currency can only be USD", FIELD_VALIDATION_ERROR));
        }
    }

    private void validateDetailLookupRequestFields(Map<String, String> xmlTagsMap) throws CustomException {
        validateNotEmpty(xmlTagsMap.get("referenceNumber"), "referenceNumber");
        validateNotEmpty(xmlTagsMap.get("includeUseData"), "includeUseData");
    }

    private void validateSendReversalRequestFields(Map<String, String> xmlTagsMap) throws CustomException {
        validateAmountField(xmlTagsMap.get("sendAmount"), "sendAmount", "sendAmount");
        ValidateFeeAmount(xmlTagsMap.get("feeAmount"));
        validateNotEmpty(xmlTagsMap.get("sendCurrency"), "sendCurrency");
        validateNotEmpty(xmlTagsMap.get("referenceNumber"), "referenceNumber");
        validateNotEmpty(xmlTagsMap.get("reversalType"), "reversalType");
        validateSendReversalReason(xmlTagsMap);
    }

    private void validateSendReversalReason(Map<String, String> xmlTagsMap) throws CustomException {
        // sendReversalReason is mandatory if reversalType value is R
        String reversalTypeValue = xmlTagsMap.get("reversalType");
        if (reversalTypeValue.equalsIgnoreCase("R")) {
            validateNotEmpty(xmlTagsMap.get("sendReversalReason"), "sendReversalReason");
        }
    }

    private void validateReceiverReversalRequestFields(Map<String, String> xmlTagsMap) throws CustomException {
        validateAmountField(xmlTagsMap.get("receiveAmount"), "receiveAmount", "receiveAmount");
        validateNotEmpty(xmlTagsMap.get("referenceNumber"), "referenceNumber");
        validateNotEmpty(xmlTagsMap.get("receiveReversalReason"), "receiveReversalReason");
    }

    private void validateAmendTransactionRequestFields(Map<String, String> xmlTagsMap) throws CustomException {
        validateNotEmpty(xmlTagsMap.get("referenceNumber"), "referenceNumber");
        validateNotEmpty(xmlTagsMap.get("operatorName"), "operatorName");
        validateNotEmpty(xmlTagsMap.get("receiverFirstName"), "receiverFirstName");
        validateNotEmpty(xmlTagsMap.get("receiverLastName"), "receiverLastName");
    }

    private void validateCodeTableRequestFields(Map<String, String> xmlTagsMap) throws CustomException {
        validateNotEmpty(xmlTagsMap.get("agentAllowedOnly"), "agentAllowedOnly");
    }

    private void validateReferenceNumberRequestFields(Map<String, String> xmlTagsMap) throws CustomException {
        validatePinField(xmlTagsMap.get("pin"));
        validateOperatorNameField(xmlTagsMap.get("operatorName"));
        validateReferenceNumberField(xmlTagsMap.get("referenceNumber"));
    }

    private void validateMgiTransactionSessionID(String mgiTransactionSessionID) throws CustomException {
        emptyFieldCheck(mgiTransactionSessionID, "mgiTransactionSessionID");
        if (mgiTransactionSessionID.trim().length() > 38) {
            throw new CustomException(String.format("%smgiTransactionSessionID must not exceed size 38", FIELD_VALIDATION_ERROR));
        }
    }

    private void validatePhotoIdNumber(String receiverPhotoIdNumber) throws CustomException {
        // Check if receiverPhotoIdNumber field is empty or null
        emptyFieldCheck(receiverPhotoIdNumber, "receiverPhotoIdNumber");

        // Define the regex pattern for alphanumeric and hyphen (-) characters
        String regex = "^[a-zA-Z0-9-]+$";

        // Check if the string matches the regex and length requirements
        if (receiverPhotoIdNumber.trim().length() < 4 || receiverPhotoIdNumber.trim().length() > 25 || !receiverPhotoIdNumber.matches(regex)) {
            throw new CustomException(String.format("%sField %s Length or patten not allowed", FIELD_VALIDATION_ERROR, "receiverPhotoIdNumber"));
        }
    }

    private void validateReceiverDOB(String receiverDOB) throws CustomException {
        // Define the expected date format CCYY-MM-DD
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        try {
            // Parse the string into a LocalDate object
            LocalDate parsedDate = LocalDate.parse(receiverDOB, dateFormatter);

            // Get the current date
            LocalDate currentDate = LocalDate.now();

            // Check if the date is later than the current date
            if (parsedDate.isAfter(currentDate)) {
                throw new CustomException(String.format("%sField %s cannot be a future date", FIELD_VALIDATION_ERROR, "receiverDOB"));
            }
        } catch (DateTimeParseException e) {
            // If the date is in an invalid format
            throw new CustomException(String.format("%sField %s must be in the format CCYY-MM-DD", FIELD_VALIDATION_ERROR, "receiverDOB"));
        } catch (CustomException e) {
            throw new RuntimeException(e);
        }
    }

    private void ValidateFeeAmount(String feeAmount) throws CustomException {
        // Check if feeAmount field is empty or null
        emptyFieldCheck(feeAmount, "feeAmount");

        BigDecimal feeAmountB = new BigDecimal(feeAmount);
        if (feeAmountB.precision() > 14 || feeAmountB.scale() > 3) {
            throw new CustomException(String.format("%sField %s exceeds maximum allowed precision or scale", FIELD_VALIDATION_ERROR, "feeAmount"));
        }
    }

    private void validateRrn(String rrn) throws CustomException {
        emptyFieldCheck(rrn, "rrn");
        if (rrn.trim().length() != 12) {
            throw new CustomException(String.format("%sRRN must be of size 12", FIELD_VALIDATION_ERROR));
        }
    }

    private void validateProductType(String productType) throws CustomException {
        emptyFieldCheck(productType, "productType");
        if (!PRODUCT_TYPE.equals(productType)) {
            throw new CustomException(String.format("%sInvalid value for productType. Expected: %s", FIELD_VALIDATION_ERROR, PRODUCT_TYPE));
        }
    }

    private void validateCommitCurrency(Map<String, String> xmlTagsMap, String type) throws CustomException {
        String rrn = xmlTagsMap.get("rrn");
        String suppliedCurrency = xmlTagsMap.get("transactionCurrency");
        try {
            String senderCurrency = getSenderCurrency(rrn, type).getSenderCurrency();
            if (!suppliedCurrency.equalsIgnoreCase(senderCurrency)) {
                throw new CustomException(CURRENCY_MISMATCH);
            }
        } catch (CustomException e) {
            throw new CustomException(e.getMessage());
        }
    }

    private TransactionDetails getSenderCurrency(String rrn, String type) throws CustomException {
        return transactionValidationAndMappingService.getDatabaseRecord(rrn, type);
    }

    private void validateAmountFields(Map<String, String> xmlTagsMap, String type) throws CustomException {
        log.info("Validating Amount Fields");
        String amountIncludingFee = xmlTagsMap.get("amountIncludingFee");
        String amountExcludingFee = xmlTagsMap.get("amountExcludingFee");
        String receiveAmount;
        if ("moneygram-get-field-for-product".equals(type)
                || "moneygram-receive-get-field-for-product".equals(type)
                || "moneygram-send-validation-request".equals(type)
                || "moneygram-commit-transaction".equals(type)) {
            receiveAmount = xmlTagsMap.get("amount");
        } else {
            receiveAmount = xmlTagsMap.get("receiveAmount");
        }

        // Only one amount type is allowed. amountIncludingFee, amountExcludingFee, or receiveAmount
        int count = 0;
        if (amountIncludingFee != null && !amountIncludingFee.isBlank()) count++;
        if (amountExcludingFee != null && !amountExcludingFee.isBlank()) count++;
        if (receiveAmount != null && !receiveAmount.isBlank()) count++;

        if (count > 1) {
            throw new CustomException(String.format("%sOnly one of amountIncludingFee, amountExcludingFee, receiveAmount can be supplied", FIELD_VALIDATION_ERROR));
        }

        if (amountIncludingFee != null && !amountIncludingFee.isBlank()) {
            validateAmountField(amountIncludingFee, "amountIncludingFee", "amountIncludingFee");
        } else if (amountExcludingFee != null && !amountExcludingFee.isBlank()) {
            validateAmountField(amountExcludingFee, "amountExcludingFee", "amountExcludingFee");
        } else if (receiveAmount != null && !receiveAmount.isBlank()) {
            validateReceiveAmountField(receiveAmount);
        }
    }

    private void validateAmountField(String amount, String fieldName, String key) throws CustomException {
        emptyFieldCheck(amount, key);
        try {
            BigDecimal amountValue = new BigDecimal(amount);
            if (amountValue.compareTo(BigDecimal.ZERO) <= 0) {
                throw new CustomException(String.format("%sField %s must be greater than 0", FIELD_VALIDATION_ERROR, fieldName));
            }
            if (amountValue.precision() > 14 || amountValue.scale() > 3) {
                throw new CustomException(String.format("%sField %s exceeds maximum allowed precision or scale", FIELD_VALIDATION_ERROR, fieldName));
            }
        } catch (NumberFormatException e) {
            throw new CustomException(String.format("%sField %s is not a valid number", FIELD_VALIDATION_ERROR, fieldName));
        }
    }

    private void validateReceiveAmountField(String receiveAmount) throws CustomException {
        emptyFieldCheck(receiveAmount, "amount");

        if (receiveAmount.trim().length() > 9) {
            throw new CustomException(String.format("%sReceiveAmount exceeds maximum length of 9 characters", FIELD_VALIDATION_ERROR));
        }
        if (receiveAmount.contains(".")) {
            String[] parts = receiveAmount.split("\\.");
            if (parts.length > 1 && parts[1].trim().length() > 3) {
                throw new CustomException(String.format("%sReceiveAmount exceeds maximum of 3 decimal digits", FIELD_VALIDATION_ERROR));
            }
        }
        try {
            new BigDecimal(receiveAmount);
        } catch (NumberFormatException e) {
            throw new CustomException(String.format("%sReceiveAmount is not a valid number", FIELD_VALIDATION_ERROR));
        }
    }

    private void validateCountryCode(String countryCode, String key) throws CustomException {
        log.info("Validating " + key);
        emptyFieldCheck(countryCode, key);
        if (countryCode.trim().length() != 3) {
            throw new CustomException(FIELD_VALIDATION_ERROR + "Invalid country code. Must be a valid 3-character code");
        }
    }

    private void validateDeliveryOption(String deliveryOption) throws CustomException {
        emptyFieldCheck(deliveryOption, "deliveryOption");
    }

    private void validateConsumerId(String consumerId) throws CustomException {
        emptyFieldCheck(consumerId, "consumerId");
        if (consumerId.trim().length() > 20) {
            throw new CustomException(FIELD_VALIDATION_ERROR + "consumerId must not exceed 20 characters");
        }
    }

    private void validateFormFreeStaging(String formFreeStaging) throws CustomException {
        emptyFieldCheck(formFreeStaging, "formFreeStaging");
        if (!"true".equalsIgnoreCase(formFreeStaging) && !"false".equalsIgnoreCase(formFreeStaging)) {
            throw new CustomException(String.format("%sInvalid value for formFreeStaging. Expected 'true' or 'false'", FIELD_VALIDATION_ERROR));
        }
    }

    private void validateThirdPartyType(String thirdPartyType) throws CustomException {
        emptyFieldCheck(thirdPartyType, "thirdPartyType");
        if (!THIRD_PARTY_SET.contains(thirdPartyType)) {
            throw new CustomException(FIELD_VALIDATION_ERROR + "Invalid value for thirdPartyType. Valid values: NONE, ORG, PERSON");
        }
    }

    private void validateCurrencyCode(String currencyCode, String key) throws CustomException {
        emptyFieldCheck(currencyCode, key);
        if (currencyCode.trim().length() != 3) {
            throw new CustomException(FIELD_VALIDATION_ERROR + "Invalid currency code. Must be a valid 3-character code");
        }
    }

    private void validateName(String senderFirstName, String key) throws CustomException {
        emptyFieldCheck(senderFirstName, key);
        if (senderFirstName.trim().length() > 40) {
            throw new CustomException(FIELD_VALIDATION_ERROR + "Invalid senderFirstName. senderFirstName must not exceed 40 characters");
        }
    }

    private void validateAddress(String senderAddress, String key) throws CustomException {
        emptyFieldCheck(senderAddress, key);
        if (senderAddress.trim().length() > 80) {
            throw new CustomException(FIELD_VALIDATION_ERROR + "Invalid senderAddress. senderAddress must not exceed 80 characters");
        }
    }

    private void validateCity(String senderCity, String key) throws CustomException {
        emptyFieldCheck(senderCity, key);
        if (senderCity.trim().length() > 40) {
            throw new CustomException(FIELD_VALIDATION_ERROR + "Invalid senderCity. senderCity must not exceed 80 characters");
        }
    }

    private void validateSenderCountry(String countryCode) throws CustomException {
        emptyFieldCheck(countryCode, "senderCountry");
        if (countryCode.trim().length() != 3) {
            throw new CustomException(FIELD_VALIDATION_ERROR + "Invalid country code. Must be a valid 3-character code");
        }
    }

    private void validateSenderHomePhone(String senderHomePhone) throws CustomException {
        emptyFieldCheck(senderHomePhone, "senderHomePhone");
        if (senderHomePhone.trim().length() > 14) {
            throw new CustomException(FIELD_VALIDATION_ERROR + "Invalid senderHomePhone. senderHomePhone must not exceed 14 characters");
        }
    }

    private void validateSenderPhotoIdType(String senderPhotoIdType) throws CustomException {
        emptyFieldCheck(senderPhotoIdType, "senderPhotoIdType");
    }

    private void validateSenderPhotoIdNumber(String senderPhotoIdNumber) throws CustomException {
        // Check if the field is empty
        emptyFieldCheck(senderPhotoIdNumber, "senderPhotoIdNumber");

        // Check the length of the senderPhotoIdNumber
        int len = senderPhotoIdNumber.trim().length();
        if (len < 4 || len > 25) {
            throw new CustomException(FIELD_VALIDATION_ERROR + "Invalid senderPhotoIdNumber. Length must be between 4 and 25 characters.");
        }

        // Check if the senderPhotoIdNumber contains only allowed characters
        if (!senderPhotoIdNumber.matches("[a-zA-Z0-9-]+")) {
            throw new CustomException(FIELD_VALIDATION_ERROR + "Invalid senderPhotoIdNumber. Only alphanumeric characters and hyphens are allowed.");
        }
    }

    private void validateSenderPhotoIdCountry(String senderPhotoIdCountry) throws CustomException {
        emptyFieldCheck(senderPhotoIdCountry, "senderPhotoIdCountry");
        if (senderPhotoIdCountry.trim().length() != 3) {
            throw new CustomException(FIELD_VALIDATION_ERROR + "Invalid senderPhotoIdCountry. Must be a valid 3-character code");
        }
    }

    private void validateSenderDOB(String senderDOB) throws CustomException {
        emptyFieldCheck(senderDOB, "senderDOB");
    }

    private void validatePhoneCountryCode(String senderHomePhoneCountryCode, String key) throws CustomException {
        // Check if the field is empty
        emptyFieldCheck(senderHomePhoneCountryCode, key);

        // Check the length of the senderHomePhoneCountryCode
        if (senderHomePhoneCountryCode.trim().length() != 3) {
            throw new CustomException(FIELD_VALIDATION_ERROR + "Invalid senderHomePhoneCountryCode. Must be a 3-character numeric code.");
        }

        // Check if the senderHomePhoneCountryCode contains only 3 numeric characters
        if (!senderHomePhoneCountryCode.matches("\\d{3}")) {
            throw new CustomException(FIELD_VALIDATION_ERROR + "Invalid senderHomePhoneCountryCode. Must be numeric only.");
        }
    }

    private void validatePinField(String pin) throws CustomException {
        if (pin != null && !pin.isBlank()) {
            if (pin.trim().length() > 8) {
                throw new CustomException(FIELD_VALIDATION_ERROR + "pin must not exceed 8 characters");
            }
        }
    }

    private void validateOperatorNameField(String operatorName) throws CustomException {
        if (operatorName != null && !operatorName.isBlank()) {
            if (operatorName.trim().length() > 7) {
                throw new CustomException(FIELD_VALIDATION_ERROR + "operatorName must not exceed 7 characters");
            }
        }
    }

    private void validateReferenceNumberField(String referenceNumber) throws CustomException {
        emptyFieldCheck(referenceNumber, "referenceNumber");
        if (referenceNumber.trim().length() > 12) {
            throw new CustomException(FIELD_VALIDATION_ERROR + "referenceNumber must not exceed 12 characters");
        }
    }

    private void validateNotEmpty(String amount, String key) throws CustomException {
        emptyFieldCheck(amount, key);
    }

    private void validateBooleanField(String fieldValue) throws CustomException {
        emptyFieldCheck(fieldValue, "allOptions");
        if (!"true".equalsIgnoreCase(fieldValue) && !"false".equalsIgnoreCase(fieldValue)) {
            throw new CustomException(String.format("%sInvalid value for allOptions. Expected 'true' or 'false'", FIELD_VALIDATION_ERROR));
        }
    }

    private void emptyFieldCheck(String fieldValue, String key) throws CustomException {
        log.info("Key: " + key);
        log.info("value: " + fieldValue);
        if (fieldValue == null || fieldValue.isBlank()) {
            throw new CustomException(String.format("%s%s tag cannot be null or empty", FIELD_VALIDATION_ERROR, key));
        }
    }
}
