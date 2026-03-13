package com.equitybank.gag.papss.its.jpos.jposService.impl;

import com.equitybank.gag.papss.its.entity.TransactionMaster;
import com.equitybank.gag.papss.its.enums.TransactionType;
import com.equitybank.gag.papss.its.exception.CustomException;
import com.equitybank.gag.papss.its.jpos.jposService.ISOMessageBuilderService;
import com.equitybank.gag.papss.its.jpos.jposService.ISOMsgSerializerAndDeserializerService;
import com.equitybank.gag.papss.its.jpos.jposService.ISOUtilityService;
import com.equitybank.gag.papss.its.service.DatabaseService;
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
import java.util.Map;
import java.util.Set;

import static com.equitybank.gag.papss.its.config.StatusCodeMessages.DEFAULT_CURRENCY_KE;
import static com.equitybank.gag.papss.its.config.StatusCodeMessages.ISO_DEFAULT_ERROR;
import static com.equitybank.gag.papss.its.jpos.iso8583.configs.ISOApplicationConstants.*;


@Service
public class ISOMessageBuilderServiceImpl implements ISOMessageBuilderService {
    private static final Logger log = LoggerFactory.getLogger(ISOMessageBuilderServiceImpl.class);

    private final String debitGlKes;
    private final String debitGlUsd;
    private final ISOPackager packager;
    private final DatabaseService databaseService;
    private final ISOUtilityService isoUtilityService;
    private final ISOMsgSerializerAndDeserializerService isoMsgSerializerAndDeserializerService;

    public ISOMessageBuilderServiceImpl(@Value("${accounts.debit-gl.papss-settlement.kes}") String debitGlKes,
                                        @Value("${accounts.debit-gl.papss-settlement.usd}") String debitGlUsd,
                                        ISOPackager packager,
                                        DatabaseService databaseService,
                                        ISOUtilityService isoUtilityService,
                                        ISOMsgSerializerAndDeserializerService isoMsgSerializerAndDeserializerService) {
        this.debitGlKes = debitGlKes;
        this.debitGlUsd = debitGlUsd;
        this.packager = packager;
        this.databaseService = databaseService;
        this.isoUtilityService = isoUtilityService;
        this.isoMsgSerializerAndDeserializerService = isoMsgSerializerAndDeserializerService;
    }

    @Override
    public ISOMsg buildTransactionMessage(String rrn, Map<String, String> requestMap, String transactionCurrency) throws CustomException {
        try {
            String finacleRrn = requestMap.get("finacleRrn");
            String narration = requestMap.get("narration");
            String receiverAccount = requestMap.get("receiverAccount");
            String amountStr = requestMap.get("receiverAmount");
            String feeAmountStr = "0";
//            String debitGl = transactionCurrency.equalsIgnoreCase("KES") ? creditGlKes : creditGlUsd;

            // Format debit amount
            String debitAmount = formatAmount(amountStr, new BigDecimal(feeAmountStr));

            ISOMsg msg = new ISOMsg();
            msg.setPackager(packager);
            msg.setMTI(ISO_MTI_TRANSACTION);                                // 1200 = financial transaction
            msg.set(2, TRANSACTION_PAN_KE);                                 // Default PAN
            msg.set(3, TRANSACTION_CODE_IDENTIFIER);                        // Processing code for credit
            msg.set(4, debitAmount);                                        // Transaction amount in smallest units
            msg.set(7, isoUtilityService.getDateField7());                  // Transmission Date & Time (MMDDhhmmss)
            msg.set(11, isoUtilityService.generateSTAN());                  // System Trace Audit Number (STAN)
            msg.set(12, isoUtilityService.getDateField12());                // Local Transaction Time (yyMMddhhmmss)
            msg.set(17, isoUtilityService.getDateField17());                // Capture date (MMDD)
            msg.set(24, TRANSACTION_NII);                                   // Network International Identifier
            msg.set(32, TRANSACTION_ACQUIRER_ID_KE);                        // Acquiring institution code
            msg.set(37, finacleRrn);                                        // Retrieval Reference Number (RRN)
            msg.set(41, TRANSACTION_TERMINAL_ID);                           // Terminal ID
            msg.set(43, getNarrationField43(requestMap));                   // Card Acceptor Name
            msg.set(46, formatFee(feeAmountStr, rrn));                      // Transaction fee amount
            msg.set(49, transactionCurrency);                               // Transaction Currency
            msg.set(102, debitGlUsd);                                       // Sender account number
            msg.set(103, receiverAccount);                                  // Receiver account number - GL
            msg.set(123, TRANSACTION_CHANNEL_CODE);                         // Transaction channel
            msg.set(125, getNarrationField125(requestMap));                 // Narration/purpose
            msg.set(126, TRANSACTION_CHARGE_CODE);                          // Charge metadata (e.g., PAPSS)

            return msg;
        } catch (Exception e) {
            log.error("{}: Failed to build transaction ISO message. Exception: {}", rrn, e.getMessage());
            throw new CustomException(ISO_DEFAULT_ERROR + "Failed to build transaction ISO message: " + e.getMessage());
        }
    }

