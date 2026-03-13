package com.equitybank.gag.telco_b2c.ISO8583.service.impl;

import com.equitybank.gag.telco_b2c.ISO8583.service.ISOMessageCreatorService;
import com.equitybank.gag.telco_b2c.dto.airtime.request.Envelope;
import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.mapper.CustomMapperService;
import com.equitybank.gag.telco_b2c.service.ChargeCalculationService;
import com.equitybank.gag.telco_b2c.service.DatabaseService;
import org.jpos.iso.ISOMsg;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.task.TaskExecutor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

import static com.equitybank.gag.telco_b2c.ISO8583.configs.Constants.*;
import static com.equitybank.gag.telco_b2c.config.ApplicationConstants.MONEY_GRAM;
import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.*;

@Service
public class ISOMessageCreatorServiceImpl implements ISOMessageCreatorService {
    private static final Logger log = LoggerFactory.getLogger(ISOMessageCreatorServiceImpl.class);
    private static final AtomicInteger counter = new AtomicInteger(0); // Thread-safe counter for STAN

    private final String drcImtCreditGl;
    private final String drcB2cCreditGl;
    private final String drcB2cCommissionGl;
    private final String drcImtCommissionGl;
    private final String drcOrangeFloatPurchaseCreditGlCDF;
    private final String drcOrangeFloatPurchaseCreditGlUSD;
    private final String drcAirtelFloatPurchaseCreditGlCDF;
    private final String drcAirtelFloatPurchaseCreditGlUSD;
    private final String drcAirtelFloatPurchaseCommissionGl;
    private final String drcVodacomFloatPurchaseCreditGlCDF;
    private final String drcVodacomFloatPurchaseCreditGlUSD;
    private final String drcVodacomFloatPurchaseCommissionGl;
    private final String southSudanMTNFloatPurchaseCreditGl;
    private final String keAirtelMoneyFloatPurchaseCreditGl;
    private final String keSafaricomMpesaFloatPurchaseCreditGl;

    private final TaskExecutor taskExecutor;
    private final DatabaseService databaseService;
    private final CustomMapperService customMapperService;
    private final ChargeCalculationService chargeCalculationService;

    @Autowired
    public ISOMessageCreatorServiceImpl(@Value("${finacle.gls.drc.imt.credit:}") String drcImtCreditGl,
                                        @Value("${finacle.gls.drc.b2c.credit:}") String drcB2cCreditGl,
                                        @Value("${finacle.gls.drc.b2c.commission:}") String drcB2cCommissionGl,
                                        @Value("${finacle.gls.drc.imt.commission:}") String drcImtCommissionGl,
                                        @Value("${finacle.gls.drc.float-purchase.orange.credit-CDF:}") String drcOrangeFloatPurchaseCreditGlCDF,
                                        @Value("${finacle.gls.drc.float-purchase.orange.credit-USD:}") String drcOrangeFloatPurchaseCreditGlUSD,
                                        @Value("${finacle.gls.drc.float-purchase.airtel.credit-CDF:}") String drcAirtelFloatPurchaseCreditGlCDF,
                                        @Value("${finacle.gls.drc.float-purchase.airtel.credit-USD:}") String drcAirtelFloatPurchaseCreditGlUSD,
                                        @Value("${finacle.gls.drc.float-purchase.airtel.commission:}") String drcAirtelFloatPurchaseCommissionGl,
                                        @Value("${finacle.gls.drc.float-purchase.vodacom.credit-CDF:}") String drcVodacomFloatPurchaseCreditGlCDF,
                                        @Value("${finacle.gls.drc.float-purchase.vodacom.credit-USD:}") String drcVodacomFloatPurchaseCreditGlUSD,
                                        @Value("${finacle.gls.drc.float-purchase.vodacom.commission:}") String drcVodacomFloatPurchaseCommissionGl,
                                        @Value("${finacle.gls.south-sudan.float-purchase.mtn.credit-SSP:}") String southSudanMTNFloatPurchaseCreditGl,
                                        @Value("${finacle.gls.kenya.float-purchase.airtel.credit-KES:}") String keAirtelMoneyFloatPurchaseCreditGl,
                                        @Value("${finacle.gls.kenya.float-purchase.safaricom.credit-KES:}") String keSafaricomMpesaFloatPurchaseCreditGl,
                                        @Qualifier("taskExecutor") TaskExecutor taskExecutor,
                                        DatabaseService databaseService,
                                        CustomMapperService customMapperService,
                                        ChargeCalculationService chargeCalculationService) {
        this.drcImtCreditGl = drcImtCreditGl;
        this.drcB2cCreditGl = drcB2cCreditGl;
        this.drcB2cCommissionGl = drcB2cCommissionGl;
        this.drcImtCommissionGl = drcImtCommissionGl;
        this.drcOrangeFloatPurchaseCreditGlCDF = drcOrangeFloatPurchaseCreditGlCDF;
        this.drcOrangeFloatPurchaseCreditGlUSD = drcOrangeFloatPurchaseCreditGlUSD;
        this.drcAirtelFloatPurchaseCreditGlCDF = drcAirtelFloatPurchaseCreditGlCDF;
        this.drcAirtelFloatPurchaseCreditGlUSD = drcAirtelFloatPurchaseCreditGlUSD;
        this.drcAirtelFloatPurchaseCommissionGl = drcAirtelFloatPurchaseCommissionGl;
        this.drcVodacomFloatPurchaseCreditGlCDF = drcVodacomFloatPurchaseCreditGlCDF;
        this.drcVodacomFloatPurchaseCreditGlUSD = drcVodacomFloatPurchaseCreditGlUSD;
        this.drcVodacomFloatPurchaseCommissionGl = drcVodacomFloatPurchaseCommissionGl;
        this.southSudanMTNFloatPurchaseCreditGl = southSudanMTNFloatPurchaseCreditGl;
        this.keAirtelMoneyFloatPurchaseCreditGl = keAirtelMoneyFloatPurchaseCreditGl;
        this.keSafaricomMpesaFloatPurchaseCreditGl = keSafaricomMpesaFloatPurchaseCreditGl;
        this.taskExecutor = taskExecutor;
        this.databaseService = databaseService;
        this.customMapperService = customMapperService;
        this.chargeCalculationService = chargeCalculationService;
    }

