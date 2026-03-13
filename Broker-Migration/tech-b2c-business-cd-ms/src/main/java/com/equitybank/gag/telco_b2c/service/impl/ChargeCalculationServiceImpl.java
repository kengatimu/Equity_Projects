package com.equitybank.gag.telco_b2c.service.impl;

import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.scheduler.DataCacheService;
import com.equitybank.gag.telco_b2c.service.ChargeCalculationService;
import com.equitybank.gag.telco_b2c.service.TransactionValidationAndMappingService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.HashMap;
import java.util.Map;

import static com.equitybank.gag.telco_b2c.ISO8583.configs.Constants.*;
import static com.equitybank.gag.telco_b2c.config.ApplicationConstants.DEFAULT_RATE_CONFIG_ID;
import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.DEFAULT_PROCESSING_FAILURE;

@Service
public class ChargeCalculationServiceImpl implements ChargeCalculationService {
    private static final Logger log = LoggerFactory.getLogger(ChargeCalculationServiceImpl.class);

    private final DataCacheService dataCacheService;
    private final TransactionValidationAndMappingService transactionValidationAndMappingService;

    @Autowired
    public ChargeCalculationServiceImpl(DataCacheService dataCacheService,
                                        TransactionValidationAndMappingService transactionValidationAndMappingService) {
        this.dataCacheService = dataCacheService;
        this.transactionValidationAndMappingService = transactionValidationAndMappingService;
    }

    @Override
    public Map<String, String> calculateCharges(TransactionDetails transactionDetails, request request, Map<String, String> xmlTagsMap, String type) throws CustomException {
        return switch (type) {
            case "transaction" -> calculateB2CCharges(request, xmlTagsMap, type);
            case "floatPurchase" -> calculateFloatPurchaseCharges(request, xmlTagsMap, type);
            case "moneygram-commit-transaction", "moneygram-receive-commit-transaction" ->
                    calculateMoneyGramImtCharges(transactionDetails, request, xmlTagsMap, type);
            default ->
                    throw new CustomException(String.format("%sCould not calculate charges for the supplied transaction type. %s", DEFAULT_PROCESSING_FAILURE, type));
        };
    }

    private Map<String, String> calculateB2CCharges(request request, Map<String, String> xmlTagsMap, String type) throws CustomException {
        BigDecimal chargesB;
        String currency = request.getEazzycash().getCurrency();
        BigDecimal amountB = request.getEazzycash().getAmount();
        String telco = request.getEazzycash().getTelco().toUpperCase();

        // Get the charges based on amount bands
        if (("CDF").equalsIgnoreCase(currency)) {
            chargesB = getCDFCharges(amountB, telco);
        } else if (("USD").equalsIgnoreCase(currency)) {
            chargesB = calculateChargesBasedOnBands(amountB, amountB, telco); // for USD amountB and amountB parameters are same
        } else {
            throw new CustomException(String.format("%sCurrency %s is not supported. Try USD or CDF", DEFAULT_PROCESSING_FAILURE, currency));
        }

        // Generate the formatted finacle iso charge string
        String chargeFormatted = getChargePadded(chargesB, currency);

        // Store in the hashmap
        Map<String, String> chargesMap = new HashMap<>();
        chargesMap.put("formattedIsoCharges", chargeFormatted);
        chargesMap.put("chargeAmount", String.valueOf(chargesB));

        return chargesMap;
    }

    private Map<String, String> calculateFloatPurchaseCharges(request request, Map<String, String> xmlTagsMap, String type) {
        // Float purchase has no charge
        BigDecimal chargesB = BigDecimal.ZERO;
        String currency = request.getEazzycash().getCurrency();

        // Generate the formatted finacle iso charge string
        String chargeFormatted = getChargePadded(chargesB, currency);

        // Store in the hashmap
        Map<String, String> chargesMap = new HashMap<>();
        chargesMap.put("formattedIsoCharges", chargeFormatted);
        chargesMap.put("chargeAmount", String.valueOf(chargesB));

        return chargesMap;
    }

    private Map<String, String> calculateMoneyGramImtCharges(TransactionDetails transactionDetails, request request, Map<String, String> xmlTagsMap, String type) throws CustomException {
        String currency = xmlTagsMap.get("transactionCurrency");
        String rrn = xmlTagsMap.get("rrn");

        // Get the original amount from the db object
        BigDecimal amountB = transactionDetails.getAmount();

        // Calculate fees for bank 43
        return getImtFees(transactionDetails, amountB, currency, type);
    }

    private BigDecimal getCDFCharges(BigDecimal amountB, String telco) {
        // Get the finacle rate
        String usdCdfRate = dataCacheService.getCachedData().get(DEFAULT_RATE_CONFIG_ID);
        log.info("USD/CDF Rate is: " + usdCdfRate);

        // Amount in USD
        BigDecimal amountBigDecimalUSD = getUSDAmount(amountB, usdCdfRate);
        log.info("Amount in USD: " + amountBigDecimalUSD);

        // Calculate charge based on bands
        BigDecimal totalChargesB = calculateChargesBasedOnBands(amountBigDecimalUSD, amountB, telco);
        log.info("Total Charges Plus TAX: " + totalChargesB);

        return totalChargesB;
    }

    private BigDecimal getUSDAmount(BigDecimal amountB, String usdCdfRate) {
        return amountB.divide(new BigDecimal(usdCdfRate), 2, RoundingMode.CEILING);
    }