    @Override
    public ISOMsg buildReversalMessage(String rrn) throws CustomException {
        ISOMsg originalISORequest;

        try {
            // Retrieve original ISO request from the database
            log.info("{}: Retrieving original ISO message from database.", rrn);
            originalISORequest = getOriginalIsoRequestMessage(rrn);

            return createReversalMessage(originalISORequest, rrn);

        } catch (CustomException e) {
            log.error("{}: Failed to build reversal ISO message. Could not retrieve original transaction. Exception: {}", rrn, e.getMessage());
            throw e;
        } catch (Exception e) {
            log.error("{}: Failed to build reversal ISO message. Unexpected error: {}", rrn, e.getMessage());
            throw new CustomException(ISO_DEFAULT_ERROR + "Failed to build reversal ISO message: " + e.getMessage());
        }
    }

    @Override
    public ISOMsg buildAccountEnquiryMessage(String rrn, String accountNumber) throws CustomException {
        try {
            ISOMsg msg = new ISOMsg();
            msg.setPackager(packager);
            msg.setMTI(ISO_MTI_TRANSACTION);                        // Same MTI as transaction (1200)
            msg.set(2, ACCT_VALIDATION_TRANSACTION_PAN_KE);         // Default PAN
            msg.set(3, ACCT_INQUIRY_CODE_IDENTIFIER);               // Processing code for inquiry
            msg.set(7, isoUtilityService.getDateField7());          // Transmission Date & Time (MMDDhhmmss)
            msg.set(11, isoUtilityService.generateSTAN());          // System Trace Audit Number (STAN)
            msg.set(12, isoUtilityService.getDateField12());        // Local Transaction Time (yyMMddhhmmss)
            msg.set(17, isoUtilityService.getDateField17());        // Capture date (MMDD)
            msg.set(24, TRANSACTION_NII);                           // Network International Identifier
            msg.set(32, TRANSACTION_ACQUIRER_ID_KE);                // Acquiring institution code
            msg.set(37, truncateRrn(rrn));                          // Retrieval Reference Number (RRN)
            msg.set(41, ACCT_VALIDATION_TRANSACTION_TERMINAL_ID);   // Terminal ID
            msg.set(43, ACCT_VALIDATION_TRANSACTION_CHANNEL_CODE_2);// Channel ID for narration
            msg.set(102, accountNumber);                            // Inquiry account number
            msg.set(123, ACCT_VALIDATION_TRANSACTION_CHANNEL_CODE); // Transaction channel
            msg.set(126, ACCT_VALIDATION_TRANSACTION_TERMINAL_ID);  // Terminal ID

            return msg;
        } catch (Exception e) {
            log.error("{}: Failed to build account enquiry ISO message. Exception: {}", accountNumber, e.getMessage());
            throw new CustomException(ISO_DEFAULT_ERROR + "Failed to build account enquiry ISO message: " + e.getMessage());
        }
    }

    private String truncateRrn(String rrn) {
        return rrn.length() > 12 ? rrn.substring(0, 12) : rrn;
    }

    private ISOMsg createReversalMessage(ISOMsg originalIsoRequest, String rrn) throws CustomException {
        Set<String> supportedCurrencies = new HashSet<>(Arrays.asList("USD", "CDF", "KES", "SSP", "RWF", "TZS", "UGX"));

        try {
            ISOMsg isoMsg = (ISOMsg) originalIsoRequest.clone();
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
            log.error("{}: Failed to clone and build reversal ISO message. Exception: {}", rrn, e.getMessage());
            throw new CustomException(ISO_DEFAULT_ERROR + "Failed to clone and build reversal ISO message: " + e.getMessage());
        }
    }

    private ISOMsg getOriginalIsoRequestMessage(String rrn) throws CustomException {
        TransactionMaster entity = databaseService.getSavedRecord(rrn, TransactionType.CREDIT_TRANSFER);

        // Get original transaction ISO Message
        byte[] isoByteMessage = entity.getTransactionPayload().getFinTxnIsoRequest();

        ISOMsg isoRequest = isoMsgSerializerAndDeserializerService.deserializeISOMsg(isoByteMessage);

        if (isoRequest.getMaxField() == 0) {
            throw new CustomException(String.format("%s: Deserialized ISOMsg is empty.", rrn));
        }
        return isoRequest;
    }

    private String getNarrationField43(Map<String, String> requestMap) {
        String narration = requestMap.getOrDefault("messageId", "PAPSS Inbound Transaction");
        return narration.length() > 38 ? narration.substring(0, 38) : narration;
    }

    private String getNarrationField125(Map<String, String> requestMap) {
        String messageId = requestMap.get("messageId");
        String senderName = requestMap.get("senderName");
        return "PAPSS " + messageId + " " + senderName;
    }

    private String formatAmount(String amountStr, BigDecimal feeAmount) {
        // Convert to cents and pad to 12 digits
        BigDecimal amount = new BigDecimal(amountStr).add(feeAmount);
        return String.format("%012d", amount.multiply(BigDecimal.valueOf(100)).longValue());
    }

    private String formatFee(String feeAmountStr, String rrn) {
        String currency = DEFAULT_CURRENCY_KE;

        BigDecimal feeAmount;
        try {
            feeAmount = new BigDecimal(feeAmountStr).max(BigDecimal.ZERO);
        } catch (Exception e) {
            log.warn("{}: Invalid fee amount '{}'. Defaulting to 0", rrn, feeAmountStr);
            feeAmount = BigDecimal.ZERO;
        }

        // Convert to cents (e.g., 282.00 -> 28200)
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

    public String nonStringLeftPadding(long n, int length) {
        return String.format("%0" + length + "d", n);
    }
}