    @Override
    public ISOMsg createMainTransactionIsoMsg(TransactionDetails transactionDetails, request request, Envelope airtimeRequest, Map<String, String> xmlTagsMap, String type) throws CustomException {
        try {
            log.info("Starting to create ISO message for type: {}", type);
            Map<String, String> params = extractParameters(transactionDetails, request, xmlTagsMap, type);
            log.info("Extracted Details For Debit/Credit: " + params);

            String chargeCode = DEFAULT_MONEYGRAM_CHARGE_CODE;
            String channelCode = DEFAULT_IMT_CHANNEL_CODE;
            String cardAcceptorName = getField43(params.get("rrn"), params.get("telco"), params.get("beneficiary"));
            if ("floatPurchase".equals(type)) {
                chargeCode = FLOAT_CHARGE_CODE;
                channelCode = DEFAULT_GAG_CHANNEL_CODE;
                String fullNameCardAcceptorName = params.get("beneficiary") + " " + request.getEazzycash().getName();
                cardAcceptorName = fullNameCardAcceptorName.length() > 49
                        ? fullNameCardAcceptorName.substring(0, 49)
                        : fullNameCardAcceptorName;
            }

            String stan = generateSTAN();
            String rrn = getRrn(request, xmlTagsMap, type);
            String tranDateTime = getFormattedDateTime(7);
            String transmissionDate = getFormattedDateTime(17);
            String localTranDateTime = getFormattedDateTime(12);
            String formattedRRN = formatRrn(params.get("rrn"), stan);
            String tranAmount = getTranAmountStr(new BigDecimal(params.get("tranAmount")));
            String narration = getField125(params.get("narration"), rrn, params.get("imtReferenceNumber"), params.get("receiverName"), params.get("telco"), type);
            narration = narration.length() > 50 ? narration.substring(0, 50) : narration;

            ISOMsg isoMsg = new ISOMsg();
            isoMsg.setMTI(DEFAULT_MESSAGE_TYPE_INDICATOR_MTI);
            isoMsg.set(2, DEFAULT_PRIMARY_ACCOUNT_NUMBER_PAN);
            isoMsg.set(3, DEFAULT_PROCESSING_CODE);
            isoMsg.set(4, tranAmount);
//            isoMsg.set(7, tranDateTime);
            isoMsg.set(11, stan);
            isoMsg.set(12, localTranDateTime);
            isoMsg.set(17, transmissionDate);
            isoMsg.set(24, DEFAULT_NETWORK_INTERNATIONAL_IDENTIFIER_NII);
            isoMsg.set(32, DEFAULT_ACQUIRING_INSTITUTION_IDENTIFICATION_CODE);
            isoMsg.set(37, formattedRRN);
            isoMsg.set(41, DEFAULT_RATE_CODE);
            isoMsg.set(43, cardAcceptorName);
            isoMsg.set(46, params.get("formattedIsoCharges"));
            isoMsg.set(49, params.get("currency"));
//            isoMsg.set(63, params.get("commissionGl"));
            isoMsg.set(102, params.get("debitAccount"));
            isoMsg.set(103, params.get("creditGl").replace("#", ""));
            isoMsg.set(123, channelCode);
            isoMsg.set(125, narration);
            isoMsg.set(126, chargeCode);
            log.info("ISO Message created successfully for type: {}", type);
            return isoMsg;
        } catch (Exception e) {
            throw new CustomException(String.format("%sIsoMsg request generation failed. %s", DEFAULT_PROCESSING_FAILURE, e.getMessage()));
        }
    }

