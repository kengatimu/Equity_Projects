package com.equitybank.gag.papss.ots.jpos.jposService.impl;

import com.equitybank.gag.papss.ots.jpos.jposService.ISOMessageBuilderService;
import com.equitybank.gag.papss.ots.jpos.jposService.ISOMsgSerializerAndDeserializerService;
import com.equitybank.gag.papss.ots.jpos.jposService.ISOUtilityService;
import com.equitybank.gag.papss.ots.dto.channelRequest.statusCheck.ChannelStatusCheckDetailsReq;
import com.equitybank.gag.papss.ots.dto.channelRequest.transaction.ChannelCreditTransferDetailsReq;
import com.equitybank.gag.papss.ots.dto.channelRequest.transaction.TransactionInfo;
import com.equitybank.gag.papss.ots.exception.CustomException;
import com.equitybank.gag.papss.ots.service.DatabaseService;
import org.jpos.iso.ISOException;
import org.jpos.iso.ISOMsg;
import org.jpos.iso.ISOPackager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

import static com.equitybank.gag.papss.ots.config.ApplicationConstants.*;
import static com.equitybank.gag.papss.ots.jpos.iso8583.configs.ISOApplicationConstants.*;

@Service
public class ISOMessageBuilderServiceImpl implements ISOMessageBuilderService {
    private static final Logger log = LoggerFactory.getLogger(ISOMessageBuilderServiceImpl.class);

    private final String kesTransactionCreditGL;
    private final String usdTransactionCreditGL;
    private final String kesChargesCreditGL;
    private final String usdChargesCreditGL;
    private final ISOPackager packager;
    private final DatabaseService databaseService;
    private final ISOUtilityService isoUtilityService;
    private final ISOMsgSerializerAndDeserializerService isoMsgSerializerAndDeserializerService;

    public ISOMessageBuilderServiceImpl(
            @Value("${accounts.credit-gl.papss-settlement.kes}") String kesTransactionCreditGL,
            @Value("${accounts.credit-gl.papss-settlement.usd}") String usdTransactionCreditGL,
            @Value("${accounts.credit-gl.bank-income.kes}") String kesChargesCreditGL,
            @Value("${accounts.credit-gl.bank-income.usd}") String usdChargesCreditGL,
            ISOPackager packager,
            DatabaseService databaseService,
            ISOUtilityService isoUtilityService,
            ISOMsgSerializerAndDeserializerService isoMsgSerializerAndDeserializerService
    ) {
        this.kesTransactionCreditGL = kesTransactionCreditGL;
        this.usdTransactionCreditGL = usdTransactionCreditGL;
        this.kesChargesCreditGL = kesChargesCreditGL;
        this.usdChargesCreditGL = usdChargesCreditGL;
        this.packager = packager;
        this.databaseService = databaseService;
        this.isoUtilityService = isoUtilityService;
        this.isoMsgSerializerAndDeserializerService = isoMsgSerializerAndDeserializerService;
    }

