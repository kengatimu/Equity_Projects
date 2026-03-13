package com.equitybank.gag.telco_b2c.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;

import java.math.BigDecimal;

@XmlAccessorType(XmlAccessType.FIELD)
@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
        "amount",
        "bankId",
        "currency",
        "name",
        "number",
        "rrn",
        "sender",
        "senderIdNumber",
        "signature",
        "telco",
        "channel",
        "amountCurrency",
        "sourceAccount",
        "fromCurrency",
        "chargeAmount",
        "chargeCurrency",
        "destinationShortCode",
        "storeNumber",
        "tranType",
        "narration",
        "refNumber",
        "source",
        "tranID",
        "optIn",
        "debitAccount",
        "callbackUrl",
        "chargeFlag",
})
public class Eazzycash {
    @JsonProperty("amount")
    @XmlElement(name = "amount")
    @NotNull(message = "Amount field cannot be null")
    @DecimalMin(value = "0.0", inclusive = false, message = "Amount must be greater than zero")
    private BigDecimal amount;

    @JsonProperty("bankId")
    @XmlElement(name = "bankId")
    @NotBlank(message = "bankId field cannot be blank/null")
    private String bankId;

    @JsonProperty("currency")
    @XmlElement(name = "currency")
    @NotBlank(message = "Currency field cannot be blank/null")
    private String currency;

    @JsonProperty("name")
    @XmlElement(name = "name")
//    @NotBlank(message = "Name field cannot be blank/null")
    private String name;

    @JsonProperty("number")
    @XmlElement(name = "number")
    @NotBlank(message = "Number field cannot be blank/null")
    private String number;

    @JsonProperty("rrn")
    @XmlElement(name = "rrn")
    @NotBlank(message = "RRN field cannot be blank/null")
    @Size(min = 12, message = "msgId must be atleast 12 characters")
//    @Size(min = 12, max = 12, message = "RRN must be exactly 12 characters")
    private String rrn;

    @JsonProperty("sender")
    @XmlElement(name = "sender")
//    @NotBlank(message = "Sender field cannot be blank/null")
    private String sender;
    
    @JsonProperty("senderIdNumber")
    @XmlElement(name = "senderIdNumber")
//    @Size(max = 12, message = "senderIdNumber must not be more than 12 characters")
    private String senderIdNumber;

    @JsonProperty("signature")
    @XmlElement(name = "signature")
    @NotBlank(message = "Signature field cannot be blank/null")
    private String signature;

    @JsonProperty("telco")
    @XmlElement(name = "telco")
    @NotBlank(message = "Telco field cannot be blank/null")
    private String telco;

    @JsonProperty("channel")
    @XmlElement(name = "channel")
    @NotBlank(message = "channel field cannot be blank/null")
    private String channel;

    @JsonProperty("amountCurrency")
    @XmlElement(name = "amountCurrency")
//    @NotBlank(message = "amountCurrency field cannot be blank/null")
    private String amountCurrency;

    @JsonProperty("sourceAccount")
    @XmlElement(name = "sourceAccount")
//    @NotBlank(message = "sourceAccount field cannot be blank/null")
    private String sourceAccount;

    @JsonProperty("fromCurrency")
    @XmlElement(name = "fromCurrency")
//    @NotBlank(message = "fromCurrency field cannot be blank/null")
    private String fromCurrency;

    @JsonProperty("chargeAmount")
    @XmlElement(name = "chargeAmount")
//    @NotNull(message = "chargeAmount field cannot be null")
    @DecimalMin(value = "0.0", message = "charges must be equal or greater than zero")
    private BigDecimal chargeAmount;

    @JsonProperty("chargeCurrency")
    @XmlElement(name = "chargeCurrency")
//    @NotBlank(message = "chargeCurrency field cannot be blank/null")
    private String chargeCurrency;

    @JsonProperty("destinationShortCode")
    @XmlElement(name = "destinationShortCode")
//    @NotBlank(message = "destinationShortCode field cannot be blank/null")
    private String destinationShortCode;

    @JsonProperty("storeNumber")
    @XmlElement(name = "storeNumber")
//    @NotBlank(message = "storeNumber field cannot be blank/null")
    private String storeNumber;

    @JsonProperty("tranType")
    @XmlElement(name = "tranType")
//    @NotBlank(message = "tranType field cannot be blank/null")
    private String tranType;

    @JsonProperty("narration")
    @XmlElement(name = "narration")
//    @NotBlank(message = "narration field cannot be blank/null")
    private String narration;