    private String getRrn(request request, Map<String, String> xmlTagsMap, String type) {
        return switch (type) {
            case "moneygram-commit-transaction", "moneygram-receive-commit-transaction" -> xmlTagsMap.get("rrn");
            case "transaction", "floatPurchase" -> request.getEazzycash().getRrn();
            default -> "";
        };
    }

    private Map<String, String> extractParameters(TransactionDetails transactionDetails, request request, Map<String, String> xmlTagsMap, String type) throws CustomException {
        // Extracts and maps values to be used in the ISO message based on the transaction type
        String rrn = "";
        Map<String, String> params = new HashMap<>();
        Map<String, String> chargeMap = new HashMap<>();
        switch (type) {
            case "transaction" -> {
                rrn = request.getEazzycash().getRrn();
                chargeMap = chargeCalculationService.calculateCharges(transactionDetails, request, new HashMap<>(), type);
                params.put("chargeAmount", chargeMap.get("chargeAmount"));
                params.put("formattedIsoCharges", chargeMap.get("formattedIsoCharges"));
                params.put("bankId", request.getEazzycash().getBankId() != null ? request.getEazzycash().getBankId() : DEFAULT_BANK_ID);
                params.put("creditGl", drcB2cCreditGl);
                params.put("commissionGl", drcB2cCommissionGl);
                params.put("rrn", rrn);
                params.put("tranAmount", request.getEazzycash().getAmount().toString());
                params.put("telco", request.getEazzycash().getTelco());
                params.put("currency", request.getEazzycash().getCurrency());
                params.put("beneficiary", request.getEazzycash().getNumber());
                params.put("debitAccount", request.getEazzycash().getDebitAccount());
                params.put("narration", "");

            }
            case "floatPurchase" -> {
                String creditGl = "";
                String commissionGl = "";
                rrn = request.getEazzycash().getRrn();
                String currency = request.getEazzycash().getAmountCurrency();
                String telcom = request.getEazzycash().getTelco();
                String telco = telcom != null ? telcom.toLowerCase() : "";
                String bankId = request.getEazzycash().getBankId();

                switch (bankId) {
                    case "43":
                        if (telco.contains("vodacom")) {
                            creditGl = "USD".equalsIgnoreCase(currency)
                                    ? drcVodacomFloatPurchaseCreditGlUSD
                                    : drcVodacomFloatPurchaseCreditGlCDF;
                        } else if (telco.contains("airtel")) {
                            creditGl = "USD".equalsIgnoreCase(currency)
                                    ? drcAirtelFloatPurchaseCreditGlUSD
                                    : drcAirtelFloatPurchaseCreditGlCDF;
                        } else if (telco.contains("orange")) {
                            creditGl = "USD".equalsIgnoreCase(currency)
                                    ? drcOrangeFloatPurchaseCreditGlUSD
                                    : drcOrangeFloatPurchaseCreditGlCDF;
                        }
                        break;

                    case "54":
                        if (telco.contains("mpesa")) {
                            creditGl = keSafaricomMpesaFloatPurchaseCreditGl;
                        } else if (telco.contains("airtel")) {
                            creditGl = keAirtelMoneyFloatPurchaseCreditGl;
                        }
                        break;

                    case "11":
                        if (telco.contains("mtn")) {
                            creditGl = southSudanMTNFloatPurchaseCreditGl;
                        }
                        break;

                    default:
                        log.warn("{}: BankId {} currently not supported!", rrn, bankId);
                        break;
                }

                if (creditGl.isEmpty()) {
                    log.warn("{}: No matching credit GL found for telco: {}", rrn, telcom);
                }

                chargeMap = chargeCalculationService.calculateCharges(transactionDetails, request, new HashMap<>(), type);
                params.put("chargeAmount", chargeMap.get("chargeAmount"));
                params.put("formattedIsoCharges", chargeMap.get("formattedIsoCharges"));
                params.put("bankId", request.getEazzycash().getBankId() != null ? request.getEazzycash().getBankId() : DEFAULT_BANK_ID);
                params.put("creditGl", creditGl.replace("#",""));
                params.put("commissionGl", commissionGl);
                params.put("rrn", rrn);
                params.put("tranAmount", request.getEazzycash().getAmount().toString());
                params.put("telco", telco);
                params.put("currency", currency);
                params.put("beneficiary", request.getEazzycash().getNumber());
                params.put("debitAccount", request.getEazzycash().getSourceAccount());
                params.put("narration", request.getEazzycash().getNarration());
            }

            case "moneygram-commit-transaction", "moneygram-receive-commit-transaction" -> {
                String creditAccount = "moneygram-commit-transaction".equals(type) ? drcImtCreditGl : xmlTagsMap.get("receiverAccountNumber");
                String debitAccount = "moneygram-commit-transaction".equals(type) ? xmlTagsMap.get("senderAccountNumber") : drcImtCreditGl;

                rrn = xmlTagsMap.get("rrn");
                chargeMap = chargeCalculationService.calculateCharges(transactionDetails, new request(), xmlTagsMap, type);
                params.put("chargeAmount", chargeMap.get("chargeAmount"));
                params.put("formattedIsoCharges", chargeMap.get("formattedIsoCharges"));
                params.put("bankId", xmlTagsMap.get("bankId") != null ? xmlTagsMap.get("bankId") : DEFAULT_BANK_ID);
                params.put("creditGl", creditAccount);
                params.put("commissionGl", drcImtCommissionGl);
                params.put("telco", MONEY_GRAM);
                params.put("rrn", rrn);
                params.put("tranAmount", xmlTagsMap.get("amount"));
                params.put("currency", xmlTagsMap.get("transactionCurrency"));
                params.put("debitAccount", debitAccount);
                params.put("imtReferenceNumber", xmlTagsMap.get("imtReferenceNumber"));
                params.put("receiverName", xmlTagsMap.get("receiverName"));
                params.put("narration", "");
            }
            default -> log.warn("Unknown transaction type: {}", type);
        }

        // Update total fees to DB
        updateDatabaseWithCharges(chargeMap.get("chargeAmount"), rrn, type);
        return params;
    }

