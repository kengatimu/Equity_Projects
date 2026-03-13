
package com.equitybank.gag.papss.ots.dto.channelResponse;

import java.io.Serializable;

import com.equitybank.gag.papss.ots.dto.channelRequest.statusCheck.OriginalTxnInfo;
import com.equitybank.gag.papss.ots.dto.fxrate.PaymentFXRate;
import com.equitybank.gag.papss.ots.dto.participants.ParticipantsResponse;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
        "rrn",
        "ipsStatusInfo",
        "originalTxnStatusInfo",
        "receiver",
        "paymentFXRate",
        "participants",
        "channelStatusInfo"
})
public class ChannelResponse implements Serializable {
    private final static long serialVersionUID = 5925085769294697638L;

    @JsonProperty("rrn")
    private String rrn;

    @JsonProperty("ipsStatusInfo")
    private IpsStatusInfo ipsStatusInfo;

    @JsonProperty("originalTxnStatusInfo")
    private OriginalTxnStatusInfo originalTxnStatusInfo;

    @JsonProperty("receiver")
    private Receiver receiver;

    @JsonProperty("paymentFXRate")
    private PaymentFXRate paymentFXRate;

    @JsonProperty("participants")
    private ParticipantsResponse participants;

    @JsonProperty("channelStatusInfo")
    private ChannelStatusInfo channelStatusInfo;


    @JsonProperty("rrn")
    public String getRrn() {
        return rrn;
    }

    @JsonProperty("rrn")
    public void setRrn(String rrn) {
        this.rrn = rrn;
    }

    @JsonProperty("ipsStatusInfo")
    public IpsStatusInfo getIpsStatusInfo() {
        return ipsStatusInfo;
    }

    @JsonProperty("ipsStatusInfo")
    public void setIpsStatusInfo(IpsStatusInfo ipsStatusInfo) {
        this.ipsStatusInfo = ipsStatusInfo;
    }

    @JsonProperty("originalTxnStatusInfo")
    public OriginalTxnStatusInfo getOriginalTxnStatusInfo() {
        return originalTxnStatusInfo;
    }

    @JsonProperty("originalTxnStatusInfo")
    public void setOriginalTxnStatusInfo(OriginalTxnStatusInfo originalTxnStatusInfo) {
        this.originalTxnStatusInfo = originalTxnStatusInfo;
    }

    @JsonProperty("receiver")
    public Receiver getReceiver() {
        return receiver;
    }

    @JsonProperty("receiver")
    public void setReceiver(Receiver receiver) {
        this.receiver = receiver;
    }

    public PaymentFXRate getPaymentFXRate() {
        return paymentFXRate;
    }

    public void setPaymentFXRate(PaymentFXRate paymentFXRate) {
        this.paymentFXRate = paymentFXRate;
    }

    public ParticipantsResponse getParticipants() {
        return participants;
    }

    public void setParticipants(ParticipantsResponse participants) {
        this.participants = participants;
    }

    @JsonProperty("channelStatusInfo")
    public ChannelStatusInfo getChannelStatusInfo() {
        return channelStatusInfo;
    }

    @JsonProperty("channelStatusInfo")
    public void setChannelStatusInfo(ChannelStatusInfo channelStatusInfo) {
        this.channelStatusInfo = channelStatusInfo;
    }

}