    // --------------------------------------------------------------------
    // PRINCIPAL MESSAGE (LEG 1)
    // --------------------------------------------------------------------
    @Override
    public ISOMsg buildPrincipalISOMessage(ChannelCreditTransferDetailsReq request, String messageId) throws CustomException {
        String creditGl = resolveTransactionCreditGL(request);
        String rrn = request.getChannelInfo().getRrn();
        String transactionCurrency = request.getTransactionInfo().getTransactionCurrency();
        String beneficiaryName = request.getReceiver().getAccountName();

        try {
            TransactionInfo txn = request.getTransactionInfo();

            String principalAmountStr = txn.getSenderAmount();
            BigDecimal principalAmount = new BigDecimal(principalAmountStr);

            // principal only : no fees
            String amountField4 = toISOAmount(principalAmount);

            ISOMsg msg = new ISOMsg();
            msg.setPackager(packager);
            msg.setMTI(ISO_MTI_TRANSACTION);
            msg.set(2, TRANSACTION_PAN_KE);
            msg.set(3, TRANSACTION_CODE_IDENTIFIER);
            msg.set(4, amountField4);
            msg.set(7, isoUtilityService.getDateField7());
            msg.set(11, isoUtilityService.generateSTAN());
            msg.set(12, isoUtilityService.getDateField12());
            msg.set(17, isoUtilityService.getDateField17());
            msg.set(24, TRANSACTION_NII);
            msg.set(32, TRANSACTION_ACQUIRER_ID_KE);
            msg.set(37, rrn);
            msg.set(41, TRANSACTION_TERMINAL_ID);
            msg.set(43, getNarrationField43(txn.getNarration(), "transaction"));
            msg.set(46, formatFeeForPrincipal(request, transactionCurrency)); // amount zero
//            msg.set(49, DEFAULT_TRANSACTION_CURRENCY);
            msg.set(49, transactionCurrency);
            msg.set(102, request.getSender().getAccountNumber());
            msg.set(103, creditGl);
            msg.set(123, TRANSACTION_CHANNEL_CODE);
            msg.set(125, getNarrationField125(messageId, "transaction", beneficiaryName));
            msg.set(126, TRANSACTION_PRINCIPAL_CHARGE_CODE);

            return msg;

        } catch (Exception e) {
            log.error("{}: Failed to build principal ISO message: {}", rrn, e.getMessage());
            throw new CustomException(ISO_DEFAULT_ERROR + "Principal ISO build failed: " + e.getMessage());
        }
    }

    // --------------------------------------------------------------------
    // CHARGES MESSAGE (LEG 2)
    // --------------------------------------------------------------------
    @Override
    public ISOMsg buildChargesISOMessage(ChannelCreditTransferDetailsReq request, String messageId) throws CustomException {
        String chargesCreditGl = resolveChargesCreditGL(request);
        String rrn = request.getChannelInfo().getRrn();
        String beneficiaryName = request.getReceiver().getAccountName();
        String currency = request.getTransactionInfo().getTransactionCurrency();

        try {
            TransactionInfo txn = request.getTransactionInfo();
            BigDecimal totalFee = getFees(request);

            String amountField4 = toISOAmount(totalFee);

            ISOMsg msg = new ISOMsg();
            msg.setPackager(packager);
            msg.setMTI(ISO_MTI_TRANSACTION);
            msg.set(2, TRANSACTION_PAN_KE);
            msg.set(3, TRANSACTION_CODE_IDENTIFIER);
            msg.set(4, amountField4);
            msg.set(7, isoUtilityService.getDateField7());
            msg.set(11, isoUtilityService.generateSTAN());
            msg.set(12, isoUtilityService.getDateField12());
            msg.set(17, isoUtilityService.getDateField17());
            msg.set(24, TRANSACTION_NII);
            msg.set(32, TRANSACTION_ACQUIRER_ID_KE);
            msg.set(37, rrn);
            msg.set(41, TRANSACTION_TERMINAL_ID);
            msg.set(43, getNarrationField43(txn.getNarration(), "charges"));
            msg.set(46, formatChargesIsoFee(request));  // real charge details
//            msg.set(49, DEFAULT_CHARGE_CURRENCY);
            msg.set(49, currency);
            msg.set(102, request.getSender().getAccountNumber());
            msg.set(103, chargesCreditGl);
            msg.set(123, TRANSACTION_CHANNEL_CODE);
            msg.set(125, getNarrationField125(messageId, "charges", beneficiaryName));
            msg.set(126, TRANSACTION_CHARGES_CHARGE_CODE);

            return msg;

        } catch (Exception e) {
            log.error("{}: Failed to build charges ISO message: {}", rrn, e.getMessage());
            throw new CustomException(ISO_DEFAULT_ERROR + "Charges ISO build failed: " + e.getMessage());
        }
    }

