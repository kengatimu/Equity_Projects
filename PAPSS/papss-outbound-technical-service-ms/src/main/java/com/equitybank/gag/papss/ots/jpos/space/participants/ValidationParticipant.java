package com.equitybank.gag.papss.ots.jpos.space.participants;

import com.equitybank.gag.papss.ots.jpos.space.configs.JposConstants;
import com.equitybank.gag.papss.ots.jpos.space.configs.SpringBeanLoader;
import com.equitybank.gag.papss.ots.jpos.space.configs.TransactionLimitsPropConfig;
import com.equitybank.gag.papss.ots.dto.channelRequest.transaction.ChannelCreditTransferDetailsReq;
import com.equitybank.gag.papss.ots.enums.TransactionStatus;
import com.equitybank.gag.papss.ots.enums.TransactionType;
import org.jpos.transaction.Context;
import org.jpos.transaction.TransactionParticipant;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;

import java.io.Serializable;
import java.math.BigDecimal;


/**
 * jPOS Transaction Participant for performing deeper, business-specific validations on the transaction data within the Context.
 * This is executed after initial synchronous validation (DTO InputValidation, signature, duplicate checks).
 * If any validation fails, it marks the transaction for ABORTED.
 */
public class ValidationParticipant implements TransactionParticipant {
    private static final Logger log = LoggerFactory.getLogger(ValidationParticipant.class);

    private TransactionLimitsPropConfig transactionLimitsPropConfig;

    public ValidationParticipant() {
        ApplicationContext context = SpringBeanLoader.getApplicationContext();
        if (context != null) {
            try {
                this.transactionLimitsPropConfig = context.getBean(TransactionLimitsPropConfig.class);
                log.info("{}: ValidationParticipant Initialized with TransactionLimitsPropConfig from Spring context.", context.getId());
            } catch (Exception e) {
                log.error("Failed to retrieve TransactionLimitsPropConfig from Spring context. Limit checks will be critically affected. Error: {}", e.getMessage(), e);
            }
        } else {
            log.error("Spring ApplicationContext is null. Cannot initialize transactionLimitsPropConfig. Limit checks will be critically affected.");
        }
    }

