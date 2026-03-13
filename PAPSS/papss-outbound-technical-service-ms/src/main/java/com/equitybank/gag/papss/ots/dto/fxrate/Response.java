package com.equitybank.gag.papss.ots.dto.fxrate;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlElementWrapper;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;

import java.io.Serializable;
import java.util.List;

@JsonInclude(JsonInclude.Include.NON_NULL)
public class Response implements Serializable {
    private final static long serialVersionUID = 1L;

    @JacksonXmlProperty(isAttribute = true)
    private String time;

    @JacksonXmlElementWrapper(useWrapping = false)
    @JacksonXmlProperty(localName = "Rate")
    private List<Rate> rates;

    @JacksonXmlProperty(localName = "SenderAmount")
    private CurrencyAmount senderAmount;

    @JacksonXmlProperty(localName = "ExchangeAmount")
    private CurrencyAmount exchangeAmount;

    @JacksonXmlProperty(localName = "ReceiverAmount")
    private CurrencyAmount receiverAmount;

    @JacksonXmlProperty(localName = "NationalFeeAmount")
    private CurrencyAmount nationalFeeAmount;

    @JacksonXmlProperty(localName = "FeeAmount")
    private CurrencyAmount feeAmount;

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public List<Rate> getRates() {
        return rates;
    }

    public void setRates(List<Rate> rates) {
        this.rates = rates;
    }

    public CurrencyAmount getSenderAmount() {
        return senderAmount;
    }

    public void setSenderAmount(CurrencyAmount senderAmount) {
        this.senderAmount = senderAmount;
    }

    public CurrencyAmount getExchangeAmount() {
        return exchangeAmount;
    }

    public void setExchangeAmount(CurrencyAmount exchangeAmount) {
        this.exchangeAmount = exchangeAmount;
    }

    public CurrencyAmount getReceiverAmount() {
        return receiverAmount;
    }

    public void setReceiverAmount(CurrencyAmount receiverAmount) {
        this.receiverAmount = receiverAmount;
    }

    public CurrencyAmount getNationalFeeAmount() {
        return nationalFeeAmount;
    }

    public void setNationalFeeAmount(CurrencyAmount nationalFeeAmount) {
        this.nationalFeeAmount = nationalFeeAmount;
    }

    public CurrencyAmount getFeeAmount() {
        return feeAmount;
    }

    public void setFeeAmount(CurrencyAmount feeAmount) {
        this.feeAmount = feeAmount;
    }
}