    // --------------------------------------------------------------------
    // REVERSALS
    // --------------------------------------------------------------------
    @Override
    public ISOMsg buildReversalFromOriginalIso(ISOMsg originalIso, String rrn) throws CustomException {
        Set<String> supportedCurrencies =
                new HashSet<>(Arrays.asList("USD", "CDF", "KES", "SSP", "RWF", "TZS", "UGX"));

        try {
            ISOMsg isoMsg = (ISOMsg) originalIso.clone();
            isoMsg.setPackager(packager);

            String f56 = isoMsg.getMTI()
                    + PADDING
                    + isoMsg.getValue(11)
                    + isoMsg.getValue(12)
                    + REVERSAL_INDICATOR
                    + isoMsg.getValue(32);

            String charges = isoMsg.getString(46);
            if (charges != null) {
                String currencyCode = isoMsg.getString(49);
                if (supportedCurrencies.contains(currencyCode)) {
                    charges = charges.replace(currencyCode, "TEMP");
                    charges = charges.replace("D", "C");
                    charges = charges.replace("TEMP", currencyCode);
                } else {
                    charges = charges.replace("D", "C");
                }
                isoMsg.set(46, charges);
            }

            isoMsg.setMTI(REVERSAL_DEFAULT_MESSAGE_TYPE_INDICATOR_MTI);
            isoMsg.set(24, REVERSAL_TRANSACTION_TYPE_CODE);
            isoMsg.set(56, f56);

            return isoMsg;

        } catch (ISOException e) {
            log.error("{}: Failed to build reversal: {}", rrn, e.getMessage());
            throw new CustomException("Reversal build failed: " + e.getMessage());
        }
    }

    private ISOMsg deserialize(String rrn, byte[] bytes, String type) throws CustomException {
        if (bytes == null || bytes.length == 0) {
            throw new CustomException(rrn + ": No original ISO (" + type + ") stored.");
        }
        ISOMsg iso = isoMsgSerializerAndDeserializerService.deserializeISOMsg(bytes);
        if (iso.getMaxField() == 0) {
            throw new CustomException(rrn + ": Deserialized ISO (" + type + ") is empty.");
        }
        return iso;
    }

    // --------------------------------------------------------------------
    // STATUS CHECK
    // --------------------------------------------------------------------
    @Override
    public ISOMsg buildTransactionStatusISOMessage(ChannelStatusCheckDetailsReq request) throws CustomException {
        String rrn = request.getOriginalTxnInfo().getOriginalRrn();

        try {
            ISOMsg msg = new ISOMsg();
            msg.setPackager(packager);
            msg.setMTI(ISO_MTI_STATUS_INQUIRY);
            msg.set(2, TRANSACTION_PAN_KE);
            msg.set(3, STATUS_CHECK_CODE_IDENTIFIER);
            msg.set(7, isoUtilityService.getDateField7());
            msg.set(11, isoUtilityService.generateSTAN());
            msg.set(12, isoUtilityService.getDateField12());
            msg.set(24, TRANSACTION_NII);
            msg.set(37, rrn);
            msg.set(41, TRANSACTION_TERMINAL_ID);
            msg.set(123, TRANSACTION_CHANNEL_CODE);
            return msg;
        } catch (Exception e) {
            throw new CustomException("Status check ISO build failed: " + e.getMessage());
        }
    }

    // --------------------------------------------------------------------
    // ACCOUNT INQUIRY
    // --------------------------------------------------------------------
    @Override
    public ISOMsg buildAccountInquiryISOMessage(String accountNumber) throws CustomException {
        try {
            ISOMsg msg = new ISOMsg();
            msg.setPackager(packager);
            msg.setMTI(ISO_MTI_TRANSACTION);
            msg.set(2, TRANSACTION_PAN_KE);
            msg.set(3, ACCT_INQUIRY_CODE_IDENTIFIER);
            msg.set(7, isoUtilityService.getDateField7());
            msg.set(11, isoUtilityService.generateSTAN());
            msg.set(12, isoUtilityService.getDateField12());
            msg.set(24, TRANSACTION_NII);
            msg.set(41, TRANSACTION_TERMINAL_ID);
            msg.set(102, accountNumber);
            msg.set(123, TRANSACTION_CHANNEL_CODE);
            return msg;
        } catch (Exception e) {
            throw new CustomException("Account inquiry ISO failed: " + e.getMessage());
        }
    }

    // --------------------------------------------------------------------
    // HELPERS
    // --------------------------------------------------------------------
    private String resolveTransactionCreditGL(ChannelCreditTransferDetailsReq request) {
        // Transaction settlement gl should resolve to USD
        return usdTransactionCreditGL;

//        return "USD".equalsIgnoreCase(request.getTransactionInfo().getTransactionCurrency())
//                ? usdTransactionCreditGL : kesTransactionCreditGL;
    }

