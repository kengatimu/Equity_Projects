
package com.equitybank.gag.papss.ots.dto.channelRequest.transaction;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import jakarta.validation.constraints.*;

@JsonPropertyOrder({
        "senderAmount",
        "receiverAmount",
        "fxRate",
        "papssFeeAmount",
        "bankFeeAmount",
        "transactionCurrency",
        "paymentReason",
        "narration",
})
public class TransactionInfo implements Serializable {
    private final static long serialVersionUID = 2230515558889414629L;

    @NotBlank(message = "SenderAmount is mandatory")
    @DecimalMin(value = "0.01", message = "SenderAmount must be greater than 0")
    @Digits(integer = 10, fraction = 20, message = "SenderAmount must have up to 10 integer and 20 fraction digits")
    @JsonProperty("senderAmount")
    private String senderAmount;

    @NotBlank(message = "ReceiverAmount is mandatory")
    @DecimalMin(value = "0.01", message = "ReceiverAmount must be greater than 0")
    @Digits(integer = 10, fraction = 20, message = "ReceiverAmount must have up to 10 integer and 20 fraction digits")
    @JsonProperty("receiverAmount")
    private String receiverAmount;

    @NotBlank(message = "FxRate is mandatory")
    @DecimalMin(value = "0.01", message = "FxRate must be greater than 0")
    @Digits(integer = 10, fraction = 20, message = "FxRate must have up to 10 integer and 20 fraction digits")
    @JsonProperty("fxRate")
    private String fxRate;

    @NotBlank(message = "PapssFeeAmount amount is mandatory")
    @DecimalMin(value = "0.00", message = "PapssFeeAmount amount cannot be negative")
    @Digits(integer = 10, fraction = 20, message = "PapssFeeAmount amount must have up to 10 integer and 20 fraction digits")
    @JsonProperty("papssFeeAmount")
    private String papssFeeAmount;

    @NotBlank(message = "BankFeeAmount amount is mandatory")
    @DecimalMin(value = "0.00", message = "BankFeeAmount amount cannot be negative")
    @Digits(integer = 10, fraction = 20, message = "BankFeeAmount amount must have up to 10 integer and 20 fraction digits")
    @JsonProperty("bankFeeAmount")
    private String bankFeeAmount;

    @NotBlank(message = "TransactionCurrency is mandatory")
    @Size(min = 3, max = 3, message = "Currency code must be 3 characters")
    @Pattern(regexp = "^[a-zA-Z]+$", message = "Currency contains invalid characters")
    @JsonProperty("transactionCurrency")
    private String transactionCurrency;

    @NotBlank(message = "Payment reason is mandatory")
    @Pattern(regexp = "^[a-zA-Z0-9\\s\\-._]+$", message = "Payment reason contains invalid characters")
    @JsonProperty("paymentReason")
    private String paymentReason;

    @NotBlank(message = "Narration is mandatory")
    @Pattern(regexp = "^[a-zA-Z0-9\\s\\-._]+$", message = "Narration contains invalid characters")
    @Size(max = 100, message = "Narration must be less than 100 characters")
    @JsonProperty("narration")
    private String narration;

    @JsonProperty("senderAmount")
    public String getSenderAmount() {
        return senderAmount;
    }

    @JsonProperty("senderAmount")
    public void setSenderAmount(String senderAmount) {
        this.senderAmount = senderAmount;
    }

    @JsonProperty("receiverAmount")
    public String getReceiverAmount() {
        return receiverAmount;
    }

    @JsonProperty("receiverAmount")
    public void setReceiverAmount(String receiverAmount) {
        this.receiverAmount = receiverAmount;
    }

    @JsonProperty("fxRate")
    public String getFxRate() {
        return fxRate;
    }

    @JsonProperty("fxRate")
    public void setFxRate(String fxRate) {
        this.fxRate = fxRate;
    }

    @JsonProperty("papssFeeAmount")
    public String getPapssFeeAmount() {
        return papssFeeAmount;
    }

    @JsonProperty("papssFeeAmount")
    public void setPapssFeeAmount(String papssFeeAmount) {
        this.papssFeeAmount = papssFeeAmount;
    }

    @JsonProperty("bankFeeAmount")
    public String getBankFeeAmount() {
        return bankFeeAmount;
    }

    @JsonProperty("bankFeeAmount")
    public void setBankFeeAmount(String bankFeeAmount) {
        this.bankFeeAmount = bankFeeAmount;
    }

    @JsonProperty("transactionCurrency")
    public String getTransactionCurrency() {
        return transactionCurrency;
    }

    @JsonProperty("transactionCurrency")
    public void setTransactionCurrency(String transactionCurrency) {
        this.transactionCurrency = transactionCurrency;
    }

    @JsonProperty("paymentReason")
    public String getPaymentReason() {
        return paymentReason;
    }

    @JsonProperty("paymentReason")
    public void setPaymentReason(String paymentReason) {
        this.paymentReason = paymentReason;
    }

    @JsonProperty("narration")
    public String getNarration() {
        return narration;
    }

    @JsonProperty("narration")
    public void setNarration(String narration) {
        this.narration = narration;
    }
}