    // Generate System Trace Audit Number - STAN value
    private String generateSTAN() {
        // Get the last 4 digits of the timestamp
        long timestamp = System.currentTimeMillis() % 10000;

        // Increment the counter and ensure it's always in the range 00 to 99
        int counterValue = counter.incrementAndGet() % 100;

        // Combine timestamp and counter to create a 6-digit STAN
        // Use the last 4 digits of timestamp(left pad if needed) and ensure counterValue is 2 digits (left pad if needed).
        return String.format("%04d%02d", timestamp, counterValue);
    }

    // Generate ISO date format
    private String getFormattedDateTime(int field) {
        Date today = new Date();

        if (field == 7) {
            // Field 7: Transmission Date & Time (MMDDhhmmss)
            return String.format("%1$tm%1$td%1$tH%1$tM%1$tS", today);
        } else if (field == 12) {
            // Field 12: Local Transaction Time (yyMMddhhmmss)
            return String.format("%1$ty%1$tm%1$td%1$tH%1$tM%1$tS", today);
        } else if (field == 17) {
            // Field 17: Transaction Date (MMDD)
            return String.format("%1$tm%1$td", today);
        } else {
            log.error("Invalid field number. getFormattedDateTime only supports fields: 7, 12 and 17");
            return "";
        }
    }