    private String resolveChargesCreditGL(ChannelCreditTransferDetailsReq request) {
        // Charges income gl should resolve to KES
//        return kesChargesCreditGL;

        return "USD".equalsIgnoreCase(request.getTransactionInfo().getTransactionCurrency())
                ? usdTransactionCreditGL : kesChargesCreditGL;
    }

    private String toISOAmount(BigDecimal amount) {
        return String.format("%012d", amount.multiply(BigDecimal.valueOf(100)).longValue());
    }

    private String getNarrationField43(String narration, String leg) {
        if (!"transaction".equalsIgnoreCase(leg)) {
            narration = "CHARGES: " + narration;
        }
        return narration.length() > 38 ? narration.substring(0, 38) : narration;
    }

    private String getNarrationField125(String messageId, String leg, String beneficiaryName) {
        if (!"transaction".equalsIgnoreCase(leg)) {
             return "CHARGE: " + messageId + " " + beneficiaryName;
        }
        return "PAPSS: " + messageId + " " + beneficiaryName;
    }

    private BigDecimal getFees(ChannelCreditTransferDetailsReq request) {
        String papssFee = request.getTransactionInfo().getPapssFeeAmount();
        String bankFee = request.getTransactionInfo().getBankFeeAmount();
        return new BigDecimal(papssFee).add(new BigDecimal(bankFee));
    }

    private String formatFeeForPrincipal(ChannelCreditTransferDetailsReq request, String transactionCurrency) {
//        String currency = request.getTransactionInfo().getTransactionCurrency();
//        String currency = DEFAULT_TRANSACTION_CURRENCY;
//        return "01" + currency + "D" + "0000000000000000" + "00000000D0000000000000000" + currency;

        return "01" + transactionCurrency + "D" + "0000000000000000" + "00000000D0000000000000000" + transactionCurrency;
    }

    /**
     * Builds the Field-46 fee string for CHARGES ISO message.
     * <p>
     * Fee Logic Example:
     * -------------------
     * If papssFee = 200
     * If bankFee  = 100
     * <p>
     * Tax on PAPSS fee   = 200 * 0.15 = 30
     * Tax on Bank fee    = 100 * 0.15 = 15
     * <p>
     * Total Tax          = 30 + 15 = 45
     * <p>
     * Amount credited to PAPSS GL  = 200 - 30 = 170
     * Amount credited to Bank GL   = 100 - 15 = 85
     * Amount credited to Tax GL    = 30 + 15 = 45
     * <p>
     * Field-46 format per fee:
     * "01" + currency + "D" + <paddedAmount> + "00000000D" + <paddedAmount> + currency
     * <p>
     * Final returned string = BANK_FEE46 + PAPSS_FEE46 + TAX46
     */
    private String formatChargesIsoFee(ChannelCreditTransferDetailsReq request) {

        String rrn = request.getChannelInfo().getRrn();
        String currency = request.getTransactionInfo().getTransactionCurrency();
//        String currency = DEFAULT_CHARGE_CURRENCY;

        // Raw input fees
        BigDecimal papssFeeRaw = new BigDecimal(request.getTransactionInfo().getPapssFeeAmount());
        BigDecimal bankFeeRaw = new BigDecimal(request.getTransactionInfo().getBankFeeAmount());

        // Tax calculation
//        BigDecimal taxAmount = calculateTax(papssFeeRaw, bankFeeRaw);  // total 15% tax on both fees
//        BigDecimal papssTax = papssFeeRaw.multiply(new BigDecimal(TAX_RATE));

        BigDecimal taxAmount = calculateTax(bankFeeRaw);  // total 15% tax on bank fees
        BigDecimal papssTax = new BigDecimal(0); // No tax on papss fee
        BigDecimal bankTax = bankFeeRaw.multiply(new BigDecimal(TAX_RATE));

        // Net amounts after tax
        BigDecimal papssNet = papssFeeRaw.subtract(papssTax);       // e.g., 200 - 0 = 200
        BigDecimal bankNet = bankFeeRaw.subtract(bankTax);          // e.g., 100 - 15 = 85

        // Build formatted strings for each component
        String formattedBankFee = formatFee(rrn, currency, bankNet);
        String formattedPapssFee = formatFee(rrn, currency, papssNet);
        String formattedTax = formatFee(rrn, currency, taxAmount);

        // For USD return formattedBankFee and tax
        if ("USD".equalsIgnoreCase(currency)) {
            return formattedBankFee + formattedTax;
        }

        // For KES return formattedPapssFee and tax
        return formattedPapssFee + formattedTax;
    }