    @Override
    public int prepare(long id, Serializable serialisedContext) {
        Context ctx = (Context) serialisedContext;

        String rrn = (String) ctx.get(JposConstants.RRN);
        ChannelCreditTransferDetailsReq channelRequest = (ChannelCreditTransferDetailsReq) ctx.get(JposConstants.TRANSACTION_CONTEXT);
        log.info("{}: Starting business validation.", rrn);

        // Ensure the transaction request and its channel metadata are present before proceeding.
        if (channelRequest == null || channelRequest.getChannelInfo() == null) {
            String errorMsg = "[ValidationParticipant] - Internal Error: Missing channel request for validation.";
            updateJposContext(ctx, rrn, TransactionStatus.FAILURE, errorMsg);
            return ABORTED;
        }

        try {
            // CRITICAL CHECK: Abort if TransactionLimitsPropConfig was not successfully loaded during initialization.
            if (this.transactionLimitsPropConfig == null) {
                String errorMsg = "Configuration for transaction limits not loaded. Cannot perform critical limit checks. Aborting transaction.";
                updateJposContext(ctx, rrn, TransactionStatus.FAILURE, errorMsg);
                return ABORTED;
            }

            // Validate the amount
            BigDecimal txnAmount;
            String amountString = channelRequest.getTransactionInfo().getSenderAmount();

            // Validate that the amount string is not null or empty.
            if (amountString == null || amountString.trim().isEmpty()) {
                String errorMsg = "Invalid transaction amount: missing or empty.";
                updateJposContext(ctx, rrn, TransactionStatus.FAILURE, errorMsg);
                return ABORTED;
            }

            // Safely convert amount string to BigDecimal, handle format issues
            try {
                txnAmount = new BigDecimal(amountString);
            } catch (NumberFormatException e) {
                String errorMsg = String.format("Transaction amount format is invalid (%s): Exception: %s", amountString, e.getMessage());
                updateJposContext(ctx, rrn, TransactionStatus.FAILURE, errorMsg);
                return ABORTED;
            }

            // Validate that the transaction amount is a positive value.
            if (txnAmount.compareTo(BigDecimal.ZERO) <= 0) {
                String errorMsg = "Invalid transaction amount: must be positive.";
                updateJposContext(ctx, rrn, TransactionStatus.FAILURE, errorMsg);
                return ABORTED;
            }

            // Determine which transaction limit to apply based on the 'isVelocityEnabled' flag.
//            String isVelocityEnabled = channelRequest.getTransactionInfo().getIsVelocityEnabled();

            // If velocity check is enabled, enforce velocity limit only
//            if ("Y".equalsIgnoreCase(isVelocityEnabled)) {
//                BigDecimal velocityLimit = transactionLimitsPropConfig.getVelocityLimit();
//                if (txnAmount.compareTo(velocityLimit) > 0) {
//                    String errorMsg = String.format("Velocity limit exceeded. Amount: %s, Limit: %s", txnAmount, velocityLimit);
//                    updateJposContext(ctx, rrn, TransactionStatus.FAILURE, errorMsg);
//                    return ABORTED;
//                }
//            } else {
//                // Otherwise, enforce the general max transaction limit
//                BigDecimal maxTransactionLimit = transactionLimitsPropConfig.getMaxTransactionLimit();
//                if (txnAmount.compareTo(maxTransactionLimit) > 0) {
//                    String errorMsg = String.format("Transaction limit exceeded. Amount: %s, Limit: %s", txnAmount, maxTransactionLimit);
//                    updateJposContext(ctx, rrn, TransactionStatus.FAILURE, errorMsg);
//                    return ABORTED;
//                }
//            }

            // Enforce the general max transaction limit
            BigDecimal maxTransactionLimit = transactionLimitsPropConfig.getMaxTransactionLimit();
            if (txnAmount.compareTo(maxTransactionLimit) > 0) {
                String errorMsg = String.format("Transaction limit exceeded. Amount: %s, Limit: %s", txnAmount, maxTransactionLimit);
                updateJposContext(ctx, rrn, TransactionStatus.FAILURE, errorMsg);
                return ABORTED;
            }

            // Ensure source and beneficiary accounts are not the same
            String sourceAccount = channelRequest.getSender().getAccountNumber();
            String beneficiaryAccount = channelRequest.getReceiver().getAccountNumber();
            if ((sourceAccount != null && beneficiaryAccount != null) && sourceAccount.equals(beneficiaryAccount)) {
                String errorMsg = "Source and beneficiary accounts cannot be identical.";
                updateJposContext(ctx, rrn, TransactionStatus.FAILURE, errorMsg);
                return ABORTED;
            }

            // All validations passed — Update Jpos Space context with Pending status for next phase
            String statusMsg = String.format("All business validations passed. Status set to %s.", TransactionStatus.PENDING.name());
            ctx.put(JposConstants.TXN_TYPE, TransactionType.CREDIT_TRANSFER);
            updateJposContext(ctx, rrn, TransactionStatus.PENDING, statusMsg);
            return PREPARED;

        } catch (Exception e) {
            // Catch any other unexpected exceptions during validation steps
            String errorMsg = String.format("An unexpected error occurred during validation: %s", e.getMessage());
            updateJposContext(ctx, rrn, TransactionStatus.FAILURE, errorMsg);
            return ABORTED;
        }
    }

    @Override
    public void commit(long id, Serializable serialisedContext) {
        Context ctx = (Context) serialisedContext;
        String rrn = (String) ctx.get(JposConstants.RRN);
        log.info("{}: Commit phase (no action).", rrn);
    }

    @Override
    public void abort(long id, Serializable serialisedContext) {
        Context ctx = (Context) serialisedContext;
        String rrn = (String) ctx.get(JposConstants.RRN);
        log.info("{}: Abort phase (no action).", rrn);
    }

    //Helper method to update the jPOS Context with transaction status, code, and message.
    private void updateJposContext(Context ctx, String rrn, TransactionStatus status, String message) {
        // Log the message
        if (status.equals(TransactionStatus.FAILURE)) {
            log.error("{}: {}", rrn, message);
        } else {
            log.info("{}: {}", rrn, message);
        }

        // Set the context variables
        ctx.put(JposConstants.TXN_STATUS, status);
        ctx.put(JposConstants.STATUS_CODE, status.getCode());
        ctx.put(JposConstants.STATUS_MESSAGE, message);
    }
}