    @JsonProperty("refNumber")
    @XmlElement(name = "refNumber")
//    @NotBlank(message = "refNumber field cannot be blank/null")
    private String refNumber;

    @JsonProperty("source")
    @XmlElement(name = "source")
//    @NotBlank(message = "source field cannot be blank/null")
    private String source;

    @JsonProperty("tranID")
    @XmlElement(name = "tranID")
//    @NotBlank(message = "tranID field cannot be blank/null")
    private String walletTranID;

    @JsonProperty("optIn")
    @XmlElement(name = "optIn")
//    @NotBlank(message = "optIn field cannot be blank/null")
    private String optIn;

    @JsonProperty("debitAccount")
    @XmlElement(name = "debitAccount")
//    @NotBlank(message = "debitAccount field cannot be blank/null")
    private String debitAccount;

    @JsonProperty("callbackUrl")
    @XmlElement(name = "callbackUrl")
//    @NotBlank(message = "callbackUrl field cannot be blank/null")
    private String callbackUrl;

    @JsonProperty("chargeFlag")
    @XmlElement(name = "chargeFlag")
    @NotBlank(message = "chargeFlag field cannot be blank/null")
    private String chargeFlag;

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getBankId() {
        return bankId;
    }

    public void setBankId(String bankId) {
        this.bankId = bankId;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getRrn() {
        return rrn;
    }

    public void setRrn(String rrn) {
        this.rrn = rrn;
    }

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public String getSignature() {
        return signature;
    }

    public void setSignature(String signature) {
        this.signature = signature;
    }

    public String getTelco() {
        return telco;
    }

    public void setTelco(String telco) {
        this.telco = telco;
    }

    public String getAmountCurrency() {
        return amountCurrency;
    }

    public void setAmountCurrency(String amountCurrency) {
        this.amountCurrency = amountCurrency;
    }

    public String getSourceAccount() {
        return sourceAccount;
    }

    public void setSourceAccount(String sourceAccount) {
        this.sourceAccount = sourceAccount;
    }

    public String getFromCurrency() {
        return fromCurrency;
    }

    public void setFromCurrency(String fromCurrency) {
        this.fromCurrency = fromCurrency;
    }

    public String getChargeCurrency() {
        return chargeCurrency;
    }

    public void setChargeCurrency(String chargeCurrency) {
        this.chargeCurrency = chargeCurrency;
    }

    public String getDestinationShortCode() {
        return destinationShortCode;
    }

    public void setDestinationShortCode(String destinationShortCode) {
        this.destinationShortCode = destinationShortCode;
    }

    public String getStoreNumber() {
        return storeNumber;
    }

    public void setStoreNumber(String storeNumber) {
        this.storeNumber = storeNumber;
    }

    public String getChannel() {
        return channel;
    }

    public void setChannel(String channel) {
        this.channel = channel;
    }

    public String getTranType() {
        return tranType;
    }

    public void setTranType(String tranType) {
        this.tranType = tranType;
    }

    public String getNarration() {
        return narration;
    }

    public void setNarration(String narration) {
        this.narration = narration;
    }

    public String getRefNumber() {
        return refNumber;
    }

    public void setRefNumber(String refNumber) {
        this.refNumber = refNumber;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getWalletTranID() {
        return walletTranID;
    }

    public void setWalletTranID(String walletTranID) {
        this.walletTranID = walletTranID;
    }

    public String getOptIn() {
        return optIn;
    }

    public void setOptIn(String optIn) {
        this.optIn = optIn;
    }

    public String getDebitAccount() {
        return debitAccount;
    }

    public void setDebitAccount(String debitAccount) {
        this.debitAccount = debitAccount;
    }

    public BigDecimal getChargeAmount() {
        return chargeAmount;
    }

    public void setChargeAmount(BigDecimal chargeAmount) {
        this.chargeAmount = chargeAmount;
    }

    public String getCallbackUrl() {
        return callbackUrl;
    }

    public void setCallbackUrl(String callbackUrl) {
        this.callbackUrl = callbackUrl;
    }

    public String getChargeFlag() {
        return chargeFlag;
    }

    public void setChargeFlag(String chargeFlag) {
        this.chargeFlag = chargeFlag;
    }

    public String getSenderIdNumber() {
        return senderIdNumber;
    }

    public void setSenderIdNumber(String senderIdNumber) {
        this.senderIdNumber = senderIdNumber;
    }
    
    
    
}
