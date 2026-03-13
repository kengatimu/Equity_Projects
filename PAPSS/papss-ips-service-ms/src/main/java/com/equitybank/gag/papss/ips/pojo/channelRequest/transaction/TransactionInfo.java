
package com.equitybank.gag.papss.ips.pojo.channelRequest.transaction;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import jakarta.validation.constraints.*;

import java.io.Serializable;

@JsonPropertyOrder({
    "amount",
    "feeAmount",
    "chargeFlag",
    "isSmsChargeIncluded",
    "isVelocityEnabled",
    "paymentReason",
    "narration",
    "tranDateTime"
})
public class TransactionInfo implements Serializable {
    private final static long serialVersionUID = 2230515558889414629L;

    @NotBlank(message = "Amount is mandatory")
    @DecimalMin(value = "0.01", message = "Amount must be greater than 0")
    @Digits(integer = 10, fraction = 2, message = "Amount must have up to 10 integer and 2 fraction digits")
    @JsonProperty("amount")
    private String amount;

    @NotBlank(message = "Fee amount is mandatory")
    @DecimalMin(value = "0.00", message = "Fee amount cannot be negative")
    @Digits(integer = 10, fraction = 2, message = "Fee amount must have up to 10 integer and 2 fraction digits")
    @JsonProperty("feeAmount")
    private String feeAmount;

    @NotBlank(message = "Charge flag is mandatory")
    @Pattern(regexp = "^[ynYN]$", message = "Charge flag must be Y or N")
    @JsonProperty("chargeFlag")
    private String chargeFlag;

    @Pattern(regexp = "^[ynYN]$", message = "SMS charge flag must be Y or N")
    @JsonProperty("isSmsChargeIncluded")
    private String isSmsChargeIncluded;

    @Pattern(regexp = "^[ynYN]$", message = "Velocity flag must be Y or N")
    @JsonProperty("isVelocityEnabled")
    private String isVelocityEnabled;

    @NotBlank(message = "Payment reason is mandatory")
    @Pattern(regexp = "^[a-zA-Z0-9\\s\\-._]+$", message = "Payment reason contains invalid characters")
    @JsonProperty("paymentReason")
    private String paymentReason;

    @NotBlank(message = "Narration is mandatory")
    @Pattern(regexp = "^[a-zA-Z0-9\\s\\-._]+$", message = "Narration contains invalid characters")
    @Size(max = 100, message = "Narration must be less than 100 characters")
    @JsonProperty("narration")
    private String narration;


    @JsonProperty("amount")
    public String getAmount() {
        return amount;
    }

    @JsonProperty("amount")
    public void setAmount(String amount) {
        this.amount = amount;
    }

    @JsonProperty("feeAmount")
    public String getFeeAmount() {
        return feeAmount;
    }

    @JsonProperty("feeAmount")
    public void setFeeAmount(String feeAmount) {
        this.feeAmount = feeAmount;
    }

    @JsonProperty("chargeFlag")
    public String getChargeFlag() {
        return chargeFlag;
    }

    @JsonProperty("chargeFlag")
    public void setChargeFlag(String chargeFlag) {
        this.chargeFlag = chargeFlag;
    }

    @JsonProperty("isSmsChargeIncluded")
    public String getIsSmsChargeIncluded() {
        return isSmsChargeIncluded;
    }

    @JsonProperty("isSmsChargeIncluded")
    public void setIsSmsChargeIncluded(String isSmsChargeIncluded) {
        this.isSmsChargeIncluded = isSmsChargeIncluded;
    }

    @JsonProperty("isVelocityEnabled")
    public String getIsVelocityEnabled() {
        return isVelocityEnabled;
    }

    @JsonProperty("isVelocityEnabled")
    public void setIsVelocityEnabled(String isVelocityEnabled) {
        this.isVelocityEnabled = isVelocityEnabled;
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
