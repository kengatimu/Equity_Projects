package com.equitybank.gag.papss.ots.dto.fxrate;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;

import java.io.Serializable;

@JsonInclude(JsonInclude.Include.NON_NULL)
public class Request implements Serializable {
    private final static long serialVersionUID = 1L;

    @JacksonXmlProperty(isAttribute = true)
    private String LclInstrm;

    @JacksonXmlProperty(isAttribute = true)
    private String ReceiverBank;

    @JacksonXmlProperty(isAttribute = true)
    private String ReceiverCountry;

    @JacksonXmlProperty(isAttribute = true)
    private String ReceiverCurrency;

    @JacksonXmlProperty(isAttribute = true)
    private String SenderCountry;

    @JacksonXmlProperty(isAttribute = true)
    private String SenderCurrency;

    @JacksonXmlProperty(isAttribute = true)
    private String amount;

    @JacksonXmlProperty(isAttribute = true)
    private String isInvoice;

    @JacksonXmlProperty(isAttribute = true)
    private String time;

    public String getLclInstrm() {
        return LclInstrm;
    }

    public void setLclInstrm(String lclInstrm) {
        LclInstrm = lclInstrm;
    }

    public String getReceiverBank() {
        return ReceiverBank;
    }

    public void setReceiverBank(String receiverBank) {
        ReceiverBank = receiverBank;
    }

    public String getReceiverCountry() {
        return ReceiverCountry;
    }

    public void setReceiverCountry(String receiverCountry) {
        ReceiverCountry = receiverCountry;
    }

    public String getReceiverCurrency() {
        return ReceiverCurrency;
    }

    public void setReceiverCurrency(String receiverCurrency) {
        ReceiverCurrency = receiverCurrency;
    }

    public String getSenderCountry() {
        return SenderCountry;
    }

    public void setSenderCountry(String senderCountry) {
        SenderCountry = senderCountry;
    }

    public String getSenderCurrency() {
        return SenderCurrency;
    }

    public void setSenderCurrency(String senderCurrency) {
        SenderCurrency = senderCurrency;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getIsInvoice() {
        return isInvoice;
    }

    public void setIsInvoice(String isInvoice) {
        this.isInvoice = isInvoice;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }
}
