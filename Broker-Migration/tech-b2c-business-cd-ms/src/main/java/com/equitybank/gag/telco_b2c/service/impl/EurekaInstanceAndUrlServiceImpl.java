package com.equitybank.gag.telco_b2c.service.impl;

import com.equitybank.gag.telco_b2c.config.ApplicationConstants;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.service.EurekaInstanceAndUrlService;
import com.equitybank.gag.telco_b2c.service.EurekaService;
import com.equitybank.gag.telco_b2c.service.TypeResolverService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import static com.equitybank.gag.telco_b2c.config.ApplicationConstants.*;
import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.DEFAULT_PROCESSING_FAILURE;
import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.EUREKA_FAILURE;

@Service
public class EurekaInstanceAndUrlServiceImpl implements EurekaInstanceAndUrlService {
    private static final Logger log = LoggerFactory.getLogger(EurekaInstanceAndUrlServiceImpl.class);

    private final EurekaService eurekaService;
    private final TypeResolverService typeResolverService;

    public EurekaInstanceAndUrlServiceImpl(EurekaService eurekaService,
                                           TypeResolverService typeResolverService) {
        this.eurekaService = eurekaService;
        this.typeResolverService = typeResolverService;
    }

    @Override
    public void checkInstanceStatus(String telco, String rrn) throws CustomException {
        String instanceName = eurekaService.getInstanceName(telco);
        String status = eurekaService.getInstanceStatus(telco);

        log.info("{}: Checking status for instance: {}. Status: {}", rrn, instanceName, status);
        if (!STATUS_UP.equalsIgnoreCase(status)) {
            throw new CustomException(String.format("%s%s is offline or not reachable. Status: %s", EUREKA_FAILURE, instanceName, status));
        }
    }

    @Override
    public String getUrl(String telco, String type) throws CustomException {
        try {
            // Handle Float Purchase type separately
            if ("floatPurchase".equalsIgnoreCase(type)) {
                return composeFloatPurchaseUrl(telco, type);
            }

            // Handle MoneyGram-related types
            if (typeResolverService.isMoneyGramService(type)) {
                return composeMoneyGramUrl(telco, type);
            }

            // Handle all other types
            return composeUrl(telco, type);

        } catch (CustomException e) {
            throw new CustomException(e.getMessage());
        }
    }

    private String composeFloatPurchaseUrl(String telco, String type) throws CustomException {
        String uri;
        if (telco.contains("AIRTEL")) {
            uri = ApplicationConstants.AIRTEL_MONEY_FLOAT_PURCHASE_TRANSACTION;
        } else if (telco.contains("MPESA-KE")) {
            uri = SAFARICOM_MONEY_FLOAT_PURCHASE_TRANSACTION;
        } else if (telco.contains("VODACOM")) {
            uri = ApplicationConstants.VODACOM_MONEY_FLOAT_PURCHASE_TRANSACTION;
        } else if (telco.contains("MTN")) {
            uri = ApplicationConstants.MTN_MONEY_FLOAT_PURCHASE_TRANSACTION;
        } else if (telco.contains("ORANGE")) {
            uri = ApplicationConstants.ORANGE_MONEY_FLOAT_PURCHASE_TRANSACTION;
        } else throw new CustomException(EUREKA_FAILURE + ": Float purchase not implemented for telco: " + telco);

        return "http://" + eurekaService.getInstanceIpAddress(telco) + ":" + eurekaService.getInstancePort(telco) + uri;
    }

    private String composeUrl(String telco, String type) throws CustomException {
        String uri = getServiceUri(telco.toUpperCase(), type);
        String ipAddress = eurekaService.getInstanceIpAddress(telco);
        String port = String.valueOf(eurekaService.getInstancePort(telco));

        return String.format("http://%s:%s%s", ipAddress, port, uri);
    }