    private String getTranAmountStr(BigDecimal amount) {
        // Convert to float and multiply by 100 to shift the decimal point inorder to express amounts in smaller units
        float tranAmountFloat = amount.floatValue();
        tranAmountFloat = tranAmountFloat * 100.0F;

        // Convert to long for ISO8583 field 4
        long tranAmount = (long) tranAmountFloat;

        // Left-pad the amount to ensure it's 12 digits long
        return String.format("%012d", tranAmount);
    }

    // Format rrn
    private static String formatRrn(String rrn, String stan) {
        // Concatenate RRN and STAN
        String concatenated = rrn + stan;

        // Truncate to 12 digits if longer
        if (concatenated.length() > 12) {
            concatenated = concatenated.substring(0, 12);
        }

        // Pad with leading zeros if shorter than 12 digits
        return leftPad(concatenated, 12);
    }

    // Method to left pad a string to a specific length with zeros
    public static String leftPad(String str, int length) {
        return String.format("%1$" + length + "s", str).replace(' ', '0');
    }

    // Generate values for field 43 (Card acceptor name)
    private String getField43(String rrn, String telco, String beneficiary) {
        // Use default empty strings if any of the inputs are null
        String rrnValue = rrn == null ? "" : rrn;
        String telcoValue = telco == null ? "" : telco;
        String beneficiaryValue = beneficiary == null ? "" : beneficiary;

        // Format the field value
        String field43 = String.format("%s %s %s", rrnValue, telcoValue, beneficiaryValue);

        // Truncate to 39 characters if longer
        if (field43.length() > 39) {
            field43 = field43.substring(0, 39);
        }
        return field43;
    }

    private String getField125(String narration, String rrn, String imtReferenceNumber, String receiverName, String telco, String type) {
        String imtTranName = telco.equalsIgnoreCase("moneygram") ? "MGTran" : telco;

        //MG IMT Narration should look like:::: rrn/mtcn/MGTran/FULL_NAME
        return switch (type) {
            case "moneygram-commit-transaction", "moneygram-receive-commit-transaction" ->
                    String.format("%s/%s/%s/%s", rrn, imtReferenceNumber, imtTranName, receiverName);
//            case "moneygram-commit-transaction", "moneygram-receive-commit-transaction" ->
//                    String.format("%s/%s/%s", rrn, DEFAULT_CHARGE_CODE, DEFAULT_IMT_NARRATION_MSG);
            case "transaction" -> String.format("%s/%s/%s", rrn, telco, DEFAULT_B2C_NARRATION_MSG);
            case "floatPurchase" -> String.format("%s/%s/%s", rrn, telco, narration);
            default -> String.format("%s/%s/%s", rrn, telco, DEFAULT_AIRTIME_NARRATION_MSG);
        };
    }

    private void updateDatabaseWithCharges(String charge, String rrn, String type) {
        TransactionDetails entity = customMapperService.composeChargeEntity(charge, rrn, type);
        updateDatabase(entity, rrn);
//        updateDatabaseAsync(entity, rrn);
    }

    // This will update the database in async (background thread). Therefore, not need for @Transaction annotation
    private void updateDatabase(TransactionDetails entity, String rrn) {
        if (entity != null) {
            log.info("{}: Saving updated total charges entity record", rrn);
            databaseService.updateTransactionRecord(entity);
        } else {
            log.warn("{}: Could not save updated total charges entity record in database. Entity is null", rrn);
        }
    }

//    // This will update the database in async (background thread). Therefore, not need for @Transaction annotation
//    private void updateDatabaseAsync(TransactionDetails entity, String rrn) {
//        taskExecutor.execute(() -> {
//            if (entity != null) {
//                log.info("{}: Saving updated total charges entity record", rrn);
//                databaseService.updateTransactionRecord(entity);
//            } else {
//                log.warn("{}: Could not save updated total charges entity record in database. Entity is null", rrn);
//            }
//        });
//    }
}