    private BigDecimal calculateChargesBasedOnBands(BigDecimal amountBigDecimalUSD, BigDecimal amountB, String telco) {
        BigDecimal charges = BigDecimal.ZERO;
        BigDecimal taxes;

        // ORANGE Telco Logic
        if (telco.contains("ORANGE")) {
            if (amountBigDecimalUSD.compareTo(new BigDecimal("10.99")) < 0) {
                charges = amountB.multiply(new BigDecimal("0.0575")); // 1 - 10.99 usd | 5.75%
            } else if (amountBigDecimalUSD.compareTo(new BigDecimal("50.99")) < 0) {
                charges = amountB.multiply(new BigDecimal("0.0288")); // 11 - 50.99 usd | 2.88%
            } else if (amountBigDecimalUSD.compareTo(new BigDecimal("100.99")) < 0) {
                charges = amountB.multiply(new BigDecimal("0.0086")); // 51 - 100.99 usd | 0.86%
            } else if (amountBigDecimalUSD.compareTo(new BigDecimal("500.99")) < 0) {
                charges = amountB.multiply(new BigDecimal("0.0066")); // 101 - 500.99 usd | 0.66%
            } else if (amountBigDecimalUSD.compareTo(new BigDecimal("1000")) < 0) {
                charges = amountB.multiply(new BigDecimal("0.0058")); // 501 - 1000 usd | 0.58%
            }
        } else { // Other Telco Logic
            if (amountBigDecimalUSD.compareTo(new BigDecimal(50)) < 0) {
                charges = amountB.multiply(new BigDecimal("0.015")); // 1 - 50 usd | 1.5%
            } else {
                charges = amountB.multiply(new BigDecimal("0.01")); // > 50 usd | 1%
            }
        }
        // Tax calculation (16% of the charges)
        taxes = charges.multiply(new BigDecimal("0.16"));

        // Return the total amount (charges + taxes)
        return charges.add(taxes);
    }

    private Map<String, String> getImtFees(TransactionDetails transactionDetails, BigDecimal amountB, String transactionCurrency, String type) {
        BigDecimal bankCommission = BigDecimal.ZERO;
        Map<String, String> imtChargesMap = new HashMap<>();
        imtChargesMap.put("amount", String.valueOf(amountB));

        // Get the saved imt fees from db object
        BigDecimal imtTotalFeesAndTaxesB = getImtFees(transactionDetails, type);


        // Enable this to calculate bank commission.
        // By default, we are only taking MoneyGram commission
//        // Calculate bank commission:
//        bankCommission = new BigDecimal("0.02").multiply(amountB);

        // Calculate total fees (imtFees plus bankCommission)
        BigDecimal totalCommission = imtTotalFeesAndTaxesB.add(bankCommission);

        // Enable this to calculate bank commission.
        // By default, we are only taking MoneyGram commission
//        // Ensure the total commission is at least 3.00 USD
//        if (totalCommission.compareTo(new BigDecimal("3.00")) < 0) {
//            totalCommission = new BigDecimal("3.00");
//        }

        imtChargesMap.put("chargeAmount", String.valueOf(totalCommission));
        log.info("Total commission : {}", totalCommission);

        // Generate the formatted charge string
        String chargeFormatted = getChargePadded(totalCommission, transactionCurrency);
        imtChargesMap.put("formattedIsoCharges", chargeFormatted);
        log.info(String.format("Formatted Charges: %s", chargeFormatted));

        return imtChargesMap;
    }

    /**
     * Formats the chargesB into a padded charge string.
     */
    public String getChargePadded(BigDecimal chargesB, String chargeCurrency) {
        // Multiply by 100 to shift the decimal point inorder to express chargesB in smaller units and pad to 16 digits
        String chargeValue = nonStringLeftPadding(chargesB.multiply(new BigDecimal(100)).longValue(), 16);

        // Build and return the final formatted string
        return DEFAULT_CHARGE_TYPE_PREFIX_CODE +
                chargeCurrency + // Currency code
                DEFAULT_START_OF_DATA_TYPE_SECTION_DELIMITER +
                chargeValue + // Commission amount in cents, padded
                DEFAULT_FIXED_LENGTH_PADDING_PLACEHOLDER + // Fixed length padding
                chargeValue + // Commission amount in cents, padded again
                chargeCurrency; // Currency code again
    }

    /**
     * Pads a number to the specified length with leading zeros.
     *
     * @param n      The number to pad.
     * @param length The desired length of the padded string.
     * @return The padded string representation of the number.
     */
    public String nonStringLeftPadding(long n, int length) {
        return String.format("%0" + length + "d", n);
    }

//    private TransactionDetails getSavedDbRecord(String rrn, String type) throws CustomException {
//        return initialValidatorService.getDatabaseRecord(rrn, type);
//    }

    private BigDecimal getImtFees(TransactionDetails transactionDetails, String type) {
        // For receive commit, return 0 charges
        if ("moneygram-receive-commit-transaction".equals(type)) {
            return BigDecimal.ZERO;
        }

        BigDecimal originalImtFeeAmount = transactionDetails.getImtTotalFeeAndTaxes();

        // Return 0 if the value is null or <= 0
        if (originalImtFeeAmount == null || originalImtFeeAmount.compareTo(BigDecimal.ZERO) <= 0) {
            return BigDecimal.ZERO;
        }
        return originalImtFeeAmount;
    }
}