    private String getServiceUri(String telco, String type) throws CustomException {
        if (telco.contains("ORANGE")) {
            return switch (type) {
                case "transaction" -> ORANGE_MONEY_B2C_SERVICE_TRANSACTION;
                case "airtime" -> ORANGE_MONEY_B2C_SERVICE_AIRTIME_TOP_UP;
                case "bank-to-wallet-namecheck" -> ORANGE_MONEY_B2C_NAMECHECK_SERVICE;
                case "airtime-topup-namecheck" -> ORANGE_MONEY_AIRTIME_TOPUP_NAMECHECK_SERVICE;
                case "float-purchase-namecheck" -> ORANGE_MONEY_FLOAT_PURCHASE_NAMECHECK_SERVICE;
                default ->
                        throw new CustomException(String.format("%s %s for Telco %s is unknown", DEFAULT_PROCESSING_FAILURE, type, telco));
            };
        } else if (telco.contains("AIRTEL")) {
            return switch (type) {
                case "transaction" -> AIRTEL_MONEY_B2C_SERVICE_TRANSACTION;
                case "airtime" -> AIRTEL_MONEY_B2C_SERVICE_AIRTIME_TOP_UP;
                case "bank-to-wallet-namecheck" -> AIRTEL_MONEY_B2C_NAMECHECK_SERVICE;
                case "airtime-topup-namecheck" -> AIRTEL_MONEY_AIRTIME_TOPUP_NAMECHECK_SERVICE;
                case "float-purchase-namecheck" -> AIRTEL_MONEY_FLOAT_PURCHASE_NAMECHECK_SERVICE;
                case "status-check-banktowallet" -> AIRTEL_MONEY_BANK_TO_WALLET_STATUS_CHECK_SERVICE;
                case "status-check-floatpurchase" -> AIRTEL_MONEY_FLOAT_PURCHASE_STATUS_CHECK_SERVICE;
                default ->
                        throw new CustomException(String.format("%s %s for Telco %s is unknown", DEFAULT_PROCESSING_FAILURE, type, telco));
            };
        } else if (telco.contains("MPESA-KE")) {
            return switch (type) {
                case "float-purchase-namecheck" -> SAFARICOM_MONEY_FLOAT_PURCHASE_NAMECHECK_SERVICE;
                case "status-check-banktowallet" -> "";
                default ->
                        throw new CustomException(String.format("%s %s for Telco %s is unknown", DEFAULT_PROCESSING_FAILURE, type, telco));
            };
        } else if (telco.contains("VODACOM")) {
            return switch (type) {
                case "transaction" -> VODACOM_MONEY_B2C_SERVICE_TRANSACTION;
                case "airtime" -> VODACOM_MONEY_B2C_SERVICE_AIRTIME_TOP_UP;
                case "bank-to-wallet-namecheck" -> VODACOM_MONEY_B2C_NAMECHECK_SERVICE;
                case "airtime-topup-namecheck" -> VODACOM_MONEY_AIRTIME_TOPUP_NAMECHECK_SERVICE;
                case "float-purchase-namecheck" -> VODACOM_MONEY_FLOAT_PURCHASE_NAMECHECK_SERVICE;
                case "status-check-banktowallet" -> VODACOM_MONEY_BANK_TO_WALLET_STATUS_CHECK_SERVICE;
                default ->
                        throw new CustomException(String.format("%s %s for Telco %s is unknown", DEFAULT_PROCESSING_FAILURE, type, telco));
            };
        } else if (telco.contains("AFRICELL")) {
            return switch (type) {
                case "transaction" -> AFRICELL_MONEY_B2C_SERVICE_TRANSACTION;
                case "airtime" -> AFRICELL_MONEY_B2C_SERVICE_AIRTIME_TOP_UP;
                case "bank-to-wallet-namecheck" -> AFRICELL_MONEY_B2C_NAMECHECK_SERVICE;
                case "airtime-topup-namecheck" -> AFRICELL_MONEY_AIRTIME_TOPUP_NAMECHECK_SERVICE;
                case "float-purchase-namecheck" -> AFRICELL_MONEY_FLOAT_PURCHASE_NAMECHECK_SERVICE;
                default ->
                        throw new CustomException(String.format("%s %s for Telco %s is unknown", DEFAULT_PROCESSING_FAILURE, type, telco));
            };
        } else if (telco.contains("MTN")) {
            return switch (type) {
                case "transaction" -> MTN_MONEY_B2C_SERVICE_TRANSACTION;
                case "airtime" -> MTN_MONEY_B2C_SERVICE_AIRTIME_TOP_UP;
                case "bank-to-wallet-namecheck" -> MTN_MONEY_B2C_NAMECHECK_SERVICE;
                case "airtime-topup-namecheck" -> MTN_MONEY_AIRTIME_TOPUP_NAMECHECK_SERVICE;
                case "float-purchase-namecheck" -> MTN_MONEY_FLOAT_PURCHASE_NAMECHECK_SERVICE;
                case "status-check-floatpurchase" -> MTN_MONEY_FLOAT_STATUS_CHECK_SERVICE;
                default ->
                        throw new CustomException(String.format("%s %s for Telco %s is unknown", DEFAULT_PROCESSING_FAILURE, type, telco));
            };
        } else if (telco.contains("THUNES")) {
            return switch (type) {
                case "thunes-get-payers" -> THUNES_PAYERS;
                case "thunes-bic-lookup" -> THUNES_BIC_LOOKUP;
                case "thunes-payer_rates" -> THUNES_PAYER_RATES;
                case "thunes-payer_details" -> THUNES_PAYER_DETAILS;
                case "thunes-list-of-services" -> THUNES_LIST_OF_SERVICES;
                case "thunes-list-of-countries" -> THUNES_LIST_OF_COUNTRIES;
                case "thunes-credit-party-verify" -> THUNES_CREDIT_PARTY_VERIFY;
                case "thunes-credit-party-information" -> THUNES_CREDIT_PARTY_INFORMATION;
                case "thunes-create-quote" -> THUNES_CREATE_QUOTATION;
                case "thunes-send-transaction" -> THUNES_SEND_TRANSACTION;
                default ->
                        throw new CustomException(String.format("%s %s for IMT %s is unknown", DEFAULT_PROCESSING_FAILURE, type, telco));
            };

        } else if (telco.contains("WENDI")) {
            return switch (type) {
                case "wendi-b2c-namecheck" -> WENDI_B2C_NAMECHECK;
                case "wendi-b2c-transaction" -> WENDI_B2C_TRANSACTION;
                default ->
                        throw new CustomException(String.format("%s %s for Telco %s is unknown", DEFAULT_PROCESSING_FAILURE, type, telco));
            };
        } else {
            throw new CustomException(String.format("%s %s does not exist", EUREKA_FAILURE, telco));
        }
    }

