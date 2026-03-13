package com.equitybank.gag.telco_b2c.service.impl;

import com.equitybank.gag.telco_b2c.dto.thunes.staticData.StaticDataRequest;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.service.ThunesStaticDataProcessorService;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.DEFAULT_PROCESSING_FAILURE;

@Service
public class ThunesStaticDataProcessorServiceImpl implements ThunesStaticDataProcessorService {
    private static final Logger log = LoggerFactory.getLogger(ThunesStaticDataProcessorServiceImpl.class);

    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    public String getStaticData(StaticDataRequest staticDataRequest, String type) throws CustomException {
        String requestType = type.toLowerCase();

        return switch (requestType) {
            case "thunes-static-data-id-type" -> buildIdTypesJson();
            case "thunes-static-data-bank-account-type" -> buildBankAccountTypesJson();
            case "thunes-static-data-purpose-of-payment" -> buildPurposeOfPaymentJson(staticDataRequest);
            default -> throw new CustomException(DEFAULT_PROCESSING_FAILURE + " Unsupported type for static data: " + type);
        };
    }

    // Get Id Types Static Data
    private String buildIdTypesJson() throws CustomException {
        List<Map<String, String>> idTypes = new ArrayList<>();
        idTypes.add(Map.of("type", "PASSPORT", "description", "Passport"));
        idTypes.add(Map.of("type", "NATIONAL_ID", "description", "National Identification Card"));
        idTypes.add(Map.of("type", "DRIVING_LICENSE", "description", "Driving License"));
        idTypes.add(Map.of("type", "SOCIAL_SECURITY", "description", "Social Security Card/Number"));
        idTypes.add(Map.of("type", "TAX_ID", "description", "Tax Payer Identification Card/Number"));
        idTypes.add(Map.of("type", "SENIOR_CITIZEN_ID", "description", "Senior Citizen Identification Card"));
        idTypes.add(Map.of("type", "BIRTH_CERTIFICATE", "description", "Birth Certificate"));
        idTypes.add(Map.of("type", "VILLAGE_ELDER_ID", "description", "Village Elder Identification Card"));
        idTypes.add(Map.of("type", "RESIDENT_CARD", "description", "Permanent Residency Identification Card"));
        idTypes.add(Map.of("type", "ALIEN_REGISTRATION", "description", "Alien Registration Certificate/Card"));
        idTypes.add(Map.of("type", "PAN_CARD", "description", "PAN Card"));
        idTypes.add(Map.of("type", "VOTERS_ID", "description", "Voter’s Identification Card"));
        idTypes.add(Map.of("type", "HEALTH_CARD", "description", "Health Insurance Card/Number"));
        idTypes.add(Map.of("type", "EMPLOYER_ID", "description", "Employer Identification Card"));
        idTypes.add(Map.of("type", "OTHER", "description", "Others not listed"));
        return toJson(idTypes);
    }

    // Get Bank Account Types Static Data
    private String buildBankAccountTypesJson() throws CustomException {
        List<Map<String, String>> accountTypes = new ArrayList<>();
        accountTypes.add(Map.of("type", "CHECKING", "description", "Checking Account"));
        accountTypes.add(Map.of("type", "SAVINGS", "description", "Savings Account"));
        accountTypes.add(Map.of("type", "DEPOSIT", "description", "Deposit Account"));
        accountTypes.add(Map.of("type", "OTHERS", "description", "Other type of account"));
        return toJson(accountTypes);
    }

    // Get Purpose of Payment Static Data
    private String buildPurposeOfPaymentJson(StaticDataRequest staticDataRequest) throws CustomException {
        String rrn = staticDataRequest.getChannelInfo().getRrn();
        String countryCode = staticDataRequest.getReceiver().getCountryCode().trim().toUpperCase();
        log.info("{}, Getting purpose of payment for country code: {}", rrn, countryCode);

        List<Map<String, String>> purposes = new ArrayList<>();

        // If country = CHN (China), return Chinese-specific list
        if ("CHN".equals(countryCode)) {
            purposes.add(Map.of("type", "FAMILY_SUPPORT", "description", "Family support"));
            purposes.add(Map.of("type", "LIBERALIZED_REMITTANCE", "description", "Liberalized remittance"));
            purposes.add(Map.of("type", "CONSTRUCTION_EXPENSES", "description", "Construction expenses"));
            purposes.add(Map.of("type", "ADVERTISING_EXPENSES", "description", "Advertising and/or public relations related expenses"));
            purposes.add(Map.of("type", "ADVISORY_FEES", "description", "Fees for advisory or consulting service"));
            purposes.add(Map.of("type", "EXPORTED_GOODS", "description", "Payments for exported goods"));
            purposes.add(Map.of("type", "SERVICE_CHARGES", "description", "Payment for services"));
            purposes.add(Map.of("type", "PROPERTY_RENTAL", "description", "Property rental payment"));
            purposes.add(Map.of("type", "TAX_PAYMENT", "description", "Tax payment"));
            purposes.add(Map.of("type", "SALARY_PAYMENT", "description", "Payment of salary"));
        } else {
            purposes.add(Map.of("type", "OTHER_FEES", "description", "Broker, commitment, guarantee and other fees"));
            purposes.add(Map.of("type", "PROPERTY_PURCHASE", "description", "Residential property purchase"));
            purposes.add(Map.of("type", "SMALL_VALUE_REMITTANCE", "description", "Small value remittance"));
            purposes.add(Map.of("type", "LIBERALIZED_REMITTANCE", "description", "Liberalized remittance"));
            purposes.add(Map.of("type", "GIFT_AND_DONATION", "description", "Gift and other donations"));
            purposes.add(Map.of("type", "PROPERTY_RENTAL", "description", "Property rental payment"));
            purposes.add(Map.of("type", "SHARES_INVESTMENT", "description", "Investment in shares"));
            purposes.add(Map.of("type", "OTHER", "description", "Other purposes"));
            purposes.add(Map.of("type", "TAX_PAYMENT", "description", "Tax payment"));
            purposes.add(Map.of("type", "LOAN_PAYMENT", "description", "Payment of loans"));
            purposes.add(Map.of("type", "FAMILY_SUPPORT", "description", "Family support"));
            purposes.add(Map.of("type", "FUND_INVESTMENT", "description", "Fund investment"));
            purposes.add(Map.of("type", "SALARY_PAYMENT", "description", "Payment of salary"));
            purposes.add(Map.of("type", "REWARD_PAYMENT", "description", "Payment of rewards"));
            purposes.add(Map.of("type", "PERSONAL_TRANSFER", "description", "Personal transfer"));
        }
        return toJson(purposes);
    }

    // Convert List<Map> to JSON string
    private String toJson(Object data) throws CustomException {
        try {
            return objectMapper.writeValueAsString(data);
        } catch (Exception e) {
            throw new CustomException(DEFAULT_PROCESSING_FAILURE + " Error converting static data to JSON. " + e.getMessage());
        }
    }
}