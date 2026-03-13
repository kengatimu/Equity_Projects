
package com.equitybank.gag.telco_b2c.dto.thunes.transfer.quotation;

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
        "sender",
        "receiver",
        "transactionDetails",
        "channelInfo",
        "signature"
})
public class CreateQuoteDto implements Serializable {
    private final static long serialVersionUID = 8737599524457273910L;

    @Valid
    @NotNull(message = "Sender information is mandatory")
    @JsonProperty("sender")
    private Sender sender;

    @Valid
    @NotNull(message = "Receiver information is mandatory")
    @JsonProperty("receiver")
    private Receiver receiver;

    @Valid
    @NotNull(message = "TransactionDetails information is mandatory")
    @JsonProperty("transactionDetails")
    private TransactionDetails transactionDetails;

    @Valid
    @NotNull(message = "Channel information is mandatory")
    @JsonProperty("channelInfo")
    private ChannelInfo channelInfo;

    @NotBlank(message = "Signature is mandatory")
    @Size(max = 1000, message = "Signature must be less than 1000 characters")
    @JsonProperty("signature")
    private String signature;

    @JsonProperty("sender")
    public Sender getSender() {
        return sender;
    }

    @JsonProperty("sender")
    public void setSender(Sender sender) {
        this.sender = sender;
    }

    @JsonProperty("receiver")
    public Receiver getReceiver() {
        return receiver;
    }

    @JsonProperty("receiver")
    public void setReceiver(Receiver receiver) {
        this.receiver = receiver;
    }

    @JsonProperty("transactionDetails")
    public TransactionDetails getTransactionDetails() {
        return transactionDetails;
    }

    @JsonProperty("transactionDetails")
    public void setTransactionDetails(TransactionDetails transactionDetails) {
        this.transactionDetails = transactionDetails;
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