    private String composeMoneyGramUrl(String telco, String type) throws CustomException {
        String uri = switch (type) {
            case "moneygram-fee-lookup" -> MONEY_GRAM_FEE_LOOKUP;
            case "moneygram-receive-reference-number-request" -> MONEY_GRAM_REFERENCE_NUMBER_REQUEST;
            case "moneygram-get-field-for-product" -> MONEY_GRAM_GET_FIELD_FOR_PRODUCT;
            case "moneygram-receive-get-field-for-product" -> MONEY_GRAM_RECEIVE_GET_FIELD_FOR_PRODUCT;
            case "moneygram-send-validation-request" -> MONEY_GRAM_SEND_VALIDATION_REQUEST;
            case "moneygram-receive-validation-request" -> MONEY_GRAM_RECEIVE_VALIDATION_REQUEST;
            case "moneygram-commit-transaction" -> MONEY_GRAM_COMMIT_TRANSACTION;
            case "moneygram-receive-commit-transaction" -> MONEY_GRAM_RECEIVE_COMMIT_TRANSACTION;
            case "moneygram-detail-lookup" -> MONEY_GRAM_DETAIL_LOOKUP;
            case "moneygram-send-reversal" -> MONEY_GRAM_SEND_REVERSAL_REQUEST;
            case "moneygram-amend-transaction" -> MONEY_GRAM_AMEND_TRANSACTION_REQUEST;
            case "moneygram-receive-reversal" -> MONEY_GRAM_RECEIVE_REVERSAL_REQUEST;
            case "moneygram-code-table-service" -> MONEY_GRAM_CODE_TABLE_REQUEST;
            default -> throw new CustomException(String.format("%s%s Does Not Exist", EUREKA_FAILURE, telco));
        };
        return "http://" + eurekaService.getInstanceIpAddress(telco) + ":" + eurekaService.getInstancePort(telco) + uri;
    }
}
