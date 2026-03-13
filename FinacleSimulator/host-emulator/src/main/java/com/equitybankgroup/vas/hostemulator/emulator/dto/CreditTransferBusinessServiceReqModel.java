package com.equitybankgroup.vas.hostemulator.emulator.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import java.io.Serializable;
import javax.annotation.Generated;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder(
    {
        "requestId",
        "channelId",
        "sourceSystemId",
        "callbackURL",
        "sourceTranType",
        "sourceAccount",
        "sourceCountryCode",
        "sourceCurrency",
        "senderName",
        "senderInstitutionCode",
        "senderPhone",
        "receiverAccount",
        "receiverName",
        "receiverInstitutionCode",
        "receiverCurrency",
        "amount",
        "feeAmount",
        "isInCharge",
        "isSmsChargeIncluded",
        "isVelocityEnabled",
        "paymentReason",
        "narration",
        "signature",
    }
)
@Generated("jsonschema2pojo")
public class CreditTransferBusinessServiceReqModel implements Serializable {

    @JsonProperty("requestId")
    private String requestId;

    @JsonProperty("channelId")
    private String channelId;
    
    @JsonProperty("sourceSystemId")
    private String sourceSystemId;

    @JsonProperty("callbackURL")
    private String callbackURL;

    @JsonProperty("sourceTranType")
    private String sourceTranType;

    @JsonProperty("sourceAccount")
    private String sourceAccount;
    
    @JsonProperty("sourceCountryCode")
    private String sourceCountryCode;

    @JsonProperty("sourceCurrency")
    private String sourceCurrency;

    @JsonProperty("senderName")
    private String senderName;

    @JsonProperty("senderInstitutionCode")
    private String senderInstitutionCode;

    @JsonProperty("senderPhone")
    private String senderPhone = "";

    @JsonProperty("receiverAccount")
    private String receiverAccount;
    
    @JsonProperty("receiverName")
    private String receiverName = "";

    @JsonProperty("receiverInstitutionCode")
    private String receiverInstitutionCode;

    @JsonProperty("receiverCurrency")
    private String receiverCurrency;
    
    @JsonProperty("amount")
    private String amount;

    @JsonProperty("feeAmount")
    private String feeAmount;

    @JsonProperty("isInCharge")
    private String isInCharge = "Y";

    @JsonProperty("isSmsChargeIncluded")
    private String isSmsChargeIncluded = "N";

    @JsonProperty("isVelocityEnabled")
    private String isVelocityEnabled = "N";

    @JsonProperty("paymentReason")
    private String paymentReason;

    @JsonProperty("narration")
    private String narration;

    @JsonProperty("signature")
    private String signature;

    private static final long serialVersionUID = 8998510454236988150L;

    @JsonProperty("requestId")
    public String getRequestId() {
        return requestId;
    }

    @JsonProperty("requestId")
    public void setRequestId(String requestId) {
        this.requestId = requestId.trim();
    }

    @JsonProperty("channelId")
    public String getChannelId() {
        return channelId;
    }

    @JsonProperty("channelId")
    public void setChannelId(String channelId) {
        this.channelId = channelId.trim();
    }

    @JsonProperty("sourceSystemId")
    public String getSourceSystemId() {
        return sourceSystemId;
    }

    @JsonProperty("sourceSystemId")
    public void setSourceSystemId(String sourceSystemId) {
        this.sourceSystemId = sourceSystemId.trim();
    }

    @JsonProperty("callbackURL")
    public String getCallbackURL() {
        return callbackURL;
    }

    @JsonProperty("callbackURL")
    public void setCallbackURL(String callbackURL) {
        this.callbackURL = callbackURL;
    }

    @JsonProperty("sourceTranType")
    public String getSourceTranType() {
        return sourceTranType;
    }

    @JsonProperty("sourceTranType")
    public void setSourceTranType(String sourceTranType) {
        this.sourceTranType = sourceTranType;
    }

    @JsonProperty("sourceAccount")
    public String getSourceAccount() {
        return sourceAccount;
    }

    @JsonProperty("sourceAccount")
    public void setSourceAccount(String sourceAccount) {
        this.sourceAccount = sourceAccount.trim();
    }

    @JsonProperty("sourceCountryCode")
    public String getSourceCountryCode() {
        return sourceCountryCode;
    }

