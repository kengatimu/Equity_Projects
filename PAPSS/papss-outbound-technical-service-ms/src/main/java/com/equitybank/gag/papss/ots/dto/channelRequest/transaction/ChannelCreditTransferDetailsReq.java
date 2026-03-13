
package com.equitybank.gag.papss.ots.dto.channelRequest.transaction;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

import java.io.Serializable;

@JsonPropertyOrder({
        "sender",
        "receiver",
        "channelInfo",
        "transactionInfo",
        "signature"
})

public class ChannelCreditTransferDetailsReq implements Serializable {
    private final static long serialVersionUID = 7380097707720340677L;

    @Valid
    @NotNull(message = "Sender information is mandatory")
    @JsonProperty("sender")
    private Sender sender;

    @Valid
    @NotNull(message = "Receiver information is mandatory")
    @JsonProperty("receiver")
    private Receiver receiver;

    @Valid
    @NotNull(message = "Channel information is mandatory")
    @JsonProperty("channelInfo")
    private ChannelInfo channelInfo;

    @Valid
    @NotNull(message = "Transaction information is mandatory")
    @JsonProperty("transactionInfo")
    private TransactionInfo transactionInfo;

    @NotBlank(message = "Signature is mandatory")
    @Size(max = 1000, message = "Signature must be less than 1000 characters")
    @JsonProperty("signature")
    private String signature;

    public Sender getSender() {
        return sender;
    }

    public void setSender(Sender sender) {
        this.sender = sender;
    }

    public Receiver getReceiver() {
        return receiver;
    }

    public void setReceiver(Receiver receiver) {
        this.receiver = receiver;
    }


    public ChannelInfo getChannelInfo() {
        return channelInfo;
    }

    public void setChannelInfo(ChannelInfo channelInfo) {
        this.channelInfo = channelInfo;
    }

    public TransactionInfo getTransactionInfo() {
        return transactionInfo;
    }

    public void setTransactionInfo(TransactionInfo transactionInfo) {
        this.transactionInfo = transactionInfo;
    }

    public String getSignature() {
        return signature;
    }

    public void setSignature(String signature) {
        this.signature = signature;
    }
}
