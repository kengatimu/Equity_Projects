package com.equitybank.gag.telco_b2c.dto.thunes.transfer.transaction;

import com.equitybank.gag.telco_b2c.dto.thunes.creditParties.creditPartyInfo.ChannelInfo;
import com.equitybank.gag.telco_b2c.enums.ImtTransactionType;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

import java.io.Serializable;
@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
        "imtProvider",
        "transactionType",
        "parties",
        "destination",
        "amount",
        "fees",
        "remittance",
        "quotation",
        "channelInfo",
        "signature"
})
public class TransactionRequestDto implements Serializable {

    private static final long serialVersionUID = 8717404707336914113L;

    @NotBlank(message = "imtProvider is mandatory")
    @Size(min = 1, max = 30, message = "imtProvider must be between 1 and 30 characters")
    @JsonProperty("imtProvider")
    private String imtProvider;

    @NotBlank(message = "transactionType is mandatory")
    @Size(min = 3, max = 3, message = "transactionType must be 3 characters eg, C2C, C2B, B2B, or B2B")
    @JsonProperty("transactionType")
    private String transactionType;

    @Valid
    @NotNull(message = "parties block is mandatory")
    @JsonProperty("parties")
    private Parties parties;

    @Valid
    @NotNull(message = "destination block is mandatory")
    @JsonProperty("destination")
    private Destination destination;

    @Valid
    @NotNull(message = "amount block is mandatory")
    @JsonProperty("amount")
    private Amount amount;

    @Valid
    @NotNull(message = "fees block is mandatory")
    @JsonProperty("fees")
    private Fees fees;

    @Valid
    @NotNull(message = "remittance block is mandatory")
    @JsonProperty("remittance")
    private Remittance remittance;

    @Valid
    @NotNull(message = "quotation block is mandatory")
    @JsonProperty("quotation")
    private Quotation quotation;

    @Valid
    @NotNull(message = "channelInfo block is mandatory")
    @JsonProperty("channelInfo")
    private ChannelInfo channelInfo;

    @NotBlank(message = "signature is mandatory")
    @Size(max = 2048, message = "signature must not exceed 2048 characters")
    @JsonProperty("signature")
    private String signature;


    @JsonProperty("imtProvider")
    public String getImtProvider() {
        return imtProvider;
    }

    @JsonProperty("imtProvider")
    public void setImtProvider(String imtProvider) {
        this.imtProvider = imtProvider;
    }

    @JsonProperty("imtTransactionType")
    public String getTransactionType() {
        return transactionType;
    }

    @JsonProperty("imtTransactionType")
    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
    }

    @JsonProperty("parties")
    public Parties getParties() {
        return parties;
    }

    @JsonProperty("parties")
    public void setParties(Parties parties) {
        this.parties = parties;
    }

    @JsonProperty("destination")
    public Destination getDestination() {
        return destination;
    }

    @JsonProperty("destination")
    public void setDestination(Destination destination) {
        this.destination = destination;
    }

    @JsonProperty("amount")
    public Amount getAmount() {
        return amount;
    }

    @JsonProperty("amount")
    public void setAmount(Amount amount) {
        this.amount = amount;
    }

    @JsonProperty("fees")
    public Fees getFees() {
        return fees;
    }

    @JsonProperty("fees")
    public void setFees(Fees fees) {
        this.fees = fees;
    }

    @JsonProperty("remittance")
    public Remittance getRemittance() {
        return remittance;
    }

    @JsonProperty("remittance")
    public void setRemittance(Remittance remittance) {
        this.remittance = remittance;
    }

    @JsonProperty("quotation")
    public Quotation getQuotation() {
        return quotation;
    }

    @JsonProperty("quotation")
    public void setQuotation(Quotation quotation) {
        this.quotation = quotation;
    }

    @JsonProperty("channelInfo")
    public ChannelInfo getChannelInfo() {
        return channelInfo;
    }

    @JsonProperty("channelInfo")
    public void setChannelInfo(ChannelInfo channelInfo) {
        this.channelInfo = channelInfo;
    }

    @JsonProperty("signature")
    public String getSignature() {
        return signature;
    }

    @JsonProperty("signature")
    public void setSignature(String signature) {
        this.signature = signature;
    }

}