    @JsonProperty("sourceCountryCode")
    public void setSourceCountryCode(String sourceCountryCode) {
        this.sourceCountryCode = sourceCountryCode.trim();
    }

    @JsonProperty("sourceCurrency")
    public String getSourceCurrency() {
        return sourceCurrency;
    }

    @JsonProperty("sourceCurrency")
    public void setSourceCurrency(String sourceCurrency) {
        this.sourceCurrency = sourceCurrency.trim();
    }

    @JsonProperty("senderName")
    public String getSenderName() {
        return senderName;
    }

    @JsonProperty("senderName")
    public void setSenderName(String senderName) {
        this.senderName = senderName;
    }

    @JsonProperty("senderInstitutionCode")
    public String getSenderInstitutionCode() {
        return senderInstitutionCode;
    }

    @JsonProperty("senderInstitutionCode")
    public void setSenderInstitutionCode(String senderInstitutionCode) {
        this.senderInstitutionCode = senderInstitutionCode.trim();
    }

    @JsonProperty("senderPhone")
    public String getSenderPhone() {
        return senderPhone;
    }

    @JsonProperty("senderPhone")
    public void setSenderPhone(String senderPhone) {
        this.senderPhone = senderPhone.trim();
    }

    @JsonProperty("receiverAccount")
    public String getReceiverAccount() {
        return receiverAccount;
    }

    @JsonProperty("receiverAccount")
    public void setReceiverAccount(String receiverAccount) {
        this.receiverAccount = receiverAccount.trim();
    }

    @JsonProperty("receiverName")
    public String getReceiverName() {
        return receiverName;
    }

    @JsonProperty("receiverName")
    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    @JsonProperty("receiverInstitutionCode")
    public String getReceiverInstitutionCode() {
        return receiverInstitutionCode;
    }

    @JsonProperty("receiverInstitutionCode")
    public void setReceiverInstitutionCode(String receiverInstitutionCode) {
        this.receiverInstitutionCode = receiverInstitutionCode.trim();
    }

    @JsonProperty("receiverCurrency")
    public String getReceiverCurrency() {
        return receiverCurrency;
    }

    @JsonProperty("receiverCurrency")
    public void setReceiverCurrency(String receiverCurrency) {
        this.receiverCurrency = receiverCurrency.trim();
    }

    @JsonProperty("amount")
    public String getAmount() {
        return amount;
    }

    @JsonProperty("amount")
    public void setAmount(String amount) {
        this.amount = amount.trim();
    }

    @JsonProperty("feeAmount")
    public String getFeeAmount() {
        return feeAmount;
    }

    @JsonProperty("feeAmount")
    public void setFeeAmount(String feeAmount) {
        this.feeAmount = feeAmount.trim();
    }

    @JsonProperty("paymentReason")
    public String getPaymentReason() {
        return paymentReason;
    }

    @JsonProperty("paymentReason")
    public void setPaymentReason(String paymentReason) {
        this.paymentReason = paymentReason.trim();
    }

    @JsonProperty("narration")
    public String getNarration() {
        return narration;
    }

    @JsonProperty("narration")
    public void setNarration(String narration) {
        this.narration = narration.trim();
    }

    @JsonProperty("signature")
    public String getSignature() {
        return signature;
    }

    @JsonProperty("signature")
    public void setSignature(String signature) {
        this.signature = signature;
    }

    @JsonProperty("isSmsChargeIncluded")
    public String getIsSmsChargeIncluded() {
        return isSmsChargeIncluded;
    }

    @JsonProperty("isSmsChargeIncluded")
    public void setIsSmsChargeIncluded(String isSmsChargeIncluded) {
        this.isSmsChargeIncluded = isSmsChargeIncluded;
    }

    @JsonProperty("isInCharge")
    public String getIsInCharge() {
        return isInCharge;
    }

    @JsonProperty("isInCharge")
    public void setIsInCharge(String isInCharge) {
        this.isInCharge = isInCharge;
    }

    @JsonProperty("isVelocityEnabled")
    public String getIsVelocityEnabled() {
        return isVelocityEnabled;
    }

    @JsonProperty("isVelocityEnabled")
    public void setIsVelocityEnabled(String isVelocityEnabled) {
        this.isVelocityEnabled = isVelocityEnabled;
    }
         
}