    private String formatFee(String rrn, String currency, BigDecimal feesBigDecimal) {

        // Validate fee input
        BigDecimal feeAmount;
        try {
            if (feesBigDecimal == null) {
                log.warn("{}: Fee amount is null. Defaulting to 0", rrn);
                feeAmount = BigDecimal.ZERO;
            } else {
                feeAmount = feesBigDecimal.max(BigDecimal.ZERO); // never allow negative
            }
        } catch (Exception e) {
            log.warn("{}: Invalid fee amount '{}'. Defaulting to 0", rrn, feesBigDecimal);
            feeAmount = BigDecimal.ZERO;
        }

        // Convert to cents (e.g., 282.00 to 28200)
        long amountInCents;
        try {
            amountInCents = feeAmount.multiply(BigDecimal.valueOf(100)).longValueExact();
        } catch (ArithmeticException ex) {
            log.warn("{}: Fee has invalid decimal places '{}'. Rounding down.", rrn, feeAmount);
            amountInCents = feeAmount.movePointRight(2).longValue();
        }

        // Pad to 16 digits (Finacle-compatible CHAR format)
        String chargeValue = nonStringLeftPadding(amountInCents, 16);

        // Build Field 46 exactly like your working Finacle format
        return "01" + currency + "D" + chargeValue + "00000000D" + chargeValue + currency;
    }

//    private BigDecimal calculateTax(BigDecimal papssFeeBigDecimal, BigDecimal bankFeeBigDecimal) {
//        // Tax is 15% of the total collected fees
//        BigDecimal totalFess = papssFeeBigDecimal.add(bankFeeBigDecimal);
//        return totalFess.multiply(new BigDecimal(TAX_RATE));
//    }

    private BigDecimal calculateTax(BigDecimal bankFeeBigDecimal) {
        // Tax is 15% of the bank collected fees
        return bankFeeBigDecimal.multiply(new BigDecimal(TAX_RATE));
    }

    private String nonStringLeftPadding(long n, int length) {
        return String.format("%0" + length + "d", n);
    }


    //For only one charge in field 46.
//    private String formatFee(BigDecimal totalFeeAmount, ChannelCreditTransferDetailsReq request) {
//        String rrn = request.getChannelInfo().getRrn();
//        String currency = request.getTransactionInfo().getTransactionCurrency();
//
//        // Validate fee input
//        BigDecimal feeAmount;
//        try {
//            if (totalFeeAmount == null) {
//                log.warn("{}: Fee amount is null. Defaulting to 0", rrn);
//                feeAmount = BigDecimal.ZERO;
//            } else {
//                feeAmount = totalFeeAmount.max(BigDecimal.ZERO); // never allow negative
//            }
//        } catch (Exception e) {
//            log.warn("{}: Invalid fee amount '{}'. Defaulting to 0", rrn, totalFeeAmount);
//            feeAmount = BigDecimal.ZERO;
//        }
//
//        // Convert to cents (e.g., 282.00 → 28200)
//        long amountInCents;
//        try {
//            amountInCents = feeAmount.multiply(BigDecimal.valueOf(100)).longValueExact();
//        } catch (ArithmeticException ex) {
//            log.warn("{}: Fee has invalid decimal places '{}'. Rounding down.", rrn, feeAmount);
//            amountInCents = feeAmount.movePointRight(2).longValue();
//        }
//
//        // Pad to 16 digits (Finacle-compatible CHAR format)
//        String chargeValue = nonStringLeftPadding(amountInCents, 16);
//
//        // Build Field 46 exactly like your working Finacle format
//        return "01" + currency + "D" + chargeValue + "00000000D" + chargeValue + currency;
//    }

}
